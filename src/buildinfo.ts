export interface BuildInfo {
  name: string;
  version: string;
  commit: string;
  node: string;
}

/** Reads build metadata from the environment the image sets at build time. */
export function buildInfo(name: string, env: Record<string, string | undefined>): BuildInfo {
  return {
    name,
    version: env["RELAY_VERSION"] || "dev",
    commit: env["RELAY_COMMIT"] || "unknown",
    node: process.version,
  };
}
