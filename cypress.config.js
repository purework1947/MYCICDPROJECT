const { defineConfig } = require("cypress");
const allureWriter = require("allure-cypress");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      allureWriter(on, config);
      return config;
    },
  },
});
