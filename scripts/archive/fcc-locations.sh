#!/bin/bash
# 
# Structure of file
#
# -re loads re-org functions
#   - mvlater(folder)
#   - mvfol(licence,MMM,yyyy):mv to $mwork
#   - Lmvfol():loops current folder
#   - mvv(folder, target):mv with log to $sesslog
#   - Lnumber(folder): renumber all ([1-9]) to (0[1-]) in given folder & sub folders using find
#
# 1. Set locations
# This includes FCC, microfiche, scripts, docs, xls, progress
#
# 2. Load functions and scripts
#   - scripts contain prompts (``startSess, imgpro, dataE, endSess, mvlater)
#   - functions set global variables, run loops, and group commands
#        entryO(yyyy,mm,licence)
#        [*.jpg].nameorder.sh
#        [*.jpg].grapcrop()
#        unsplit(img1,img2)
#        [*.jpg].finalrename()
#        checkD()
#        [*.jpg].Lfindrepjpg(find,rep)
#        ocr(img,doctype)
#        entryC()

# Set locations

## working paths
FCC=~/Dropbox/UoM/FCC
work="$FCC/Working"
scripts="$work/scripts"
docs="$work/documentation"
logs="$docs/logs"
xls="$work/spreadsheets"
# K4=~/Desktop/K4
# mlater="$m/microfiche-later"
# mwork="$K4/microfiche-working"
# mdone="$m/microfiche-done"
# msort="$m/microfiche-sort"
# menter="$m/microfiche-enter"

## logs
progress="$logs/progressLog.txt"
tracker="$logs/projectTracker.xlsx"
clean="$logs/cleaningLog.txt" # was moves(movefolders.txt)
laterlog="$logs/laterLog.txt" # was returnto(returntofolders.txt)
issues="$logs/issueLog.txt"
entrylog="$logs/entryLog.txt"

## shortcuts
master="$scripts/fcc-project.sh"
cplistfolder3="$scripts/copyFromListToFolder.sh"
wfnotes="$docs/workflow/workflow-readme.txt"
ref="$docs/workflowref.txt"
pleaseyn="Please answr yes or no."

echo "path to FCC set to $FCC. Available shortcuts: work,scripts,docs,logs,xls"

## img paths

microfiche=/Volumes/Seagate/microfiche
mbackups="$microfiche/FCC-backups"
K1="$mbackups/K1"
K2="$mbackups/K2"
K3="$mbackups/K3"
K4="$mbackups/K4"
K5="$mbackups/K5"

echo "path to microfiche set to $microfiche. Available shortcuts: mbackups, K1-5"