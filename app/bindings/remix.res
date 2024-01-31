module Scripts = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Scripts"
}

module Links = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Links"

  type link = | @unboxed Href({rel: string, href: string})
  // for links export
  type t = unit => array<link>
}

module LiveReload = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "LiveReload"
}

module Meta = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Meta"

  type meta =
    | @unboxed Content({name: string, content: string})
    | @unboxed Title({title: string})
    | @unboxed Charset({charset: string})

  type t = unit => array<meta>
}

module Outlet = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Outlet"
}

module Headers = {
  type actionHeaders
  type errorHeaders
  type loaderHeaders
  type parentHeaders

  type headers = {"Cache-Control": string}

  type t = (
    ~_actionHeaders: actionHeaders,
    ~_errorHeaders: errorHeaders,
    ~_loaderHeaders: loaderHeaders,
    ~_parentHeaders: parentHeaders,
  ) => headers
}

module Loader = {
  type env = {"FAUNA_SECRET": string}
  type context = {env: env}
  type loaderArgs = {context: context}
  type t<'a> = loaderArgs => promise<'a>
}

module type LoaderData = {
  type t
}

module MakeLoader = (Data: LoaderData) => {
  type t = Loader.t<Data.t>

  type headers = {"Server-Timing": string}
  type jsonOptions = {headers: headers}

  @module("@remix-run/react") external json: (Data.t, ~jsonOptions: jsonOptions=?) => 'b = "json"

  @module("@remix-run/react")
  external useLoaderData: unit => Data.t = "useLoaderData"
}
