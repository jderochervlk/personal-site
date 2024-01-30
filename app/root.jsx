import {
  Links,
  Meta,
  Outlet,
  Scripts,
  json,
  useLoaderData
} from "@remix-run/react";

export const loader = async () => {
  return json({ data: await fetch("https://baconipsum.com/api/?type=meat-and-filler").then(res => res.json())})
}

export default function App() {
  const {data} = useLoaderData()

  return (
    <html>
      <head>
        <link
          rel="icon"
          href="data:image/x-icon;base64,AA"
        />
        <Meta />
        <Links />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css" />
      </head>
      <body className="container">
        <h1>Hello world!</h1>
        {data.map(t => <p key={t}>{t}</p>)}
        <Outlet />

        <Scripts />
      </body>
    </html>
  );
}
