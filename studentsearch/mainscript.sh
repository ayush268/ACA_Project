#!/bin/bash

clear;
#sl;
clear;

figlet "Welcome";
cowsay "Hi, How are you?";

echo -e "\n\n\nPress '1' to search a student by ROLL NO\n\n";

echo -e "Don't Remember the ROLL NO? No worries, we have other options\n\n";
echo -e "Press '2' to search by OTHER INFO.\n\n";

echo -e "You can always exit by pressing '0'\n\n"

echo -n "Your Choice: "
read mynum;

while [ true ] ; do
if [ $mynum = 1 ] ; then
	clear;
	echo -n "Please enter the ROLL NO: ";
	read roll_no;
	while [ true ] ; do
		grep -w -q -r -P -rl -i "Roll\s*No\s*-\s*$roll_no"  ./Student_Search_Data/;
		if [[ $? = 0 && $roll_no != '.' && $roll_no = *[!\ ]* ]] ; then
			 clear;
			 sed -n 1,12p $(grep -i -w -r -P -rl "$roll_no"  ./Student_Search_Data/);
				
			 cowthink "Hmm... I think You Got it.."
			
			 echo -e -n "\n\nIf You want to see the picture Press 1: "
			 read num;
			 clear
			 if [ $num = 1 ] ; then
				link=$(cat $(grep -i -w -r -P -rl "$roll_no" ./Student_Search_Data/) | grep -P -o "http\S+\.jpg")
				wget $link
				clear
				link=$(echo "$link" | grep -o -P "\d+_\d\.jpg")
        display $link
			 fi;
		 	 break;
		else
			 clear
			 echo -e "You entered '$roll_no'\n" 
			 echo -e "Please enter a VALID ROLL NO. \n"
			 echo -e "Else If you want to leave Press '0'\n"
			 echo -n "ROLL NO: ";
			 read roll_no
			 if [ $roll_no = 0 ] ; then
				break;
			 fi;
		fi;
		if [ $roll_no = 0 ] ; then
			break;
		fi;
	done;
fi;
if [ $mynum = 2 ] ; then
	clear;
	echo -e "Please Enter the DETAILS you KNOW and press ENTER\n\n";
	echo -e "Leave BLANK the details which you dont know \n\n";
	
	echo -n "NAME: "
	read name;

	while [ true ] ; do
	echo -e "\nEnter 1 for AE\nEnter 2 for BSBE\nEnter 3 for Chemical\nEnter 4 for Chemistry\nEnter 5 for Civil\nEnter 6 for CSE\nEnter 7 for Earth Sciences\nEnter 8 for ECO\nEnter 9 for EE\nEnter 10 for IME\nEnter 11 for MSE\nEnter 12 for MTH\nEnter 13 for ME\nEnter 14 for PHY" 
	echo -e -n "\nDEPARTMENT : "
	read department;
	if [[ $department -ge 1 && $department -le 14 ]] || [[ $department != *[!\ ]* ]] ; then
		break;
	fi;
	done;
	echo -e -n "\nGender: "
	read gender;
	echo -e -n "\nProgram (mtech/btech/bs/phd/msc/mba/mdes): "
	read program;
	echo -e -n "\nHall: "
	read hall;
	echo -e -n "\nE-mail: "
	read email;
	echo -e -n "\nBlood Group (a+,b+,o+,ab+,a-,b-,o-,ab-): "
	read blood;
	echo -e -n "\nCategory (st/gn/ob/gp/sc/on/): "
	read category;	

	if [[ $department -ge 1 && $department -le 14 ]] ; then

	    if [ $department = 1 ] ; then
		    department=aerospace;
	    fi;
	    if [ $department = 2 ] ; then
            department=biol;
        fi;
	    if [ $department = 3 ] ; then
            department=chemical;
        fi;
	    if [ $department = 4 ] ; then
            department=chemistry;
        fi;
	    if [ $department = 5 ] ; then
            department=civil;
        fi;
	    if [ $department = 6 ] ; then
            department=computer;
        fi;
	    if [ $department = 7 ] ; then
            department=earth;
        fi;
	    if [ $department = 8 ] ; then
            department=eco;
        fi;
	    if [ $department = 9 ] ; then
            department=electrical;
        fi;
	    if [ $department = 10 ] ; then
            department=ind;
        fi;
	    if [ $department = 11 ] ; then
            department=material;
        fi;
	    if [ $department = 12 ] ; then
            department=math;
        fi;
	    if [ $department = 13 ] ; then
            department=mechanical;
        fi;
	    if [ $department = 14 ] ; then
            department=phy;
        fi;
	
    fi;

	clear;
	info=$(grep -r -P -rl -i "1" ./Student_Search_Data/)
	if [[ $name = *[!\ ]* && $name != '.' ]] ; then
		name=$(echo "${name// /  }")	
		info=$(grep -r -P -rl -i "Name - .*$name" $info)
	fi;
	if [[ $department = *[!\ ]* && $department != '.' ]] ; then
		info=$(grep -o -r -P -rl -i "Dept\. - $department" $info)
	fi;
	if [[ $program = *[!\ ]* && $program != '.' ]] ; then
		info=$(grep -r -P -rl -i -w "Program - $program" $info)
	fi;	
	if [[ $gender = *[!\ ]* && $gender != '.' ]] ; then
		info=$(grep -r -P -rl -i "Gender - $gender" $info)
	fi;
	if [[ $hall = *[!\ ]* && $hall != '.' ]] ; then
		if [ $hall = 10 ] ; then
                	hall=X;
       		fi;
      		if [ $hall = 11 ] ; then
                	hall=XI
	        fi;
		info=$(grep -r -P -rl -i "Address - HALL$hall\s*," $info)
	fi;
	if [[ $email = *[!\ ]* && $email != '.' ]] ; then
		info=$(grep -r -P -rl -i "E-mail - .*$email@iitk.ac.in" $info)
	fi;
	if [[ $blood = *[!\ ]* && $blood != '.' ]] ; then
		info=$(grep -r -P -rl -i -w "Blood Group - $blood" $info)
	fi;
	if [[ $category = *[!\ ]* && $category != '.' ]] ; then
		info=$(grep -r -P -rl -i "Category - $category" $info)	
	fi;
	
	count=$(echo "$info" | grep -P -n "\.txt" -c )
		
	if [[ $info = *[!\ ]* ]]; then
		awk '!/.jpg/' $info
	fi;
	
	echo -e "Total $count Results found\n\n"

	echo -e "Did you find what you were lookin for?\n\n";
	echo -e "If YES, Please Press 1 for entering the ROLL NO\n\n";
	echo -e "If NO, Please Press 2 for changing other options\n\n";
	echo -e "Remember you can always exit by pressing 0\n\n";
	echo -n "Your Choice: ";
	read mynum;
	
	if [ $mynum = 0 ] ; then
		break;
	fi;	
else
	if [ $mynum = 0 ] || [ $roll_no = 0 ] ; then
		break;
	fi;
	clear;
	
	figlet "Welcome";
	cowsay "Hi, How are you?";

	echo -e "Press '1' to search a student by ROLL NO\n\n";

	echo -e "Don't Remember the ROLL NO? No worries, we have other options\n\n";
	echo -e "Press '2' to search by OTHER INFO.\n\n";

	echo -e "You can always exit by pressing '0'\n\n"

	echo -n "Your Choice: "
	read mynum;

fi;
done;

rm *.jpg
