import {
    createRequestHandler,
    handleAsset,
} from "@remix-run/cloudflare-workers";
import * as build from "../build/index.js";

const handleRequest = createRequestHandler({ build });

const handleEvent = async (event) => {
    let response = await handleAsset(event, build);

    if (!response) {
        response = await handleRequest(event);
    }

    return response;
};

addEventListener("fetch", async (event) => {
    try {
        event.respondWith(handleEvent(event));
    } catch (e) {
        event.respondWith(new Response("Internal Error", { status: 500 }));
    }
});