import os
import sys
import json

filename2 ='varMatrix.json'
fin2=open(filename2,'r')
switchList=json.loads(fin2.read())
fin2.close()
#print(switchList)
for switch in switchList:
    filename ='template2.txt'
    fin=open(filename,'r')
    data=fin.readlines()
    for i in data:
        j= i.strip('\n').replace('{{','""" + ').replace('}}',' + """')
        if '[' in j:
            print(eval('"""'+j.replace('"',"'").replace("'''",'"""')+'"""'))
#        elif '"' or "'" in j:
#            print(j.replace('"','/"').replace("'","/'"))
        else: print j
    fin.close()
