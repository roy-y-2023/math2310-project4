import OnebusawaySDK from "onebusaway-sdk";
import type {References} from "onebusaway-sdk/resources/shared";

import {getOBAClientOptions} from "./oba-client-helper.ts";


const ROUTES = [
    "1_102745",
    "40_100479",
];


const oba: OnebusawaySDK = new OnebusawaySDK(getOBAClientOptions());

// console.log(await oba.currentTime.retrieve());
const routesTripsMap = new Map<string, References.Trip[]>();

for (let route of ROUTES){
    console.log(`Getting trips for ${route}`);
    let details = await oba.tripsForRoute.list(route)
    console.log(details.data.references.trips);
}
