import { json, useLoaderData } from '@remix-run/react';
import { make as Hero } from '../../src/home_hero.jsx'

export const headers = ({
  actionHeaders,
  errorHeaders,
  loaderHeaders,
  parentHeaders,
}) => ({
  "Cache-Control": "max-age=300, s-maxage=3600",
});

export const loader = async () => {
  return json({ data: await fetch("https://baconipsum.com/api/?type=meat-and-filler").then(res => res.json())})
}

export default function() {
    const {data} = useLoaderData()

    return (
        <>
        <Hero />
        {data.map(t => <p key={t}>{t}</p>)}
        </>
    )
}