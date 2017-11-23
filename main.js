const electron = require('electron')
const path = require('path')
const fs = require('fs');

const app = electron.app
const BrowserWindow = electron.BrowserWindow

let mainWindow

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 960,
    height: 640,
    backgroundColor:"#000",
    frame:true,
    resizable:true,
    autoHideMenuBar: true
  })
  mainWindow.loadURL(`file://${ __dirname }/static/index.html`)
  //mainWindow.webContents.openDevTools()
  mainWindow.on('closed', function () {
    mainWindow = null
  })
}

app.on('ready', createWindow)
app.on('window-all-closed', () => { app.quit() })
app.on('activate', () => { if (mainWindow === null) { createWindow() } })
