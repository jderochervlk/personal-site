let headers: Remix.Headers.t<{..}> = params =>
  switch params {
  | {loaderHeaders} => Some(loaderHeaders)
  | _ => None
  }

module Data = {
  type t = {posts: Posts.t}
  type params
  type context = Env.context
}

module Loader = Remix.MakeLoader(Data)

let loader: Loader.t = async ({context}) => {
  open Performance
  let secret = context.env["FAUNA_SECRET"]
  let start = performance.now()
  let data = await Posts.query(secret)
  let duration = performance.now() - start
  Loader.json(
    {posts: data},
    ~jsonOptions={
      headers: {
        "Server-Timing": `db;dur=${duration->Int.toString}`,
        "Cache-Control": "max-age=300, s-maxage=3600",
      },
    },
  )
}

@react.component
let make = () => {
  let {posts} = Loader.useLoaderData()
  <>
    <Home_hero />
    {posts
    ->Array.map(post => <Blog_post post chop=true />)
    ->React.array}
  </>
}

let default = make
