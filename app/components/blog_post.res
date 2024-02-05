@react.component
let make = (~post: Post.t) =>
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
      post.content
    </Markdown>
  </article>
