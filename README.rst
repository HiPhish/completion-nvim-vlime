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

Everything works. However, the result is not very user-friendly, because
anything that matches fuzzily will be displayed, sorted absolutely without
respect to the user's input. This means for instance, that `prin` will offer
`*module-provider-function*` way before offering `print` just because the
former ranks higher in an alphabetic ordering.

I could add some extra filtering rules, but then the results would be different
from what Vlime omni completion offers (which seems to order items first by
`Levenshtein distance`_, then alphabetically in case of a tie).

The other solution would be to add more sorting options to completion-nvim and
take the prefix into account.


License
#######

Release under the terms of the MIT (Expat) license. See the COPYING_ file for
details.


.. _Vlime: https://github.com/vlime/vlime
.. _completion-nvim: https://github.com/nvim-lua/completion-nvim
.. _Levenshtein distance: https://en.wikipedia.org/wiki/Levenshtein_distance
.. _COPYING: COPYING.txt
