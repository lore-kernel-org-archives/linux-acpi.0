From: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: could not map ACPI
Date: Tue, 21 Jan 2003 15:26:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2D5879.6020908@symplon.com>
References: <3E2D3471.1070307@paceblade.com> <20030121131925.GB14593@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030121131925.GB14593-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Ducrot Bruno schrieb:

>On Tue, Jan 21, 2003 at 12:52:17PM +0100, Robert Woerle Paceblade/Support wrote:
>  
>
>>Hi
>>
>>When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when using 
>> Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) one 
>>device alone is fine .
>>When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
>>BUT all the devices work fine , even together !!!
>>i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI 
>>works and the devices crash together ....
>>the machine is a Transmeta driving machine ...
>>
>>So when i look at tb_get.c at the specific functions...
>>i see that it maps the pointers there according to a 
>>switch(adress->pointer) call !
>>Is possible that it normally uses the
>>case ACPI_LOGMODE_PHYSPTR:
>>stuff but when i use mem=XXX
>>it might use the other case statement:
>>case ACPI_LOGMODE_LOGPTR:
>>
>>can i make a cruel hack around that that it always uses the working one ???
>>
>>    
>>
>
>Can I see the dmesg without mem options?
>  
>
what is also interessting is  iomem

That  is boot.msg  without mem=XXX

Inspecting /boot/System.map
Loaded 17708 symbols from /boot/System.map.
Symbols match kernel version 2.4.19.
Loaded 47 symbols from 3 modules.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.19 (root@linux) (gcc version 3.2) #5 Sun Jan 12 
09:46:26 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
<4> BIOS-e820: 000000000009a800 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000eefd000 (usable)
<4> BIOS-e820: 000000000eefd000 - 000000000ef00000 (ACPI NVS)
<4> BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>240MB LOWMEM available.
<7>ACPI: have wakeup address 0xc0001000
<6>Advanced speculative caching feature not present
<4>On node 0 totalpages: 61440
<4>zone(0): 4096 pages.
<4>zone(1): 57344 pages.
<4>zone(2): 0 pages.
<6>ACPI: RSDP (v000 PTLTD                      ) @ 0x000f81c0
<6>ACPI: RSDT (v001 PTLTD    RSDT   01540.00005) @ 0x0eef9195
<6>ACPI: FADT (v001 TMETA  PDB.ALI  01540.00005) @ 0x0eefcb64
<6>ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00005) @ 0x0eefcbd8
<6>ACPI: DSDT (v001     TM PDBALI35 01540.00005) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<4>Kernel command line: root=/dev/hda3   vga=791 init 3
<6>Initializing CPU#0
<4>Detected 599.225 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 1192.75 BogoMIPS
<6>Memory: 239880k/245760k available (1502k kernel code, 5460k reserved, 
451k data, 116k init, 0k highmem)
<6>Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
<6>Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
<4>Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
<7>CPU: Before vendor init, caps: 0084893f 0081813f 0000000e, vendor = 7
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
<6>CPU: L2 Cache: 512K (128 bytes/line)
<6>CPU: Processor revision 1.3.1.3, 600 MHz
<6>CPU: Code Morphing Software revision 4.2.7-8-278
<6>CPU: 20011004 02:04 official release 4.2.7#7
<7>CPU: After vendor init, caps: 0084893f 0081813f 0000000e 00000000
<5>CPU serial number disabled.
<7>CPU:     After generic, caps: 0080893f 0081813f 0000000e 00000000
<7>CPU:             Common caps: 0080893f 0081813f 0000000e 00000000
<4>CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
<4>mtrr: detected mtrr type: none
<6>ACPI: Subsystem revision 20021022
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd89e, last bus=0
<6>PCI: Using configuration type 1
<4>    ACPI-0135: *** Error: Could not map memory at 000000000EEF9195 
for length 24
<4>    ACPI-0086: *** Error: Acpi_load_tables: Could not load RSDT: 
AE_NO_MEMORY
<4>    ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: 
AE_NO_MEMORY
<3>ACPI: Unable to load the System Description Tables
<6>PCI: Probing PCI hardware
<4>PCI: ACPI tables contain no PCI IRQ routing entries
<4>PCI: Probing PCI hardware (bus 00)
..........................................................................
..........................................................................

AND here is boot.msg from the one with mem=238M

