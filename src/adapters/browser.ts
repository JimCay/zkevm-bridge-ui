import { z } from "zod";

import { StrictSchema } from "src/utils/type-safety";
import { RouterState } from "src/domain";

const routerStateParser = StrictSchema<RouterState>()(z.object({ redirectUrl: z.string() }));

const getRouterState = (state: unknown) => {
  return routerStateParser.safeParse(state);
};

export { getRouterState };
