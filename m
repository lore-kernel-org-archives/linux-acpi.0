From: Michal Semler <cijoml-VIXq6x/3rUk@public.gmane.org>
Subject: 2 bugs in ACPI
Date: Thu, 20 Feb 2003 17:13:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E18ltJm-0000B0-00@notas>
Reply-To: cijoml-VIXq6x/3rUk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
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

Hello, 

I use ACPI on my notebook Dell Latitude CPxJ 650 GT for a very long time.

All the time things goes well - thanks you people, but from November 2002 
there are two bugs:

1) Now ACPI can't read battery information from my batteries: those are SONY
2) Now kernel can't read info about thermal zone - kernel tells me -296 C - I 
thought, that apsoluttly zero is -273 :)) You guys are really good :)

Both thinks worked in ACPI 18112002 or 22112002 now I don't know

My system is Debian Woody 3.0r1

here is dump from dmesg:

Linux version 2.4.21-pre4 (root@notas) (gcc version 3.0.4) #2 Èt úno 20 
16:51:00 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fdb000 (usable)
 BIOS-e820: 0000000017fdb000 - 0000000018000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98267
zone(0): 4096 pages.
zone(1): 94171 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 DELL                       ) @ 0x000f4040
ACPI: RSDT (v001 DELL    CPi R   10194.01308) @ 0x17ff0000
ACPI: FADT (v001 DELL    CPi R   10194.01308) @ 0x17ff0400
ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: BOOT_IMAGE=Linux ro root=302
Initializing CPU#0
Detected 647.191 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1291.05 BogoMIPS
Memory: 386504k/393068k available (1200k kernel code, 6176k reserved, 448k 
data, 72k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030122
PCI: PCI BIOS revision 2.10 entry at 0xfc0ae, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PADA] (on)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
    ACPI-0207: *** Warning: Buffer created with zero length in AML
    ACPI-0207: *** Warning: Buffer created with zero length in AML
    ACPI-0207: *** Warning: Buffer created with zero length in AML
    ACPI-0207: *** Warning: Buffer created with zero length in AML
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THM] (-296 C)

when system works still writes into dmesg this:
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes

now /proc/

cijoml@notas:~$ > cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:
serial number:
battery type:
OEM info:

cijoml@notas:~$ > cat /proc/acpi/thermal_zone/THM/temperature
temperature:             -296 C


Thanks a lot

Michal


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
