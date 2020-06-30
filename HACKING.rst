.. default-role:: code

##################################
 Hacking on completion-vlime.nvim
##################################

There are two additional plugins involved here: completion-nvim and Vlime. The
former is configured in Lua, the latter is configured in Vim script. This means
that to get them working together we have to step back and forth between the
two languages.

The entry point is on the Lua side: when completion is triggered we forward the
request to the Vim script side. There we make any decisions necessary, issue
the request and specify the callback. Once Vlime invokes the callback we pass
the result items back to the Lua side where they can be processed and our
completion result is built.
