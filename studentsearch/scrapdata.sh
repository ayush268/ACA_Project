#!/bin/bash

#seq 16101049 16101051 | xargs -n1 -P0 -I{} bash -c
for i in $(seq 16101049 16101051) ; do
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

blood=$(echo "$a" | grep -P -A1 "Blood Group:" | tail -1 | grep -o -P "\S+" ) ;

category=$(echo "$a" | grep -P -A1 "Category:" | grep -o -P "b>(\S+)<b" | cut -d\> -f2 | cut -d\< -f1) ;

echo $email | grep -q -P "@" ;
if [ $? != 0 ] ; then
	continue;
fi;

echo $name;
echo $roll_no;
echo $gender;
echo $program;
echo $department;
echo $hostel;
echo $email;
echo $blood;
echo $category;

done
