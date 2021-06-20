# Shufti
Latest Recon Workflow Framework

Fast and Deep Recon on Large Scope to get the Juicy Stuff

```
     _______. __    __   __    __   _______  .__________.  __  
    /       ||  |  |  | |  |  |  | |   ____| |          | |  | 
   |   (---- |  |__|  | |  |  |  | |  |__    |___|  |___| |  | 
    \   \    |   __   | |  |  |  | |   __|       |  |     |  | 
.----)   |   |  |  |  | |   ---  | |  |          |  |     |  | 
|_______/    |__|  |__|  \______/  |__|          |__|     |__|
```

Jump To :

- [Features](https://github.com/utkarsh24122/Shufti/blob/main/README.md#features)                

- [Installation](https://github.com/utkarsh24122/Shufti/blob/main/README.md#installation)

- [Requirements](https://github.com/utkarsh24122/Shufti/blob/main/README.md#requirements)

- [Usage](https://github.com/utkarsh24122/Shufti/blob/main/README.md#usage)

- [ScreenShots](https://github.com/utkarsh24122/Shufti/blob/main/README.md#screenshots)

- [Development](https://github.com/utkarsh24122/Shufti/blob/main/README.md#development) 


# Features

- Passive Subdomain Enumeration (Multiple latest Tools used)
- Active Subdomain Enumeration  (DNSx)
- Subdomain Enum by Certificate Transparency
- DNS Subdomain Enumeration

.

- Scans for Subdomain Takeover using Nuclei Templates

.

- Filters active subdomains (DNS Resolution & probing)
- Segregates Subdomains according to response code

.

- Crawling and Recursive Fuzzing for Content Discovery & sensitive file/directory Exposure

.

- Gathering JavaScript Files 

.

- Parameter Discovery (Along with Hidden Parameters)

# Installation
```
$ git clone https://github.com/utkarsh24122/Shufti
$ cd Shufti
$ chmod +x shufti.sh

```
open shell file and configure
```
# Kindly Configure :
PATH_TO_DNS_Resolvers="[path]/resolvers.txt"
PATH_TO_NucleiTakeoverTemplate="[path]/nuclei-templates/takeovers/"
Path_To_FUZZ_Wordlist="onelistforallshort.txt" 
path_to_paramspider="[path]/ParamSpider/paramspider.py" 
path_to_ctfr_tool="[path]/ctfr/ctfr.py"
```
# Requirements
- Golang
- [Required Tools](https://github.com/utkarsh24122/Shufti/blob/main/Required_tools.txt)
PS: working on a single script to install all tools at once!

# Usage
```
./shufti.sh target.com
```
# ScreenShots
![ss1](https://user-images.githubusercontent.com/54320208/120292073-977e5080-c2e1-11eb-9979-5675e51bd916.PNG)
![ss2](https://user-images.githubusercontent.com/54320208/120292127-a6fd9980-c2e1-11eb-9ed6-55dff675fb5f.PNG)
![ss3](https://user-images.githubusercontent.com/54320208/120292164-b0870180-c2e1-11eb-835b-a315959a98e5.PNG)
![ss4](https://user-images.githubusercontent.com/54320208/120292213-bd0b5a00-c2e1-11eb-92ed-0bde06c09fab.PNG)

# Development
- Working on Including Automated OSINT

