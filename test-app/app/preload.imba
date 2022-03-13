# All of the Node.js APIs are available in the preload process.
# It has the same sandbox as a Chrome extension.
import { app,ipcRenderer,contextBridge } from 'electron'

global.window.addEventListener('DOMContentLoaded') do
	const replaceText = do(selector, text)
		const element = global.document.getElementById(selector)
		if element then element.innerText = text

	for type of ['chrome', 'node', 'electron']
		replaceText(`{type}-version`, process.versions[type])

# exposing window.api for the renderer process
contextBridge.exposeInMainWorld('api',{
	invoke: do(name,...params)
		console.log 'invoking action in main process',name
		ipcRenderer.invoke(name,...params)
})