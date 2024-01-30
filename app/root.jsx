import {
  Links,
  LiveReload,
  Meta,
  Outlet,
  Scripts,
  json,
  useLoaderData
} from "@remix-run/react";


import styles from "../src/pico.css";

export const links = () => [
  { rel: "stylesheet", href: styles },
];

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
        <meta name="viewport" content="width=device-width, initial-scale=1"></meta>
      </head>
      <body className="container">
        <Outlet />
        <Scripts />
        <LiveReload/>
      </body>
    </html>
  );
}
