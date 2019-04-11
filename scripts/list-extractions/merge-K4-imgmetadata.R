# INITIALISE
library(tidyverse)
library(readxl)
library(lubridate)
library(here)

## paths
wbook <- here("input-xlsx/K4-all-imgmetadata-KH.xlsx")
path4cache <- here("cache")
path4final <- here("output-csv")

# READ IN XLXS

K4 <- list()

# fix formatting of column names

read_sheet <- function(wbook, sheetname, vcoltypes) {
  new_cols <- function(x) {
    x %>%
      str_to_lower() %>%
      str_replace_all(" ", "_") %>%
      str_remove_all('[.?/]')
  }
  read_excel(wbook, sheet = sheetname, col_types = vcoltypes, na = "") %>%
  rename_all(new_cols)
}

# specify col types
vcoltypes_1990a <- c("text", "text", "text", "date", "text", "text", "skip")
vcoltypes_1991on <- c("text", "text", "date", "text", "text", "text", "text", "text")

K4[["1990a"]] <- read_sheet(wbook, "1989,1990", vcoltypes_1990a) %>% 
  rename(file_name = file)
K4[["1991"]] <- read_sheet(wbook, "1991", vcoltypes_1991on)
K4[["1992"]] <- read_sheet(wbook, "1992", vcoltypes_1991on)
K4[["1993"]] <- read_sheet(wbook, "1993", vcoltypes_1991on)
K4[["1994"]] <- read_sheet(wbook, "1994", vcoltypes_1991on)
K4[["1995"]] <- read_sheet(wbook, "1995", vcoltypes_1991on)
K4[["1996"]] <- read_sheet(wbook, "1996", vcoltypes_1991on)
K4[["1997"]] <- read_sheet(wbook, "1997", vcoltypes_1991on)
K4[["1998"]] <- read_sheet(wbook, "1998", vcoltypes_1991on)

## check colnames for merging
lapply(K4, colnames)

## Merge 1990a and all others

K4_1991on <- bind_rows(K4[2:9]) %>%
  rename(doc_reference = documentreference_no)
K4_1990a <- K4$`1990a`
rm(K4)

# explore column names to match variables, see notebook

## list col names
colnames(K4_1990a)
# [1] "file_name"            "img_type"        "type_note"       "date"            "other_reference" "doc_reference"  
colnames(K4_1991on)
# [1] "file_name"            "image_quality"        "date"                 "format"               "information"          "transferee_name"      "doc_reference"
# [8] "notes"   

## test method of counting unique
length(K4$`1990a`[["file"]])
unique(K4$`1990a`[["file"]]) %>% length()

## unique values == categories, check with legend
sort_unique <- function(variable) {
  variable %>%
    unique() %>%
    sort()
} 

count_unique <- function(variable) {
  variable %>%
    count(variable)
}

lapply(K4_1990a[2:6], sort_unique) %>% bind_cols()

unique(K4_1990a[["img_type"]]) %>% sort
unique(K4_1990a[["type_note"]]) %>% sort
unique(K4_1990a[["other_reference"]]) %>% sort
unique(K4_1990a[["doc_reference"]]) %>% sort

unique(K4_1991on[["format"]]) %>% sort
unique(K4_1991on[["information"]]) %>% sort
unique(K4_1991on[["image_quality"]]) %>% sort

## Extraction of PN for K4

list_PNa <- filter(K4_1990a, img_type == "PN") %>%
  select(file_name)
list_PNon <- filter(K4_1991on, format == "PN" | information == "PN,FS") %>%
  select(file_name) 
bind_rows(PNa, PNon) # %>%
#  write_delim("K4_E01_PN.txt", delim = "\r")

cat(format_delim(head(PN01), "\r"))

### Create entry notes for reference
entry_PNa <- list_PN01 <- filter(K4_1990a, img_type == "PN") %>%
  select(file_name, date, doc_reference, other_reference)
entry_PNon <- filter(K4_1991on, format == "PN" | information == "PN,FS") %>%
  select(file_name, date, doc_reference, transferee_name)

entry_K4_PN <- bind_rows(entry_PNa, entry_PNon)
# entry_K4_PN %>%
#  write_csv("K4_E01_PN_notes.csv")

## Extraction of IA for K4

list_IAa <- filter(K4_1990a, img_type == "IA") %>%
  select(file_name)
list_IAon <- filter(K4_1991on, format == "IA") %>%
  select(file_name)
# bind_rows(list_IAa, list_IAon) %>%
#   write_delim("K4_E02_IA.txt", delim = "\r")

## Extraction of FC for K4, including filtering for UNREAD

list_FCa <- filter(K4_1990a, img_type == "FC") %>% #no filter for unread as all type_note == NA
  select(file_name)
list_FCon <- filter(K4_1991on, format == "FC") %>%
  filter(!image_quality %in% c("UNREAD", "UNREAD, SPLIT", "UNREAD/SPLIT", "UNREAD ", "UNREAD,SPLIT")) %>%
  select(file_name)
list_FC_noUNREAD <- bind_rows(list_FCa, list_FCon) #%>%
#  write_delim("K4_E03_FC-noUNREAD.txt", delim = "\r")

### write list of unread only, use to make sub folder in extractions of unreadable docs. 

list_FCon_unreadonly <- filter(K4_1991on, format == "FC") %>%
  filter(image_quality %in% c("UNREAD", "UNREAD, SPLIT", "UNREAD/SPLIT", "UNREAD ", "UNREAD,SPLIT"))

list_FCon_unreadonly %>%
  select(file_name) %>% 
  write_delim("K4_E03_FC-unreadonly.txt", delim = "\r")

list_FCon_unreadonly %>%
  write_csv("K4_E03_FC_unreadonly.csv")



