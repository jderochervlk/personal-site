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
  type t<'a> = unit => promise<'a>
}

module type LoaderData = {
  type t
}

module MakeLoader = (Data: LoaderData) => {
  type t = Loader.t<Data.t>

  @module("@remix-run/react") external json: Data.t => 'b = "json"

  @module("@remix-run/react")
  external useLoaderData: unit => Data.t = "useLoaderData"
}
