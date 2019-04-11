#  combine_colin_chath.py
#  merges multiple 'Kx' files into a single spreadsheet
#  usage: python3 combine_colin_chath.py file1.xlsx file 2.xlsx ...
#  note: create a folder named "_output" in the working directory before running the script

# import libraries
import pandas as pd
import sys as sys
import os.path as osp
import time

start = time.time()  # record time script began at (diagnostic purposes)

#  take arguments following the script name from the command line and store in a list
arg = sys.argv[1:]
numFiles = len(arg)

#  check conditions before beginning script. if no files specified, files do not exist or
#                                                                incorrect format: exit script.
if numFiles == 0:
    sys.exit('No file(s) specified, please try again!')

filenames = arg

for check_file_ite in range(0, numFiles):  # iterate on files provided
    if osp.isfile(filenames[check_file_ite]) == False:
        sys.exit('File(s) does not exist, please try again!')

    if '.xlsx' not in filenames[check_file_ite]:
        sys.exit('File(s) format incorrect, please try again! (Remember to include \'.xlsx\')')

#  record number of sheets per workbook
numSheets = []

for file_ite in range (0, numFiles):
    numSheets.append(len(pd.ExcelFile(filenames[file_ite]).sheet_names))

#  store sheets in a list for easy access
sheets = []

for file_ite in range(0, numFiles):
    for sheet_ite in range(0, numSheets[file_ite]):
        sheets.append(pd.read_excel(filenames[file_ite], sheet_ite))

#  store variable names in each sheet in a list
var_names = []

for file_ite in range(0, numFiles):
    for sheet_ite in range(0, numSheets[file_ite]):
        var_names.append(tuple(list(sheets[sheet_ite])))  # NB list had to be converted to tuple
        # to use the set function as lists are unhashable

#  determine whether the variable sets are consistent from sheet to sheet
var_set = set(var_names)  # convert list to set to recover unique variable sets
print(var_set)
var_setNum = len(var_set)

#  sets contain the unique values contained in a list. if there is only 1 element in the set,
#  there is only one unique set of variables in the sheets and, thus, they are consistent.
if var_setNum == 1:
    print('Variables are consistent')

else:
    print(str(var_setNum) + ' unique variable sets:')
    for var_ite in range(0, var_setNum):
        print(list(var_set)[var_ite])

    sys.exit('Variables are not consistent. Script will exit')

#  create an empty data frame to merge the sheets into
ms = pd.DataFrame()

for ms_ite in range(0, sum(numSheets)):
    ms = pd.concat([ms, sheets[ms_ite]], axis=0, sort=False)


#  export the data frame
output_fileName = './_output/colin_chath_combined.csv'
print('File created:' + output_fileName)
ms.to_csv(output_fileName, sep=',')

print('Process completed in ' + str(round(time.time() - start, 2)) + ' seconds.')