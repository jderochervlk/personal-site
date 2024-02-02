module Data = {
  type t = result<Post.t, string>
  type params = {id: string}
}

module Loader = Remix.MakeLoader(Data)

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

@react.component
let make = () => {
  let post = Loader.useLoaderData()

  Console.log(post)

  <h1> {"Hey"->React.string} </h1>
}

let default = make
