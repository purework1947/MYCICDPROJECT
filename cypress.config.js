const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      require("allure-cypress/on")(on, config);
      return config;
    },
  },
});
