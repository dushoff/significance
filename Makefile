## gitroot/significance: the Clarity project

## Document main.pdf
## main.compare.pdf: doc.tex main.tex
## main.pdf: doc.tex main.tex

## Rebuttal rebuttal.html
## rebuttal.html: rebuttal.md

current: target
target = Makefile
-include target.mk

###################################################################

Sources += Makefile current.md
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

-include $(ms)/perl.def

######################################################################

## Content

Sources += chicago2.bst wlpeerj.cls

## Manuscript
Sources += main.tex doc.tex table.tex
main.pdf: doc.tex main.tex

## Real reviewed MS fa24786
## git checkout fa24786 -- doc.tex ##
## JD First pass 96679d
## JD handoff 714ccc

Ignore += *.review.tex
newrev:
	$(RM) *.review.tex
%.review.tex: %.tex.fa24786.oldfile
	$(copy)

######################################################################

## Diff pipeline not piping well!
Ignore += *.compare.tex
## latexdiff is hard with the main/doc structure
%.compare.tex: %.review.tex %.tex
	$(latexdiff)

ldpre.compare.tex: ldpre.tex
	$(copy)

main.compare.tex: main.tex Makefile
	perl -npe "s/\.tex/.compare.tex/" $< > $@

Sources += ldpre.tex
main.compare.pdf: doc.tex

######################################################################

## Revision

Sources += rebuttal.md

Ignore += rebuttal.html
rebuttal.html: rebuttal.md

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

