type style
type language
type light

@module("react-syntax-highlighter") @react.component
external make: (~language: string, ~children: React.element, ~style: style) => React.element =
  "Light"

@module("react-syntax-highlighter")
external light: light = "Light"

@send
external registerLanguage: (light, string, language) => unit = "registerLanguage"

@module("react-syntax-highlighter/dist/esm/styles/hljs")
external style: style = "nightOwl"

@module("react-syntax-highlighter/dist/esm/languages/hljs/typescript")
external typescript: language = "default"

@module("react-syntax-highlighter/dist/esm/languages/hljs/rust")
external rust: language = "default"

@module("react-syntax-highlighter/dist/esm/languages/hljs/ocaml")
external ocaml: language = "default"
