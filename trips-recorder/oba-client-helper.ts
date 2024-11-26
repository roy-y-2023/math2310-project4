import "dotenv/config";
import type {ClientOptions} from "onebusaway-sdk";

export function getOBAClientOptions(): ClientOptions {
    if (!process.env.OBA_API_KEY){
        throw new Error("No OneBusAway API Key found in environment variable");
    }

    return {
        baseURL: "https://api.pugetsound.onebusaway.org/",
        apiKey: process.env.OBA_API_KEY,
    }
}