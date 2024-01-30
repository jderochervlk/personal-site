import {
  Links,
  LiveReload,
  Meta,
  Outlet,
  Scripts,
  json,
  useLoaderData
} from "@remix-run/react";


export default function App() {

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
        <Outlet />
        <Scripts />
        <LiveReload/>
      </body>
    </html>
  );
}
