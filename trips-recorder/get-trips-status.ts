import OnebusawaySDK from "onebusaway-sdk";
import type {References} from "onebusaway-sdk/resources/shared";

import {getOBAClientOptions} from "./oba-client-helper.ts";


const ROUTES = [
    "1_102745",
    "40_100479",
];


const oba: OnebusawaySDK = new OnebusawaySDK(getOBAClientOptions());

for (let route of ROUTES){
    console.log(`Getting trips for ${route}`);
    let details = await oba.tripsForRoute.list(route);
    // console.log(details.data.references.trips);
    let tripIDs = details.data.references.trips.map(trip => trip.id);
    // console.log(tripIDs);
    for (let tripID of tripIDs){
        let statusResp = await oba.tripDetails.retrieve(tripID);
        if (!statusResp.data.entry.status){
            console.log("No status found for trip", tripID);
            continue;
        }
        
        if (!statusResp.data.entry.status!.predicted){
            console.log("No realtime information for trip", tripID);
            continue;
        }
        
        console.log(statusResp.data.entry.status!.activeTripId, statusResp.data.entry.status!.scheduleDeviation);
    }
}
