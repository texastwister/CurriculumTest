#!/bin/bash

# render.sh -- script to regenerate all standard outputs (presentation slides, 
#             instructor guide, class handouts, labguide, etc) from a 
#             restructuredtext source file.

# Syntax:  Expects a single parameter, the name of the rst file. This script expects that such a file will be named <freeformname>.rst.txt
#
# Assumptions: 
#    The PWD is:  .../<coursename>/SRCS/
#    Other assets are in .../<coursename>/GlobalAssets

SRCNAME=$1
TMPNAME=$(echo $SRCNAME | sed s/.rst.txt//)

SLIDES_NAME=${TMPNAME}_slides.pdf
if [ -e ${TMPNAME}_slides.style ] ; then SLIDESTYLENAME=${TMPNAME}_slides.style
	else SLIDESTYLENAME=../GlobalAssets/slides.style
fi

IG_NAME=${TMPNAME}_IG.pdf
if [ -e ${TMPNAME}_IG.style ] ; then IGSTYLENAME=${TMPNAME}_IG.style
    elif [ -e ../GlobalAssets/IG.style ] 
        then IGSTYLENAME=../GlobalAssets/IG.style
	else IGSTYLENAME=../GlobalAssets/template.style
fi

# SG_NAME=${TMPNAME}_SG.pdf
# if [ -e ${TMPNAME}.sgstyle ] ; then SGSTYLENAME=${TMPNAME}.sgstyle
#     elif [ -e Course-Core/template.sgstyle ] 
#         then SGSTYLENAME=../.Course-Core/template.sgstyle
# 	else SGSTYLENAME=../.Course-Core/template.style
# fi

#    LG_NAME=${TMPNAME}_LG.pdf
#    if [ -e ${TMPNAME}.lgstyle ] ; then LGSTYLENAME=${TMPNAME}.lgstyle
#        elif [ -e Course-Core/template.lgstyle ] 
#            then LGSTYLENAME=Course-Core/template.lgstyle
#	    else LGSTYLENAME=Course-Core/template.style
#    fi



# Generate Slides
if [ ! -d "../PDFS" ]; then mkdir ../PDFS ; fi
rst2pdf  "${SRCNAME}"  --default-dpi=120 --strip-elements-with-class=instructorsonly --strip-elements-with-class=printoutonly --fit-background-mode="scale" -b 2 -s "${SLIDESTYLENAME}" -o "../PDFS/${SLIDES_NAME}" 

# Generate Instructor's Guide
# rst2pdf  "${SRCNAME}" --strip-elements-with-class=slidesonly --fit-background-mode="scale" -b 1 -s "${IGSTYLENAME}" -o "../PDFS/${IG_NAME}" 

# # Generate Student Guide
# rst2pdf  "${SRCNAME}" --strip-elements-with-class=instructorsonly  --strip-elements-with-class=slidesonly --fit-background-mode="scale" -b 1 -s "${SGSTYLENAME}" -o "../PDFS/${SG_NAME}" 



