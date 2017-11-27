// Internal stuff

import electron from 'electron'
import path from 'path'
import fs from 'fs'
import elm from '../../src/Main.elm'
import * as childProcess from 'child_process'

const {shell, remote} = electron
const {app} = remote


// A default configuration (actually, it is supported
// only a Terminal :) )
const defaultConfig = {
  terminal: "Terminal.app"
}


// Retreive the configuration object
function getConfigObject(config){
  const homeDir   = app.getPath('home')
  const qianDir   = path.join(homeDir, '.qian')
  const qianFile  = path.join(qianDir, 'profil.json')
  if (!fs.existsSync(qianDir)) {
    fs.mkdirSync(qianDir);
  }
  if (!fs.existsSync(qianFile)){
    fs.writeFileSync(qianFile, JSON.stringify(config))
    return defaultConfig;
  }
  return JSON.parse(fs.readFileSync(qianFile))
}

// Rewrite the configuration file
function rewriteConfiguration(config) {
  const homeDir   = app.getPath('home')
  const qianDir   = path.join(homeDir, '.qian')
  const qianFile  = path.join(qianDir, 'profil.json')
  if (!fs.existsSync(qianDir)) {
    fs.mkdirSync(qianDir);
  }
  fs.writeFileSync(qianFile, JSON.stringify(config))
}


// Define the flag to be passed to the Elm Program
const flags = {
  current : path.resolve(".")
, config  : getConfigObject(defaultConfig)
, home    : path.resolve(app.getPath('home'))
, root    : '/'
}

// Initialize the Elm behaviour
const container = document.getElementById('app');
const elmApp = elm.Main.embed(container, flags);

// Ports to Elm Application

let watcher // the file Watcher

// Watch and get treeFile
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
  if (watcher) { watcher.close() }
  watcher = fs.watch(dir, { encoding: 'buffer' }, (et, fn) => {
    elmApp.ports.treeMutation.send(true)
  })
  elmApp.ports.retreiveTree.send(tree)
});

// Open File with a default program
elmApp.ports.openFile.subscribe((pwd) => {
  const dir = path.resolve(pwd)
  shell.openItem(dir)
});

// Open folder in finder
elmApp.ports.openInFinder.subscribe((pwd) => {
  const dir = path.resolve(pwd)
  shell.showItemInFolder(dir)
});

elmApp.ports.openInTerminal.subscribe((input) => {
  const dir = path.resolve(input.path)
  childProcess.spawn('open', ['-a', input.app, dir])
});

elmApp.ports.changeTerminal.subscribe((config) => {
  rewriteConfiguration(config)
});
