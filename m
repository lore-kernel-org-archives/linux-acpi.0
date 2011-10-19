From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Wed, 19 Oct 2011 10:59:22 +0200
Message-ID: <4E9E916A.4050007@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020307020002030705040600"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:36329 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab1JSI7d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Oct 2011 04:59:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>

This is a multi-part message in MIME format.
--------------020307020002030705040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I've updated the BIOS to the latest version supplied by the manufacturer 
and ran 2 new dmesges. I diffed them (stripped of timestamps) with the 
original ones. It did not solve or influence USB support on a 64bit 
kernel in any way. So still USB less on this specific board.

I'd update the bugreport, but the bugzilla is still offline :(

--------------020307020002030705040600
Content-Type: text/x-patch;
 name="dmesg.64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.64.diff"

--- dmesg64.v1	2011-10-18 19:30:12.968540175 +0200
+++ dmesg64.v2	2011-10-18 19:30:22.620418836 +0200
@@ -6,18 +6,18 @@
   BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
   BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
   BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
-  BIOS-e820: 0000000000100000 - 00000000bd94d000 (usable)
-  BIOS-e820: 00000000bd94d000 - 00000000bd99c000 (ACPI NVS)
-  BIOS-e820: 00000000bd99c000 - 00000000bd9a4000 (ACPI data)
-  BIOS-e820: 00000000bd9a4000 - 00000000bdadc000 (reserved)
-  BIOS-e820: 00000000bdadc000 - 00000000bdaed000 (ACPI NVS)
-  BIOS-e820: 00000000bdaed000 - 00000000bdb00000 (reserved)
-  BIOS-e820: 00000000bdb00000 - 00000000bdb02000 (ACPI NVS)
-  BIOS-e820: 00000000bdb02000 - 00000000bdb0b000 (reserved)
-  BIOS-e820: 00000000bdb0b000 - 00000000bdb11000 (ACPI NVS)
-  BIOS-e820: 00000000bdb11000 - 00000000bdb70000 (reserved)
-  BIOS-e820: 00000000bdb70000 - 00000000bdd73000 (ACPI NVS)
-  BIOS-e820: 00000000bdd73000 - 00000000bdf00000 (usable)
+  BIOS-e820: 0000000000100000 - 00000000bd94e000 (usable)
+  BIOS-e820: 00000000bd94e000 - 00000000bd99d000 (ACPI NVS)
+  BIOS-e820: 00000000bd99d000 - 00000000bd9a6000 (ACPI data)
+  BIOS-e820: 00000000bd9a6000 - 00000000bdade000 (reserved)
+  BIOS-e820: 00000000bdade000 - 00000000bdaef000 (ACPI NVS)
+  BIOS-e820: 00000000bdaef000 - 00000000bdb02000 (reserved)
+  BIOS-e820: 00000000bdb02000 - 00000000bdb04000 (ACPI NVS)
+  BIOS-e820: 00000000bdb04000 - 00000000bdb0d000 (reserved)
+  BIOS-e820: 00000000bdb0d000 - 00000000bdb13000 (ACPI NVS)
+  BIOS-e820: 00000000bdb13000 - 00000000bdb75000 (reserved)
+  BIOS-e820: 00000000bdb75000 - 00000000bdd78000 (ACPI NVS)
+  BIOS-e820: 00000000bdd78000 - 00000000bdf00000 (usable)
   BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
   BIOS-e820: 00000000fec10000 - 00000000fec11000 (reserved)
@@ -29,7 +29,7 @@
   BIOS-e820: 0000000100001000 - 0000000240000000 (usable)
   NX (Execute Disable) protection: active
   DMI 2.7 present.
-  DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0503 05/30/2011
+  DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0705 08/22/2011
   e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
   e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
   No AGP bridge found
@@ -42,10 +42,10 @@
   D1000-EBFFF uncachable
   EC000-FFFFF write-protect
   MTRR variable ranges enabled:
-  0 base 000000000000 mask FFFF00000000 write-back
-  1 base 0000BDF00000 mask FFFFFFF00000 uncachable
-  2 base 0000BE000000 mask FFFFFE000000 uncachable
-  3 base 0000C0000000 mask FFFFC0000000 uncachable
+  0 base 000000000000 mask FFFF80000000 write-back
+  1 base 000080000000 mask FFFFC0000000 write-back
+  2 base 0000BDF00000 mask FFFFFFF00000 uncachable
+  3 base 0000BE000000 mask FFFFFE000000 uncachable
   4 disabled
   5 disabled
   6 disabled
@@ -66,15 +66,15 @@
   kernel direct mapping tables up to 240000000 @ bdeff000-bdf00000
   RAMDISK: 7f738000 - 80000000
   ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
-  ACPI: XSDT 00000000bd99c068 0004C (v01 ALASKA A M I 01072009 AMI 00010013)
-  ACPI: FACP 00000000bd9a2a68 000F4 (v04 ALASKA A M I 01072009 AMI 00010013)
+  ACPI: XSDT 00000000bd99d068 0004C (v01 ALASKA A M I 01072009 AMI 00010013)
+  ACPI: FACP 00000000bd9a4038 000F4 (v04 ALASKA A M I 01072009 AMI 00010013)
   ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110112/tbfadt-557)
-  ACPI: DSDT 00000000bd99c140 06924 (v02 ALASKA A M I 00000000 INTL 20051117)
-  ACPI: FACS 00000000bdb0bf80 00040
-  ACPI: APIC 00000000bd9a2b60 0009E (v03 ALASKA A M I 01072009 AMI 00010013)
-  ACPI: MCFG 00000000bd9a2c00 0003C (v01 ALASKA A M I 01072009 MSFT 00010013)
-  ACPI: HPET 00000000bd9a2c40 00038 (v01 ALASKA A M I 01072009 AMI 00000004)
-  ACPI: SSDT 00000000bd9a2c78 00DDA (v01 AMD POWERNOW 00000001 AMD 00000001)
+  ACPI: DSDT 00000000bd99d140 06EF1 (v02 ALASKA A M I 00000000 INTL 20051117)
+  ACPI: FACS 00000000bdb0df80 00040
+  ACPI: APIC 00000000bd9a4130 0009E (v03 ALASKA A M I 01072009 AMI 00010013)
+  ACPI: MCFG 00000000bd9a41d0 0003C (v01 ALASKA A M I 01072009 MSFT 00010013)
+  ACPI: HPET 00000000bd9a4210 00038 (v01 ALASKA A M I 01072009 AMI 00000004)
+  ACPI: SSDT 00000000bd9a4248 00E10 (v01 AMD POWERNOW 00000001 AMD 00000001)
   ACPI: Local APIC address 0xfee00000
   Scanning NUMA topology in Northbridge 24
   No NUMA configuration found
@@ -89,15 +89,15 @@
   Movable zone start PFN for each node
   early_node_map[4] active PFN ranges
   0: 0x00000010 -> 0x0000009d
-  0: 0x00000100 -> 0x000bd94d
-  0: 0x000bdd73 -> 0x000bdf00
+  0: 0x00000100 -> 0x000bd94e
+  0: 0x000bdd78 -> 0x000bdf00
   0: 0x00100001 -> 0x00240000
-  On node 0 totalpages: 2087526
+  On node 0 totalpages: 2087522
   DMA zone: 56 pages used for memmap
   DMA zone: 7 pages reserved
   DMA zone: 3918 pages, LIFO batch:0
   DMA32 zone: 14280 pages used for memmap
-  DMA32 zone: 758546 pages, LIFO batch:31
+  DMA32 zone: 758542 pages, LIFO batch:31
   Normal zone: 17920 pages used for memmap
   Normal zone: 1292799 pages, LIFO batch:31
   ACPI: PM-Timer IO Port: 0x808
@@ -128,16 +128,16 @@
   PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
   PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
   PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
-  PM: Registered nosave memory: 00000000bd94d000 - 00000000bd99c000
-  PM: Registered nosave memory: 00000000bd99c000 - 00000000bd9a4000
-  PM: Registered nosave memory: 00000000bd9a4000 - 00000000bdadc000
-  PM: Registered nosave memory: 00000000bdadc000 - 00000000bdaed000
-  PM: Registered nosave memory: 00000000bdaed000 - 00000000bdb00000
-  PM: Registered nosave memory: 00000000bdb00000 - 00000000bdb02000
-  PM: Registered nosave memory: 00000000bdb02000 - 00000000bdb0b000
-  PM: Registered nosave memory: 00000000bdb0b000 - 00000000bdb11000
-  PM: Registered nosave memory: 00000000bdb11000 - 00000000bdb70000
-  PM: Registered nosave memory: 00000000bdb70000 - 00000000bdd73000
+  PM: Registered nosave memory: 00000000bd94e000 - 00000000bd99d000
+  PM: Registered nosave memory: 00000000bd99d000 - 00000000bd9a6000
+  PM: Registered nosave memory: 00000000bd9a6000 - 00000000bdade000
+  PM: Registered nosave memory: 00000000bdade000 - 00000000bdaef000
+  PM: Registered nosave memory: 00000000bdaef000 - 00000000bdb02000
+  PM: Registered nosave memory: 00000000bdb02000 - 00000000bdb04000
+  PM: Registered nosave memory: 00000000bdb04000 - 00000000bdb0d000
+  PM: Registered nosave memory: 00000000bdb0d000 - 00000000bdb13000
+  PM: Registered nosave memory: 00000000bdb13000 - 00000000bdb75000
+  PM: Registered nosave memory: 00000000bdb75000 - 00000000bdd78000
   PM: Registered nosave memory: 00000000bdf00000 - 00000000f8000000
   PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
   PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
