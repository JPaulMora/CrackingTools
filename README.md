# CrackingTools

Currently these are a bunch of MD5 scripts that use online databases for hash cracking, although this method of cracking 
sounds dumb it actually works when you realize no mask/dictionary would have gotten this one:
`Li4vLi4vLi4vLi4vLi4vLi4vLi4vLi4vLi4vLi4vZXRjL3Bhc3N3ZAAucG5n`
(yes this was found by one of the scripts). 

Not to mention, these can be run anywere **Bash** and **Curl** are \*or can be\* installed consuming almost no resources other
than some bandwith. Due to the lack of speed of this method I would recomend you to use these as your last cracking resource using
only hashes that your CPU/GPU crackers wouldnt take in a Day.

The *md5crack.sh* file needs an API key (go [get one free](http://md5crack.com/api)) and paste it inside the script. For debugging
there are two files which contain the JSON response of a successful and failed crack.

The crackers make a **pot** file in John The Ripper format, any hash found in there won't be cracked so feel free to swap those out.
