const path = require("path");

module.exports = {
  entry: "./src/js/client.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "src/")
  }
};
