import Electron from 'electron'
import Path from 'path'
import Elm from '../../src/Main.elm'

const remote = Electron.remote
const app = remote.app

const container = document.getElementById('app');
const elmApp = Elm.Main.embed(container, {
  pwd: app.getPath('home').split(Path.sep)
});
