
######################################################################

## Hooks

current: target
target = Makefile
-include target.mk

###################################################################

Sources += Makefile .ignore 
Ignore += .gitignore

######################################################################

## Default locations; use local.mk to change
msrepo = https://github.com/dushoff
ms = makestuff

Drop = ~/Dropbox

Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

######################################################################

Sources += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git submodule -b master $(msrepo)/$(ms)

$(ms)/%.mk: $(ms)/Makefile ;
$(ms)/Makefile:
	git submodule update -i

# -include $(ms)/perl.def

######################################################################

## Content

Sources += chicago2.bst wlpeerj.cls

## Manuscript
Sources += main.tex doc.tex
main.pdf: doc.tex main.tex

## Notes about references
Sources += refs.txt

## Manual bib file
Sources += stat_signif.bib 

## Folder for stuff to share
Ignore += Drop
Drop:
	(ls ~/Dropbox/clarity && ln -fs ~/Dropbox/clarity $@) \
	|| (ls ~/Dropbox/research/clarity && ln -fs ~/Dropbox/research/clarity $@) \
	|| (ls ~/Dropbox/dushoff/clarity && ln -fs ~/Dropbox/dushoff/clarity $@)

######################################################################

-include $(ms)/visual.mk
-include $(ms)/git.mk

-include $(ms)/texdeps.mk
# -include $(ms)/newtalk.mk

# -include $(ms)/modules.mk

# -include $(ms)/webpix.mk
# -include $(ms)/wrapR.mk