@@ -161,14 +161,14 @@
   PERCPU: Embedded 28 pages/cpu @ffff8800bd600000 s84416 r8192 d22080 u262144
   pcpu-alloc: s84416 r8192 d22080 u262144 alloc=1*2097152
   pcpu-alloc: [0] 0 1 2 3 4 5 6 7
-  Built 1 zonelists in Zone order, mobility grouping on. Total pages: 2055263
+  Built 1 zonelists in Zone order, mobility grouping on. Total pages: 2055259
   Policy zone: Normal
   Kernel command line: tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=true vga=normal initrd=/images/ubuntu/11.04/mini-iso/64bit/initrd.gz -- quiet BOOT_IMAGE=/images/ubuntu/11.04/mini-iso/64bit/linux
   PID hash table entries: 4096 (order: 3, 32768 bytes)
   Checking aperture...
   No AGP bridge found
   Node 0: aperture @ f8000000 size 64 MB
-  Memory: 8145952k/9437184k available (5940k kernel code, 1087080k absent, 204152k reserved, 5017k data, 956k init)
+  Memory: 8145936k/9437184k available (5940k kernel code, 1087096k absent, 204152k reserved, 5017k data, 956k init)
   SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
   Hierarchical RCU implementation.
   RCU dyntick-idle grace-period acceleration is enabled.
@@ -181,8 +181,8 @@
   please try 'cgroup_disable=memory' option if you don't want memory cgroups
   hpet clockevent registered
   Fast TSC calibration using PIT
-  Detected 3211.088 MHz processor.
-  Calibrating delay loop (skipped), value calculated using timer frequency.. 6422.17 BogoMIPS (lpj=32110880)
+  Detected 3211.052 MHz processor.
+  Calibrating delay loop (skipped), value calculated using timer frequency.. 6422.10 BogoMIPS (lpj=32110520)
   pid_max: default: 32768 minimum: 301
   Security Framework initialized
   AppArmor: AppArmor initialized
@@ -227,12 +227,12 @@
   Switch to broadcast mode on CPU4
   #5
   Brought up 6 CPUs
-  Total of 6 processors activated (38530.17 BogoMIPS).
+  Total of 6 processors activated (38530.08 BogoMIPS).
   Switch to broadcast mode on CPU5
   Switch to broadcast mode on CPU0
   devtmpfs: initialized
   print_constraints: dummy:
-  Time: 23:05:30 Date: 09/07/11
+  Time: 15:04:26 Date: 10/16/11
   NET: Registered protocol family 16
   node 0 link 0: io port [d000, ffff]
   TOM: 00000000c0000000 aka 3072M
@@ -245,15 +245,18 @@
   bus: 00 index 2 [mem 0xf0000000-0xffffffff]
   bus: 00 index 3 [mem 0x240000000-0xfcffffffff]
   Extended Config Space enabled on 1 nodes
-  Trying to unpack rootfs image as initramfs...
   ACPI: bus type pci registered
+  Trying to unpack rootfs image as initramfs...
   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
   PCI: not using MMCONFIG
   PCI: Using configuration type 1 for base access
   PCI: Using configuration type 1 for extended access
+  mtrr: your CPUs had inconsistent fixed MTRR settings
+  mtrr: probably your BIOS does not setup all CPUs.
+  mtrr: corrected configuration.
   bio: create slab <bio-0> at 0
   ACPI: EC: Look up EC in DSDT
-  ACPI: Executed 3 blocks of module-level executable AML code
+  ACPI: Executed 2 blocks of module-level executable AML code
   ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
   ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region) (20110112/nsinit-349)
   ACPI: Interpreter enabled
@@ -261,8 +264,8 @@
   ACPI: Using IOAPIC for interrupt routing
   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
   PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
-  ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
   Freeing initrd memory: 8992k freed
+  ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
   ACPI: No dock devices found.
   HEST: Table not found.
   PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
@@ -341,15 +344,15 @@
   pci 0000:00:02.0: bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
   pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
   pci 0000:02:00.0: reg 10: [io 0xd000-0xd0ff]
-  pci 0000:02:00.0: reg 18: [mem 0xd0004000-0xd0004fff 64bit pref]
-  pci 0000:02:00.0: reg 20: [mem 0xd0000000-0xd0003fff 64bit pref]
+  pci 0000:02:00.0: reg 18: [mem 0xd4004000-0xd4004fff 64bit pref]
+  pci 0000:02:00.0: reg 20: [mem 0xd4000000-0xd4003fff 64bit pref]
   pci 0000:02:00.0: supports D1 D2
   pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
   pci 0000:02:00.0: PME# disabled
   pci 0000:00:04.0: PCI bridge to [bus 02-02]
   pci 0000:00:04.0: bridge window [io 0xd000-0xdfff]
   pci 0000:00:04.0: bridge window [mem 0xfff00000-0x000fffff] (disabled)
-  pci 0000:00:04.0: bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
+  pci 0000:00:04.0: bridge window [mem 0xd4000000-0xd40fffff 64bit pref]
   pci 0000:03:00.0: [1b21:1042] type 0 class 0x000c03
   pci 0000:03:00.0: reg 10: [mem 0xfe900000-0xfe907fff 64bit]
   pci 0000:03:00.0: PME# supported from D3hot D3cold
@@ -358,10 +361,12 @@
   pci 0000:00:07.0: bridge window [io 0xfff000-0x0000] (disabled)
   pci 0000:00:07.0: bridge window [mem 0xfe900000-0xfe9fffff]
   pci 0000:00:07.0: bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
+  pci 0000:04:05.0: [4444:0016] type 0 class 0x000400
+  pci 0000:04:05.0: reg 10: [mem 0xd0000000-0xd3ffffff pref]
   pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive decode)
   pci 0000:00:14.4: bridge window [io 0xf000-0x0000] (disabled)
   pci 0000:00:14.4: bridge window [mem 0xfff00000-0x000fffff] (disabled)
-  pci 0000:00:14.4: bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
+  pci 0000:00:14.4: bridge window [mem 0xd0000000-0xd3ffffff pref]
   pci 0000:00:14.4: bridge window [io 0x0000-0x03af] (subtractive decode)
   pci 0000:00:14.4: bridge window [io 0x03e0-0x0cf7] (subtractive decode)
   pci 0000:00:14.4: bridge window [io 0x03b0-0x03df] (subtractive decode)
@@ -394,7 +399,7 @@
   PCI: Using ACPI for IRQ routing
   PCI: pci_cache_line_size set to 64 bytes
   reserve RAM buffer: 000000000009d800 - 000000000009ffff
-  reserve RAM buffer: 00000000bd94d000 - 00000000bfffffff
+  reserve RAM buffer: 00000000bd94e000 - 00000000bfffffff
   reserve RAM buffer: 00000000bdf00000 - 00000000bfffffff
   NetLabel: Initializing
   NetLabel: domain hash size = 128
@@ -404,6 +409,12 @@
   hpet0: 3 comparators, 32-bit 14.318180 MHz counter
   Switching to clocksource hpet
   AppArmor: AppArmor Filesystem Enabled
+  Switched to NOHz mode on CPU #5
+  Switched to NOHz mode on CPU #0
+  Switched to NOHz mode on CPU #4
+  Switched to NOHz mode on CPU #1
+  Switched to NOHz mode on CPU #2
+  Switched to NOHz mode on CPU #3
   pnp: PnP ACPI init
   ACPI: bus type pnp registered
   pnp 00:00: [bus 00-ff]
@@ -414,14 +425,8 @@
   pnp 00:00: [io 0x0d00-0xffff window]
   pnp 00:00: [mem 0x000a0000-0x000bffff window]
   pnp 00:00: [mem 0x000c0000-0x000dffff window]
-  Switched to NOHz mode on CPU #0
-  Switched to NOHz mode on CPU #5
   pnp 00:00: [mem 0xc0000000-0xffffffff window]
-  Switched to NOHz mode on CPU #1
   pnp 00:00: [mem 0x00000000 window]
-  Switched to NOHz mode on CPU #3
-  Switched to NOHz mode on CPU #4
-  Switched to NOHz mode on CPU #2
   pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
   pnp 00:01: [mem 0xe0000000-0xefffffff]
   system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
@@ -546,7 +551,7 @@
   pci 0000:00:04.0: PCI bridge to [bus 02-02]
   pci 0000:00:04.0: bridge window [io 0xd000-0xdfff]
   pci 0000:00:04.0: bridge window [mem disabled]
