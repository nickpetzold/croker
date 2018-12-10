const path = require("path");

module.exports = {
  entry: path.resolve(__dirname, "./lib/api_testing.js"),
  output: {
    filename: "build/application.js"
  },
  devtool: "sourcemap"
};
