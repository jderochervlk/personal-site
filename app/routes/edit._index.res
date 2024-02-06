let headers: Remix.Headers.t<{..}> = params =>
  switch params {
  | {loaderHeaders} => Some(loaderHeaders)
  | _ => None
  }

type loader = {context: Env.context}
let loader = async ({context}) => {
  let secret = context.env["FAUNA_SECRET"]
  let newPost = await Post.create(secret)

  switch newPost {
  // remix will only redirect in a loader if you throw an exception
  | Ok({id}) => raise(Remix.redirect(`/edit/${id}`))
  | Error(e) => Console.error(e)
  }

  Js.Null
}
