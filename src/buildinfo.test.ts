import { describe, expect, it } from "vitest";
import { buildInfo } from "./buildinfo.js";

describe("buildInfo", () => {
  it.each([
    {
      case: "stamped",
      env: { RELAY_VERSION: "1.2.3", RELAY_COMMIT: "abc123" },
      version: "1.2.3",
      commit: "abc123",
    },
    { case: "unstamped defaults", env: {}, version: "dev", commit: "unknown" },
    {
      case: "empty values fall back",
      env: { RELAY_VERSION: "", RELAY_COMMIT: "" },
      version: "dev",
      commit: "unknown",
    },
  ])("$case", ({ env, version, commit }) => {
    const info = buildInfo("relay-test", env);
    expect(info).toEqual({ name: "relay-test", version, commit, node: process.version });
  });
});