-  pci 0000:00:04.0: bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
+  pci 0000:00:04.0: bridge window [mem 0xd4000000-0xd40fffff 64bit pref]
   pci 0000:00:07.0: PCI bridge to [bus 03-03]
   pci 0000:00:07.0: bridge window [io disabled]
   pci 0000:00:07.0: bridge window [mem 0xfe900000-0xfe9fffff]
@@ -554,7 +559,7 @@
   pci 0000:00:14.4: PCI bridge to [bus 04-04]
   pci 0000:00:14.4: bridge window [io disabled]
   pci 0000:00:14.4: bridge window [mem disabled]
-  pci 0000:00:14.4: bridge window [mem pref disabled]
+  pci 0000:00:14.4: bridge window [mem 0xd0000000-0xd3ffffff pref]
   pci 0000:00:02.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
   pci 0000:00:02.0: setting latency timer to 64
   pci 0000:00:04.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
@@ -572,8 +577,9 @@
   pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
   pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
   pci_bus 0000:02: resource 0 [io 0xd000-0xdfff]
-  pci_bus 0000:02: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
+  pci_bus 0000:02: resource 2 [mem 0xd4000000-0xd40fffff 64bit pref]
   pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
+  pci_bus 0000:04: resource 2 [mem 0xd0000000-0xd3ffffff pref]
   pci_bus 0000:04: resource 4 [io 0x0000-0x03af]
   pci_bus 0000:04: resource 5 [io 0x03e0-0x0cf7]
   pci_bus 0000:04: resource 6 [io 0x03b0-0x03df]
@@ -599,7 +605,7 @@
   PCI-DMA: using GART IOMMU.
   PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
   audit: initializing netlink socket (disabled)
-  type=2000 audit(1315436729.210:1): initialized
+  type=2000 audit(1318777524.880:1): initialized
   HugeTLB registered 2 MB page size, pre-allocated 0 pages
   VFS: Disk quotas dquot_6.5.2
   Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
@@ -641,23 +647,23 @@
   ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
   hub 1-0:1.0: USB hub found
   hub 1-0:1.0: 5 ports detected
-  ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
+  ehci_hcd 0000:00:13.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
   ehci_hcd 0000:00:13.2: EHCI Host Controller
   ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
   ehci_hcd 0000:00:13.2: QUIRK: Enable exception for AMD Hudson ASPM
   ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
   ehci_hcd 0000:00:13.2: debug port 1
-  ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
+  ehci_hcd 0000:00:13.2: irq 21, io mem 0xfeb07000
   ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
   hub 2-0:1.0: USB hub found
   hub 2-0:1.0: 5 ports detected
-  ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
+  ehci_hcd 0000:00:16.2: PCI INT B -> GSI 23 (level, low) -> IRQ 23
   ehci_hcd 0000:00:16.2: EHCI Host Controller
   ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
   ehci_hcd 0000:00:16.2: QUIRK: Enable exception for AMD Hudson ASPM
   ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
   ehci_hcd 0000:00:16.2: debug port 1
-  ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
+  ehci_hcd 0000:00:16.2: irq 23, io mem 0xfeb04000
   ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
   hub 3-0:1.0: USB hub found
   hub 3-0:1.0: 4 ports detected
@@ -668,10 +674,10 @@
   ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
   hub 4-0:1.0: USB hub found
   hub 4-0:1.0: 5 ports detected
-  ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
+  ohci_hcd 0000:00:13.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
   ohci_hcd 0000:00:13.0: OHCI Host Controller
   ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
-  ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
+  ohci_hcd 0000:00:13.0: irq 20, io mem 0xfeb08000
   hub 5-0:1.0: USB hub found
   hub 5-0:1.0: 5 ports detected
   ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
@@ -680,21 +686,21 @@
   ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
   hub 6-0:1.0: USB hub found
   hub 6-0:1.0: 2 ports detected
-  ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
+  ohci_hcd 0000:00:16.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
   ohci_hcd 0000:00:16.0: OHCI Host Controller
   ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
-  ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
+  ohci_hcd 0000:00:16.0: irq 22, io mem 0xfeb05000
   hub 7-0:1.0: USB hub found
   hub 7-0:1.0: 4 ports detected
   uhci_hcd: USB Universal Host Controller Interface driver
-  Refined TSC clocksource calibration: 3210.781 MHz.
-  Switching to clocksource tsc
   i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
   serio: i8042 KBD port at 0x60,0x64 irq 1
   serio: i8042 AUX port at 0x60,0x64 irq 12
   mousedev: PS/2 mouse device common for all mice
   rtc_cmos 00:05: RTC can wake from S4
   input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
+  Refined TSC clocksource calibration: 3210.779 MHz.
+  Switching to clocksource tsc
   rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
   rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
   device-mapper: uevent: version 1.0.3
@@ -715,8 +721,8 @@
   powernow-k8: 3 : pstate 3 (800 MHz)
   PM: Hibernation image not present or could not be loaded.
   registered taskstats version 1
-  Magic number: 11:497:99
-  rtc_cmos 00:05: setting system clock to 2011-09-07 23:05:31 UTC (1315436731)
+  Magic number: 15:330:83
+  rtc_cmos 00:05: setting system clock to 2011-10-16 15:05:26 UTC (1318777526)
   BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
   EDD information not available.
   Freeing unused kernel memory: 956k freed
@@ -733,28 +739,6 @@
   vga16fb: mapped to 0xffff8800000a0000
   Console: switching to colour frame buffer device 80x30
   fb0: VGA16 VGA frame buffer device
-  usb 3-1: new high speed USB device using ehci_hcd and address 2
-  usb 3-1: device descriptor read/64, error -32
-  usb 3-1: device descriptor read/64, error -32
-  usb 3-1: new high speed USB device using ehci_hcd and address 3
-  usb 3-1: device descriptor read/64, error -32
-  usb 3-1: device descriptor read/64, error -32
-  usb 3-1: new high speed USB device using ehci_hcd and address 4
-  usb 3-1: device not accepting address 4, error -32
-  usb 3-1: new high speed USB device using ehci_hcd and address 5
-  usb 3-1: device not accepting address 5, error -32
-  hub 3-0:1.0: unable to enumerate USB device on port 1
-  usb 7-1: new full speed USB device using ohci_hcd and address 2
-  usb 7-1: device descriptor read/64, error -32
-  usb 7-1: device descriptor read/64, error -32
-  usb 7-1: new full speed USB device using ohci_hcd and address 3
-  usb 7-1: device descriptor read/64, error -32
-  usb 7-1: device descriptor read/64, error -32
-  usb 7-1: new full speed USB device using ohci_hcd and address 4
-  usb 7-1: device not accepting address 4, error -32
-  usb 7-1: new full speed USB device using ohci_hcd and address 5
-  usb 7-1: device not accepting address 5, error -32
-  hub 7-0:1.0: unable to enumerate USB device on port 1
   Initializing USB Mass Storage driver...
   usbcore: registered new interface driver usb-storage
   USB Mass Storage support registered.
@@ -772,12 +756,18 @@
   r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
   r8169 0000:02:00.0: irq 72 for MSI/MSI-X
   r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xffffc90011794000, 14:da:e9:03:e9:b7, XID 0c900800 IRQ 72
+  r8169 0000:02:00.0: PCI INT A disabled
+  r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
+  r8169 0000:02:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
+  r8169 0000:02:00.0: setting latency timer to 64
+  r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
+  r8169 0000:02:00.0: irq 72 for MSI/MSI-X
+  r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xffffc90011794000, 14:da:e9:03:e9:b7, XID 0c900800 IRQ 72
   r8169 0000:02:00.0: eth0: link down
   r8169 0000:02:00.0: eth0: link down
   ADDRCONF(NETDEV_UP): eth0: link is not ready
   r8169 0000:02:00.0: eth0: link up
   ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
-  usbcore: deregistering interface driver usb-storage
   ahci 0000:00:11.0: version 3.0
   ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
   ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
@@ -797,13 +787,11 @@
   ata4: SATA link down (SStatus 0 SControl 300)
   ata6: SATA link down (SStatus 0 SControl 300)
   ata3: SATA link down (SStatus 0 SControl 300)
-  ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
+  ata5: SATA link down (SStatus 0 SControl 300)
   ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
   ata1.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
   ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
-  ata2.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
-  ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
-  ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
+  ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
   ata1.00: configured for UDMA/133
   scsi 0:0:0:0: Direct-Access ATA WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
   sd 0:0:0:0: Attached scsi generic sg0 type 0
@@ -811,6 +799,8 @@
   sd 0:0:0:0: [sda] Write Protect is off
   sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
   sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+  ata2.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
+  ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
   ata2.00: configured for UDMA/133
   scsi 1:0:0:0: Direct-Access ATA WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
   sd 1:0:0:0: Attached scsi generic sg1 type 0
@@ -818,24 +808,10 @@
   sd 1:0:0:0: [sdb] Write Protect is off
   sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
   sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-  ata5.00: ATA-7: HDS725050KLA360, K2AOAH0A, max UDMA/133
-  ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
-  ata5.00: configured for UDMA/133
-  scsi 4:0:0:0: Direct-Access ATA HDS725050KLA360 K2AO PQ: 0 ANSI: 5
-  sd 4:0:0:0: Attached scsi generic sg2 type 0
-  sd 4:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
-  sd 4:0:0:0: [sdc] Write Protect is off
-  sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
-  sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
   sd 0:0:0:0: [sda] Attached SCSI disk
   sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
   sd 1:0:0:0: [sdb] Attached SCSI disk
