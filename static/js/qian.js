import fs from 'fs'
import Path from 'path'
const {shell} = require('electron')


function fileToEntry(path, file) {
  const completeName = Path.join(path, file)
  return {
    name: file
  , isHidden: file[0] === '.'
  , isDirectory: fs.lstatSync(completeName).isDirectory()
  }
}

export function ls(dir) {
  const path = Path.resolve(Path.join(...dir))
  const list = fs.readdirSync(path)
  return list.map((file) => fileToEntry(path, file))
}

export function openFile(file) {
  const path = Path.resolve(Path.join(...file))
  shell.openItem(path)
}
