/***
 Types, decoders, and query for fauna blog entries
 */

open Json.Decode
type post = Post.t

type t = array<post>

let posts = array(Post.decode_post)

let query = async secret => {
  open Fauna
  let client = client({secret: secret})
  let posts = await (fql`blog.all()`)->client.query
  switch posts
  ->JSON.Decode.object
  ->Option.flatMap(t => t->Dict.get("data"))
  ->Option.flatMap(JSON.Decode.object)
  ->Option.flatMap(t => t->Dict.get("data"))
  ->Option.flatMap(JSON.Decode.array) {
  | Some(posts) =>
    posts->Array.reduce([], (acc, item) =>
      switch item->Json.decode(Post.decode_post) {
      | Ok(item) => acc->Array.concat([item])
      | Error(err) => {
          Console.error(err)
          Console.log(item->JSON.stringifyAny)
          acc
        }
      }
    )
  | None => Exn.raiseError("Posts query returned an invalid response.")
  }
}
