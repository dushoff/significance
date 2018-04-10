
######################################################################

## Hooks

current: target
target = Makefile
-include target.mk

###################################################################

# stuff

Sources += Makefile .ignore README.md substuff.mk LICENSE.md

## Change Drop with untracked local.mk (called automatically from substuff.mk)
Drop = ~/Dropbox

-include substuff.mk
# -include $(ms)/perl.def
# -include $(ms)/newtalk.def
# -include $(ms)/repos.def

######################################################################

## Content

Sources += chicago2.bst stat_signif.bib wlpeerj.cls

Sources += main.tex doc.tex
main.pdf: doc.tex main.tex

Sources += oikos.txt

## What should we call the paper?
Sources += names.txt
## https://tinyurl.com/oikos-clarity
##  http://www.oikosjournal.org/authors/author-guidelines

######################################################################

-include $(ms)/visual.mk
-include $(ms)/git.mk

-include $(ms)/texdeps.mk
# -include $(ms)/newtalk.mk

# -include $(ms)/modules.mk

# -include $(ms)/webpix.mk
# -include $(ms)/wrapR.mk

