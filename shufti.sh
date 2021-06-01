# Kindly Configure :
PATH_TO_DNS_Resolvers="[path]/resolvers.txt"
PATH_TO_NucleiTakeoverTemplate="[path]/nuclei-templates/takeovers/"
Path_To_FUZZ_Wordlist="onelistforallshort.txt" 
# Recomended Wordlist : https://raw.githubusercontent.com/six2dez/OneListForAll/main/onelistforallshort.txt
path_to_paramspider="[path]/ParamSpider/paramspider.py" 
# wget: https://github.com/devanshbatham/ParamSpider/blob/master/paramspider.py
path_to_ctfr_tool="[path]/ctfr/ctfr.py"
# wget https://github.com/UnaPibaGeek/ctfr/blob/master/ctfr.py



echo ""
echo "--------------------------------------------------------------"
echo ""
echo "     _______. __    __   __    __   _______  .__________.  __  "
echo "    /       ||  |  |  | |  |  |  | |   ____| |          | |  | "
echo "   |   (---- |  |__|  | |  |  |  | |  |__    |___|  |___| |  | "
echo "    \   \    |   __   | |  |  |  | |   __|       |  |     |  | "
echo ".----)   |   |  |  |  | |   ---  | |  |          |  |     |  | "
echo "|_______/    |__|  |__|  \______/  |__|          |__|     |__| "
echo ""
echo "--------------------------------------------------------------"
echo ""
echo "		Features:"
echo ""
echo "1.	Passive Subdomain Enumeration"
echo "2.	Active Subdomain Enumeration"
echo "3.	crt.sh Subdomain Enumeration"
echo "4.	DNS Subdomain Enumeration"
echo ""
echo "5.	Checks for Subdomain Takeover"
echo ""
echo "6.	Filters active subdomains (DNS Resolution & probing)"
echo "7.	Segragates Subdomains according to response code"
echo ""
echo "8.	Crawling and Recursive Fuzzing for Content Discovery & sensitive file/directory Exposure"
echo ""
echo "9.	Gathering JavaScript Files"
echo ""
echo "10.	Parameter Discovery (Along with Hidden Parameters)"
echo ""
echo "--------------------------------------------------------------"
echo ""
echo "" 
target=$1
echo "All Output stored in /$target "
echo "" 
mkdir $target
cd $target
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Passive Subdomain Enumeration Running for $target \e[0m\n"
echo ""
subfinder -all -d $target -silent >> tempsubdomain.txt
assetfinder --subs-only $target >> tempsubdomain.txt
findomain --quiet -t $target >> tempsubdomain.txt
waybackurls $target | unfurl -u domains >> tempsubdomain.txt
crobat -s $target >> tempsubdomain.txt
cat tempsubdomain.txt | sort -u >> temp2.txt
rm tempsubdomain.txt
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Passive Subdomain Enumeration Completed \e[0m\n"
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Now Running Active Subdomain Enumeration \e[0m\n" 
echo $target | dnsx -retry 3 -silent -r $PATH_TO_DNS_Resolvers >> temp2.txt
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Active Subdomain Enumeration Completed \e[0m\n" 
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Now Running crt.sh Subdomain Enumeration \e[0m\n" 
python3 $path_to_ctfr_tool -d $target -o lolo1.txt >> lolo2.txt
cat lolo1.txt >> ctrshtemp.txt
rm lolo1.txt lolo2.txt
curl "https://tls.bufferover.run/dns?q=.$target" 2>>"verytemp.txt" | jq -r .Results[] 2>>"verytemp.txt" | cut -d ',' -f3 | grep -F ".$target" >> ctrshtemp.txt
rm verytemp.txt
curl "https://dns.bufferover.run/dns?q=.$target" 2>>"verytemp.txt" | jq -r '.FDNS_A'[],'.RDNS'[] 2>>"verytemp.txt" | cut -d ',' -f2 | grep -F ".$target"  >> ctrshtemp.txt
rm verytemp.txt
cat ctrshtemp.txt | sort -u >> crtsh_subs.txt
rm  ctrshtemp.txt
mv temp2.txt temp.txt
cat crtsh_subs.txt >> temp.txt
cat temp.txt | sort -u >> temp2.txt;rm temp.txt
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m crt.sh  Subdomain Enumeration Completed \e[0m\n" 
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Now Running DNS Subdomain Enumeration \e[0m\n" 
# dnsx -retry 3 -a -aaaa -cname -ns -ptr -mx -soa -resp -silent -l temp2.txt -r  $PATH_TO_DNS_Resolvers >> sub_cname.txt
# cat sub_cname.txt | cut -d '[' -f2 | sed 's/.$//' | grep ".$domain$" >> verytemp.txt
# cat verytemp.txt | sort -u >> sub_dns.txt
# rm verytemp.txt
# puredns resolve sub_dns.txt -r $PATH_TO_DNS_Resolvers >> rresolved.txt
# cat rresolved.txt >> temp2.txt
# rm rresolved.txt
cat temp2.txt | grep www. | cut -d w -f4 | sed 's/^.//' >> temp3.txt
cat temp3.txt >> temp2.txt
cat temp2.txt | grep -v www. | sort -u >> all_subs.txt
rm temp2.txt temp3.txt

echo "####################################################################################"
echo "###################      CHECKING FOR SUBDOMAIN TAKEOVER     #######################"
echo "####################################################################################"

cat all_subs.txt | httprobe -prefer-https | nuclei -silent -t $PATH_TO_NucleiTakeoverTemplate -o tko.txt


echo ""
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Now Filtering alive subdomains and Segregating according to Response code \e[0m\n" 
echo ""
cat all_subs.txt | httprobe -prefer-https >> alive_subs.txt
cat alive_subs.txt | cut -d / -f3 | httpx -status-code -silent >> codes.txt
cat codes.txt | grep 200 | cut -d [ -f1 >> 200.txt
cat codes.txt | grep 30 | cut -d [ -f1 >> 30x.txt
cat codes.txt | grep 403 | cut -d [ -f1 >> 403.txt
cat codes.txt | grep 404 | cut -d [ -f1 >> 404.txt

echo "####################################################################################"
echo "###################      Crawling and Recursive Fuzzing     ########################"
echo "####################################################################################"

echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Crawling ... \e[0m\n" 
echo ""
gospider -s "$target" -c 10 -d 1 --other-source -t 50 >> all_crawl.txt; cat all_crawl.txt | sort -u >> spiderout.txt;rm all_crawl.txt; 
cat spiderout.txt | grep .js >> jsfiles.txt; cat spiderout.txt | grep -v .js | grep -v .png | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | unfurl -u paths >> all_crawl.txt

echo $target | gau | sort >> gau_output.txt
cat gau_output.txt | unfurl -u paths | grep -v .js | grep -v .png | grep -v .css | grep -v .svg | grep -v gif >> all_crawl.txt

mv all_crawl.txt no.txt;cat no.txt | sort -u >> all_crawl.txt;rm no.txt

cat all_crawl.txt | awk -vT="$target" '{ print T $0 }' >> all_paths.txt

cat gau_output.txt | grep .js >> jsfiles.txt;
mv jsfiles.txt shew.txt; cat shew.txt | sort -u >> jsfiles.txt;rm shew.txt
echo ""
echo "JAVASCRIPT Files Enumerated & saved in /$target/jsfiles.txt" 
echo ""
echo ""
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Fuzzing for sensitive files & Directories \e[0m\n" 
echo ""
temp="https://$target/FUZZ"
ffuf -mc all -fc 404 -ac -t 400 -sf -w $Path_To_FUZZ_Wordlist -u $temp 
echo ""
echo ""
echo "####################################################################################"
echo "###################        Parameter Discovery              ########################"
echo "####################################################################################"
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Collecting Parameters \e[0m\n" 
python3 $path_to_paramspider --domain $target --level high --exclude eot,jpg,jpeg,gif,css,tif,tiff,png,ttf,otf,woff,woff2,ico,pdf,svg,txt,js --quiet --output params.txt >> tmpparam.txt; rm tmpparam.txt
cat ./output/params.txt >> params.txt ; rm -r output/;
gau -subs $target | grep -v png | grep -v jpg | grep -v .js  | grep -v woff | grep -v svg >> gau_output.txt;
mv gau_output.txt temp6.txt;cat temp6.txt | sort -u >> gau_output.txt ; rm temp6.txt
cat gau_output.txt | grep = >> params.txt
sed '/^FUZZ/d' -i params.txt
mv params.txt temp6.txt;cat temp6.txt | sort -u >> params.txt ; rm temp6.txt
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Finding Hidden Parameters \e[0m\n" 
arjun -i params.txt -t 30 -oT hidden_params.txt
