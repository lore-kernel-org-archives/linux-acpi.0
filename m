From: "Lotus 2010" <lotus_2010-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Weird USB mouse problem on a fujitsu P2120 (ACPI related)
Date: Wed, 19 Feb 2003 11:36:39 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F91HWP5RvITt7Qs6hvf000390d1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[Already posted in the support list, but it has very little traffic that 
list and I saw post similar to mine in this list so this post could be 
relevant here, sorry for the dupe]



Hi here is my first post to this list, sorry if I made grave technological 
errors in this post,  I am a newbie, I am stuck with this problem since I 
got my laptop and I dont know what to try anymore, also sorry for my very 
crude english.


Although its about a usb mouse problem I think it has to do with acpi 
because depending acpi is enabled or not different things happens, sorry if 
this problem is not acpi related .

Here is my weird usb mouse problem in my laptop which only supports acpi, my 
laptop is a fujitsu P2120, which has a transmeta crusoe 
http://www.fujitsupc.com/www/content/products/notebooks/brochures/pauling3_color.pdf
(*)SEE AT THE END OF THIS POST FOR A DUMP OF lspci -v on my SYSTEM
Note: its USB 2.0 complaint
(with 512 MB of RAM and two batteries on)

The problem is this, when the laptop is plugged to AC power and/or LAN the 
usb mouse lights up and works,
when I boot with the laptop not plugged to AC and LAN the usb mouse freezes 
the laptop doh! . I tried lots and lots of kernel variations, in one I 
managed to get the light of mouse work but the laptop didnt catch the 
movements
I even tried disabling irqs on the bios , disabling for example 5,10,11 
(simultaneously) made the usb mouse work if I plugged after booting the 
laptop from a not plugged (to AC or LAN) state.

Notes: acpi more or less works on my laptop, (I can probe the status of my 
batteries etc).


Relevant logs


1)  ACPI ON,  laptop plugged to AC and lan, and usb mouse plugged (ALL 
WORKS)

cat /proc/interrupts
-------------------------------------------------------------------------------------
CPU0
0: 43646 XT-PIC timer
1: 75 XT-PIC keyboard
2: 0 XT-PIC cascade
9: 325 XT-PIC acpi, Texas Instruments PCI1410 PC card Cardbus Controller, 
usb-ohci, usb-ohci, ALi Audio Accelerator, eth0
11: 1 XT-PIC usb-ohci
14: 3304 XT-PIC ide0
NMI: 0
ERR: 0
---------------------------------------------------------
dmeseg |grep usb when all is plugged and mouse works

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
usb-ohci.c: USB OHCI at membase 0xdf923000, IRQ 11
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
usb-ohci.c: USB OHCI at membase 0xdf925000, IRQ 9
usb-ohci.c: usb-00:09.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 2
usb-ohci.c: USB OHCI at membase 0xdf927000, IRQ 9
usb-ohci.c: usb-00:09.1, NEC Corporation USB (#2)
usb.c: new USB bus registered, assigned bus number 3
input0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb2:2.0
--------------------------------------------------------




Since this is the best configuration maybe lsmod is useful-->
---------------------------------------------------------
Module                  Size  Used by    Not tainted
8139too                15336   1
mii                     2400   0  [8139too]
nls_iso8859-1           2812   1  (autoclean)
nls_cp437               4316   1  (autoclean)
vfat                   10316   1  (autoclean)
fat                    31640   0  (autoclean) [vfat]
ide-cd                 29668   0  (autoclean)
sr_mod                 13880   0  (autoclean) (unused)
cdrom                  28800   0  (autoclean) [ide-cd sr_mod]
scsi_mod               54580   1  (autoclean) [sr_mod]
trident                28276   0  (unused)
ac97_codec             10888   0  [trident]
keybdev                 1984   0  (unused)
usb-ohci               18408   0  (unused)



---------------------------------------------------------

2) ACPI ON, laptop not plugged to anything

cat  /proc/interrupts

          CPU0
0:      20567          XT-PIC  timer
1:        170          XT-PIC  keyboard
2:          0          XT-PIC  cascade
9:          1          XT-PIC  acpi, Texas Instruments PCI1410 PC card 
Cardbus Controller, usb-ohci, ALi Audio Accelerator
10:          1          XT-PIC  usb-ohci
11:          1          XT-PIC  usb-ohci
14:       3050          XT-PIC  ide0
NMI:          0
ERR:          0

