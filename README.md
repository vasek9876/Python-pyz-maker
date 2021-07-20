# Batch-handler
Tento projekt má vyhovět požadavku:

> Udělat **BAT-ťák**, který si vytáhne **pyparsing** a **yaml** z **c:\....\python39-32\lib\site-packages**, odstraní **__pycache__** adresáře 
> a zabalí to s **nulovou kompresí** do **ZIP**u. Pak by se dělal release na **jeden klik** myší.


## Current version:
> Version 0.1.0 (Build 1)
> - set file location (pyparsing and yaml - file or folder)
> - generate folder "test2"
> - copy files (pyparsing and yaml) to folder "test2"
> - delete _pycache_ from tree (from folder "test2")
> - compress the folder "test2"
> - save compress folder next to the ".bat"
> - delete folder "test2"



