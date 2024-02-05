@react.component
let make = (~post: Post.t, ~chop) => {
  let content = switch chop {
  | true => post.content->String.split("\r")->Array.slice(~start=0, ~end=25)->Array.joinWith("\r")
  | false => post.content
  }

  <article key=post.id>
    <h2> {post.title->React.string} </h2>
    <p>
      <strong> {post.date->React.string} </strong>
    </p>
    <Markdown
      options={{
        overrides: {
          code: props => {
            <Markdown.Syntax {...props} />
          },
        },
      }}>
      content
    </Markdown>
    {chop
      ? <>
          <hr />
          <a href={`post/${post.id}`}> {"Read more"->React.string} </a>
        </>
      : React.null}
  </article>
}
