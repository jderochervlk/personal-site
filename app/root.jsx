import {
	Links,
	LiveReload,
	Meta,
	Outlet,
	Scripts,
	json,
	useLoaderData,
} from "@remix-run/react"

import styles from "../src/pico.css"

export const links = () => [{ rel: "stylesheet", href: styles }]

export const meta = () => [
	{ name: "viewport", content: "width=device-width, initial-scale=1" },
	{ title: "The Josh Derocher" },
	{
		name: "description",
		content: "Blog and all about Josh Derocher.",
	},
	{ charset: "UTF-8" },
]

export default function App() {
	return (
		<html lang="en">
			<head>
				<link rel="icon" href="data:image/x-icon;base64,AA" />
				<Meta />
				<Links />
			</head>
			<body>
				<main>
					<Outlet />
				</main>
				<Scripts />
				<LiveReload />
			</body>
		</html>
	)
}
