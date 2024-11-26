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
    try {
        let cycleStartTime = new Date();
        let tripsCount = 0;
        let routeFetchTimesMs = 0;
        let tripFetchTimesMs = 0;
        
        for (let route of ROUTES){
            console.log(`Getting trips for ${route}`);
            let routeFetchTimeStart = new Date();
            let details = await oba.tripsForRoute.list(route);
            routeFetchTimesMs += (new Date().getTime() - routeFetchTimeStart.getTime());
            // console.log(details.data.references.trips);
            let tripIDs = details.data.references.trips.map(trip => trip.id);
            // console.log(tripIDs);
            tripsCount += tripIDs.length;
            
            let batchTime = new Date();
            let tripFetchTimeStart = new Date();
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
                let d = new Date();
                await prisma.tripStatus.create({
                    data: {
                        collectedAt: batchTime,
                        secondsOfDay: d.getHours() * 3600 + d.getMinutes() * 60 + d.getSeconds(),
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
            tripFetchTimesMs += (new Date().getTime() - tripFetchTimeStart.getTime());
        }
        console.log(`Batch finished, ${tripsCount} fetched in`, (new Date().getTime() - cycleStartTime.getTime()) / 1000, "seconds");
        await prisma.scraperRunLog.create({
            data: {
                scraperSessionID: scraperSessionID,
                beginAt: cycleStartTime,
                endAt: new Date(),
                routeCount: ROUTES.length,
                tripCount: tripsCount,
                routeFetchTimeS: routeFetchTimesMs / 1000,
                tripFetchTimeS: tripFetchTimesMs / 1000,
            }
        });
    } catch (e) {
        console.error("Error in run()", e);
    }
}


// run the function every 2 minutes
await run();
setInterval(run, 2 * 60 * 1000);
