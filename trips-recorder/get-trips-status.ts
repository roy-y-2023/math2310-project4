import OnebusawaySDK from "onebusaway-sdk";
import {PrismaClient} from "@prisma/client"

import {getOBAClientOptions} from "./oba-client-helper.ts";


const ROUTES = [
    "1_102615",
    "1_102745",
    "23_102638",
    "40_100479",
    "40_2LINE",
];

const prisma = new PrismaClient();
const oba: OnebusawaySDK = new OnebusawaySDK(getOBAClientOptions());
const scraperSessionID = Math.random().toString(36).substring(2, 15);

console.log("Starting scraper session", scraperSessionID);
async function run(){
    let startTime = new Date();
    let tripsCount = 0;
    
    for (let route of ROUTES){
        console.log(`Getting trips for ${route}`);
        let details = await oba.tripsForRoute.list(route);
        // console.log(details.data.references.trips);
        let tripIDs = details.data.references.trips.map(trip => trip.id);
        // console.log(tripIDs);
        tripsCount += tripIDs.length;
        
        let batchTime = new Date();
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
            await prisma.tripStatus.create({
                data: {
                    collectedAt: batchTime,
                    routeID: route,
                    tripID: tripID,
                    scheduleDeviation: statusResp.data.entry.status!.scheduleDeviation,
                    scraperSessionID: scraperSessionID,
                    nextStopID: statusResp.data.entry.status!.nextStop,
                    nextStopTimeOffset: statusResp.data.entry.status!.nextStopTimeOffset,
                    distanceAlongTrip: statusResp.data.entry.status!.distanceAlongTrip,
                }
            })
        }
    }
    console.log(`Batch finished, ${tripsCount} fetched in`, (new Date().getTime() - startTime.getTime()) / 1000, "seconds");
}


// run the function every 3 minutes
await run();
setInterval(run, 3 * 60 * 1000);
