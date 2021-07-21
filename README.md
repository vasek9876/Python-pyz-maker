# Batch-handler
This project has to meet the requirement:

> Udělat **BAT-ťák**, který si vytáhne **pyparsing** a **yaml** z **c:\....\python39-32\lib\site-packages**, odstraní **__pycache__** adresáře 
> a zabalí to s **nulovou kompresí** do **ZIP**u. Pak by se dělal release na **jeden klik** myší.

## You need to download:
> https://www.7-zip.org/

## Current version:
> Version 1.0.2-alpha
> - set file location (pyparsing and yaml - file or folder)
> - generate folder "package"
> - copy files (pyparsing and yaml) to folder "package"
> - delete _pycache_ from tree (from folder "package")
> - compress the folder "package"
> - save compress folder next to the ".bat"
> - delete folder "package"

## Features:
> Version 1.1.0-alpha
> - set file location from list (by for cycle)
> - find all modules with name (folder+file/only one)
