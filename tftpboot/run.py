import os
import sys
import json
import comware

def setMember(irfMemberNumber):
    """Sets the IRF member number in the switch.
    """
    comware.CLI("sys ; irf member 2 renumber " + irfMemberNumber)
    comware.CLI("sys ; irf member 1 renumber " + irfMemberNumber)

def levelFirmware(firmwareMain,firmwareBackup,serverFtp,serverTftp):
    """Update the firmware in the switch. 
    Pulls the files firmware main and backup from FTP server.
    """
    comware.CLI("tftp " + serverTftp + " get " + firmwareBackup)
    comware.CLI("boot-loader file flash:/" + firmwareBackup + " s 1 b")
    comware.CLI("delete /unreserved *.bin")
    comware.CLI("tftp " + serverTftp + " get " + firmwareMain)
    comware.CLI("boot-loader file flash:/" + firmwareMain + " s 1 m")
    comware.CLI("delete /unreserved *.ipe")
#setMember()
#levelFirmware()

switchMacAddress=comware.CLI("disp irf | i MAC").get_output()[1][-14:].replace("-","")
filename2 ='flash:/varMatrix.json'
fin2=open(filename2,'r')
switchList=json.loads(fin2.read())
fin2.close()
#print(switchList)
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
#            comware.CLI("ftp " + switchList[switch]['tftpServer'] + " get " + switchList[switch]['firmwareBackup'])
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
#            elif '"' or "'" in j:
#                print(j.replace('"','/"').replace("'","/'"))
            else: fin3.write(j)
        fin.close()
        fin3.close()
    else : pass

comware.CLI('startup saved-configuration startup.cfg backup')
comware.CLI('startup saved-configuration startup.cfg main')
comware.CLI("delete /unreserved *.txt")
comware.CLI("delete /unreserved *.json")
comware.CLI("delete /unreserved *.py")
comware.CLI("delete /unreserved *.pyc")
#comware.CLI("delete file*")
comware.CLI("sys ; public-key local create rsa")
try:
    comware.CLI('reboot')
except SystemError: pass
quit()
