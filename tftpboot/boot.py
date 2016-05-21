# Copyright 2016. by James Delancey
import comware
import os
import sys
import json

# Name variables, these can be replaced by SED if needed
serverTftp="10.1.1.1"
serverdataFtp="10.1.1.1"
switchMacAddress=comware.CLI("disp irf | i MAC").get_output()[1][-14:].replace("-","")

switchSysname=boot_dict[switchMacAddress][0]
irfMemberNumber=boot_dict[switchMacAddress][1]
switchLoopback=boot_dict[switchMacAddress][2]
firmwareMain=boot_dict[switchMacAddress][3]
firmwareBackup=firmwareMain
configMain=switchMacAddress + "_config.cfg"
configBackup=configMain

def setMember(irfMemberNumber):
    """Sets the IRF member number in the switch.
    """
    comware.CLI("sys ; irf member 2 renumber " + irfMemberNumber)
    comware.CLI("sys ; irf member 1 renumber " + irfMemberNumber)

def levelFirmware(firmwareMain,firmwareBackup,serverFtp,serverTftp):
    """Update the firmware in the switch. 
    Pulls the files firmware main and backup from FTP server.
    """
    comware.CLI("tftp " + serverTftp + " get " + firmwareMain)
    comware.CLI("boot-loader file flash:/" + firmwareMain + " s 1 m")
    comware.CLI("delete *.bin")
    comware.CLI("tftp " + serverTftp + " get " + firmwareBackup)
    comware.CLI("boot-loader file flash:/" + firmwareBackup + " s 1 b")
    comware.CLI("delete *.ipe")

def getConfig(configMain,configBackup,serverTftp):
    """Pull down the right configuraiton for the switch
    """
    comware.CLI("tftp " + serverTftp + " get " + configMain)
    comware.CLI("startup saved-configuration " + configMain + " main")
    comware.CLI("startup saved-configuration " + configBackup + " backup")

#setMember(irfMemberNumber)
#levelFirmware(firmwareMain,firmwareBackup,serverFtp,serverTftp)


getConfig(configMain,configBackup,serverTftp)