-  sdc: sdc1 sdc2 sdc4
-  sd 4:0:0:0: [sdc] Attached SCSI disk
-  Initializing USB Mass Storage driver...
-  usbcore: registered new interface driver usb-storage
-  USB Mass Storage support registered.
   NTFS driver 2.1.30 [Flags: R/O MODULE].
   Btrfs loaded
   JFS: nTxBlock = 8192, nTxLock = 65536
@@ -883,12 +859,6 @@
   EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
   EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
   EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
-  EXT3-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
-  EXT2-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
-  EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
-  EXT3-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
-  EXT2-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
-  EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: (null)
   EXT3-fs (md0): error: couldn't mount because of unsupported optional features (240)
   EXT2-fs (md0): error: couldn't mount because of unsupported optional features (240)
   EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
@@ -904,14 +874,28 @@
   EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
   EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
   EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
-  EXT3-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
-  EXT2-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
-  EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
-  EXT3-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
-  EXT2-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
-  EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: (null)
-  EXT3-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
-  EXT2-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
-  EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts:
- 
- 
+  EXT3-fs (md126): error: couldn't mount because of unsupported optional features (240)
+  EXT2-fs (md126): error: couldn't mount because of unsupported optional features (240)
+  EXT4-fs (md126): mounted filesystem with ordered data mode. Opts:
+  usb 3-2: new high speed USB device using ehci_hcd and address 2
+  usb 3-2: device descriptor read/64, error -32
+  usb 3-2: device descriptor read/64, error -32
+  usb 3-2: new high speed USB device using ehci_hcd and address 3
+  usb 3-2: device descriptor read/64, error -32
+  usb 3-2: device descriptor read/64, error -32
+  usb 3-2: new high speed USB device using ehci_hcd and address 4
+  usb 3-2: device not accepting address 4, error -32
+  usb 3-2: new high speed USB device using ehci_hcd and address 5
+  usb 3-2: device not accepting address 5, error -32
+  hub 3-0:1.0: unable to enumerate USB device on port 2
+  usb 7-2: new full speed USB device using ohci_hcd and address 2
+  usb 7-2: device descriptor read/64, error -32
+  usb 7-2: device descriptor read/64, error -32
+  usb 7-2: new full speed USB device using ohci_hcd and address 3
+  usb 7-2: device descriptor read/64, error -32
+  usb 7-2: device descriptor read/64, error -32
+  usb 7-2: new full speed USB device using ohci_hcd and address 4
+  usb 7-2: device not accepting address 4, error -32
+  usb 7-2: new full speed USB device using ohci_hcd and address 5
+  usb 7-2: device not accepting address 5, error -32
+  hub 7-0:1.0: unable to enumerate USB device on port 2


--------------020307020002030705040600
Content-Type: text/x-patch;
 name="dmesg.32.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.32.diff"

--- dmesg_32.v2	2011-10-19 10:22:14.284864445 +0200
+++ dmesg_32.v1	2011-10-19 10:21:55.828850426 +0200
@@ -1,22 +1,22 @@
   Initializing cgroup subsys cpuset
   Initializing cgroup subsys cpu
-  Linux version 2.6.38-11-generic-pae (buildd@rothera) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu4) ) #48-Ubuntu SMP Fri Jul 29 20:51:21 UTC 2011 (Ubuntu 2.6.38-11.48-generic-pae 2.6.38.8)
+  Linux version 2.6.38-8-generic (buildd@vernadsky) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #42-Ubuntu SMP Mon Apr 11 03:31:50 UTC 2011 (Ubuntu 2.6.38-8.42-generic 2.6.38.2)
   BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
   BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
   BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
-  BIOS-e820: 0000000000100000 - 00000000bd94d000 (usable)
-  BIOS-e820: 00000000bd94d000 - 00000000bd99c000 (ACPI NVS)
-  BIOS-e820: 00000000bd99c000 - 00000000bd9a4000 (ACPI data)
-  BIOS-e820: 00000000bd9a4000 - 00000000bdadc000 (reserved)
-  BIOS-e820: 00000000bdadc000 - 00000000bdaed000 (ACPI NVS)
-  BIOS-e820: 00000000bdaed000 - 00000000bdb00000 (reserved)
-  BIOS-e820: 00000000bdb00000 - 00000000bdb02000 (ACPI NVS)
-  BIOS-e820: 00000000bdb02000 - 00000000bdb0b000 (reserved)
-  BIOS-e820: 00000000bdb0b000 - 00000000bdb11000 (ACPI NVS)
-  BIOS-e820: 00000000bdb11000 - 00000000bdb70000 (reserved)
-  BIOS-e820: 00000000bdb70000 - 00000000bdd73000 (ACPI NVS)
-  BIOS-e820: 00000000bdd73000 - 00000000bdf00000 (usable)
+  BIOS-e820: 0000000000100000 - 00000000bd94e000 (usable)
+  BIOS-e820: 00000000bd94e000 - 00000000bd99d000 (ACPI NVS)
+  BIOS-e820: 00000000bd99d000 - 00000000bd9a6000 (ACPI data)
+  BIOS-e820: 00000000bd9a6000 - 00000000bdade000 (reserved)
+  BIOS-e820: 00000000bdade000 - 00000000bdaef000 (ACPI NVS)
+  BIOS-e820: 00000000bdaef000 - 00000000bdb02000 (reserved)
+  BIOS-e820: 00000000bdb02000 - 00000000bdb04000 (ACPI NVS)
+  BIOS-e820: 00000000bdb04000 - 00000000bdb0d000 (reserved)
+  BIOS-e820: 00000000bdb0d000 - 00000000bdb13000 (ACPI NVS)
+  BIOS-e820: 00000000bdb13000 - 00000000bdb75000 (reserved)
+  BIOS-e820: 00000000bdb75000 - 00000000bdd78000 (ACPI NVS)
+  BIOS-e820: 00000000bdd78000 - 00000000bdf00000 (usable)
   BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
   BIOS-e820: 00000000fec10000 - 00000000fec11000 (reserved)
@@ -26,12 +26,13 @@
   BIOS-e820: 00000000fed80000 - 00000000fed90000 (reserved)
   BIOS-e820: 00000000fef00000 - 0000000100000000 (reserved)
   BIOS-e820: 0000000100001000 - 0000000240000000 (usable)
-  NX (Execute Disable) protection: active
+  Notice: NX (Execute Disable) protection cannot be enabled in hardware: non-PAE kernel!
+  NX (Execute Disable) protection: approximated by x86 segment limits
   DMI 2.7 present.
-  DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0503 05/30/2011
+  DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0705 08/22/2011
   e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
   e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
-  last_pfn = 0x240000 max_arch_pfn = 0x1000000
+  last_pfn = 0xbdf00 max_arch_pfn = 0x100000
   MTRR default type: uncachable
   MTRR fixed ranges enabled:
   00000-9FFFF write-back
@@ -40,10 +41,10 @@
   D1000-EBFFF uncachable
   EC000-FFFFF write-protect
   MTRR variable ranges enabled:
-  0 base 000000000000 mask FFFF00000000 write-back
-  1 base 0000BDF00000 mask FFFFFFF00000 uncachable
-  2 base 0000BE000000 mask FFFFFE000000 uncachable
-  3 base 0000C0000000 mask FFFFC0000000 uncachable
+  0 base 000000000000 mask FFFF80000000 write-back
+  1 base 000080000000 mask FFFFC0000000 write-back
+  2 base 0000BDF00000 mask FFFFFFF00000 uncachable
+  3 base 0000BE000000 mask FFFFFE000000 uncachable
   4 disabled
   5 disabled
   6 disabled
@@ -51,47 +52,48 @@
   TOM2: 0000000240000000 aka 9216M
   x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
   e820 update range: 00000000bdf00000 - 0000000100000000 (usable) ==> (reserved)
-  initial memory mapped : 0 - 01e00000
-  init_memory_mapping: 0000000000000000-0000000037bfe000
-  0000000000 - 0000200000 page 4k
-  0000200000 - 0037a00000 page 2M
-  0037a00000 - 0037bfe000 page 4k
-  kernel direct mapping tables up to 37bfe000 @ 1dfb000-1e00000
-  RAMDISK: 366c6000 - 3735b000
+  initial memory mapped : 0 - 01c00000
+  init_memory_mapping: 0000000000000000-00000000377fe000
+  0000000000 - 0000400000 page 4k
+  0000400000 - 0037400000 page 2M
+  0037400000 - 00377fe000 page 4k
+  kernel direct mapping tables up to 377fe000 @ 1bfb000-1c00000
+  RAMDISK: 7f862000 - 80000000
+  Allocated new RAMDISK: 37060000 - 377fdfc7
+  Move RAMDISK from 000000007f862000 - 000000007fffffc6 to 37060000 - 377fdfc6
   ACPI: RSDP 000f0450 00024 (v02 ALASKA)
