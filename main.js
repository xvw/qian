'use strict'
const electron = require('electron')
const app = electron.app 
const BrowserWindow = electron.BrowserWindow
let mainWindow
app.on('ready', createWindow) 

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 820, 
    height: 480
  })

  mainWindow.loadURL(`file://${ __dirname }/static/index.html`)
  //mainWindow.webContents.openDevTools()
  mainWindow.on('closed', function () {
    mainWindow = null
  })
}

app.on('window-all-closed', () => { app.quit() })
app.on('activate', () => { if (mainWindow === null) { createWindow() } })