..........................................................................
Inspecting /boot/System.map
Loaded 17708 symbols from /boot/System.map.
Symbols match kernel version 2.4.19.
Loaded 47 symbols from 3 modules.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.19 (root@linux) (gcc version 3.2) #5 Sun Jan 12 
09:46:26 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
<4> BIOS-e820: 000000000009a000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000eefd000 (usable)
<4> BIOS-e820: 000000000eefd000 - 000000000ef00000 (ACPI NVS)
<4> BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<6>user-defined physical RAM map:
<4> user: 0000000000000000 - 000000000009a000 (usable)
<4> user: 000000000009a000 - 0000000000100000 (reserved)
<4> user: 0000000000100000 - 000000000ee00000 (usable)
<5>0MB HIGHMEM available.
<5>238MB LOWMEM available.
<7>ACPI: have wakeup address 0xc0001000
<6>Advanced speculative caching feature not present
<4>On node 0 totalpages: 60928
<4>zone(0): 4096 pages.
<4>zone(1): 56832 pages.
<4>zone(2): 0 pages.
<6>ACPI: RSDP (v000 PTLTD                      ) @ 0x000f81c0
<6>ACPI: RSDT (v001 PTLTD    RSDT   01540.00005) @ 0x0eef9195
<6>ACPI: FADT (v001 TMETA  PDB.ALI  01540.00005) @ 0x0eefcb64
<6>ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00005) @ 0x0eefcbd8
<6>ACPI: DSDT (v001     TM PDBALI35 01540.00005) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<4>Kernel command line: root=/dev/hda3 mem=238M  vga=791
<6>Initializing CPU#0
<4>Detected 599.208 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 1192.75 BogoMIPS
<6>Memory: 237872k/243712k available (1502k kernel code, 5432k reserved, 
451k data, 116k init, 0k highmem)
<6>Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
<6>Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
<4>Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
<7>CPU: Before vendor init, caps: 0084893f 0081813f 0000000e, vendor = 7
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
<6>CPU: L2 Cache: 512K (128 bytes/line)
<6>CPU: Processor revision 1.3.1.3, 600 MHz
<6>CPU: Code Morphing Software revision 4.2.7-8-278
<6>CPU: 20011004 02:04 official release 4.2.7#7
<7>CPU: After vendor init, caps: 0084893f 0081813f 0000000e 00000000
<5>CPU serial number disabled.
<7>CPU:     After generic, caps: 0080893f 0081813f 0000000e 00000000
<7>CPU:             Common caps: 0080893f 0081813f 0000000e 00000000
<4>CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
<4>mtrr: detected mtrr type: none
<6>ACPI: Subsystem revision 20021022
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd89e, last bus=0
<6>PCI: Using configuration type 1
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S3 S4 S5)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs 5, disabled)
<4>ACPI: PCI Interrupt Link [LNK2] (IRQs *10)
<4>ACPI: PCI Interrupt Link [LNK3] (IRQs 10, disabled)
<4>ACPI: PCI Interrupt Link [LNK4] (IRQs 6 7 10 11, enabled at IRQ 5)
<4>ACPI: PCI Interrupt Link [LNK5] (IRQs 6 7 10 11, disabled)
<4>ACPI: PCI Interrupt Link [LNK6] (IRQs *10)
<4>ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
<4>ACPI: PCI Interrupt Link [LNK8] (IRQs *5)
<4>ACPI: PCI Interrupt Link [LNKU] (IRQs *5)
<6>PCI: Probing PCI hardware
<4>ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
<4>ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
<4>ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
<4>PCI: No IRQ known for interrupt pin A of device 00:0f.0 - using IRQ 255
<6>PCI: Using ACPI for IRQ routing


iomem without mem=XXXM

00000000-0009a7ff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d0fff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
  000d0000-000d0fff : usb-ohci
000f0000-000fffff : System ROM
00100000-0eefcfff : System RAM
  00100000-00277a45 : Kernel code
  00277a46-002e887f : Kernel data
0eefd000-0eefffff : ACPI Non-volatile Storage    < -----what is this 
?????? there the mapping fails in tb_get.c ! is it mapped by himself 
already ??
0ef00000-0effffff : System RAM
10000000-10000fff : Texas Instruments PCI1410 PC card Cardbus Controller
  10000000-10000fff : i82365
f8000000-fbffffff : Silicon Motion, Inc. SM720 Lynx3DM
  f8200000-f89fffff : vesafb
fc000000-fc0fffff : Transmeta Corporation LongRun Northbridge
fc100000-fc100fff : Lucent Microelectronics FW323
fc101000-fc101fff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link 
Controller Audio Device
fc103000-fc1030ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  fc103000-fc1030ff : 8139too
fff80000-ffffffff : reserved

and now iomem with mem=238M ( with other values ACPI fails the same like 
without the mem=XXX ! )



00000000-00099fff : System RAM            <------ this has changed
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d0fff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
  000d0000-000d0fff : usb-ohci
000f0000-000fffff : System ROM
00100000-0edfffff : System RAM        <------------- this has changed
  00100000-00277a45 : Kernel code
  00277a46-002e887f : Kernel data
10000000-10000fff : Texas Instruments PCI1410 PC card Cardbus Controller
  10000000-10000fff : i82365
f8000000-fbffffff : Silicon Motion, Inc. SM720 Lynx3DM
  f8200000-f89fffff : vesafb
fc000000-fc0fffff : Transmeta Corporation LongRun Northbridge
fc100000-fc100fff : Lucent Microelectronics FW323
fc101000-fc101fff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link 
Controller Audio Device
fc103000-fc1030ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  fc103000-fc1030ff : 8139too





Looks like ACPI prevents himself for copying into the "ACPI 
 Non_volatile Storage " ???



Cheers Rob



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
