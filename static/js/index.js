// Internal stuff

import electron from 'electron'
import path from 'path'
import fs from 'fs'
import elm from '../../src/Main.elm'

const remote = electron.remote
const app = remote.app


// A default configuration (actually, it is supported
// only a Terminal :) )
const defaultConfig = {
  terminal: "Terminal.app"
}


// Retreive the configuration object
function getConfigObject(){
  const homeDir   = app.getPath('home')
  const qianDir   = path.join(homeDir, '.qian')
  const qianFile  = path.join(qianDir, 'profil.json')
  if (!fs.existsSync(qianDir)){
    fs.mkdirSync(qianDir)
    fs.writeFileSync(qianFile, JSON.stringify(defaultConfig))
    return defaultConfig;
  }
  return JSON.parse(fs.readFileSync(qianFile))
}


// Define the flag to be passed to the Elm Program
const flags = {
  current : path.resolve(".")
, config  : getConfigObject()
, home    : path.resolve(app.getPath('home'))
, root    : '/'
}

// Initialize the Elm behaviour
const container = document.getElementById('app');
const elmApp = elm.Main.embed(container, flags);

// Ports to Elm Application

elmApp.ports.getTree.subscribe((pwd) => {
  const dir = path.resolve(pwd)
  const tree = fs.readdirSync(dir).map((entry) => {
    const completePath = path.join(dir, entry)
    return {
        name:      entry
      , path:      completePath
      , hidden:    entry[0] === '.' /* Maybe to be improve :/ */
      , directory: fs.lstatSync(completePath).isDirectory()
    }
  });
  elmApp.ports.retreiveTree.send(tree)
});
