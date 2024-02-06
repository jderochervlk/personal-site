let loader = Post.loader

@react.component
let make = () => {
  let post = Post.Loader.useLoaderData()
  <>
    <Home_hero />
    {switch post {
    | Ok(post) => <Blog_post post chop=false />
    | Error(err) => <pre> {err->React.string} </pre>
    }}
  </>
}
