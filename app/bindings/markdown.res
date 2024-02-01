module Syntax = {
  @react.component
  let make = (~className: option<string>, ~children: React.element) => {
    let language =
      className
      ->Option.map(cn => cn->String.split("-"))
      ->Option.flatMap(cn => cn[1])
      ->Option.getOr("javascript")
    <Highlight style=Highlight.style language> {children} </Highlight>
  }
}

type overrides<'a> = {code: 'a}
type markdownOptions<'a> = {overrides: overrides<'a>}
@module("markdown-to-jsx") @react.component
external make: (~children: string, ~options: markdownOptions<'a>=?) => React.element = "default"
