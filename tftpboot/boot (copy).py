# Comware Ansible by CSV  wookieware 2016
# Base on James Delancy's orighinal version this script
# uses the python "string" import to access the Template function

import comware
import os
import sys
import csv
from string import Template

# Create application variables
#--------------------------------------------------
count = 0
serverTftp="172.16.0.2"
serverdataFtp="172.16.0.2"
file2="ansible_template.txt"
file3="varMatrix.csv"
#--------------------------------------------------


def copyFiles():
    try:
        comware.CLI("system ; interface m0/0/0 ; ip address dhcp")
    except SystemError:
        pass
    try:
        comware.CLI("tftp " + serverTftp + " get " + file2)
    except SystemError:
        pass
    try:
        comware.CLI("tftp " + serverTftp + " get " + file3)
    except SystemError:
        pass

def configureSwitch():
	count = 0
	#open the template
	form = open('flash:/ansible_template.txt', 'r')
	src = Template( form.read() )
	# ------------------------------------------------	
	
	#open the csv file build Dictionary
    
	csvfile = open('flash:/varMatrix.csv', 'r')
	content = csv.DictReader(csvfile)
	switch = []
	print switch
	for row in content:
		switch.append(row)

	# how many switches do we have? 		
	check = len(switch) 
  
	switchMacAddress=comware.CLI("disp irf | i MAC").get_output()[1][-14:]


	while (count < check):
		#do the substitution
		if switchMacAddress == switch[count]['mac']:
			result = src.substitute(switch[count])
			config = open('flash:/startup.cfg','w')
			config.write(result)
		count = count + 1

def cleanup():

	comware.CLI('startup saved-configuration startup.cfg backup')
	comware.CLI('startup saved-configuration startup.cfg main')
	comware.CLI('delete /unreserved *.txt')
	comware.CLI('delete /unreserved *.csv')
	comware.CLI('sys ; public-key local create rsa')
	comware.CLI('ping 8.8.8.8')
	comware.CLI('reboot force')


copyFiles()
configureSwitch()
cleanup()
quit()
