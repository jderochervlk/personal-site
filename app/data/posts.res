/***
 Types, decoders, and query for fauna blog entries
 */

open Json.Decode
type post = Post.t

type t = array<post>

let posts = array(Post.decode_post)

let decode_response = object(field =>
  {
    "data": field.required("data", posts),
  }
)

let decode = object(field =>
  {
    "data": field.required("data", decode_response),
  }
)

let query = async secret => {
  open Fauna
  let client = client({secret: secret})
  let posts = await (fql`blog.all()`)->client.query
  switch posts->Json.decode(decode) {
  | Ok(res) => res["data"]["data"]
  | Error(err) => {
      let _ = Console.error(err)
      []
    }
  }
}