at this moment if I plug the usb mouse (or boot with the usb mouse) I get a 
freeze cute laptop, for example booting
with the usb mouse gives-->
---------------------------------------------------------
Calculating modules dependencies......done
Loading modules:usb-ohci usb-ohci.c:USB OHCI at membase 0xdf923000, IRQ 11
usb-ohci.c: usb-00:02.0 Acer Laboratories Inc. [ALi] US 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Enabling device 00:09.0 (0000->0002)
usb-ohci.c:USB OHCI at membase 0xdf927000, IRQ 10
usb-ohci.c:usb-00:09.1, NEC CORPORATION USB (#2)
usb.c: new USB bus registered, asigned bus number 3
hub.c: USB hub found
hub.c: 1 port detected
hub.c: new USB device 00:09.0-1, asigned address 2 -->the buck stops here
---------------------------------------------------------

FREZZE at this point , nothing works only the power off button :(  (booting 
this way with the mouse plugged, the mouse lights up 2 times for a tiny 
time, like two pulses), and I suspect the cpu goes to full or over full, 
this laptop doesnt have a fan for the cpu but it has one for the pcmcia 
card,very rarely it goes off for example if I recompile the kernel 4 times 
consecutivily at 100% of CPU (this  cpu is longrun enabled  so you can 
regulate from command line the window you like it to work) it goes off, well 
when the usb mouse locks the computer the fan starts really quickly


3)  boot: Linux-2.4.20-acpi acpi=off  pci=biosirq, laptop plugged to AC and 
lan ,mouse plugged (but doesnt work, no lights ,and the laptop doesnt 
freeze)

3.1) cat /proc/interrupts
---------------------------------------------------------
          CPU0
0:      15056          XT-PIC  timer
1:        177          XT-PIC  keyboard
2:          0          XT-PIC  cascade
9:          0          XT-PIC  Texas Instruments PCI1410 PC card Cardbus 
Controller, ALi Audio Accelerator
11:          1          XT-PIC  usb-ohci
14:       4573          XT-PIC  ide0
NMI:          0
ERR:          0
---------------------------------------------------------


Notice only one usb-ohci loaded

at this state the mouse is plugged but no lights
Only 1 usb-ohci module loaded,ok we try unloading usb-ohci and reloading it
rmmod usb-ohic
modprobe usb-ohci
same result, only one module loaded and with IRQ not found kernel errors
---------------------------------------------------------
Feb 18 16:56:11 fuji kernel: PCI: Found IRQ 11 for device 00:02.0
Feb 18 16:56:11 fuji kernel: usb-ohci.c: USB OHCI at membase 0xe0117000, IRQ 
11
Feb 18 16:56:11 fuji kernel: usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. 
[ALi] USB 1.1 Controller
Feb 18 16:56:11 fuji kernel: usb.c: new USB bus registered, assigned bus 
number 1
Feb 18 16:56:11 fuji kernel: hub.c: USB hub found
Feb 18 16:56:11 fuji kernel: hub.c: 3 ports detected
Feb 18 16:56:11 fuji kernel: PCI: No IRQ known for interrupt pin A of device 
00:09.0.
Feb 18 16:56:11 fuji kernel: usb-ohci.c: found OHCI device with no IRQ 
assigned. check BIOS settings!
Feb 18 16:56:11 fuji kernel: PCI: No IRQ known for interrupt pin B of device 
00:09.1.
Feb 18 16:56:11 fuji kernel: usb-ohci.c: found OHCI device with no IRQ 
assigned. check BIOS settings!
---------------------------------------------------------



cat /proc/interrupts
--------------------------------------------------------           CPU0
0:       8515          XT-PIC  timer
1:        139          XT-PIC  keyboard
2:          0          XT-PIC  cascade
9:          0          XT-PIC  Texas Instruments PCI1410 PC card Cardbus 
Controller, ALi Audio Accelerator
11:          1          XT-PIC  usb-ohci
14:       2851          XT-PIC  ide0
NMI:          0
ERR:          0
---------------------------------------------------------
Notice: only one usb-ohci module loaded on IRQ 11, not 3 like in 1) , and 
the mouse doesnt work (no lights also) but doesnt freeze the laptop





4) boot: Linux-2.4.20-acpi acpi=off  pci=biosirq, laptop Not plugged
cat /proc/interrupts-> same as 3.1








Note: with acpi off  in an acpi enabled kernel (or with a kernel with not 
ACPI at all) booting plugged or not plugged is the same, only one usb-ohci 
module is loaded and the mouse doesnt freeze the laptop but it doesnt light 
up and doesnt  work



5) Since this kernel is the best it works for me , I put here relevant 
.config information

-CPU

#
# Processor type and features
#

....
....
CONFIG_MCRUSOE=y
....
....
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y  (for longrun to work)


-General Setup

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y


-PCI
#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_APM is not set

-ACPI
#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set



-USB

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=m
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_BLUETOOTH=m
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
......


#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

-MOUSE
#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m



I tried the last acpi patches , I tried several kernels 2.4.20, 2.4.21-pre4, 
2.5.61 (with the patch dont recall if this patch was accepted, douh, so many 
compilations ....)

Bassically:

a) With acpi, 3 usb-ohci modules are loaded
I need 3 usb-ohci modules loaded, when one module is on irq 10 , (booting in 
a not plugged state) the mouse goes to that irq and freezes the laptop,  
booting with AC power or plugged to LAN (better both of them or LAN than 
only AC power), the 2 usb-ohci modules are on IRQ 9, and the other in IRQ 
11, and the mouse goes to IRQ 9 and all works.
Disabling irqs, 5,10,11  and booting not plugged ,forces the assignement of 
the usb-mouse to a usb-ohci that is on irq 9 )
cat /proc/interrupts :
---------------------------------------------------------
          CPU0
