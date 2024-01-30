open Webapi

let headers: Remix.Headers.t = (
  ~_actionHeaders,
  ~_errorHeaders,
  ~_loaderHeaders,
  ~_parentHeaders,
) =>
  {
    "Cache-Control": "max-age=300, s-maxage=3600",
  }

@spice
type bacon = array<string>

module Data = {
  open Json.Decode
  type t = {"foo": string, "data": array<string>}

  let decode = array(string)
}

module Loader = Remix.MakeLoader(Data)

let loader: Loader.t = async () => {
  let bacon = switch await Fetch.fetch("https://baconipsum.com/api/?type=meat-and-filler")
  ->Promise.then(Fetch.Response.json)
  ->Promise.thenResolve(t => t->Json.decode(Data.decode)) {
  | Ok(data) => data
  | Error(e) => {
      Console.error(e)
      []
    }
  }
  let data = {
    "foo": "bar",
    "data": bacon,
  }

  Loader.json(data)
}

@react.component
let make = () => {
  let data = Loader.useLoaderData()
  <>
    <Home_hero />
    {data["data"]->Array.map(v => <p key=v> {v->React.string} </p>)->React.array}
  </>
}

let default = make