-  ACPI: XSDT bd99c068 0004C (v01 ALASKA A M I 01072009 AMI 00010013)
-  ACPI: FACP bd9a2a68 000F4 (v04 ALASKA A M I 01072009 AMI 00010013)
+  ACPI: XSDT bd99d068 0004C (v01 ALASKA A M I 01072009 AMI 00010013)
+  ACPI: FACP bd9a4038 000F4 (v04 ALASKA A M I 01072009 AMI 00010013)
   ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110112/tbfadt-557)
-  ACPI: DSDT bd99c140 06924 (v02 ALASKA A M I 00000000 INTL 20051117)
-  ACPI: FACS bdb0bf80 00040
-  ACPI: APIC bd9a2b60 0009E (v03 ALASKA A M I 01072009 AMI 00010013)
-  ACPI: MCFG bd9a2c00 0003C (v01 ALASKA A M I 01072009 MSFT 00010013)
-  ACPI: HPET bd9a2c40 00038 (v01 ALASKA A M I 01072009 AMI 00000004)
-  ACPI: SSDT bd9a2c78 00DDA (v01 AMD POWERNOW 00000001 AMD 00000001)
+  ACPI: DSDT bd99d140 06EF1 (v02 ALASKA A M I 00000000 INTL 20051117)
+  ACPI: FACS bdb0df80 00040
+  ACPI: APIC bd9a4130 0009E (v03 ALASKA A M I 01072009 AMI 00010013)
+  ACPI: MCFG bd9a41d0 0003C (v01 ALASKA A M I 01072009 MSFT 00010013)
+  ACPI: HPET bd9a4210 00038 (v01 ALASKA A M I 01072009 AMI 00000004)
+  ACPI: SSDT bd9a4248 00E10 (v01 AMD POWERNOW 00000001 AMD 00000001)
   ACPI: Local APIC address 0xfee00000
-  8324MB HIGHMEM available.
-  891MB LOWMEM available.
-  mapped low ram: 0 - 37bfe000
-  low ram: 0 - 37bfe000
+  2151MB HIGHMEM available.
+  887MB LOWMEM available.
+  mapped low ram: 0 - 377fe000
+  low ram: 0 - 377fe000
   Zone PFN ranges:
   DMA 0x00000010 -> 0x00001000
-  Normal 0x00001000 -> 0x00037bfe
-  HighMem 0x00037bfe -> 0x00240000
+  Normal 0x00001000 -> 0x000377fe
+  HighMem 0x000377fe -> 0x000bdf00
   Movable zone start PFN for each node
-  early_node_map[4] active PFN ranges
+  early_node_map[3] active PFN ranges
   0: 0x00000010 -> 0x0000009d
-  0: 0x00000100 -> 0x000bd94d
-  0: 0x000bdd73 -> 0x000bdf00
-  0: 0x00100001 -> 0x00240000
-  On node 0 totalpages: 2087526
-  free_area_init_node: node 0, pgdat c17bac40, node_mem_map f1ec6200
+  0: 0x00000100 -> 0x000bd94e
+  0: 0x000bdd78 -> 0x000bdf00
+  On node 0 totalpages: 776803
+  free_area_init_node: node 0, pgdat c1784100, node_mem_map f589f200
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 3949 pages, LIFO batch:0
-  Normal zone: 1752 pages used for memmap
-  Normal zone: 222502 pages, LIFO batch:31
-  HighMem zone: 16649 pages used for memmap
-  HighMem zone: 1842642 pages, LIFO batch:31
+  Normal zone: 1744 pages used for memmap
+  Normal zone: 221486 pages, LIFO batch:31
+  HighMem zone: 4303 pages used for memmap
+  HighMem zone: 545289 pages, LIFO batch:31
   Using APIC driver default
   ACPI: PM-Timer IO Port: 0x808
   ACPI: Local APIC address 0xfee00000
@@ -124,43 +126,41 @@
   Allocating PCI resources starting at bdf00000 (gap: bdf00000:3a100000)
   Booting paravirtualized kernel on bare hardware
   setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
-  PERCPU: Embedded 13 pages/cpu @f7800000 s32320 r0 d20928 u262144
-  pcpu-alloc: s32320 r0 d20928 u262144 alloc=1*2097152
+  PERCPU: Embedded 13 pages/cpu @f5400000 s28800 r0 d24448 u524288
+  pcpu-alloc: s28800 r0 d24448 u524288 alloc=1*4194304
   pcpu-alloc: [0] 0 1 2 3 4 5 6 7
-  Built 1 zonelists in Zone order, mobility grouping on. Total pages: 2069093
-  Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.38-11-generic-pae root=UUID=6d351741-09db-4c02-8a37-6d7910d9d4da ro quiet splash vt.handoff=7
+  Built 1 zonelists in Zone order, mobility grouping on. Total pages: 770724
+  Kernel command line: tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=true vga=normal initrd=/images/ubuntu/11.04/mini-iso/initrd.gz -- quiet BOOT_IMAGE=/images/ubuntu/11.04/mini-iso/linux
   PID hash table entries: 4096 (order: 2, 16384 bytes)
   Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
   Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
   Initializing CPU#0
-  allocated 47185600 bytes of page_cgroup
+  allocated 15559360 bytes of page_cgroup
   please try 'cgroup_disable=memory' option if you don't want memory cgroups
-  Initializing HighMem for node 0 (00037bfe:00240000)
-  Memory: 8206480k/9437184k available (5351k kernel code, 143624k reserved, 2597k data, 720k init, 7437164k highmem)
+  Initializing HighMem for node 0 (000377fe:000bdf00)
+  Memory: 3049236k/3111936k available (5188k kernel code, 57976k reserved, 2540k data, 700k init, 2198368k highmem)
   virtual kernel memory layout:
   fixmap : 0xfff16000 - 0xfffff000 ( 932 kB)
-  pkmap : 0xffc00000 - 0xffe00000 (2048 kB)
-  vmalloc : 0xf83fe000 - 0xffbfe000 ( 120 MB)
-  lowmem : 0xc0000000 - 0xf7bfe000 ( 891 MB)
-  .init : 0xc17c4000 - 0xc1878000 ( 720 kB)
-  .data : 0xc1539e95 - 0xc17c35c0 (2597 kB)
-  .text : 0xc1000000 - 0xc1539e95 (5351 kB)
+  pkmap : 0xff800000 - 0xffc00000 (4096 kB)
+  vmalloc : 0xf7ffe000 - 0xff7fe000 ( 120 MB)
+  lowmem : 0xc0000000 - 0xf77fe000 ( 887 MB)
+  .init : 0xc178d000 - 0xc183c000 ( 700 kB)
+  .data : 0xc15112a1 - 0xc178c480 (2540 kB)
+  .text : 0xc1000000 - 0xc15112a1 (5188 kB)
   Checking if this processor honours the WP bit even in supervisor mode...Ok.
   SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
   Hierarchical RCU implementation.
   RCU dyntick-idle grace-period acceleration is enabled.
   RCU-based detection of stalled CPUs is disabled.
   NR_IRQS:2304 nr_irqs:1288 16
-  CPU 0 irqstacks, hard=f740a000 soft=f740c000
+  CPU 0 irqstacks, hard=f400a000 soft=f400c000
   Extended CMOS year: 2000
-  spurious 8259A interrupt: IRQ7.
-  vt handoff: transparent VT on vt#7
   Console: colour VGA+ 80x25
   console [tty0] enabled
   hpet clockevent registered
   Fast TSC calibration using PIT
-  Detected 3210.863 MHz processor.
-  Calibrating delay loop (skipped), value calculated using timer frequency.. 6421.72 BogoMIPS (lpj=12843452)
+  Detected 3210.741 MHz processor.
+  Calibrating delay loop (skipped), value calculated using timer frequency.. 6421.48 BogoMIPS (lpj=12842964)
   pid_max: default: 32768 minimum: 301
   Security Framework initialized
   AppArmor: AppArmor initialized
@@ -179,7 +179,7 @@
   mce: CPU supports 6 MCE banks
   using C1E aware idle routine
   ACPI: Core revision 20110112
-  ftrace: allocating 24259 entries in 48 pages
+  ftrace: allocating 23640 entries in 47 pages
   Enabling APIC mode: Flat. Using 2 I/O APICs
   ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
   CPU0: AMD Phenom(tm) II X6 1090T Processor stepping 00
@@ -191,33 +191,33 @@
   ... max period: 00007fffffffffff
   ... fixed-purpose events: 0
   ... event mask: 000000000000000f
-  CPU 1 irqstacks, hard=f74ae000 soft=f74b8000
+  CPU 1 irqstacks, hard=f40ae000 soft=f40b8000
   Booting Node 0, Processors #1
   Initializing CPU#1
   System has AMD C1E enabled
   Switch to broadcast mode on CPU1
-  CPU 2 irqstacks, hard=f74e2000 soft=f74e4000
+  CPU 2 irqstacks, hard=f40e2000 soft=f40e4000
   #2
   Initializing CPU#2
   Switch to broadcast mode on CPU2
-  CPU 3 irqstacks, hard=f74ee000 soft=f74f0000
+  CPU 3 irqstacks, hard=f40ee000 soft=f40f0000
   #3
   Initializing CPU#3
   Switch to broadcast mode on CPU3
