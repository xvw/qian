import Electron from 'electron'
import Path from 'path'
import Elm from '../../src/Main.elm'
import * as Qian from './qian.js'

const remote = Electron.remote
const app = remote.app
const container = document.getElementById('app');
const homeDir = app.getPath('home')
const homeSplitted = homeDir.split(Path.sep)

const elmApp = Elm.Main.embed(container, {
  pwd:  homeSplitted
, home: homeSplitted
});

elmApp.ports.ls.subscribe((pwd) => {
  const list = Qian.ls(pwd)
  elmApp.ports.getDirTree.send(list)
});

elmApp.ports.openFile.subscribe((path) => {
  Qian.openFile(path)
});


elmApp.ports.openInFinder.subscribe((path) => {
  Qian.openInFinder(path)
})
