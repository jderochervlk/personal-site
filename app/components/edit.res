module LoaderData = {
  type t = result<Post.t, string>
  type params = {id: string}
}

module Loader = Remix.MakeLoader(LoaderData)

let loader: Loader.t = async ({context, params}) => {
  open Performance
  let secret = context.env["FAUNA_SECRET"]
  let start = performance.now()
  let post = await Post.query(params.id, secret)
  let duration = performance.now() - start

  Loader.json(
    post,
    ~jsonOptions={
      headers: {
        "Server-Timing": `db;dur=${duration->Int.toString}`,
      },
    },
  )
}

module ActionData = {
  type t
}

module Action = Remix.MakeAction(ActionData)

let action: Action.t = async ({context, request}) => {
  open Webapi.Fetch
  let formData = await request->Request.formData

  let id = switch formData->FormData.get("id") {
  | Some(id) =>
    switch id->FormData.EntryValue.classify {
    | #String(id) => id
    | _ => Js.Exn.raiseError("Id is not a valid string")
    }
  | None => Js.Exn.raiseError("Id does not exist")
  }

  let title = switch formData->FormData.get("title") {
  | Some(title) =>
    switch title->FormData.EntryValue.classify {
    | #String(title) => title
    | _ => ""
    }
  | None => ""
  }

  let content = switch formData->FormData.get("content") {
  | Some(content) =>
    switch content->FormData.EntryValue.classify {
    | #String(content) => content
    | _ => ""
    }
  | None => ""
  }

  let date = switch formData->FormData.get("date") {
  | Some(date) =>
    switch date->FormData.EntryValue.classify {
    | #String(date) => date
    | _ => ""
    }
  | None => ""
  }

  let published = switch formData->FormData.get("published") {
  | Some(published) =>
    switch published->FormData.EntryValue.classify {
    | #String(published) =>
      switch published {
      | "on" => true
      | _ => false
      }
    | _ => false
    }
  | None => false
  }

  let _ = await Post.update(
    {"content": content, "title": title, "published": published, "date": date},
    id,
    context.env["FAUNA_SECRET"],
  )

  Js.Null
}

@react.component
let make = () => {
  let post = Loader.useLoaderData()

  // format the date into YYYY-MM-DD
  let date = React.useMemo(() => {
    switch post {
    | Ok(post) =>
      switch post.date {
      | "" => {
          let currentTime = Date.now()->Date.fromTime
          let year = currentTime->Date.getFullYear->Int.toString
          let month = (currentTime->Date.getMonth + 1)->Int.toString
          let month = switch month->String.length {
          | 1 => `0${month}`
          | _ => month
          }
          let day = currentTime->Date.getDate->Int.toString
          let day = switch day->String.length {
          | 1 => `0${day}`
          | _ => day
          }
          `${year}-${month}-${day}`
        }
      | _ => post.date
      }
    | Error(_) => ""
    }
  }, [])

  Console.log(date)

  <div>
    <h1> {"Edit Post"->React.string} </h1>
    {switch post {
    | Ok(post) =>
      <article>
        <form method="post">
          <input type_="hidden" name="id" value=post.id />
          <label to="title"> {"Title"->React.string} </label>
          <input name="title" defaultValue=post.title autoFocus=true />
          <label to="date"> {"Date"->React.string} </label>
          <input name="date" type_="date" defaultValue=date />
          <label to="published"> {"Published"->React.string} </label>
          <input name="published" type_="checkbox" defaultChecked=post.published />
          <br />
          <br />
          <label to="content"> {"Content"->React.string} </label>
          <textarea style={{height: "600px"}} name="content" defaultValue=post.content />
          <button> {"save"->React.string} </button>
        </form>
      </article>
    | Error(err) =>
      <article>
        <h2> {"There was an error"->React.string} </h2>
        <pre style={{padding: "20px", background: "pink", color: "red"}}> {err->React.string} </pre>
      </article>
    }}
  </div>
}

let default = make
