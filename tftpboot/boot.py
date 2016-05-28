## Copyright 2016. by James Delancey
import comware
import os
import sys
import json

# Name variables, these can be replaced by SED if needed
serverTftp="10.1.1.1"
serverdataFtp="10.1.1.1"
file2="template.txt"
file3="varMatrix.json"
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
    switchMacAddress=comware.CLI("disp irf | i MAC").get_output()[1][-14:].replace("-","")
    filename2 ='flash:/varMatrix.json'
    fin2=open(filename2,'r')
    switchList=json.loads(fin2.read())
    fin2.close()
#    #print(switchList)
    for switch in switchList:
        if switch==switchMacAddress:
            try:
                comware.CLI("sys ; irf member 2 renumber " + switchList[switch]['IRF'])
            except SystemError: pass
            try:
                comware.CLI("sys ; irf member 3 renumber " + switchList[switch]['IRF'])
            except SystemError: pass
            try:
                comware.CLI("sys ; irf member 1 renumber " + switchList[switch]['IRF'])
            except SystemError: pass
            try:
                comware.CLI("copy ftp://james:demo@" + switchList[switch]['tftpServer'] + "/comware/tftpboot/" + switchList[switch]['firmwareBackup'] + " .")
#    #            comware.CLI("ftp " + switchList[switch]['tftpServer'] + " get " + switchList[switch]['firmwareBackup'])
            except SystemError: pass
            comware.CLI("delete /unreserved *.bin")
            try:
                comware.CLI("boot-loader file flash:/" + switchList[switch]['firmwareBackup'] + " s 1 b")
            except SystemError: pass
            try:
                comware.CLI("boot-loader file flash:/" + switchList[switch]['firmwareBackup'] + " s 2 b")
            except SystemError: pass
            try:
                comware.CLI("boot-loader file flash:/" + switchList[switch]['firmwareBackup'] + " s 3 b")
            except SystemError: pass
            try:
                comware.CLI("copy ftp://james:demo@" + switchList[switch]['tftpServer'] + "/comware/tftpboot/" + switchList[switch]['firmwareMain'] + " .")
    #            comware.CLI("ftp " + switchList[switch]['tftpServer'] + " get " + switchList[switch]['firmwareMain'])
            except SystemError: pass
            try:
                comware.CLI("boot-loader file flash:/" + switchList[switch]['firmwareBackup'] + " s 1 m")
            except SystemError: pass
            try:
                comware.CLI("boot-loader file flash:/" + switchList[switch]['firmwareBackup'] + " s 2 m")
            except SystemError: pass
            try:
                comware.CLI("boot-loader file flash:/" + switchList[switch]['firmwareBackup'] + " s 3 m")
            except SystemError: pass
            comware.CLI("delete /unreserved *.ipe")
            filename3 ='flash:/startup.cfg'
            fin3=open(filename3,'w')
            filename ='flash:/template.txt'
            fin=open(filename,'r')
            data=fin.readlines()
            print switch
            for i in data:
                j= i.replace('{{','""" + ').replace('}}',' + """')
                if '[' in j:
                    fin3.write(eval('"""'+j.replace('"',"'").replace("'''",'"""')+'"""'))
                else: fin3.write(j)
            fin.close()
            fin3.close()
        else : pass



    comware.CLI('startup saved-configuration startup.cfg backup')
    comware.CLI('startup saved-configuration startup.cfg main')
    try: 
        comware.CLI("delete /unreserved *.txt")
        comware.CLI("delete /unreserved *.json")
        comware.CLI("delete /unreserved *.py")
        comware.CLI("delete /unreserved *.pyc")
        comware.CLI("sys ; public-key local create rsa")
        comware.CLI("ping 8.8.8.8")
    except SystemError: pass
    try:
        comware.CLI('reboot force')
    except SystemError: pass


copyFiles()
configureSwitch()
quit()


