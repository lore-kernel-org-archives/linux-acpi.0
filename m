From: Miles Lane <miles.lane-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org>
Subject: 2.5.54 -- Possible ACPI problems
Date: Thu, 02 Jan 2003 23:58:39 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E1542AF.1050902@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Do you need me to be running ACPI code that isn't in the development kernel?
I tried applying the acpi-20021213-2.5.51.diff to 2.5.54 and found that 
it is
quite out of sync.
Is there other testing you'd like me to perform?

Possible problems taken from log (log with context follows at end of 
message):

    1)    Jan  2 17:59:31 bellybutton kernel: ACPI: Wakeup code way too 
big, will crash on attempt to suspend

    2)    Jan  2 17:59:32 bellybutton kernel: Executing all Device _STA 
and_INI methods:............... exfldio-0110 [23] ex_setup_region       
: Field
[PS2E] access width (4 bytes) too large for region [PSRG] (length 1)
            Jan  2 17:59:32 bellybutton kernel:  exfldio-0121 [23] 
ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond 
end of region [PSRG] (length 1)
            Jan  2 17:59:32 bellybutton kernel:  psparse-1102: *** 
Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node 
cff43de8), AE_AML_REGION_LIMIT

    3)    Jan  2 17:59:32 bellybutton kernel:  exfldio-0110 [21] 
ex_setup_region       : Field [PS2E] access width (4 bytes) too large 
for region [PSRG] (length 1)
            Jan  2 17:59:32 bellybutton kernel:  exfldio-0121 [21] 
ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond 
end of region [PSRG] (length 1)
            Jan  2 17:59:32 bellybutton kernel:  psparse-1102: *** 
Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node 
cff43de8), AE_AML_REGION_LIMIT

My machine configuration:

    Gateway 800MHz Athlon desktop

    00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
    00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
AGP Bridge (rev 01)
    00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA 
(rev 01)
    00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] 
IDE (rev 03)
    00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI 
(rev 03)
    00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] 
USB (rev 06)
    00:0f.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
    00:12.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 07)
    00:12.1 Input device controller: Creative Labs SB Live! MIDI/Game 
Port (rev 07)
    00:13.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
    00:14.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04)
    01:05.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 
256 DDR] (rev 10)

