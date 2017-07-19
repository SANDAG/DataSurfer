from pyPdf import PdfFileWriter, PdfFileReader
from reportlab.pdfgen import canvas
from reportlab.lib.colors import PCMYKColor, PCMYKColorSep, Color, white,black
from reportlab.lib.pagesizes import letter

import os
import shutil

__author__ = 'cdan'

folder_path = r'E:\Apps\DataSurfer\api\pdf\forecast\12'

c = canvas.Canvas('rect.pdf')
c.setFillColor(white)
#Series 12
c.rect(10,180,575,198, fill=True, stroke=False) #Series 13 Rectangle: Region AND Tract

#Series 13
#c.rect(10,180,555,195, fill=True, stroke=False) #Series 13 Rectangle: Region AND Tract
#c.rect(10,180,555,210, fill=True, stroke=False) #Series 13 Rectangle: Not Region, Tract

c.setFillColor(black)
c.setFontSize(size=10.0)
c.drawString(180, 290, "Income Forecast Under Review")
c.save()

new_pdf = PdfFileReader(file('rect.pdf', 'rb'))

for dirpath, dirnames, files in os.walk(folder_path):
    for file in files:
        old_name = str(dirpath) + os.sep + file[:-4] + '_old.' + file[-3:]
        new_name = dirpath + os.sep + file
        print old_name
        os.rename(dirpath + os.sep + file, dirpath + os.sep + file[:-4] + '_old.' + file[-3:])
        with open(old_name, 'rb') as existing_file:
        
            existing_pdf = PdfFileReader(existing_file)
            output = PdfFileWriter()

            p = existing_pdf.getPage(0)
            page = existing_pdf.getPage(0)
            page.mergePage(new_pdf.getPage(0))
            page.compressContentStreams()
            output.addPage(p)
            output.addPage(existing_pdf.getPage(1))
            output.addPage(existing_pdf.getPage(2))

            # finally, write "output" to a real file
            with open(new_name, 'wb') as new_file:
                output.write(new_file)