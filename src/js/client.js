import electron from "electron";
import path from "path";
import * as fs from "fs";

import { Elm } from "./elm_artifact.js";

const { shell, remote } = electron;
const { app } = remote;

const home = path.resolve(app.getPath("home"));

console.log(home);

const node = document.getElementById("app");
const elmApp = Elm.Main.init({
  node: node
});
