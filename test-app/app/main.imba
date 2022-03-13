# Modules to control application life and create native browser window
import {app,BrowserWindow,protocol,ipcMain} from 'electron'
import path from 'path'

const preload = import.preload('./preload.imba')
const index = import.html('./index.html')

# setting up an action
ipcMain.handle('perform-action') do(event,...args)
	console.log 'perform-action',args

def createWindow
	
	const mainWindow = new BrowserWindow({
		width: 800,
		height: 600,
		webPreferences: {
			preload: preload.absPath
		}
	})

	let filter = {urls: ['file:///__assets__/*']}

	# redirect absolute asset urls to correct asset paths.
	# temporary workaround until full electron support lands.
	mainWindow.webContents.session.webRequest.onBeforeRequest(filter) do({url}, callback)
		if let asset = imba.manifest.urls[url.slice(7)]
			return callback(cancel: false, redirectURL: "file://{asset.absPath}")

	# and load the index.html of the app.
	mainWindow.loadFile(index.absPath)

	# Open the DevTools.
	# mainWindow.webContents.openDevTools()

# This method will be called when Electron has finished
# initialization and is ready to create browser windows.
# Some APIs can only be used after this event occurs.
app.whenReady!.then do
	createWindow!
	
	app.on('activate') do
		// On macOS it's common to re-create a window in the app when the
		// dock icon is clicked and there are no other windows open.
		if BrowserWindow.getAllWindows!.length === 0
			createWindow!

# Quit when all windows are closed, except on macOS. There, it's common
# for applications and their menu bar to stay active until the user quits
# explicitly with Cmd + Q.
app.on('window-all-closed') do
	if process.platform !== 'darwin'
		app.quit!

# In this file you can include the rest of your app's specific main process
# code. You can also put them in separate files and require them here.