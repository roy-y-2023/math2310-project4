import OnebusawaySDK from "onebusaway-sdk";

import {getOBAClientOptions} from "./oba-client-helper.ts";


const ROUTES = [
    "1_102745"
];


const oba: OnebusawaySDK = new OnebusawaySDK(getOBAClientOptions());

// console.log(await oba.currentTime.retrieve());

for (let route of ROUTES){
    console.log(`Getting trips for ${route}`);
    let details = await oba.tripsForRoute.list(route)
    console.log(details.data.references.trips);
}