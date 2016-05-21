import comware
import os
import sys
import termios
import time

# Name variables, these can be replaced by SED if needed
serverTftp="10.1.1.1"
serverFtp="10.1.1.1"

irfMemberNumber="2"

firmwareMain="5900_5920-CMW710-R2311P06.ipe"
firmwareBackup="5900_5920-CMW710-R2311P06.ipe"

def setMember(irfMemberNumber):
    """Sets the IRF member number in the switch.
    """
    comware.CLI("sys ; irf member 1 renumber " + irfMemberNumber)

def levelFirmware(firmwareMain,firmwareBackup,serverFtp,serverTftp):
    """Update the firmware in the switch. 
    Pulls the files firmware main and backup from FTP server.
    """
    comware.CLI("tftp " + serverTftp + " get " + firmwareMain)
    comware.CLI("boot-loader file flash:/" + firmwareMain + " s 1 m")


setMember(irfMemberNumber)
levelFirmware(firmwareMain,firmwareBackup,serverFtp,serverTftp)