-  CPU 4 irqstacks, hard=f7506000 soft=f7508000
+  CPU 4 irqstacks, hard=f4106000 soft=f4108000
   #4
   Initializing CPU#4
   Switch to broadcast mode on CPU4
-  CPU 5 irqstacks, hard=f7526000 soft=f7528000
+  CPU 5 irqstacks, hard=f4126000 soft=f4128000
   #5
   Initializing CPU#5
   Brought up 6 CPUs
-  Total of 6 processors activated (38529.53 BogoMIPS).
+  Total of 6 processors activated (38529.97 BogoMIPS).
   Switch to broadcast mode on CPU5
   Switch to broadcast mode on CPU0
   devtmpfs: initialized
   print_constraints: dummy:
-  Time: 22:52:03 Date: 09/07/11
+  Time: 14:56:27 Date: 10/16/11
   NET: Registered protocol family 16
   EISA bus registered
   node 0 link 0: io port [d000, ffff]
@@ -229,7 +229,6 @@
   bus: 00 index 0 [io 0x0000-0xffff]
   bus: 00 index 1 [mem 0xc0000000-0xdfffffff]
   bus: 00 index 2 [mem 0xf0000000-0xffffffff]
-  bus: 00 index 3 [mem 0x240000000-0xfcffffffff]
   Extended Config Space enabled on 1 nodes
   ACPI: bus type pci registered
   Trying to unpack rootfs image as initramfs...
@@ -237,9 +236,12 @@
   PCI: not using MMCONFIG
   PCI: Using configuration type 1 for base access
   PCI: Using configuration type 1 for extended access
+  mtrr: your CPUs had inconsistent fixed MTRR settings
+  mtrr: probably your BIOS does not setup all CPUs.
+  mtrr: corrected configuration.
   bio: create slab <bio-0> at 0
   ACPI: EC: Look up EC in DSDT
-  ACPI: Executed 3 blocks of module-level executable AML code
+  ACPI: Executed 2 blocks of module-level executable AML code
   ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
   ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region) (20110112/nsinit-349)
   ACPI: Interpreter enabled
@@ -327,27 +329,30 @@
   pci 0000:00:02.0: bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
   pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
   pci 0000:02:00.0: reg 10: [io 0xd000-0xd0ff]
-  pci 0000:02:00.0: reg 18: [mem 0xd0004000-0xd0004fff 64bit pref]
-  pci 0000:02:00.0: reg 20: [mem 0xd0000000-0xd0003fff 64bit pref]
+  pci 0000:02:00.0: reg 18: [mem 0xd4004000-0xd4004fff 64bit pref]
+  pci 0000:02:00.0: reg 20: [mem 0xd4000000-0xd4003fff 64bit pref]
   pci 0000:02:00.0: supports D1 D2
   pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
   pci 0000:02:00.0: PME# disabled
   pci 0000:00:04.0: PCI bridge to [bus 02-02]
   pci 0000:00:04.0: bridge window [io 0xd000-0xdfff]
   pci 0000:00:04.0: bridge window [mem 0xfff00000-0x000fffff] (disabled)
-  pci 0000:00:04.0: bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
+  pci 0000:00:04.0: bridge window [mem 0xd4000000-0xd40fffff 64bit pref]
   pci 0000:03:00.0: [1b21:1042] type 0 class 0x000c03
   pci 0000:03:00.0: reg 10: [mem 0xfe900000-0xfe907fff 64bit]
   pci 0000:03:00.0: PME# supported from D3hot D3cold
   pci 0000:03:00.0: PME# disabled
+  Freeing initrd memory: 7800k freed
   pci 0000:00:07.0: PCI bridge to [bus 03-03]
   pci 0000:00:07.0: bridge window [io 0xfff000-0x0000] (disabled)
   pci 0000:00:07.0: bridge window [mem 0xfe900000-0xfe9fffff]
   pci 0000:00:07.0: bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
+  pci 0000:04:05.0: [4444:0016] type 0 class 0x000400
+  pci 0000:04:05.0: reg 10: [mem 0xd0000000-0xd3ffffff pref]
   pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive decode)
   pci 0000:00:14.4: bridge window [io 0xf000-0x0000] (disabled)
   pci 0000:00:14.4: bridge window [mem 0xfff00000-0x000fffff] (disabled)
-  pci 0000:00:14.4: bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
+  pci 0000:00:14.4: bridge window [mem 0xd0000000-0xd3ffffff pref]
   pci 0000:00:14.4: bridge window [io 0x0000-0x03af] (subtractive decode)
   pci 0000:00:14.4: bridge window [io 0x03e0-0x0cf7] (subtractive decode)
   pci 0000:00:14.4: bridge window [io 0x03b0-0x03df] (subtractive decode)
@@ -381,7 +386,7 @@
   PCI: Using ACPI for IRQ routing
   PCI: pci_cache_line_size set to 64 bytes
   reserve RAM buffer: 000000000009d800 - 000000000009ffff
-  reserve RAM buffer: 00000000bd94d000 - 00000000bfffffff
+  reserve RAM buffer: 00000000bd94e000 - 00000000bfffffff
   reserve RAM buffer: 00000000bdf00000 - 00000000bfffffff
   NetLabel: Initializing
   NetLabel: domain hash size = 128
@@ -390,12 +395,12 @@
   hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
   hpet0: 3 comparators, 32-bit 14.318180 MHz counter
   Switching to clocksource hpet
-  Switched to NOHz mode on CPU #1
-  Switched to NOHz mode on CPU #3
-  Switched to NOHz mode on CPU #2
   Switched to NOHz mode on CPU #5
-  Switched to NOHz mode on CPU #0
+  Switched to NOHz mode on CPU #2
   Switched to NOHz mode on CPU #4
+  Switched to NOHz mode on CPU #0
+  Switched to NOHz mode on CPU #3
+  Switched to NOHz mode on CPU #1
   AppArmor: AppArmor Filesystem Enabled
   pnp: PnP ACPI init
   ACPI: bus type pnp registered
@@ -427,7 +432,7 @@
   pnp 00:02: [io 0x0cd6-0x0cd7]
   pnp 00:02: [io 0x0cd8-0x0cdf]
   pnp 00:02: [io 0x0800-0x089f]
-  pnp 00:02: [io 0x0000-0xffffffffffffffff disabled]
+  pnp 00:02: [io 0x0000-0xffffffff disabled]
   pnp 00:02: [io 0x0000-0x000f]
   pnp 00:02: [io 0x0b20-0x0b3f]
   pnp 00:02: [io 0x0900-0x090f]
@@ -468,9 +473,9 @@
   system 00:02: [mem 0xfed00000-0xfed00fff] has been reserved
   system 00:02: [mem 0xffc00000-0xffffffff] has been reserved
   system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
-  pnp 00:03: [io 0x0000-0xffffffffffffffff disabled]
+  pnp 00:03: [io 0x0000-0xffffffff disabled]
   pnp 00:03: [io 0x0290-0x02af]
-  pnp 00:03: [io 0x0000-0xffffffffffffffff disabled]
+  pnp 00:03: [io 0x0000-0xffffffff disabled]
   system 00:03: [io 0x0290-0x02af] has been reserved
   system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
   pnp 00:04: [dma 4]
@@ -516,9 +521,9 @@
   pnp 00:0c: [irq 4]
   pnp 00:0c: [dma 0 disabled]
   pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
-  pnp 00:0d: [mem 0x00000000-0xffffffffffffffff disabled]
+  pnp 00:0d: [mem 0x00000000-0xffffffff disabled]
   system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
-  pnp 00:0e: [mem 0x00000000-0xffffffffffffffff disabled]
+  pnp 00:0e: [mem 0x00000000-0xffffffff disabled]
   pnp 00:0e: [mem 0xfec20000-0xfec200ff]
   system 00:0e: [mem 0xfec20000-0xfec200ff] could not be reserved
   system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
@@ -534,7 +539,7 @@
   pci 0000:00:04.0: PCI bridge to [bus 02-02]
   pci 0000:00:04.0: bridge window [io 0xd000-0xdfff]
   pci 0000:00:04.0: bridge window [mem disabled]
-  pci 0000:00:04.0: bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
+  pci 0000:00:04.0: bridge window [mem 0xd4000000-0xd40fffff 64bit pref]
   pci 0000:00:07.0: PCI bridge to [bus 03-03]
   pci 0000:00:07.0: bridge window [io disabled]
   pci 0000:00:07.0: bridge window [mem 0xfe900000-0xfe9fffff]
@@ -542,7 +547,7 @@
   pci 0000:00:14.4: PCI bridge to [bus 04-04]
   pci 0000:00:14.4: bridge window [io disabled]
   pci 0000:00:14.4: bridge window [mem disabled]
-  pci 0000:00:14.4: bridge window [mem pref disabled]
+  pci 0000:00:14.4: bridge window [mem 0xd0000000-0xd3ffffff pref]
   pci 0000:00:02.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
   pci 0000:00:02.0: setting latency timer to 64
   pci 0000:00:04.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
