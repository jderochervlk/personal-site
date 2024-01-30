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
