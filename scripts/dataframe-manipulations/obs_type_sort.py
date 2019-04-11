import pandas as pd

filename = '_files/Master-licenceEvents-combined_clean.xlsx'
file = pd.read_excel(filename, 0)  # read first sheet

file['obs_type'] = None

numRow = file.shape[0]
print(numRow)

for row_ite in range(0, numRow):
    print(row_ite)
    if pd.isnull(file.loc[row_ite, 'Assignor/Transferor']):
        print('Empty')
        file.at[row_ite, 'obs_type'] = 'Snapshot'

    else:
        print('Not Empty')
        file.at[row_ite, 'obs_type'] = 'Transaction'

print(file.head(100))


def export():
    """Exports the cleaned data to a new excel workbook"""
    output_fileName = '_output/' + 'obs_type.xlsx'
    writer = pd.ExcelWriter(output_fileName, engine='xlsxwriter')

    file.to_excel(writer, sheet_name='0')

    writer.save()

export()
