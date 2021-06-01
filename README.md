# Shufti
Latest Recon Workflow Framework
Fast and Deep Recon on Large Scope to get the Juicy Stuff

# Features

- Passive Subdomain Enumeration (Multiple latest Tools used)
- Active Subdomain Enumeration  (DNSx)
- Subdomain Enum by Certificate Transparancy
- DNS Subdomain Enumeration

.

- Scans for Subdomain Takeover using Nuclei Templates

.

- Filters active subdomains (DNS Resolution & probing)
- Segragates Subdomains according to response code
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
# Recomended Wordlist : https://raw.githubusercontent.com/six2dez/OneListForAll/main/onelistforallshort.txt
path_to_paramspider="[path]/ParamSpider/paramspider.py" 
# wget: https://github.com/devanshbatham/ParamSpider/blob/master/paramspider.py
path_to_ctfr_tool="[path]/ctfr/ctfr.py"
# wget https://github.com/UnaPibaGeek/ctfr/blob/master/ctfr.py
```
# Requirements
- Golang
- Required_tools.txt
