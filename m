From: "< shpokas >" <shpokas-5tn+sputDXw@public.gmane.org>
Subject: evevent-0286 on HP omnibook 6000
Date: Mon, 26 May 2003 17:08:15 +0100 (GMT+01:00)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3916607.1053965295750.JavaMail.SYSTEM@db1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
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
To: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

hello all,

don't know if this could be interesting to any of you, sorry if not.
on boot hp omnibook 6000 with bios v1.83 gives acpi error:
evevent-0286: *** Error: No installed handler for fixed event [00000000]
so ACPI is not enabled.
Kernel is 2.4.21-rc3 with latest acpi patch (ACPI: Subsystem revision 20030522)
2.4.20 with ACPI doesn't boot at all, it simply crashes at boot.

I don't know if this is BIOS problem.
A little bit more from dmesg:

Linux version 2.4.21-rc3 (root@shpokas (gcc version 3.2.2 20030322 (Gentoo Linux 1.4 3.2.2-r2)) #2 Mon May 26 16:04:26 EEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 HP-MCD                     ) @ 0x000f6770
ACPI: RSDT (v001 HP-MCD EA RSDT  00387.00000) @ 0x0fff59b8
ACPI: FADT (v001 HP-MCD EA FACP  00387.00000) @ 0x0ffffb65
ACPI: BOOT (v001 PTLTD  EABFTBL$ 00387.00000) @ 0x0ffffbd9
ACPI: DSDT (v001 HP-MCD EA DSDT  00387.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: ro root=/dev/hda3
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 647.197 MHz processor.
...
ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xfd980, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1035 Objects with 68 Devices 300 Methods 32 Regions
ACPI Namespace successfully loaded at root c03025bc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0743 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000800C on int 9
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L09 as GPE number 0x09
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0A as GPE number 0x0A
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0B as GPE number 0x0B
 evevent-0286: *** Error: No installed handler for fixed event [00000000]
evregion-0249 [23] ev_address_space_dispa: no handler for region(c12e0be8) [PCI_Config]
 exfldio-0235 [22] ex_access_region      : Region PCI_Config(2) has no handler
evregion-0249 [23] ev_address_space_dispa: no handler for region(c12e0be8) [PCI_Config]
 exfldio-0235 [22] ex_access_region      : Region PCI_Config(2) has no handler
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.FDS_.FCB1.CSID] (Node cff3f688), AE_NOT_EXIST
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.FDS_._REG] (Node c12e00e8), AE_NOT_EXIST
ACPI: Unable to initialize ACPI objects
evxfevnt-0318 [06] acpi_disable_event    : Could not disable PM_Timer events
  evmisc-0542 [05] ev_terminate          : Could not disable fixed event 0
evxfevnt-0318 [06] acpi_disable_event    : Could not disable global_lock events
  evmisc-0542 [05] ev_terminate          : Could not disable fixed event 1
evxfevnt-0318 [06] acpi_disable_event    : Could not disable sleep_button events
  evmisc-0542 [05] ev_terminate          : Could not disable fixed event 3
evxfevnt-0318 [06] acpi_disable_event    : Could not disable real_time_clock events
  evmisc-0542 [05] ev_terminate          : Could not disable fixed event 4
evxfevnt-0139 [06] acpi_disable          : ACPI mode disabled
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
...

wbr,
ivars

-------------------------------------------------------------------------------
http://www.one.lv - Tavs mobilais e-pasts!

Tagad lasi savu e-pastu ar mobilo telefonu - wap.one.lv!


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
