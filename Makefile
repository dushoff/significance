
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

Ignore += *.compare.tex
## latexdiff is not working well here; maybe because of the main/doc structure
main.compare.tex: main.tex.*.oldfile main.tex
	$(latexdiff)

######################################################################

## Submission
## Oikos proposal: https://docs.google.com/document/d/1U30hJsz7iz8wQidHo7oYEwB-y1H_xvmi4am7cntePvs/

## Preparing to submit to Ecology
Sources += cover.md
Ignore += cover.html
cover.html: cover.md

######################################################################

## Notes 
Sources += refs.txt notes.txt

## Manual bib file
Sources += stat_signif.bib 

## Folder for stuff to share (so far one paper!
## LMK if you want access
Ignore += Drop
Drop:
	(ls ~/Dropbox/clarity && ln -fs ~/Dropbox/clarity $@) \
	|| (ls ~/Dropbox/research/clarity && ln -fs ~/Dropbox/research/clarity $@) \
	|| (ls ~/Dropbox/dushoff/clarity && ln -fs ~/Dropbox/dushoff/clarity $@)

######################################################################

-include $(ms)/visual.mk
-include $(ms)/git.mk

-include $(ms)/texdeps.mk
-include $(ms)/pandoc.mk
# -include $(ms)/wrapR.mk

