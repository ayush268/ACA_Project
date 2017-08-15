#!/bin/bash


for i in $(seq 13001 13819) ; do

a=$(curl -s http://oa.cc.iitk.ac.in/Oa/Jsp/OAServices/IITk_SrchRes.jsp?sbm=Y -d typ="stud" -d numtxt=$i) ;

name=$(echo "$a" | grep -P -A1 "Name:" | tail -1 | grep -o -P "(\w+\s+)*\w+") ;

roll_no=$(echo "$a" | grep -P -A1 "Roll\s+No:" | tail -1 | grep -o -P "\d+") ;

echo "$a" | grep -P -A1 "Gender:" | tail -1 | grep -q -P "F" ;
if [ $? = 0 ] ; then
        gender=Female;
else
        gender=Male;
fi;

department=$(echo "$a" | grep -P -A1 "Department:" | tail -1 | grep -o -P "(\S+\s+)*\S+") ;

program=$(echo "$a" | grep -P -A1 "Program:" | tail -1 | grep -o -P "\w+") ;

hostel=$(echo "$a" | grep -P -A1 "Hostel Info:" | tail -1 | grep -o -P "\w+,*\s*\S*") ;

email=$(echo "$a" | grep -P -A1 "mailto:\S+>\w+@" | grep -o -P ":\w+@iitk.ac.in" | cut -d\: -f2) ;

blood=$(echo "$a" | grep -P -A1 "Blood Group:" | tail -1 | grep -o -P "\S+") ;

category=$(echo "$a" | grep -P -A1 "Category:" | grep -o -P "b>(\S+)<b" | cut -d\> -f2 | cut -d\< -f1) ;

image=$(echo "$a" | grep -P -A1 "img\s*src=.http://oa.cc.iitk.ac.in:\d+/Oa/Jsp/Photo/$roll_no..\.\w+." | cut -d\" -f2) ;

#echo "Roll No - $roll_no" >> $roll_no.txt;
#echo "Name - $name" >> $roll_no.txt;
#echo "Gender - $gender" >> $roll_no.txt;
#echo "Dept. - $department" >> $roll_no.txt;
#echo "Program - $program" >> $roll_no.txt;
#echo "Address - $hostel" >> $roll_no.txt;
#echo "E-mail - $email" >> $roll_no.txt;
#echo "Blood Group - $blood" >> $roll_no.txt;
#echo "Category - $category" >> $roll_no.txt;
echo -e "\n\n" >> $roll_no.txt
echo "Image - $image" >> $roll_no.txt;

done ;
echo complete ;

