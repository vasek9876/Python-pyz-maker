# Batch-handler
Tento projekt má vyhovět požadavku:

> Udělat **BAT-ťák**, který si vytáhne **pyparsing** a **yaml** z **c:\....\python39-32\lib\site-packages**, odstraní **__pycache__** adresáře 
> a zabalí to s **nulovou kompresí** do **ZIP**u. Pak by se dělal release na **jeden klik** myší.


## Current version:
> Version 1.0.2 (Build 4)
> - set file location (pyparsing and yaml - file or folder)
> - generate folder "package"
> - copy files (pyparsing and yaml) to folder "package"
> - delete _pycache_ from tree (from folder "package")
> - compress the folder "package"
> - save compress folder next to the ".bat"
> - delete folder "package"


