@module("./pico.css")
external styles: string = "default"

let links: Remix.Links.t = () => [Remix.Links.Href({rel: "stylesheet", href: styles})]

let meta: Remix.Meta.t = () => [
  Remix.Meta.Content({name: "viewport", content: "width=device-width, initial-scale=1"}),
  Remix.Meta.Title({title: "The Josh Derocher"}),
  Remix.Meta.Content({
    name: "description",
    content: "Blog and all about Josh Derocher.",
  }),
  Remix.Meta.Charset({charset: "UTF-8"}),
]

Highlight.light->Highlight.registerLanguage("typescript", Highlight.typescript)
Highlight.light->Highlight.registerLanguage("rust", Highlight.rust)
Highlight.light->Highlight.registerLanguage("ocaml", Highlight.ocaml)

@react.component
let make = () => {
  <html lang="en">
    <head>
      <link rel="icon" href="data:image/x-icon;base64,AA" />
      <Remix.Meta />
      <Remix.Links />
    </head>
    <body>
      <main>
        <Remix.Outlet />
      </main>
      <Remix.Scripts />
      <Remix.ScrollRestoration />
      <Remix.LiveReload />
    </body>
  </html>
}

let default = make
