// console.log(electron);

// const electron = require("electron");
// const path = require("path");

// const { shell, remote } = electron;
// const { app, Menu, MenuItem } = remote;

// const home = path.resolve(app.getPath("home"));
// const node = document.getElementById("app");

// console.log(home);
import { Elm } from "./elm_artifact.js";

const node = document.getElementById("app");
const elmApp = Elm.Main.init({
  node: node
});
