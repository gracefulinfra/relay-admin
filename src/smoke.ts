// Bootstrap smoke entrypoint (P0-01): prints build metadata and exits. Replaced by the real app later.
import { buildInfo } from "./buildinfo.js";

console.log(JSON.stringify(buildInfo("relay-admin", process.env)));
