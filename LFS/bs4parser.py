#!/usr/bin/env python2

import sys,re
from bs4 import BeautifulSoup

file = open(sys.argv[1], 'r')
doc = file.read()
file2 = open(sys.argv[2], 'r')
f2 = file2.read()
soup = BeautifulSoup(doc, 'html.parser')

regex = r"([a-zA-Z]+[\w-]*)-"
fr = r"(\S+).tar"

pdirec = ''
count = 1

sys.stdout=open(sys.argv[3], 'a')
print ("#!/bin/bash\n\nset -e\nset -x\n\ntime {\n")

for item in soup.find_all("div", {"class": "wrap"}):
    x = str(re.findall(regex,item.contents[1].text))
    x = x[3:-2]
    x = x.lower()
    r2 = r"\s" + re.escape(x) + r"\S+"
    filename = str(re.findall(r2,f2))
    filename = filename[4:-2]
    directory = str(re.findall(fr,filename))
    directory = directory[2:-2]
    
    sys.stdout=open(sys.argv[3], 'a')
    print ("cd /mnt/lfs/sources/")
    if count > 1:
        #sys.stdout=open(sys.argv[3],'a')
        print ("rm -rf " + pdirec)
        #sys.stdout.close()
    print ("tar -xvf " + filename)
    print ("cd " + directory + "\n")
    sys.stdout.close()

    for f in item.contents[5].find_all("kbd", {"class": "command"}):
        sys.stdout=open(sys.argv[3], 'a')
        print f.text
        sys.stdout.close()
    
    sys.stdout=open(sys.argv[3],'a')
    print ("\n" + "#**************************************************************" + "\n")
    sys.stdout.close()
    count += 1
    pdirec = directory

sys.stdout=open(sys.argv[3],'a')
print ("}")
sys.stdout.close()
