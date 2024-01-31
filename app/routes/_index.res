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
  type t = {posts: Posts.t}
}

module Loader = Remix.MakeLoader(Data)

let loader: Loader.t = async ({context}) => {
  let secret = context.env["FAUNA_SECRET"]
  let data = await Posts.query(secret)

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