@@ -560,8 +565,9 @@
   pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
   pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
   pci_bus 0000:02: resource 0 [io 0xd000-0xdfff]
-  pci_bus 0000:02: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
+  pci_bus 0000:02: resource 2 [mem 0xd4000000-0xd40fffff 64bit pref]
   pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
+  pci_bus 0000:04: resource 2 [mem 0xd0000000-0xd3ffffff pref]
   pci_bus 0000:04: resource 4 [io 0x0000-0x03af]
   pci_bus 0000:04: resource 5 [io 0x03e0-0x0cf7]
   pci_bus 0000:04: resource 6 [io 0x03b0-0x03df]
@@ -578,18 +584,17 @@
   UDP hash table entries: 512 (order: 2, 16384 bytes)
   UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
   NET: Registered protocol family 1
-  Freeing initrd memory: 12884k freed
   pci 0000:01:00.0: Boot video device
   PCI: CLS 64 bytes, default 64
   cpufreq-nforce2: No nForce2 chipset.
   audit: initializing netlink socket (disabled)
-  type=2000 audit(1315435924.524:1): initialized
+  type=2000 audit(1318777072.293:1): initialized
   highmem bounce pool size: 64 pages
-  HugeTLB registered 2 MB page size, pre-allocated 0 pages
+  HugeTLB registered 4 MB page size, pre-allocated 0 pages
   VFS: Disk quotas dquot_6.5.2
   Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
   fuse init (API version 7.16)
-  msgmni has been set to 1527
+  msgmni has been set to 1677
   Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
   io scheduler noop registered
   io scheduler deadline registered
@@ -628,23 +633,23 @@
   ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
   hub 1-0:1.0: USB hub found
   hub 1-0:1.0: 5 ports detected
-  ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
+  ehci_hcd 0000:00:13.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
   ehci_hcd 0000:00:13.2: EHCI Host Controller
   ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
   ehci_hcd 0000:00:13.2: QUIRK: Enable exception for AMD Hudson ASPM
   ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
   ehci_hcd 0000:00:13.2: debug port 1
-  ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
+  ehci_hcd 0000:00:13.2: irq 21, io mem 0xfeb07000
   ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
   hub 2-0:1.0: USB hub found
   hub 2-0:1.0: 5 ports detected
-  ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
+  ehci_hcd 0000:00:16.2: PCI INT B -> GSI 23 (level, low) -> IRQ 23
   ehci_hcd 0000:00:16.2: EHCI Host Controller
   ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
   ehci_hcd 0000:00:16.2: QUIRK: Enable exception for AMD Hudson ASPM
   ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
   ehci_hcd 0000:00:16.2: debug port 1
-  ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
+  ehci_hcd 0000:00:16.2: irq 23, io mem 0xfeb04000
   ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
   hub 3-0:1.0: USB hub found
   hub 3-0:1.0: 4 ports detected
@@ -655,10 +660,10 @@
   ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
   hub 4-0:1.0: USB hub found
   hub 4-0:1.0: 5 ports detected
-  ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
+  ohci_hcd 0000:00:13.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
   ohci_hcd 0000:00:13.0: OHCI Host Controller
   ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
-  ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
+  ohci_hcd 0000:00:13.0: irq 20, io mem 0xfeb08000
   hub 5-0:1.0: USB hub found
   hub 5-0:1.0: 5 ports detected
   ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
@@ -667,10 +672,10 @@
   ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
   hub 6-0:1.0: USB hub found
   hub 6-0:1.0: 2 ports detected
-  ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
+  ohci_hcd 0000:00:16.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
   ohci_hcd 0000:00:16.0: OHCI Host Controller
   ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
-  ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
+  ohci_hcd 0000:00:16.0: irq 22, io mem 0xfeb05000
   hub 7-0:1.0: USB hub found
   hub 7-0:1.0: 4 ports detected
   uhci_hcd: USB Universal Host Controller Interface driver
@@ -711,230 +716,49 @@
   Using IPI No-Shortcut mode
   PM: Hibernation image not present or could not be loaded.
   registered taskstats version 1
-  Magic number: 11:218:906
-  rtc_cmos 00:05: setting system clock to 2011-09-07 22:52:05 UTC (1315435925)
+  Magic number: 15:601:940
+  rtc_cmos 00:05: setting system clock to 2011-10-16 14:57:54 UTC (1318777074)
   BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
   EDD information not available.
-  Freeing unused kernel memory: 720k freed
-  Write protecting the kernel text: 5352k
-  Write protecting the kernel read-only data: 2192k
-  NX-protecting the kernel data: 4888k
-  <30>udev[76]: starting version 167
-  input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
-  md: linear personality registered for level -1
-  md: multipath personality registered for level -4
-  md: raid0 personality registered for level 0
-  md: raid1 personality registered for level 1
-  xhci_hcd 0000:03:00.0: PCI INT A -> GSI 50 (level, low) -> IRQ 50
-  xhci_hcd 0000:03:00.0: setting latency timer to 64
-  xhci_hcd 0000:03:00.0: xHCI Host Controller
-  xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
-  async_tx: api initialized (async)
-  xor: automatically using best checksumming function: pIII_sse
+  Freeing unused kernel memory: 700k freed
+  Write protecting the kernel text: 5192k
+  Write protecting the kernel read-only data: 2148k
   r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
   r8169 0000:02:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
   r8169 0000:02:00.0: setting latency timer to 64
   r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
   r8169 0000:02:00.0: irq 72 for MSI/MSI-X
-  r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xf8438000, 14:da:e9:03:e9:b7, XID 0c900800 IRQ 72
-  ahci 0000:00:11.0: version 3.0
-  ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
-  ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
-  ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part
-  scsi0 : ahci
-  scsi1 : ahci
-  scsi2 : ahci
-  scsi3 : ahci
-  scsi4 : ahci
-  scsi5 : ahci
-  ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b100 irq 19
-  ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b180 irq 19
-  ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19
-  ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b280 irq 19
-  ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b300 irq 19
-  ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b380 irq 19
-  pIII_sse : 12815.000 MB/sec
-  xor: using function: pIII_sse (12815.000 MB/sec)
-  usb 3-2: new high speed USB device using ehci_hcd and address 2
-  xhci_hcd 0000:03:00.0: irq 50, io mem 0xfe900000
-  xhci_hcd 0000:03:00.0: irq 73 for MSI/MSI-X
-  xhci_hcd 0000:03:00.0: irq 74 for MSI/MSI-X
-  xhci_hcd 0000:03:00.0: irq 75 for MSI/MSI-X
-  xhci_hcd 0000:03:00.0: irq 76 for MSI/MSI-X
-  xhci_hcd 0000:03:00.0: irq 77 for MSI/MSI-X
-  xhci_hcd 0000:03:00.0: irq 78 for MSI/MSI-X
-  xhci_hcd 0000:03:00.0: irq 79 for MSI/MSI-X
-  usb usb8: No SuperSpeed endpoint companion for config 1 interface 0 altsetting 0 ep 129: using minimum values
-  xHCI xhci_add_endpoint called for root hub
-  xHCI xhci_check_bandwidth called for root hub
-  hub 8-0:1.0: USB hub found
-  hub 8-0:1.0: 4 ports detected
-  Refined TSC clocksource calibration: 3210.781 MHz.
+  input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
+  r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xf800e000, 14:da:e9:03:e9:b7, XID 0c900880 IRQ 72
+  Refined TSC clocksource calibration: 3210.793 MHz.
   Switching to clocksource tsc
-  usbcore: registered new interface driver uas
-  ata6: SATA link down (SStatus 0 SControl 300)
-  ata4: SATA link down (SStatus 0 SControl 300)
-  ata3: SATA link down (SStatus 0 SControl 300)
-  ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
-  ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
-  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
-  ata5.00: ATA-7: HDS725050KLA360, K2AOAH0A, max UDMA/133
-  ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
-  ata5.00: configured for UDMA/133
-  ata1.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
-  ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
-  ata2.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
-  ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
-  ata1.00: configured for UDMA/133
-  scsi 0:0:0:0: Direct-Access ATA WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
-  sd 0:0:0:0: Attached scsi generic sg0 type 0
-  sd 0:0:0:0: [sda] 586072368 512-byte logical blocks: (300 GB/279 GiB)
-  sd 0:0:0:0: [sda] Write Protect is off
-  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
-  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-  ata2.00: configured for UDMA/133
-  scsi 1:0:0:0: Direct-Access ATA WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
-  sd 1:0:0:0: Attached scsi generic sg1 type 0
-  sd 1:0:0:0: [sdb] 586072368 512-byte logical blocks: (300 GB/279 GiB)
-  sd 1:0:0:0: [sdb] Write Protect is off
-  sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
-  sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-  scsi 4:0:0:0: Direct-Access ATA HDS725050KLA360 K2AO PQ: 0 ANSI: 5
-  sd 4:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
-  sd 4:0:0:0: Attached scsi generic sg2 type 0
-  sd 4:0:0:0: [sdc] Write Protect is off
-  sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
-  sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
-  sd 0:0:0:0: [sda] Attached SCSI disk
-  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
-  sd 1:0:0:0: [sdb] Attached SCSI disk
-  sdc: sdc1 sdc2 sdc4
-  sd 4:0:0:0: [sdc] Attached SCSI disk
+  vga16fb: initializing
+  vga16fb: mapped to 0xc00a0000
+  Console: switching to colour frame buffer device 80x30
+  fb0: VGA16 VGA frame buffer device
   Initializing USB Mass Storage driver...
