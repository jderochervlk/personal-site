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
  type loaderHeaders<'a> = {..} as 'a
  type parentHeaders

  //  {...loaderHeaders, "Cache-Control": string}
  type headers<'a> = {..} as 'a

  type headersArgs<'a> = {actionHeaders?: actionHeaders, loaderHeaders?: loaderHeaders<'a>}

  type t<'a> = headersArgs<'a> => option<headers<'a>>
}

module Loader = {
  type env = {"FAUNA_SECRET": string}
  type context = {env: env}
  type request = Webapi.Fetch.Request.t
  type loaderArgs<'p> = {context: context, request: request, params: 'p}
  type t<'a, 'p> = loaderArgs<'p> => promise<'a>
}

module type LoaderData = {
  type t
  type params
}

module MakeLoader = (Data: LoaderData) => {
  type t = Loader.t<Data.t, Data.params>

  type headers<'a> = Headers.loaderHeaders<'a>
  type jsonOptions<'a> = {headers: headers<'a>}

  @module("@remix-run/react")
  external json: (Data.t, ~jsonOptions: jsonOptions<'a>=?) => 'b = "json"

  @module("@remix-run/react")
  external useLoaderData: unit => Data.t = "useLoaderData"
}

@module("@remix-run/react")
external redirect: string => exn = "redirect"
