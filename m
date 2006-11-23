From: Len Brown <len.brown@intel.com>
Subject: Re: [0/12] acpi: make ACPI use driver model
Date: Wed, 22 Nov 2006 23:07:26 -0500
Message-ID: <200611222307.26536.len.brown@intel.com>
References: <1158916460.11985.45.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:28548 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755563AbWKWEEb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 23:04:31 -0500
In-Reply-To: <1158916460.11985.45.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday 22 September 2006 05:14, Zhang Rui wrote:
> Make ACPI use driver model.
> 
> Patrick has posted patches on rewriting ACPI driver model in November 2005.
> And recently Shaohua send me a prototype on making ACPI use driver model.
> This patch series bases on both Patrick and Shaohua's previous work. 
> 
> Two features are gonna to be changed by applying this series of patches.
> 1.	ACPI driver model. 
> 	ACPI driver are made to follow Linux driver model.
> 	The mainly work is to convert the registeration interfaces, so that
> 	ACPI devices are registered with the global device tree.
> 	Note the new .uevent method mark ACPI drivers by PNPID 
> 	instead of by name. Udev script needs to look for "HWID = "
> 	or "COMPTID = " to load the right ACPI driver.
> 2.	ACPI sysfs interface. 
> 	As a result of using driver model, ACPI devices is added in the 
> 	/sys/device tree. So after _EJ0 is added as a property of 
> 	ACPI device in device tree, /sys/firm/acpi is deleted.
> 	Note that the corresponding userspace script needs to be changed 
> 	for hot removal.
> 
> Note that this is only the first step of ACPI sysfs convert project.
> The next step is to duplicate /proc/acpi functions in /sys/device tree.

This patch series didn't boot on my T30:

Linux version 2.6.19-rc6-g608eebb7 (lenb@toshiba) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #183 SMP Wed Nov 22 18:37:12 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7e000 (ACPI data)
 BIOS-e820: 000000003ff7e000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 262000) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262000
early_node_map[1] active PFN ranges
    0:        0 ->   262000
On node 0 totalpages: 262000
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 254 pages used for memmap
  HighMem zone: 32370 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f7010
