const { defineConfig } = require("cypress");
const allureWriter = require("@shelex/cypress-allure-plugin/writer");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // Allure plugin
      allureWriter(on, config);

      // IMPORTANT: always return config
      return config;
    },
  },
});
