From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: [BUG][2.6.3-rc2] Unable to turn display on with ASUS L3D
Date: Thu, 12 Feb 2004 17:10:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212161008.GA8729@dreamland.darkstar.lan>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: julien.lerouge-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
my notebook is  an ASUS L3350D, with BIOS 0113. Using  linux 2.6.3-rc2 I
see no output on the display. 2.6.2 works well.

I'm using a custom DSDT, but this is the only change (to enable C2): 

--- dsdt.dsl-0113	Fri Feb  6 21:45:41 2004
+++ dsdt-hack-0113.dsl	Fri Feb  6 21:44:22 2004
@@ -43,7 +43,7 @@
     })
     Scope (_PR)
     {
-        Processor (CPU0, 0x01, 0x0000E410, 0x05)
+        Processor (CPU0, 0x01, 0x0000E410, 0x06)
         {
             Name (PSBT, Package (0x20)
             {

kronos-ZfjlkMfYLo8@public.gmane.org:~$ cat /proc/acpi/asus/info
Asus Laptop ACPI Extras Driver 0.27
Model reference    : L3D
SFUN value         : 0x0077
DSDT length        : 16155
DSDT checksum      : 154
DSDT revision      : 1
OEM id             : ASUS
OEM table id       : L3000D
OEM revision       : 0x1000
ASL comp vendor id : INTL
ASL comp revision  : 0x20030918

LCD is on:

kronos-ZfjlkMfYLo8@public.gmane.org:~$ cat /proc/acpi/asus/lcd
1

But:

kronos-ZfjlkMfYLo8@public.gmane.org:~$ cat /proc/acpi/asus/disp
0

echo 1 > /proc/acpi/asus/disp hangs the system but turns the lcd on.
These are the last lines I see (with debug_level = 0x000000ff):

exnames-0188 [46] ex_name_segment: Byte from stream:
exnames-0194 [46] ex_name_segment: S
exnames-0194 [46] ex_name_segment: M
exnames-0194 [46] ex_name_segment: C
exnames-0194 [46] ex_name_segment: M
exregion-0294 [52] ex_system_io_han: System_iO 1 (8 width) Address=000000000000E448

The machine is hardlocked (do not respond to pings). Fn+F8 doen't hang
the machine but doen't turn on the display as well.

I can turn leds on/off and can echo {0,1} asus/lcd (but LCD stays blank) without problems.
This is the bootlog:

Linux version 2.6.3-rc2 (root-ZfjlkMfYLo8@public.gmane.org) (gcc version 3.2.3 (Debian)) #17
Wed Feb 11 00:41:45 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dfea000 (usable)
 BIOS-e820: 000000001dfea000 - 000000001dfef000 (ACPI data)
 BIOS-e820: 000000001dfef000 - 000000001dfff000 (reserved)
 BIOS-e820: 000000001dfff000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
479MB LOWMEM available.
On node 0 totalpages: 122858
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118762 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6e30
ACPI: RSDT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea000
ACPI: FADT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea080
ACPI: BOOT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea040
ACPI: DSDT (v001   ASUS L3000D   0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=linux-2.6.3-rc2 ro root=305
video=sisfb:specialtiming:none,mode:1024x768x8
sisfb: Options specialtiming:none,mode:1024x768x8
sisfb: Special timing disabled
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1874.636 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 482376k/491432k available (2160k kernel code, 8312k reserved,
908k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3702.78 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: CLK_CTL MSR was 60071263. Reprogramming to 20071263
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1874.0344 MHz.
..... host bus clock speed is 267.0763 MHz.
NET: Registered protocol family 16
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xf1050, last bus=1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
   tbget-0291: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................................................................
Table [DSDT](id F004) - 558 Objects with 54 Devices 196 Methods 22 Regions
ACPI Namespace successfully loaded at root c044345c
ACPI: IRQ9 SCI: Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package
initialization:....................................................................
Initialized 22/22 Regions 0/0 Fields 21/21 Buffers 25/25 Packages (566 nodes)
Executing all Device _STA and_INI
methods:........................................................
56 Devices found containing: 56 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
pnp: 00:11: ioport range 0x290-0x297 has been reserved
pnp: 00:11: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:11: ioport range 0xe400-0xe47f has been reserved
pnp: 00:11: ioport range 0xec00-0xec3f has been reserved
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
[...]
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (49 C)
Asus Laptop ACPI Extras version 0.27
  L3D model detected, supported


Any clue?

Luca
-- 
Home: http://kronoz.cjb.net
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
