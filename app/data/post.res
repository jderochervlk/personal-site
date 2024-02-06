open Json.Decode
type t = {
  title: string,
  id: string,
  content: string,
  published: bool,
  date: string,
}
let decode_post = object(field => {
  title: field.required("title", string),
  id: field.required("id", string),
  content: field.required("content", string),
  published: field.required("published", bool),
  date: field.required("date", string),
})

let decode_response = object(field =>
  {
    "data": field.required("data", decode_post),
  }
)

let create = async secret => {
  open Fauna
  let client = client({secret: secret})
  let newPost = await (
    fql`blog.create({
    "title": "",
    "content": "",
    "published": false,
    "date": "",
  })`
  )->client.query

  switch newPost->Json.decode(decode_response) {
  | Ok(res) => Ok(res["data"])
  | Error(err) => Error(err)
  }
}

let query = async (id, secret) => {
  open Fauna
  let client = client({secret: secret})
  let newPost = await (fql`blog.byId(${id})`)->client.query

  switch newPost->Json.decode(decode_response) {
  | Ok(res) => Ok(res["data"])
  | Error(err) => Error(err)
  }
}

type postId = string

let update = async (_content: {..} as 'a, id: postId, secret) => {
  open Fauna
  let client = client({secret: secret})
  let content: string = %raw("_content")
  await (
    fql`blog.byId(${id})!.update(${content}) { 
    title,
    content,
    published,
    date
   }`
  )->client.query
}

module LoaderData = {
  type t = result<t, string>
  type params = {id: string}
  type context = Env.context
}

module Loader = Remix.MakeLoader(LoaderData)

let loader: Loader.t = async ({context, params}) => {
  open Performance
  let secret = context.env["FAUNA_SECRET"]
  let start = performance.now()
  let post = await query(params.id, secret)
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
