# Python-pyz-maker
This project has to meet the requirement:

> Udělat **BAT-ťák**, který si vytáhne **pyparsing** a **yaml** z **c:\....\python39-32\lib\site-packages**, odstraní **__pycache__** adresáře 
> a zabalí to s **nulovou kompresí** do **ZIP**u. Pak by se dělal release na **jeden klik** myší.

## You need 7zip:
> https://www.7-zip.org/

## Current version:
> Version 1.3.0
> - Write your python location in Compress.bat here (full path) + lib\site-packages:

> ![image](https://user-images.githubusercontent.com/76277379/131219524-5d61b626-9957-42ae-a6bd-93158666f9ba.png)

> - Write your modules in Modules.dat like: main,pyparsing,yaml... (it reads first from local (".") and next it reads from python location like python import - but only site-packages) 
> - Write it here (only name without ending):

>![image](https://user-images.githubusercontent.com/76277379/130512197-588ec372-9a03-45f7-85ea-5ed52d6c748b.png)

> - Include error detection (not include detection of locked files or folders)


