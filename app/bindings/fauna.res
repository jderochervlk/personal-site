type query
type client = {query: query => promise<Js.Json.t>}

type clientOptions = {secret: string}
@module("fauna") @new
external client: clientOptions => client = "Client"

@module("fauna") @taggedTemplate
external fql: (array<string>, array<string>) => query = "fql"
