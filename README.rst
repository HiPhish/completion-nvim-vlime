.. default-role:: code

##################################
 Vlime source for completion-nvim
##################################

This Neovim plugin provides a Vlime_ completion source for the completion-nvim_
plugin.


Installation
############

You need both Vlime and completion-nvim installed and set up first. Then
install this plugin as you would install any other Neovim plugin.


Configuration
#############

The new source is registered automatically. You can prevent this by defining
the variable `g:completion_vlime_did_load`. You should then add the `'vlime'`
source to your completions settings, the same as any other source. Please refer
to the documentation of completion-nvim for more information.


Status of the project
#####################

Everything works as expected.


License
#######

Release under the terms of the MIT (Expat) license. See the COPYING_ file for
details.


.. _Vlime: https://github.com/vlime/vlime
.. _completion-nvim: https://github.com/nvim-lua/completion-nvim
.. _Levenshtein distance: https://en.wikipedia.org/wiki/Levenshtein_distance
.. _COPYING: COPYING.txt