0:      12419          XT-PIC  timer
1:        136          XT-PIC  keyboard
2:          0          XT-PIC  cascade
7:          1          XT-PIC  usb-ohci
9:          1          XT-PIC  acpi, Texas Instruments PCI1410 PC card 
Cardbus Controller, usb-ohci, usb-ohci, ALi Audio Accelerator
14:       2902          XT-PIC  ide0
NMI:          0
ERR:          0
---------------------------------------------------------


so it works, but  for example now lan doesnt work (I guess a bunch of other 
things also ...). Playing the game of disabling irq 10 only doesnt work, the 
mouse then goes to irq 5, and freezes the laptop

b) With no acpi, only one usb-ohci module is loaded, the mouse doesnt freeze 
the laptop, it doesnt matter if I boot plugged or not, the mouse doesnt 
lights/works


I tried modinfo -p usb-ohci to see if I could force usb-ohci to an irq but 
it doesnt accep parameters, I tried also sending other stuff out of irq 9 (a 
lot goes there dont know why) but it doesnt work, or doesnt accept such 
parameters

[Things already tried: all sort of kernel compilations, ACPI stuff as M /* 
USB as M/*, enabling ehci-hcd, etc.... you know the deal..]


Well any help/idea on whats going on, ??
Thanks very much .
Regards

PD:Also I would like to express my gratitude to the efforts of countless of 
hackers that made this linux dream possible, in especial to the acpi ones, 
shame on fujitsu my vendor for caving to M$ and not providing support to 
linux.



(*)

lspci -v
---------------------------------------------------------



00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
Subsystem: Citicorp TTI: Unknown device 110e
Flags: bus master, medium devsel, latency 64
Memory at e8100000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
Subsystem: Citicorp TTI: Unknown device 110e
Flags: fast devsel

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
Subsystem: Citicorp TTI: Unknown device 110e
Flags: fast devsel

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 
03) (prog-if 10 [OHCI])
Subsystem: Citicorp TTI: Unknown device 10a2
Flags: bus master, medium devsel, latency 64, IRQ 11
Memory at e8014000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [60] Power Management version 2

00:04.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI 
AC-Link Controller Audio Device (rev 01)
Subsystem: Citicorp TTI: Unknown device 1177
Flags: bus master, medium devsel, latency 64, IRQ 9
I/O ports at 1000 [size=256]
Memory at e8015000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [dc] Power Management version 2

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
Subsystem: Citicorp TTI: Unknown device 10a3
Flags: medium devsel

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
Flags: bus master, medium devsel, latency 0
Capabilities: [a0] Power Management version 1

00:09.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
Subsystem: Citicorp TTI: Unknown device 11a3
Flags: bus master, medium devsel, latency 64, IRQ 9
Memory at 1f100000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [40] Power Management version 2

00:09.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
Subsystem: Citicorp TTI: Unknown device 11a3
Flags: bus master, medium devsel, latency 64, IRQ 9
Memory at 1f101000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [40] Power Management version 2

00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
Subsystem: Citicorp TTI: Unknown device 11a3
Flags: medium devsel, IRQ 9
Memory at 1f102000 (32-bit, non-prefetchable) [disabled] [size=256]
Capabilities: [40] Power Management version 2

00:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
Subsystem: Citicorp TTI: Unknown device 10c6
Flags: bus master, medium devsel, latency 168, IRQ 9
Memory at 1f103000 (32-bit, non-prefetchable) [size=4K]
Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
Memory window 0: 1f400000-1f7ff000 (prefetchable)
Memory window 1: 1f800000-1fbff000
I/O window 0: 00004000-000040ff
I/O window 1: 00004400-000044ff
16-bit legacy interface ports at 0001

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) 
(prog-if ea)
Subsystem: Citicorp TTI: Unknown device 10a4
Flags: bus master, medium devsel, latency 32
I/O ports at 1800 [size=16]
Capabilities: [60] Power Management version 2

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C 
(rev 10)
Subsystem: Citicorp TTI: Unknown device 111c
Flags: bus master, medium devsel, latency 64, IRQ 9
I/O ports at 8000 [size=256]
Memory at e8016800 (32-bit, non-prefetchable) [size=256]
Capabilities: [50] Power Management version 2

00:13.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394 
Controller (PHY/Link) 1394a-2000 (prog-if 10 [OHCI])
Subsystem: Citicorp TTI: Unknown device 1162
Flags: medium devsel, IRQ 9
Memory at e8016000 (32-bit, non-prefetchable) [size=2K]
Memory at e8010000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [44] Power Management version 2

00:14.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 
LY (prog-if 00 [VGA])
Subsystem: Citicorp TTI: Unknown device 11c8
Flags: stepping, medium devsel, IRQ 9
Memory at f0000000 (32-bit, prefetchable) [size=128M]
I/O ports at 1400 [size=256]
Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
Expansion ROM at <unassigned> [disabled] [size=128K]
Capabilities: [50] Power Management version 2





_________________________________________________________________




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
