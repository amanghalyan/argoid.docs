from subprocess import Popen, PIPE
import xml.etree.ElementTree as ET
import logging

logging.basicConfig(level=logging.INFO,format='%(asctime)s %(levelname)s %(message)s')



def UpdateXML():

    mem_kb_command = Popen( "cat /proc/meminfo | awk NR==1 | awk  '{print $2}'", shell=True,stdout=PIPE, stderr=PIPE)
    mem_kb= mem_kb_command.communicate()
    mem_mb=int(mem_kb[0])/1024
    mem_mb_setting=mem_mb - 300
    


    cpu_num_command = Popen( "grep -c ^processor /proc/cpuinfo", shell=True,stdout=PIPE, stderr=PIPE)
    cpu_num= cpu_num_command.communicate()
    cpu_num_setting=int(cpu_num[0]) * 3



    tree = ET.parse('/etc/hadoop/conf/yarn-site.xml')
    root = tree.getroot()
    memory_property=root.find(".//property/[name='yarn.nodemanager.resource.memory-mb']")
    cpu_property=root.find(".//property/[name='yarn.nodemanager.resource.cpu-vcores']")

    memory_property_val = memory_property.find('value')
    cpu_property_val=cpu_property.find('value')

    memory_property_val.text=str(mem_mb_setting)
    cpu_property_val.text=str(cpu_num_setting)


    tree=ET.ElementTree(root)
    with open("/etc/hadoop/conf/yarn-site.xml", "wb") as fileupdate:
        tree.write(fileupdate)

    start_nodemanager_command =  Popen( "sudo /etc/init.d/hadoop-yarn-nodemanager start", shell=True,stdout=PIPE, stderr=PIPE)
    start_nodemanager=start_nodemanager_command.communicate()
    


if __name__ =="__main__":
    UpdateXML()
