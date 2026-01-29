// cypress.config.js
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      const allureWriter = require("allure-cypress");
      allureWriter(on, config);
      return config;
    },
  },
  reporter: 'mochawesome', // optional
  env: {
    allureResultsPath: 'allure-results' // must match Docker volume path
  }
});
