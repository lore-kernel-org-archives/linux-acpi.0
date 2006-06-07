From: Maurizio Bongini <maurizio.bongini@poste.it>
Subject: toshiba satelli 1800-712
Date: Wed, 7 Jun 2006 18:52:34 +0200
Message-ID: <200606071852.34813.maurizio.bongini@poste.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay-pt2.poste.it ([62.241.5.253]:45963 "EHLO
	relay-pt2.poste.it") by vger.kernel.org with ESMTP id S932264AbWFGQsb
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jun 2006 12:48:31 -0400
Received: from host4-185.pool212171.interbusiness.it (212.171.185.4) by relay-pt2.poste.it (7.2.063) (authenticated as maurizio.bongini@poste.it)
        id 4485AD7900005778 for linux-acpi@vger.kernel.org; Wed, 7 Jun 2006 18:48:30 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Summary : Reboot hungs on Toshiba laptop  model: Satellite 1800-712
Description: dual booting pc winxp & linux 
the problem is during reboot processing 
win xp is able to correctly shutdown and reboot , linux  not 
to better inform i shortly describe the reboot process on both operating 
systems
toshiba satellite 1800-712  indications leds are : 
ac volatage plugged - power on light - battery status - hard disk - removable 
media  
winxp :
after closing applications finally the screen blanks ,the power on light is 
turned off 
for two seconds (only ac voltage and batery light are on ) ,then pc is turned 
on again 
the first screen apperas with the toshiba logo and the options to enter bios 
setup  
win xp uses acpi 
linux:
the system shutdowns correctly but reboot process is unable to turn off the 
power on light,so the system hangs with the 3 leds (ac voltage - power on - 
battery status ) on 
and a blank screen : to exit from this situation i have to keep the power 
on/off button pressed for 4 sec. to turn off the machine.
(poweroff command correctly  works)
linux uses acpi  
so it seems that win xp reboots acting a power off/on process 
linux not follow this path so power is still on and screen blanks (the toshiba 
logo with
bios setup option is not displayed)

actions performed :
i had this problem also with my first linux distro : mandrake 9.2 i had it 
with mandrake 10.1 and now with mandriva 2006 .... i tried also to installal 
suse 9.3 but the results are always the same    
i tried many acpi options (force ,etc etc ) without success
i tried to add reboot=b to lilo 
iinstalled the last bios from toshiba site   
i'm not the same with this problem...please google "reboot  toshiba satellite 
1800-712"
no one found a fix or a bypass for this 

in my humble opinios this seems to be a new bug 
i available to perform some test 
if also in yours opinion this is a new bug,then please bring me in contact 
with an acpi developer  

thanks in advance 

Maurizio 


(here are some info i hope will be useful to debug)   


 
kernel:Linux version 2.6.12-12mdk (apatard@n1.mandriva.com) (gcc version 4.0.1 
(4.0.1-5mdk for Mandriva Linux release 2006.0)) #1 Fri Sep 9 18:15:22 CEST 
2005
Software:
dual booting win xp & linux 
bootmanager : lilo 22.6.1
distribution: mandriva 2006
kernel: 2.6.12-12ndk 
acpi:  0.07
acpid: 1.0.4
/proc/acpi/info version:  20050309
apm not used
toshiba acpi enabled
[root@localhost acpi]# ls  toshiba
fan  keys  lcd  version  video

Machine: toshiba satellite 1800-712 laptop  
CPU:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 1095.784
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips        : 2170.88

# biosdecode 2.6
ACPI 1.0 present.
        OEM Identifier: TOSHIB
        RSD Table 32-bit Address: 0x0EFF0000
BIOS32 Service Directory present.
        Revision: 0
        Calling Interface Address: 0x000FAF93
PCI Interrupt Routing 1.0 present.
        Router ID: 00:07.0
        Exclusive IRQs: None
        Compatible Router: 10b9:1533
        Slot Entry 1: ID 00:02, on-board
        Slot Entry 2: ID 00:06, on-board
        Slot Entry 3: ID 00:11, on-board
        Slot Entry 4: ID 00:0a, on-board
        Slot Entry 5: ID 01:00, on-board
        Slot Entry 6: ID 00:10, on-board
        Slot Entry 7: ID 00:0c, on-board
PNP BIOS 1.0 present.
        Event Notification: Polling
        Event Notification Flag Address: 0x00000510
        Real Mode 16-bit Code Address: F000:08B9
        Real Mode 16-bit Data Address: 0000:0000
        16-bit Protected Mode Code Address: 0x000F08D6
        16-bit Protected Mode Data Address: 0x00000000
        OEM Device Identifier: TOS3600
SMBIOS 2.3 present.
        Structure Table Length: 1394 bytes
        Structure Table Address: 0x000EC000
        Number Of Structures: 44
        Maximum Structure Size: 101 bytes
SYSID present.
        Revision: 0
        Structure Table Address: 0x000F0320
        Number Of Structures: 1
 

_____________________________________________________________
Email with attachment's size more than 1 Mb will no more be received
