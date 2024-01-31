/***
 Types, decoders, and query for fauna blog entries
 */

open Json.Decode
open Fauna
open Post
type post = Post.t

type t = array<post>

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

let postQuery = %raw("Fauna.fql`blog.all()`")

let query = async secret => {
  let client = client({secret: secret})
  let postQuery = postQuery
  let posts = await client.query(postQuery)
  switch posts->Json.decode(decode) {
  | Ok(res) => res["data"]["data"]
  | Error(err) => {
      let _ = Console.error(err)
      []
    }
  }
}