Jan  2 17:59:31 bellybutton kernel: BIOS-provided physical RAM map:
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 00000000000e0000 - 
0000000000100000 (reserved)
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 0000000000100000 - 
000000000ffe0000 (usable)
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 000000000ffe0000 - 
000000000fff8000 (ACPI data)
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 000000000fff8000 - 
0000000010000000 (ACPI NVS)
Jan  2 17:59:31 bellybutton kernel:  BIOS-e820: 00000000fff80000 - 
0000000100000000 (reserved)
Jan  2 17:59:31 bellybutton kernel: 255MB LOWMEM available.
Jan  2 17:59:31 bellybutton kernel: ACPI: Wakeup code way too big, will 
crash on attempt to suspend
Jan  2 17:59:31 bellybutton kernel: On node 0 totalpages: 65504
Jan  2 17:59:31 bellybutton kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan  2 17:59:31 bellybutton kernel:   Normal zone: 61408 pages, LIFO 
batch:14
Jan  2 17:59:31 bellybutton kernel:   HighMem zone: 0 pages, LIFO batch:1
Jan  2 17:59:31 bellybutton kernel: ACPI: RSDP (v000 
AMI                        ) @ 0x000fae70
Jan  2 17:59:31 bellybutton kernel: ACPI: RSDT (v001 GATEWA 8DT-084  
00529.06553) @ 0x0fff0000
Jan  2 17:59:31 bellybutton kernel: ACPI: FADT (v001 GATEWA 8DT-084  
00529.06553) @ 0x0fff1000
Jan  2 17:59:31 bellybutton kernel: ACPI: DSDT (v001 GATEWA 8DT-084  
00168.11951) @ 0x00000000
Jan  2 17:59:31 bellybutton kernel: ACPI: BIOS passes blacklist
Jan  2 17:59:31 bellybutton kernel: ACPI: MADT not present
Jan  2 17:59:31 bellybutton kernel: Building zonelist for node : 0
Jan  2 17:59:31 bellybutton kernel: Local APIC disabled by BIOS -- 
reenabling.
Jan  2 17:59:31 bellybutton kernel: Found and enabled local APIC!
Jan  2 17:59:31 bellybutton kernel: Memory: 255068k/262016k available 
(2249k kernel code, 6252k reserved, 916k data, 132k init, 0k highmem)
Jan  2 17:59:31 bellybutton kernel: Dentry cache hash table entries: 
32768 (order: 6, 262144 bytes)
Jan  2 17:59:31 bellybutton kernel: Inode-cache hash table entries: 
16384 (order: 5, 131072 bytes)
Jan  2 17:59:31 bellybutton kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Jan  2 17:59:32 bellybutton kernel: CPU: L1 I Cache: 64K (64 
bytes/line), D cache 64K (64 bytes/line)
Jan  2 17:59:32 bellybutton kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jan  2 17:59:32 bellybutton kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfdad1, last bus=1
Jan  2 17:59:32 bellybutton kernel: PCI: Using configuration type 1
Jan  2 17:59:32 bellybutton kernel: ACPI: Subsystem revision 20021217
Jan  2 17:59:32 bellybutton kernel:  tbxface-0098 [03] 
acpi_load_tables      : ACPI Tables successfully acquired
Jan  2 17:59:32 bellybutton kernel: Parsing all Control 
Methods:...................................................................................
Jan  2 17:59:32 bellybutton kernel: Table [DSDT] - 271 Objects with 26 
Devices 83 Methods 15 Regions
Jan  2 17:59:32 bellybutton kernel: ACPI Namespace successfully loaded 
at root c04676bc
Jan  2 17:59:32 bellybutton kernel: evxfevnt-0073 [04] 
acpi_enable           : Transition to ACPI mode successful
Jan  2 17:59:32 bellybutton kernel:    evgpe-0262: *** Info: GPE Block0 
defined as GPE0 to GPE15
Jan  2 17:59:32 bellybutton kernel: Executing all Device _STA and_INI 
methods:............... exfldio-0110 [23] ex_setup_region       : Field
[PS2E] access width (4 bytes) too large for region [PSRG] (length 1)
Jan  2 17:59:32 bellybutton kernel:  exfldio-0121 [23] 
ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond 
end of region [PSRG] (length 1)
Jan  2 17:59:32 bellybutton kernel:  psparse-1102: *** Error: Method 
execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node cff43de8), 
AE_AML_REGION_LIMIT
Jan  2 17:59:32 bellybutton kernel:   uteval-0079: *** Error: Method 
execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node cff43de8), 
AE_AML_REGION_LIMIT
Jan  2 17:59:32 bellybutton kernel: ...........
Jan  2 17:59:32 bellybutton kernel: 26 Devices found containing: 25 
_STA, 2 _INI methods
Jan  2 17:59:32 bellybutton kernel: Completing 
Region/Field/Buffer/Package 
initialization:..........................................
Jan  2 17:59:32 bellybutton kernel: Initialized 12/15 Regions 1/1 Fields 
21/21 Buffers 8/9 Packages (271 nodes)
Jan  2 17:59:32 bellybutton kernel: ACPI: Interpreter enabled
Jan  2 17:59:32 bellybutton kernel: ACPI: Using PIC for interrupt routing
Jan  2 17:59:32 bellybutton kernel: ACPI: (supports S0 S1 S5)
Jan  2 17:59:32 bellybutton kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan  2 17:59:32 bellybutton kernel: PCI: Probing PCI hardware (bus 00)
Jan  2 17:59:32 bellybutton kernel:  exfldio-0110 [21] 
ex_setup_region       : Field [PS2E] access width (4 bytes) too large 
for region [PSRG] (length 1)
Jan  2 17:59:32 bellybutton kernel:  exfldio-0121 [21] 
ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond 
end of region [PSRG] (length 1)
Jan  2 17:59:32 bellybutton kernel:  psparse-1102: *** Error: Method 
execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node cff43de8), 
AE_AML_REGION_LIMIT
Jan  2 17:59:32 bellybutton kernel: ACPI: PCI Interrupt Link [LNKA] 
(IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Jan  2 17:59:32 bellybutton kernel: ACPI: PCI Interrupt Link [LNKB] 
(IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Jan  2 17:59:32 bellybutton kernel: ACPI: PCI Interrupt Link [LNKC] 
(IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Jan  2 17:59:32 bellybutton kernel: ACPI: PCI Interrupt Link [LNKD] 
(IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Jan  2 17:59:32 bellybutton kernel: ACPI: Power Button (FF) [PWRF]
Jan  2 17:59:32 bellybutton kernel: ACPI: Processor [CPU1] (supports C1)





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
