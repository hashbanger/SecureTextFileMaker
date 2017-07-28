#!/bin/sh

#===============================================================All TheFunctions===================================================================================#

createFile()      					     #Function to create file and input
{
echo "Enter the name of the file"
read fileName
clear
echo "Begin To Write. Press ctrl+d when done"
cat >> "$fileName"
echo "Do you want to save, y/n ?"
read confirmStore
if [ "confirmStore" = "n" ]
then
rm -f "$fileName"
fi
return
}

statics()						#To show the statics of the contacts stored
{
ls > .list_of_files
nof=$(wc -l .list_of_files) 2> .errFile 
nof=${nof%%' '*}
echo "Total no. of files= $nof"
while read line
do
echo $line
done < .list_of_files
rm -f $line $nof
}

reset()
{
echo "Are you sure? y/n?"
read conf
if [ "$conf" = "y" ]
then
cd
rm -r .secTFC
rm -f *e
exit 0
fi
}

exitApp()                                                 #Exit The App
{
rm -f *e
exit 0
}

editFile()
{
echo "Enter the file you want to search"
read fileOpen
nano "$fileOpen"
}

openFile()
{
echo "Enter the file you want to search"
read fileOpen
ls > .list_of_files
schOfFile=$(grep "$fileOpen" .list_of_files)
schOfFile=${schOfFiles%%':'*}
if [ "schOfFile" != "0" ] 
then
clear
cat "$fileOpen"
fi
}
main_choice()                                    	   #Main Menu Functions Callings
{
	while [ $choice_1 != "" ]
	do
	case $choice_1 in
	a|A) createFile;;
	b|B) statics;;
	c|C) openFile;;
	e|exit) exitApp;;
	R|r) reset;;
	ed|ED) editFile;;
	*) echo "Invalid Choice";;
	esac
return
done
}

#===================================================================================================================================================================


#=================================================================Main Program Starts===============================================================================
clear
chmod 777 .secTFC 2> .errFile
chmod 777 .secTFC/* 2> .errFile
chmod 777 .secTFC/.appPasswd 2> .errFile
echo 
echo "------------------------Secure Text File Creator--------------------"
echo "By Prashant Brahmbhatt"
echo "prashant.brahmbhatt32@outlook.com"
sleep 0.5
exiter="y"
if [ -f .secTFC/.appPasswd ]
then
	echo "\nEnter the password for authorisation"
	read confPasswd
	setPasswd=$(cat .secTFC/.appPasswd)
		if [ "$confPasswd" = "$setPasswd" ]
		then
			while [ $exiter != "n" ]
			do
			cd .secTFC
			echo "----------------------------------"
			echo "| Enter your Choice              |"
			echo "| a) Create a new file           |"
			echo "| b) Statics of files            |"
			echo "| c) Open a file                 |" 
			echo "| ed) Edit File                  |"
			echo "| r) Reset App                   |"
			echo "| e) Exit                        |"
			echo "----------------------------------"
			read choice_1
			main_choice
			echo "do you want to continue with the Application? y/n?"
			read exiter
			clear			
			cd
			done
		else
		echo "Wrong Password! Bye!"
		exit 0
		fi
elif ! [ -d .secTFC ]
then
	mkdir .secTFC
	echo "First Time Run"	
	echo "Set a password you will need everytime for authorisation"
	read setPasswd
	echo "Enter password to confirm"
	read confPasswd
 		if [ "$confPasswd" = "$setPasswd" ]
		then
			echo "Password set. Please re-run the file"
			echo $setPasswd> .secTFC/.appPasswd 		
		else
		echo "Passwords Do not Match! Re-run the app"		
		fi

fi
$(cd)
rm -f *e
chmod 0000 .secTFC/*
chmod 0000 .secTFC/.appPasswd 
chmod 0000 .secTFC
exit 0

