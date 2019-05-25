# AdVirC

[![Status: Alpha](https://img.shields.io/badge/Status-Alpha-red.svg?style=for-the-badge)](#)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-black.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0)
[![Latest Release](https://img.shields.io/badge/Latest-Release-blue.svg?style=for-the-badge)](https://github.com/MikronT/AdVirC/releases/latest)

<!--
[![Status: Pre-Alpha](https://img.shields.io/badge/Status-Pre--Alpha-black.svg?style=for-the-badge)](#)

[![Status: Beta](https://img.shields.io/badge/Status-Beta-orange.svg?style=for-the-badge)](#)
[![Status: Pre-Release](https://img.shields.io/badge/Status-Pre--Release-yellow.svg?style=for-the-badge)](#)
[![Status: Release](https://img.shields.io/badge/Status-Release-green.svg?style=for-the-badge)](#)
-->

### Version name: *AdVirC v2.0 Alpha 2*

AdVirC (AdVirC Removal Tool or AdVirC RT) is a free **open source** console program for cleaning PCs from Adware, Malware, Trojans, Miners and rubbish for Windows 10.

*If you have ads, third-party programs or your computer live your life, I may be able to help you.*

*Developed only for Windows 10*

Utility is in Alpha-period, so there may be false positives and program errors. Some features do not working or are not exist yet. You must be patient.



## Features
- Interface
  - simple and understandable
  - dynamically updating loading window (you can close it if you want)
  - temporary files cleaning
- Databases
  - downloading
  - import from desktop
- Settings
  - settings saving
  - autoupdate for program and databases with reminder
  - update channel
- Exceptions for cleaning
- About and help menus



## Keys
| Key Name          | Option          | Description                           |
|-------------------|-----------------|---------------------------------------|
| filesChecking     | [boolean] false | to skip startup files checking        |
| wait              | [integer] 5     | start delay in seconds (default is 0) |

### How to run AdVirC with specified keys?
Run Command Prompt as admin and enter the command like this:

```
"[Path]\starter.cmd" --key_[KeyName]=[Options] --key_[KeyName2]=[Options]

"C:\Users\Admin\Desktop\AdVirC\starter.cmd" --filesChecking=true --wait=20
```

| Syntax marking | Description                   |
|----------------|-------------------------------|
| Path           | Path to the starter.cmd file  |
| KeyName        | Key name from the first table |
| Options        | Options from the first table  |

<!--
| ...            | Other keys and options        |
-->

Note: you can combine the keys as you wish.



## Disclaimer
- I can not guarantee 100% treatment. I must "catch" the virus, and only after the research the virus enters the database. It takes some time.
- *I am not responsible for any damage to your computer.* I am not responsible for any lost files or data.
- Everything that removes the utility is considered to be viral and adware. If you need it, download again.
- It is my hobby, not work.



## Version History
| Date       | Version Name   | Version Code    |
|------------|----------------|-----------------|
| 13.05.2019 | v2.0 Alpha 2   | 2.0.0.1.2.0     |
| 06.05.2019 | v2.0 Alpha 1   | 2.0.0.1.1.0     |
| 27.11.2018 | v2.0 Pre-Alpha | 2.0.0.0.0.0     |

<!--
AdVirC v2.0 Alpha 1                2.0.0.1.1.0
AdVirC v2.0 Alpha 2                2.0.0.1.2.0
AdVirC v2.0 Beta 1                 2.0.0.2.1.0
AdVirC v2.0 Pre-Release 1          2.0.0.3.1.0
AdVirC v2.0 Release                2.0.0.4.0.0

AdVirC v2.1 Beta 1                 2.1.0.2.1.0
AdVirC v2.1 Beta 1 Nightly 001     2.1.0.2.1.0.001
AdVirC v2.1 Release                2.1.0.4.0.0
-->