-  scsi6 : usb-storage 3-2:1.0
   usbcore: registered new interface driver usb-storage
   USB Mass Storage support registered.
-  raid6: int32x1 1564 MB/s
-  md: bind<sdb3>
-  md: bind<sdb4>
-  md: bind<sdb5>
-  raid6: int32x2 1621 MB/s
-  md: bind<sdb6>
-  raid6: int32x4 1233 MB/s
-  raid6: int32x8 954 MB/s
-  raid6: mmxx1 2958 MB/s
-  raid6: mmxx2 5559 MB/s
-  raid6: sse1x1 2490 MB/s
-  raid6: sse1x2 3934 MB/s
-  raid6: sse2x1 4696 MB/s
-  raid6: sse2x2 7811 MB/s
-  raid6: using algorithm sse2x2 (7811 MB/s)
-  md: raid6 personality registered for level 6
-  md: raid5 personality registered for level 5
-  md: raid4 personality registered for level 4
-  md: raid10 personality registered for level 10
-  md: bind<sda6>
-  bio: create slab <bio-1> at 1
-  md/raid10:md124: active with 2 out of 2 devices
-  md124: detected capacity change from 0 to 233556410368
-  md124: unknown partition table
-  EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
-  md: bind<sda4>
-  md/raid10:md126: active with 2 out of 2 devices
-  md126: detected capacity change from 0 to 17453285376
-  md: bind<sda5>
-  md: md123 stopped.
-  md: unbind<sda5>
-  md: export_rdev(sda5)
-  md: array md127 already has disks!
-  scsi 6:0:0:0: Direct-Access WG Corner Office 8.02 PQ: 0 ANSI: 0 CCS
-  sd 6:0:0:0: Attached scsi generic sg3 type 0
-  sd 6:0:0:0: [sdd] 3907583 512-byte logical blocks: (2.00 GB/1.86 GiB)
-  sd 6:0:0:0: [sdd] Write Protect is off
-  sd 6:0:0:0: [sdd] Mode Sense: 45 00 00 08
-  sd 6:0:0:0: [sdd] Assuming drive cache: write through
-  sd 6:0:0:0: [sdd] Assuming drive cache: write through
-  sdd: sdd1
-  sd 6:0:0:0: [sdd] Assuming drive cache: write through
-  sd 6:0:0:0: [sdd] Attached SCSI removable disk
-  <30>udev[376]: starting version 167
-  <30>udev[392]: renamed network interface eth0 to eth2
-  md126: unknown partition table
-  Adding 4000180k swap on /dev/sdc4. Priority:-1 extents:1 across:4000180k
-  type=1400 audit(1315435938.465:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=523 comm="apparmor_parser"
-  type=1400 audit(1315435938.465:3): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=532 comm="apparmor_parser"
-  type=1400 audit(1315435938.465:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=523 comm="apparmor_parser"
-  type=1400 audit(1315435938.465:5): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=532 comm="apparmor_parser"
-  type=1400 audit(1315435938.465:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=523 comm="apparmor_parser"
-  type=1400 audit(1315435938.465:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=532 comm="apparmor_parser"
-  md: bind<sda5>
-  md/raid10:md125: active with 2 out of 2 devices
-  md125: detected capacity change from 0 to 34907881472
-  md125: unknown partition table
-  md: bind<sda3>
-  md/raid1:md127: active with 2 out of 2 mirrors
-  md127: detected capacity change from 0 to 1090453504
-  md127: unknown partition table
-  lp: driver loaded but no devices found
-  piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
-  SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
-  SP5100 TCO timer: mmio address 0xbafe00 already in use
-  input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input3
-  fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
-  Disabling lock debugging due to kernel taint
-  [fglrx] Maximum main memory to use for locked dma buffers: 3769 MBytes.
-  [fglrx] vendor: 1002 device: 6758 count: 1
-  [fglrx] ioport: bar 4, base 0xe000, size: 0x100
-  pci 0000:01:00.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
-  pci 0000:01:00.0: setting latency timer to 64
-  [fglrx] Kernel PAT support is enabled
-  [fglrx] module loaded - fglrx 8.84.60 [Mar 24 2011] with 1 minors
-  HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
-  hda-intel: Enable sync_write for AMD chipset
-  hda_codec: ALC887-VD: BIOS auto-probing.
-  input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
-  HDA Intel 0000:01:00.1: PCI INT B -> GSI 25 (level, low) -> IRQ 25
-  HDA Intel 0000:01:00.1: irq 80 for MSI/MSI-X
-  HDA Intel 0000:01:00.1: setting latency timer to 64
-  hda-intel: Enable sync_write for AMD chipset
-  EXT4-fs (sdc1): re-mounted. Opts: errors=remount-ro
-  input: ImExPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input5
-  EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: (null)
-  type=1400 audit(1315435941.709:8): apparmor="STATUS" operation="profile_load" name="/usr/share/gdm/guest-session/Xsession" pid=1005 comm="apparmor_parser"
-  type=1400 audit(1315435941.709:9): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=1010 comm="apparmor_parser"
-  type=1400 audit(1315435941.709:10): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=1010 comm="apparmor_parser"
-  type=1400 audit(1315435941.709:11): apparmor="STATUS" operation="profile_load" name="/usr/bin/freshclam" pid=1009 comm="apparmor_parser"
-  r8169 0000:02:00.0: eth2: link down
-  r8169 0000:02:00.0: eth2: link down
-  ADDRCONF(NETDEV_UP): eth2: link is not ready
-  ppdev: user-space parallel port driver
-  fglrx_pci 0000:01:00.0: irq 81 for MSI/MSI-X
-  [fglrx] Firegl kernel thread PID: 1375
-  [fglrx] Firegl kernel thread PID: 1376
-  [fglrx] Firegl kernel thread PID: 1377
-  [fglrx] IRQ 81 Enabled
-  [fglrx] Gart USWC size:1280 M.
-  [fglrx] Gart cacheable size:508 M.
-  [fglrx] Reserved FB block: Shared offset:0, size:1000000
-  [fglrx] Reserved FB block: Unshared offset:f8fd000, size:403000
-  [fglrx] Reserved FB block: Unshared offset:3fff4000, size:c000
-  EXT4-fs (sdc1): re-mounted. Opts: errors=remount-ro,commit=0
-  EXT4-fs (sdc2): re-mounted. Opts: commit=0
-  r8169 0000:02:00.0: eth2: link up
-  ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
-  hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
-  EXT4-fs (sdc1): re-mounted. Opts: errors=remount-ro,commit=0
-  EXT4-fs (sdc2): re-mounted. Opts: commit=0
-  eth2: no IPv6 routers present
-  usb 3-2: USB disconnect, address 2
-  usb 4-1: new full speed USB device using ohci_hcd and address 2
-  input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-1/4-1:1.0/input/input6
-  generic-usb 0003:1532:0101.0001: input,hidraw0: USB HID v10.01 Mouse [Razer Razer Copperhead Laser Mouse] on usb-0000:00:12.0-1/input0
-  input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-1/4-1:1.1/input/input7
-  generic-usb 0003:1532:0101.0002: input,hidraw1: USB HID v10.01 Keyboard [Razer Razer Copperhead Laser Mouse] on usb-0000:00:12.0-1/input1
-  usbcore: registered new interface driver usbhid
-  usbhid: USB HID core driver
- 
- 
- 
+  Intel ISA PCIC probe: not found.
+  r8169 0000:02:00.0: eth0: link down
+  r8169 0000:02:00.0: eth0: link down
+  ADDRCONF(NETDEV_UP): eth0: link is not ready
+  r8169 0000:02:00.0: eth0: link down
+  ADDRCONF(NETDEV_UP): eth0: link is not ready
+  r8169 0000:02:00.0: eth0: link up
+  ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
+  usb 3-2: new high speed USB device using ehci_hcd and address 2
+  scsi0 : usb-storage 3-2:1.0
+  scsi 0:0:0:0: Direct-Access Ut163 USB2FlashStorage 0.00 PQ: 0 ANSI: 2
+  sd 0:0:0:0: Attached scsi generic sg0 type 0
+  sd 0:0:0:0: [sda] 983808 512-byte logical blocks: (503 MB/480 MiB)
+  sd 0:0:0:0: [sda] Write Protect is off
+  sd 0:0:0:0: [sda] Mode Sense: 00 00 00 00
+  sd 0:0:0:0: [sda] Asking for cache data failed
+  sd 0:0:0:0: [sda] Assuming drive cache: write through
+  sd 0:0:0:0: [sda] Asking for cache data failed
+  sd 0:0:0:0: [sda] Assuming drive cache: write through
+  sda: sda1
+  sd 0:0:0:0: [sda] Asking for cache data failed
+  sd 0:0:0:0: [sda] Assuming drive cache: write through
+  sd 0:0:0:0: [sda] Attached SCSI removable disk

--------------020307020002030705040600--
