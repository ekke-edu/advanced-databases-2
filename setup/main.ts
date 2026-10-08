import { defineAppSetup } from "@slidev/types";

export default defineAppSetup(({ router }) => {
  router.afterEach((to) => {
    if (window.location.hash.includes("/portfolio-vedes-b9xgep/")) {
      const cleanHash = window.location.hash.replace(
        "/portfolio-vedes-b9xgep/",
        "/",
      );

      window.location.hash = cleanHash;
    }
  });
});
