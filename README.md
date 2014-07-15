This is Log Emitter for Node.js
===

author: Rudolph-Miller
---

How to Use
```
	logemitter = require('log-emitter').LogEmitter
	LogEmitter = new logemitter('*watching-file*)
	LogEmitter.use *function*
		-> when file changed and do *function*({file: *file-name*, data: *data*})

	folderlogemitter= require('log-emitter').FolderLogEmitter
	FolderLogEmitter = new folderlogemitter('*watcher-folder*')
	FolderLogEmitter.use *function*
		-> when file in folder changed and do *function*({file: *file-name*, data: *data*})
```
