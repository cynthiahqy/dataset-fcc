## The Journey so Far

### (not so) Simple Data Entry
In early 2017, I started working as a Research Assistant to Dr. David Byrne at the University of Melbourne. 

I was given 6 "BATCH" folders of scanned microfiche, which some poor souls in Washington D.C. pulled from the depths of the Federal Communication Commission's archives. Each subfolder (CALLSIGN/) in a BATCH/ corresponded to a set of licence transfer applications (FILING/) for a particular licence number/call-sign. In each FILING/ was a varying number of .jpg images. All the documents date from the late 1980s to the late 1990s. After this period filings were made digitally.  

My assigned task was to take each scanned application form for licence transfers and enter the details into a Excel. Simple right? Not so much. 

Let me detail a few of the problems I encountered. 

The archived forms were what can only be described as red tape standard. There was missing information, inconsistencies, changing formats, and lots of redundancy. 
    - Some applications had missing pages, some applications probably weren't archived at all. Filings listed party A to party B, and then the next filing in the BATCH would list party C to party D. 
    - The format of the forms changed every few years -- fields were added, others were renamed or disappeared. The requirements for supporting documentation differed from case to case, and year to year.
    - The forms were designed for single licence transfers, not multi-licence transactions. If party A was buying multiple licences from party B, they still had to file individual applications for each licence. This meant a whole lot of redundant paper work -- all the supporting documents were the same, the party details were the same, just a few characters in the entire application would be different. 

On top of the forms making no sense, the scanned files lacked consistent structure, and image quality was often poor. 
    - Files in BATCH 1 were named differently to those BATCH 2, and then those might be different to BATCH 3. On top of that, I couldn't work out if each CALLSIGN/ folder was a **complete set** for that licence number. 
    - Some of the microfiche were so blurry I just made random guesses between '5 or S'.
    - The folder structure meant I was progressing according to CALLSIGN/ not chronological date. As a result, I coudn't identify multi-licence transactions, or cluster forms form the same time period to uncover patterns.

The upshot of these issues was that I had no references for whether I was doing useful work or not, or if I was making progress towards any tangible goal. It took time to work out a lot of these quirks, and once a lot of the data entry I had done became garbage. For example, in the beginning I was recording the first date I saw as the transaction date. It was how the .jpg files were named, so I figured it was good enough. Turns out that was a mistake. 

Data entry is not exactly anyone's favourite past-time, but realising you've been entering junk into your spreadsheets? I can think of few things more demoralising. Except maybe the realisation that you have to do it all again, AND that so far you've only touched a fraction of the total number of scans. I was told they've been scanning these microfiche for almost 4 years...

### BASH those files!

After a month of two of creating basically junk data, I was slowing losing my mind. Worse yet, I was constantly either avoiding or apologising to my supervisor for my lack of progress. I had no idea what to do with all these quirks. The messiest datasets I'd encountered so far were ABS spreadsheets -- missing values, and weirdly named variables. 

My supervisor had told me to just keep note of any questions or issues I came across. The problem was that my list of "things I'm not sure about" was growing faster than the actual data set -- What's the difference between an Assignment and a Transfer? What does "Pro-Forma" mean, and why is it written on some transactions? What if there are more than two parties to a transaction? 

The dataset itself was also not much of a table. "Record information that seems useful." What happens when the supporting documents contain all kinds of useful information? -- lists of subsidary companies, details of other licences owned, notices for the issuance of new licence numbers for partial assignments? Well, in my case, the number of columns and sheets I was working just grew exponentially. 

Eventually I figured out I need to do some reorganising. 

- Organise the folders
- Rename the files
- Regular Expressions & GLOB transformations:
     - BATCH/LICENCE/FILING to COMBINED/FILING by date
     - DATE-LICENCE-NOTE/ to ... 
- master.sh


### Tesseract misadventures (invest in set-up or continue manually? human-in-the-loop decisions)

- lots of googling, stackoverflow
- how to find the right tool?
- installing packages

### ImageMagick (regularising images into individual source units)

- Two to a page -- split fnc
- issues of scans in the middle of the page
- checking for splits -- later didn't need to

### Meta-Tagging, clustering images, elimination (identifying high density images)

- fuzzy tagging 
     - definitely want, definitely don't want, definitely related, useful as a back-up

- High information density
- Legend/notes
- LOG everything

### Finally encoding data, triangulation (detective work)

- progress reference lists (creating more filters)
     - complete list of call signs
     - number of files
     - date ranges with complete transaction sequences
- encoding into the dataset variables
     - pulled 3 doc types -- later focus on one
     - fuzzy entry -- use weird characters
     - record every type of interpretation decision 
     - stay as close to source as possible -- transformations/imputations should be systematically performed
     - VERSION CONTROL FOR DATASETS????

### Reinforcements are here! But who does what? (operationalisation)

- fuzzy tagging with multiple people
- arbitrary batches
- parallel work streams






