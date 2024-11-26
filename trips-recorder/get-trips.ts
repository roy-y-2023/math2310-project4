import OnebusawaySDK from "onebusaway-sdk";

import {getOBAClientOptions} from "./oba-client-helper.ts";


const ROUTES = [
    "102745"
];


const oba = new OnebusawaySDK(getOBAClientOptions());

console.log(await oba.currentTime.retrieve());