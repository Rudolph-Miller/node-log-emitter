This is Log Emitter for Node.js
===

author: Rudolph-Miller
---

How to Use
```
	LogEmitter = require('log-emitter').LogEmitter('*watching-file*')
	LogEmitter.use *function*
		-> when file changed and do *function*({file: *file-name*, data: *data*})

	FolderLogEmitter= require('log-emitter').FolderLogEmitter('*watching-folder*')
	LogEmitter.use *function*
		-> when file in folder changed and do *function*({file: *file-name*, data: *data*})
```
