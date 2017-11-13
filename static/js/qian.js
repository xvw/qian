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

function resolvePath(path) {
  return Path.resolve(Path.join(...path))
}

export function ls(dir) {
  const path = resolvePath(dir)
  const list = fs.readdirSync(path)
  return list.map((file) => fileToEntry(path, file))
}

export function openFile(file) {
  const path = resolvePath(file)
  shell.openItem(path)
}

export function openInFinder(dir) {
  const path = resolvePath(dir)
  shell.showItemInFolder(path)
}
