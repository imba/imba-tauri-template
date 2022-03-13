# This file is required by the index.html file and will
# be executed in the renderer process for that window.
# No Node.js APIs are available in this process because
# `nodeIntegration` is turned off. Use `preload.imba` to
# selectively enable features needed in the rendering
# process.

tag App
	def mount
		await import('./async')
		
	def submit
		global.api.invoke('perform-action',1,2,3)

	<self>
		<svg src='./logo.svg'>
		<div> "Welcome"
		<button @click=submit> 'perform-action'

imba.mount <App>