ACPI: XSDT (v001 IBM    TP-1I    0x00002100  LTP 0x00000000) @ 0x3ff731cd
ACPI: FADT (v001 IBM    TP-1I    0x00002100 IBM  0x00000001) @ 0x3ff73300
ACPI: SSDT (v001 IBM    TP-1I    0x00002100 MSFT 0x0100000d) @ 0x3ff733b4
ACPI: ECDT (v001 IBM    TP-1I    0x00002100 IBM  0x00000001) @ 0x3ff7debc
ACPI: TCPA (v001 IBM    TP-1I    0x00002100 PTL  0x00000001) @ 0x3ff7df0e
ACPI: BOOT (v001 IBM    TP-1I    0x00002100  LTP 0x00000001) @ 0x3ff7dfd8
ACPI: DSDT (v001 IBM    TP-1I    0x00002100 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
Detected 1798.521 MHz processor.
Built 1 zonelists.  Total pages: 259954
Kernel command line: root=/dev/hda2 console=tty0 console=ttyS0,115200n8 debug apm=off
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0180c000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0635000 soft=c063d000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032688k/1048000k available (3400k kernel code, 14720k reserved, 1641k data, 244k init, 130496k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xf8800000 - 0xffbfe000   ( 115 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc05f3000 - 0xc0630000   ( 244 kB)
      .data : 0xc04523c8 - 0xc05ec8c8   (1641 kB)
      .text : 0xc0100000 - 0xc04523c8   (3400 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3600.98 BogoMIPS (lpj=7201968)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0006) - 1241 Objects with 62 Devices 377 Methods 19 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c066c2b0
ACPI: setting ELCR to 0200 (from 0a00)
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
Setting up standard PCI resources
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 6 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 2 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..........................................................................................
Initialized 18/19 Regions 123/123 Fields 67/67 Buffers 26/34 Packages (1251 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:........
Executed 8 _INI methods requiring 2 _STA executions (examined 66 objects)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:ACPI
PM: Adding info for acpi:PWRF
PM: Adding info for acpi:CPU
PM: Adding info for acpi:_SB
PM: Adding info for acpi:LNKA
PM: Adding info for acpi:LNKB
PM: Adding info for acpi:LNKC
PM: Adding info for acpi:LNKD
PM: Adding info for acpi:LNKE
PM: Adding info for acpi:LNKF
PM: Adding info for acpi:LNKG
PM: Adding info for acpi:LNKH
PM: Adding info for acpi:MEM
PM: Adding info for acpi:LID
PM: Adding info for acpi:SLPB
PM: Adding info for acpi:PCI0
PM: Adding info for acpi:LPC
PM: Adding info for acpi:SIO
PM: Adding info for acpi:PIC
PM: Adding info for acpi:TIMR
PM: Adding info for acpi:DMAC
PM: Adding info for acpi:SPKR
PM: Adding info for acpi:FPU
PM: Adding info for acpi:RTC
PM: Adding info for acpi:KBD
PM: Adding info for acpi:MOU
PM: Adding info for acpi:FDC
PM: Adding info for acpi:FDD0
PM: Adding info for acpi:UART
PM: Adding info for acpi:LPT
PM: Adding info for acpi:FIR
PM: Adding info for acpi:EC
PM: Adding info for acpi:PUBS
PM: Adding info for acpi:BAT0
PM: Adding info for acpi:AC
PM: Adding info for acpi:HKEY
PM: Adding info for acpi:AGP
PM: Adding info for acpi:VID
PM: Adding info for acpi:LCD0
PM: Adding info for acpi:CRT0
PM: Adding info for acpi:TV0
PM: Adding info for acpi:DVI0
PM: Adding info for acpi:PCI1
PM: Adding info for acpi:CBS0
PM: Adding info for acpi:CBS1
PM: Adding info for acpi:IDE0
PM: Adding info for acpi:PRIM
PM: Adding info for acpi:MSTR
PM: Adding info for acpi:SCND
PM: Adding info for acpi:MSTR
PM: Removing info for acpi:MSTR
------------[ cut here ]------------
kernel BUG at fs/sysfs/file.c:460!
invalid opcode: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c01991c2>]    Not tainted VLI
EFLAGS: 00010202   (2.6.19-rc6-g608eebb7 #183)
EIP is at sysfs_create_file+0x20/0x44
eax: c1a30700   ebx: c0576f20   ecx: c1a30708   edx: c1a30701
esi: 00000000   edi: c1a30498   ebp: 00000000   esp: c1920ed8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c1920000 task=c191fa70 task.ti=c1920000)
Stack: c1a30720 c1a30690 c02b4694 c1a30690 c02b46d7 c1a30708 c0576f20 c1a30488
       c1a30690 c0283fbf c1a30690 c0576f20 c1920f2c c18de1c8 c1a30894 c1920f68
       00000000 00000068 c19e84f0 4d000001 00525453 c1909684 00000001 00000000
Call Trace:
 [<c02b4694>] get_device+0x16/0x1b
 [<c02b46d7>] device_create_file+0x29/0x3a
 [<c0283fbf>] acpi_add_single_object+0x8cc/0x93e
 [<c0284173>] acpi_bus_scan+0x142/0x1cd
 [<c0609bf8>] acpi_scan_init+0xe8/0x103
 [<c01004fc>] init+0x143/0x2f3
 [<c0102dce>] ret_from_fork+0x6/0x1c
 [<c01003b9>] init+0x0/0x2f3
 [<c01003b9>] init+0x0/0x2f3
 [<c0103a4b>] kernel_thread_helper+0x7/0x10
 =======================
Code: 00 89 f8 83 c4 18 5b 5e 5f 5d c3 53 83 ec 0c 8b 4c 24 14 8b 5c 24 18 85 c9 74 10 83 79 30 00 0f 94 c2 85 db 0f 94 c0 08 c2 74 08 <0f> 0b
EIP: [<c01991c2>] sysfs_create_file+0x20/0x44 SS:ESP 0068:c1920ed8
 <0>Kernel panic - not syncing: Attempted to kill init!
