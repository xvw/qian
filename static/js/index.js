import Electron from 'electron'
import Path from 'path'
import Elm from '../../src/Main.elm'
import * as Qian from './qian.js'
import fs from 'fs'

const remote = Electron.remote
const app = remote.app
const container = document.getElementById('app');
const homeDir = app.getPath('home')

const elmApp = Elm.Main.embed(container, {
  pwd:  homeDir
, home: homeDir
});


let watcher

elmApp.ports.ls.subscribe((pwd) => {
  const path = Qian.resolvePath(pwd)
  const list = Qian.ls(path)
  if (watcher) {
    watcher.close()
  }
  watcher = fs.watch(path, { encoding: 'buffer' }, (et, fn) => {
    elmApp.ports.treeMutation.send(true)
  })
  elmApp.ports.getDirTree.send(list)
});

elmApp.ports.openFile.subscribe((path) => {
  Qian.openFile(path)
});

elmApp.ports.openTerminal.subscribe((path) => {
  Qian.openTerminal(path)
});


elmApp.ports.openInExplorer.subscribe((path) => {
  Qian.openInFinder(path)
})
