open Webapi

let headers: Remix.Headers.t = (
  ~_actionHeaders,
  ~_errorHeaders,
  ~_loaderHeaders,
  ~_parentHeaders,
) =>
  {
    "Cache-Control": "max-age=300, s-maxage=3600",
  }

module Data = {
  open Json.Decode
  type post = {title: string, id: string}

  type t = {posts: array<post>}

  type data = {data: t}

  let post = object(field => {
    title: field.required("title", string),
    id: field.required("id", string),
  })

  let posts = array(post)

  let response = object(field =>
    {
      "data": field.required("data", posts),
    }
  )

  let decode = object(field =>
    {
      "data": field.required("data", response),
    }
  )
}

module Loader = Remix.MakeLoader(Data)

let loader: Loader.t = async ({context}) => {
  let secret = context.env["FAUNA_SECRET"]
  open Fauna
  let client = client({secret: secret})
  let postQuery = %raw("Fauna.fql`blog.all()`")
  let posts = await client.query(postQuery)
  let data = switch posts->Json.decode(Data.decode) {
  | Ok(res) => res["data"]["data"]
  | Error(err) => {
      let _ = Console.error(err)
      []
    }
  }

  Loader.json({posts: data})
}

@react.component
let make = () => {
  let {posts} = Loader.useLoaderData()
  <>
    <Home_hero />
    {posts->Array.map(post => <h2 key=post.id> {post.title->React.string} </h2>)->React.array}
  </>
}

let default = make
