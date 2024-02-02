type t = {
  title: string,
  id: string,
  content: string,
  published: bool,
  date: string,
}

open Json.Decode
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
    "date": 0,
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
