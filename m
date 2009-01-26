From: Norbert Preining <preining@logic.at>
Subject: suspend to ram regression from 2.6.28 to 2.6.29-rc2
Date: Mon, 26 Jan 2009 23:15:54 +0100
Message-ID: <20090126221554.GA15492@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:57982 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbZAZWP4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jan 2009 17:15:56 -0500
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1LRZkI-0000Jm-7y
	for linux-acpi@vger.kernel.org; Mon, 26 Jan 2009 23:15:54 +0100
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1LRZkI-0005EG-67
	for linux-acpi@vger.kernel.org; Mon, 26 Jan 2009 23:15:54 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear all,

while switching from 2.6.28(-rc*) to 2.6.29-rc2 S2R is completely hosed
now.

With 2.6.28 I can suspend directly from X and that several times without
problems.

With 2.6.29-rc2 the following symptoms occur:
- when suspending from X screen is shut down, but the computer is still
  running, and it does not react to sysrq
- when suspending from a minimal boot with all modules unloaded it
  suspends fine (the power lamp on my laptop flashes slowly red, that is
  usual and fine), but waking up hangs the computer

It might be related that with 2.6.29-rc2 the intel drm is not activated
due to a buggy KConfig problem that seems still unfixed. But I don't
know if that is important.

Attached is a dmesg output of starting 2.6.29-rc2. 

What else can I provide?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HOYLAKE (n.)
The pool of edible gravy which surrounds an inedible and disgusting
lump of meat - eaten to give the impression that the person is 'just
not very hungry, but mmm this is delicious'. Cf. Peaslake - a similar
experience had by vegetarians.
			--- Douglas Adams, The Meaning of Liff

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: 8bit

[    0.000000] Linux version 2.6.29-rc2 (root@mithrandir) (gcc version 4.3.3 20090119 (prerelease) (Debian 4.3.2-4) ) #3 SMP PREEMPT Sat Jan 24 16:52:05 CET 2009
[    0.000000] Command line: root=UUID=b64e1ef8-3758-499d-9c5a-385592cf75b5 ro 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000ba20e000 (usable)
[    0.000000]  BIOS-e820: 00000000ba20e000 - 00000000ba211000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ba211000 - 00000000bbb6b000 (usable)
[    0.000000]  BIOS-e820: 00000000bbb6b000 - 00000000bbbbf000 (reserved)
[    0.000000]  BIOS-e820: 00000000bbbbf000 - 00000000bbc73000 (usable)
[    0.000000]  BIOS-e820: 00000000bbc73000 - 00000000bbcbf000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bbcbf000 - 00000000bbce9000 (usable)
[    0.000000]  BIOS-e820: 00000000bbce9000 - 00000000bbcff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bbcff000 - 00000000bbd00000 (usable)
[    0.000000]  BIOS-e820: 00000000bbd00000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
[    0.000000] DMI 2.4 present.
[    0.000000] last_pfn = 0x140000 max_arch_pfn = 0x100000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xbbd00 max_arch_pfn = 0x100000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000bbd00000
[    0.000000]  0000000000 - 00bbc00000 page 2M
[    0.000000]  00bbc00000 - 00bbd00000 page 4k
[    0.000000] kernel direct mapping tables up to bbd00000 @ 8000-d000
[    0.000000] last_map_addr: bbd00000 end: bbd00000
[    0.000000] init_memory_mapping: 0000000100000000-0000000140000000
[    0.000000]  0100000000 - 0140000000 page 2M
[    0.000000] kernel direct mapping tables up to 140000000 @ b000-11000
[    0.000000] last_map_addr: 140000000 end: 140000000
[    0.000000] RAMDISK: 37cab000 - 37fefd0e
[    0.000000] ACPI: RSDP 000FE020, 0024 (r2   Sony)
[    0.000000] ACPI: XSDT BBCFE120, 006C (r1   Sony     VAIO 20080826       1000013)
[    0.000000] ACPI: FACP BBCFD000, 00F4 (r4   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
[    0.000000] ACPI: DSDT BBCEC000, B00F (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: FACS BBC92000, 0040
[    0.000000] ACPI: HPET BBCFC000, 0038 (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: APIC BBCFB000, 006C (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: MCFG BBCFA000, 003C (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: SLIC BBCF9000, 0176 (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: ASF! BBCF8000, 00A5 (r32   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: BOOT BBCEB000, 0028 (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: DBGP BBCEA000, 0034 (r1   Sony     VAIO 20080826 MSFT  1000013)
[    0.000000] ACPI: SSDT BBCE9000, 0655 (r1   Sony     VAIO 20080826 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 0140000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 0000723c6c]    TEXT DATA BSS ==> [0000200000 - 0000723c6c]
[    0.000000]   #3 [0037cab000 - 0037fefd0e]          RAMDISK ==> [0037cab000 - 0037fefd0e]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #5 [0000008000 - 000000b000]          PGTABLE ==> [0000008000 - 000000b000]
[    0.000000]   #6 [000000b000 - 000000c000]          PGTABLE ==> [000000b000 - 000000c000]
[    0.000000]  [ffffe20000000000-ffffe200045fffff] PMD -> [ffff880028200000-ffff88002c7fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00140000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000ba20e
[    0.000000]     0: 0x000ba211 -> 0x000bbb6b
[    0.000000]     0: 0x000bbbbf -> 0x000bbc73
[    0.000000]     0: 0x000bbcbf -> 0x000bbce9
[    0.000000]     0: 0x000bbcff -> 0x000bbd00
[    0.000000]     0: 0x00100000 -> 0x00140000
[    0.000000] On node 0 totalpages: 1031142
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1418 pages reserved
[    0.000000]   DMA zone: 2525 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 750719 pages, LIFO batch:31
[    0.000000]   Normal zone: 3584 pages used for memmap
[    0.000000]   Normal zone: 258560 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] 4 Processors exceeds NR_CPUS limit of 2
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000ba20e000 - 00000000ba211000
[    0.000000] PM: Registered nosave memory: 00000000bbb6b000 - 00000000bbbbf000
[    0.000000] PM: Registered nosave memory: 00000000bbc73000 - 00000000bbcbf000
[    0.000000] PM: Registered nosave memory: 00000000bbce9000 - 00000000bbcff000
[    0.000000] PM: Registered nosave memory: 00000000bbd00000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed14000
[    0.000000] PM: Registered nosave memory: 00000000fed14000 - 00000000fed18000
[    0.000000] PM: Registered nosave memory: 00000000fed18000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffe80000
[    0.000000] PM: Registered nosave memory: 00000000ffe80000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c4000000 (gap: c0000000:38000000)
[    0.000000] NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Allocating 45056 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1011804
[    0.000000] Kernel command line: root=UUID=b64e1ef8-3758-499d-9c5a-385592cf75b5 ro 
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2526.928 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.004000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.004000] Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
[    0.004000] software IO TLB at phys 0x20000000 - 0x24000000
[    0.004000] Memory: 3970976k/5242880k available (2922k kernel code, 1118312k absent, 152712k reserved, 1438k data, 336k init)
[    0.004000] hpet clockevent registered
[    0.004000] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5053.85 BogoMIPS (lpj=10107712)
[    0.004000] Mount-cache hash table entries: 256
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] [ds] using core 2 configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.004000] CPU0: Thermal monitoring handled by SMI
[    0.004000] using mwait in idle threads.
[    0.004000] ACPI: Core revision 20081204
[    0.036088] Setting APIC routing to flat
[    0.040275] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.080041] CPU0: Intel(R) Core(TM)2 Duo CPU     P9500  @ 2.53GHz stepping 06
[    0.084001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 5054.08 BogoMIPS (lpj=10108170)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] [ds] using core 2 configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] CPU1: Thermal monitoring enabled (TM2)
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.175870] CPU1: Intel(R) Core(TM)2 Duo CPU     P9500  @ 2.53GHz stepping 06
[    0.176159] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.180044] Brought up 2 CPUs
[    0.180111] Total of 2 processors activated (10107.94 BogoMIPS).
[    0.180288] PM: Adding info for No Bus:platform
[    0.180288] net_namespace: 1376 bytes
[    0.180437] NET: Registered protocol family 16
[    0.180437] PM: Adding info for No Bus:vtcon0
[    0.180437] ACPI: bus type pci registered
[    0.180437] PM: Adding info for No Bus:id
[    0.180437] PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
[    0.180437] PCI: MCFG area at f8000000 reserved in E820
[    0.192508] PCI: Using MMCONFIG at f8000000 - fbffffff
[    0.192576] PCI: Using configuration type 1 for base access
[    0.200068] PM: Adding info for No Bus:default
[    0.200083] bio: create slab <bio-0> at 0
[    0.206486] ACPI: EC: Look up EC in DSDT
[    0.218544] ACPI: BIOS _OSI(Linux) query ignored
[    0.246087] ACPI: Interpreter enabled
[    0.246161] ACPI: (supports S0 S3 S4 S5)
[    0.246473] ACPI: Using IOAPIC for interrupt routing
[    0.246743] PM: Adding info for acpi:LNXSYSTM:00
[    0.246743] PM: Adding info for acpi:ACPI_CPU:00
[    0.246743] PM: Adding info for acpi:ACPI_CPU:01
[    0.246743] PM: Adding info for acpi:ACPI_CPU:02
[    0.246743] PM: Adding info for acpi:ACPI_CPU:03
[    0.246743] PM: Adding info for acpi:device:00
[    0.246743] PM: Adding info for acpi:PNP0C0C:00
[    0.246743] PM: Adding info for acpi:PNP0C0D:00
[    0.249685] PM: Adding info for acpi:PNP0C0A:00
[    0.249710] PM: Adding info for acpi:ACPI0003:00
[    0.249710] PM: Adding info for acpi:PNP0A08:00
[    0.249710] PM: Adding info for acpi:device:01
[    0.249710] PM: Adding info for acpi:device:02
[    0.249710] PM: Adding info for acpi:device:03
[    0.249710] PM: Adding info for acpi:device:04
[    0.252220] PM: Adding info for acpi:device:05
[    0.252465] PM: Adding info for acpi:device:06
[    0.252786] PM: Adding info for acpi:device:07
[    0.252024] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.253278] PM: Adding info for acpi:device:08
[    0.253278] PM: Adding info for acpi:device:09
[    0.253278] PM: Adding info for acpi:device:0a
[    0.253278] PM: Adding info for acpi:device:0b
[    0.253278] PM: Adding info for acpi:device:0c
[    0.253434] PM: Adding info for acpi:device:0d
[    0.253751] PM: Adding info for acpi:device:0e
[    0.253830] PM: Adding info for acpi:device:0f
[    0.254224] PM: Adding info for acpi:PNP0C0F:00
[    0.256186] PM: Adding info for acpi:PNP0C0F:01
[    0.256390] PM: Adding info for acpi:PNP0C0F:02
[    0.256428] PM: Adding info for acpi:PNP0C0F:03
[    0.256431] PM: Adding info for acpi:PNP0C0F:04
[    0.256432] PM: Adding info for acpi:PNP0C0F:05
[    0.256432] PM: Adding info for acpi:PNP0C0F:06
[    0.256432] PM: Adding info for acpi:PNP0C0F:07
[    0.256432] PM: Adding info for acpi:PNP0C02:00
[    0.256432] PM: Adding info for acpi:PNP0200:00
[    0.256432] PM: Adding info for acpi:PNP0B00:00
[    0.260465] PM: Adding info for acpi:PNP0103:00
[    0.260504] PM: Adding info for acpi:PNP0000:00
[    0.260504] PM: Adding info for acpi:PNP0C04:00
[    0.260504] PM: Adding info for acpi:PNP0100:00
[    0.260504] PM: Adding info for acpi:INT0800:00
[    0.260504] PM: Adding info for acpi:PNP0303:00
[    0.260504] PM: Adding info for acpi:SNY9001:00
[    0.260504] PM: Adding info for acpi:PNP0C09:00
[    0.260504] PM: Adding info for acpi:SNY6001:00
[    0.260519] PM: Adding info for acpi:IFX0102:00
[    0.260558] PM: Adding info for acpi:SNY5001:00
[    0.260563] PM: Adding info for acpi:device:10
[    0.261091] PM: Adding info for acpi:device:11
[    0.261610] PM: Adding info for acpi:device:12
[    0.264409] PM: Adding info for acpi:device:13
[    0.264749] PM: Adding info for acpi:device:14
[    0.265264] PM: Adding info for acpi:device:15
[    0.265780] PM: Adding info for acpi:device:16
[    0.266295] PM: Adding info for acpi:device:17
[    0.266632] PM: Adding info for acpi:device:18
[    0.266733] PM: Adding info for acpi:device:19
[    0.266831] PM: Adding info for acpi:device:1a
[    0.266930] PM: Adding info for acpi:device:1b
[    0.267026] PM: Adding info for acpi:device:1c
[    0.267122] PM: Adding info for acpi:device:1d
[    0.267217] PM: Adding info for acpi:device:1e
[    0.267313] PM: Adding info for acpi:device:1f
[    0.267407] PM: Adding info for acpi:device:20
[    0.267505] PM: Adding info for acpi:device:21
[    0.267606] PM: Adding info for acpi:device:22
[    0.267705] PM: Adding info for acpi:device:23
[    0.267804] PM: Adding info for acpi:device:24
[    0.267915] PM: Adding info for acpi:device:25
[    0.268028] PM: Adding info for acpi:device:26
[    0.268128] PM: Adding info for acpi:device:27
[    0.268227] PM: Adding info for acpi:device:28
[    0.268328] PM: Adding info for acpi:device:29
[    0.268427] PM: Adding info for acpi:device:2a
[    0.268525] PM: Adding info for acpi:device:2b
[    0.268603] PM: Adding info for acpi:device:2c
[    0.268694] PM: Adding info for acpi:device:2d
[    0.268764] PM: Adding info for acpi:device:2e
[    0.268837] PM: Adding info for acpi:device:2f
[    0.268912] PM: Adding info for acpi:device:30
[    0.268984] PM: Adding info for acpi:device:31
[    0.269057] PM: Adding info for acpi:device:32
[    0.269131] PM: Adding info for acpi:device:33
[    0.269203] PM: Adding info for acpi:device:34
[    0.269277] PM: Adding info for acpi:device:35
[    0.269350] PM: Adding info for acpi:device:36
[    0.269431] PM: Adding info for acpi:device:37
[    0.269513] PM: Adding info for acpi:device:38
[    0.269586] PM: Adding info for acpi:device:39
[    0.269658] PM: Adding info for acpi:device:3a
[    0.269733] PM: Adding info for acpi:device:3b
[    0.269804] PM: Adding info for acpi:device:3c
[    0.269879] PM: Adding info for acpi:device:3d
[    0.269961] PM: Adding info for acpi:device:3e
[    0.270062] PM: Adding info for acpi:pnp0c14:00
[    0.270102] PM: Adding info for acpi:LNXPOWER:00
[    0.270102] PM: Adding info for acpi:LNXPOWER:01
[    0.270102] PM: Adding info for acpi:LNXTHERM:00
[    0.270102] PM: Adding info for acpi:LNXTHERM:01
[    0.270102] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.270102] ACPI: EC: driver started in interrupt mode
[    0.272053] PM: Adding info for platform:dock.0
[    0.273954] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    0.274374] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.274468] PM: Adding info for No Bus:pci0000:00
[    0.274490] PM: Adding info for No Bus:0000:00
[    0.274532] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.274532] pci 0000:00:01.0: PME# disabled
[    0.274532] pci 0000:00:02.0: reg 10 64bit mmio: [0xe8400000-0xe87fffff]
[    0.274532] pci 0000:00:02.0: reg 18 64bit mmio: [0xd0000000-0xdfffffff]
[    0.274532] pci 0000:00:02.0: reg 20 io port: [0x8130-0x8137]
[    0.274532] pci 0000:00:19.0: reg 10 32bit mmio: [0xee900000-0xee91ffff]
[    0.274532] pci 0000:00:19.0: reg 14 32bit mmio: [0xee924000-0xee924fff]
[    0.274532] pci 0000:00:19.0: reg 18 io port: [0x8100-0x811f]
[    0.274532] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.274532] pci 0000:00:19.0: PME# disabled
[    0.274532] pci 0000:00:1a.0: reg 20 io port: [0x80e0-0x80ff]
[    0.274532] pci 0000:00:1a.1: reg 20 io port: [0x80c0-0x80df]
[    0.274532] pci 0000:00:1a.2: reg 20 io port: [0x80a0-0x80bf]
[    0.274532] pci 0000:00:1a.7: reg 10 32bit mmio: [0xee925c00-0xee925fff]
[    0.274532] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.276016] pci 0000:00:1a.7: PME# disabled
[    0.276150] pci 0000:00:1b.0: reg 10 64bit mmio: [0xee920000-0xee923fff]
[    0.276228] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.276300] pci 0000:00:1b.0: PME# disabled
[    0.276467] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.276539] pci 0000:00:1c.0: PME# disabled
[    0.276707] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.276780] pci 0000:00:1c.1: PME# disabled
[    0.276950] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.277022] pci 0000:00:1c.3: PME# disabled
[    0.277194] pci 0000:00:1d.0: reg 20 io port: [0x8080-0x809f]
[    0.277339] pci 0000:00:1d.1: reg 20 io port: [0x8060-0x807f]
[    0.277484] pci 0000:00:1d.2: reg 20 io port: [0x8040-0x805f]
[    0.277620] pci 0000:00:1d.7: reg 10 32bit mmio: [0xee925800-0xee925bff]
[    0.277714] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.277786] pci 0000:00:1d.7: PME# disabled
[    0.278148] pci 0000:00:1f.2: reg 10 io port: [0x8128-0x812f]
[    0.278160] pci 0000:00:1f.2: reg 14 io port: [0x813c-0x813f]
[    0.278171] pci 0000:00:1f.2: reg 18 io port: [0x8120-0x8127]
[    0.278183] pci 0000:00:1f.2: reg 1c io port: [0x8138-0x813b]
[    0.278194] pci 0000:00:1f.2: reg 20 io port: [0x8020-0x803f]
[    0.278206] pci 0000:00:1f.2: reg 24 32bit mmio: [0xee925000-0xee9257ff]
[    0.278265] pci 0000:00:1f.2: PME# supported from D3hot
[    0.278335] pci 0000:00:1f.2: PME# disabled
[    0.278449] pci 0000:00:1f.3: reg 10 64bit mmio: [0xee926000-0xee9260ff]
[    0.278475] pci 0000:00:1f.3: reg 20 io port: [0x8000-0x801f]
[    0.278735] pci 0000:01:00.0: reg 10 32bit mmio: [0xe4000000-0xe4ffffff]
[    0.278808] pci 0000:01:00.0: reg 14 64bit mmio: [0xc0000000-0xcfffffff]
[    0.278881] pci 0000:01:00.0: reg 1c 64bit mmio: [0xe2000000-0xe3ffffff]
[    0.278920] pci 0000:01:00.0: reg 24 io port: [0x7000-0x707f]
[    0.278958] pci 0000:01:00.0: reg 30 32bit mmio: [0xfffe0000-0xffffffff]
[    0.279284] pci 0000:00:01.0: bridge io port: [0x7000-0x7fff]
[    0.279291] pci 0000:00:01.0: bridge 32bit mmio: [0xe2000000-0xe4ffffff]
[    0.279301] pci 0000:00:01.0: bridge 64bit mmio pref: [0xc0000000-0xcfffffff]
[    0.279374] pci 0000:00:1c.0: bridge io port: [0x6000-0x6fff]
[    0.279382] pci 0000:00:1c.0: bridge 32bit mmio: [0xed900000-0xee8fffff]
[    0.279393] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xe8800000-0xe97fffff]
[    0.279702] pci 0000:06:00.0: reg 10 64bit mmio: [0xec800000-0xec801fff]
[    0.280108] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.280209] pci 0000:06:00.0: PME# disabled
[    0.280440] pci 0000:00:1c.1: bridge io port: [0x5000-0x5fff]
[    0.280448] pci 0000:00:1c.1: bridge 32bit mmio: [0xec800000-0xed8fffff]
[    0.280460] pci 0000:00:1c.1: bridge 64bit mmio pref: [0xe9800000-0xea7fffff]
[    0.280534] pci 0000:00:1c.3: bridge io port: [0x4000-0x4fff]
[    0.280543] pci 0000:00:1c.3: bridge 32bit mmio: [0xeb800000-0xec7fffff]
[    0.280554] pci 0000:00:1c.3: bridge 64bit mmio pref: [0xea800000-0xeb7fffff]
[    0.280624] pci 0000:0b:04.0: reg 10 32bit mmio: [0xe8000000-0xe8000fff]
[    0.280659] pci 0000:0b:04.0: supports D1 D2
[    0.280663] pci 0000:0b:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.280737] pci 0000:0b:04.0: PME# disabled
[    0.280859] pci 0000:0b:04.1: reg 10 32bit mmio: [0xe8001000-0xe80017ff]
[    0.280944] pci 0000:0b:04.1: PME# supported from D0 D3hot D3cold
[    0.281017] pci 0000:0b:04.1: PME# disabled
[    0.281137] pci 0000:0b:04.2: reg 10 32bit mmio: [0xe8001900-0xe80019ff]
[    0.281221] pci 0000:0b:04.2: supports D1 D2
[    0.281225] pci 0000:0b:04.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.281299] pci 0000:0b:04.2: PME# disabled
[    0.281422] pci 0000:0b:04.4: reg 10 32bit mmio: [0xe8001800-0xe80018ff]
[    0.281507] pci 0000:0b:04.4: supports D1 D2
[    0.281511] pci 0000:0b:04.4: PME# supported from D0 D1 D2 D3hot D3cold
[    0.281584] pci 0000:0b:04.4: PME# disabled
[    0.281724] pci 0000:00:1e.0: transparent bridge
[    0.281795] pci 0000:00:1e.0: bridge io port: [0x3000-0x3fff]
[    0.281803] pci 0000:00:1e.0: bridge 32bit mmio: [0xe6000000-0xe80fffff]
[    0.281814] pci 0000:00:1e.0: bridge 64bit mmio pref: [0xe0000000-0xe1ffffff]
[    0.281883] pci_bus 0000:00: on NUMA node 0
[    0.281910] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.282534] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[    0.282761] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.283128] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.283408] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.283638] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
[    0.287044] PM: Adding info for pci:0000:00:00.0
[    0.289970] PM: Adding info for pci:0000:00:01.0
[    0.292885] PM: Adding info for pci:0000:00:02.0
[    0.294843] PM: Adding info for pci:0000:00:19.0
[    0.298705] PM: Adding info for pci:0000:00:1a.0
[    0.301622] PM: Adding info for pci:0000:00:1a.1
[    0.304532] PM: Adding info for pci:0000:00:1a.2
[    0.306839] PM: Adding info for pci:0000:00:1a.7
[    0.310335] PM: Adding info for pci:0000:00:1b.0
[    0.313247] PM: Adding info for pci:0000:00:1c.0
[    0.316155] PM: Adding info for pci:0000:00:1c.1
[    0.318843] PM: Adding info for pci:0000:00:1c.3
[    0.321963] PM: Adding info for pci:0000:00:1d.0
[    0.324871] PM: Adding info for pci:0000:00:1d.1
[    0.326843] PM: Adding info for pci:0000:00:1d.2
[    0.330687] PM: Adding info for pci:0000:00:1d.7
[    0.333599] PM: Adding info for pci:0000:00:1e.0
[    0.336512] PM: Adding info for pci:0000:00:1f.0
[    0.338843] PM: Adding info for pci:0000:00:1f.2
[    0.342329] PM: Adding info for pci:0000:00:1f.3
[    0.342372] PM: Adding info for pci:0000:01:00.0
[    0.344030] PM: Adding info for No Bus:0000:01
[    0.344055] PM: Adding info for No Bus:0000:02
[    0.344101] PM: Adding info for pci:0000:06:00.0
[    0.344130] PM: Adding info for No Bus:0000:06
[    0.344130] PM: Adding info for No Bus:0000:08
[    0.344225] PM: Adding info for pci:0000:0b:04.0
[    0.344255] PM: Adding info for pci:0000:0b:04.1
[    0.344255] PM: Adding info for pci:0000:0b:04.2
[    0.344255] PM: Adding info for pci:0000:0b:04.4
[    0.344255] PM: Adding info for No Bus:0000:0c
[    0.344255] PM: Adding info for No Bus:0000:0b
[    0.344282] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12)
[    0.345213] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
[    0.346141] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12)
[    0.348883] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
[    0.349806] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12)
[    0.350729] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.351650] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 *10 11 12)
[    0.352545] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
[    0.353269] ACPI: Power Resource [DGPR] (on)
[    0.353269] ACPI: Power Resource [MGPR] (on)
[    0.353269] SCSI subsystem initialized
[    0.353269] libata version 3.00 loaded.
[    0.353269] usbcore: registered new interface driver usbfs
[    0.353269] usbcore: registered new interface driver hub
[    0.353269] usbcore: registered new device driver usb
[    0.356101] ACPI: WMI: Mapper loaded
[    0.356101] PCI: Using ACPI for IRQ routing
[    0.356423] PM: Adding info for No Bus:lo
[    0.376016] Bluetooth: Core ver 2.14
[    0.376102] NET: Registered protocol family 31
[    0.376102] Bluetooth: HCI device and connection manager initialized
[    0.376172] Bluetooth: HCI socket layer initialized
[    0.376289] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.376591] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.400016] pnp: PnP ACPI init
[    0.400093] PM: Adding info for No Bus:pnp0
[    0.400097] ACPI: bus type pnp registered
[    0.403634] PM: Adding info for pnp:00:00
[    0.406455] PM: Adding info for pnp:00:01
[    0.406608] PM: Adding info for pnp:00:02
[    0.406874] PM: Adding info for pnp:00:03
[    0.407464] PM: Adding info for pnp:00:04
[    0.407625] PM: Adding info for pnp:00:05
[    0.407770] PM: Adding info for pnp:00:06
[    0.408053] PM: Adding info for pnp:00:07
[    0.408332] PM: Adding info for pnp:00:08
[    0.408683] PM: Adding info for pnp:00:09
[    0.408977] PM: Adding info for pnp:00:0a
[    0.409253] pnp: PnP ACPI: found 11 devices
[    0.409320] ACPI: ACPI bus type pnp unregistered
[    0.409402] system 00:01: ioport range 0x164e-0x164f has been reserved
[    0.409474] system 00:01: ioport range 0x600-0x60f has been reserved
[    0.409544] system 00:01: ioport range 0x610-0x610 has been reserved
[    0.409615] system 00:01: ioport range 0x800-0x80f has been reserved
[    0.409685] system 00:01: ioport range 0x810-0x817 has been reserved
[    0.409756] system 00:01: ioport range 0x820-0x823 has been reserved
[    0.409827] system 00:01: ioport range 0x400-0x47f has been reserved
[    0.409897] system 00:01: ioport range 0x500-0x53f has been reserved
[    0.409967] system 00:01: ioport range 0x2000-0x2000 has been reserved
[    0.410038] system 00:01: ioport range 0x2004-0x2004 has been reserved
[    0.410110] system 00:01: iomem range 0xf8000000-0xfbffffff has been reserved
[    0.410182] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.410254] system 00:01: iomem range 0xfed10000-0xfed13fff has been reserved
[    0.410328] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.410403] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.410475] system 00:01: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.410547] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.410619] system 00:01: iomem range 0xfed45000-0xfed8ffff has been reserved
[    0.410692] system 00:01: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.410917] PM: Adding info for No Bus:mem
[    0.410991] PM: Adding info for No Bus:null
[    0.411065] PM: Adding info for No Bus:port
[    0.411139] PM: Adding info for No Bus:zero
[    0.411212] PM: Adding info for No Bus:full
[    0.411284] PM: Adding info for No Bus:random
[    0.411360] PM: Adding info for No Bus:urandom
[    0.411436] PM: Adding info for No Bus:kmsg
[    0.416125] pci 0000:01:00.0: BAR 6: can't allocate mem resource [0xd0000000-0xcfffffff]
[    0.416210] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.416280] pci 0000:00:01.0:   IO window: 0x7000-0x7fff
[    0.416352] pci 0000:00:01.0:   MEM window: 0xe2000000-0xe4ffffff
[    0.416423] pci 0000:00:01.0:   PREFETCH window: 0x000000c0000000-0x000000cfffffff
[    0.416510] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.416581] pci 0000:00:1c.0:   IO window: 0x6000-0x6fff
[    0.416654] pci 0000:00:1c.0:   MEM window: 0xed900000-0xee8fffff
[    0.416726] pci 0000:00:1c.0:   PREFETCH window: 0x000000e8800000-0x000000e97fffff
[    0.416816] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:06
[    0.416886] pci 0000:00:1c.1:   IO window: 0x5000-0x5fff
[    0.416958] pci 0000:00:1c.1:   MEM window: 0xec800000-0xed8fffff
[    0.417031] pci 0000:00:1c.1:   PREFETCH window: 0x000000e9800000-0x000000ea7fffff
[    0.417119] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:08
[    0.417189] pci 0000:00:1c.3:   IO window: 0x4000-0x4fff
[    0.417262] pci 0000:00:1c.3:   MEM window: 0xeb800000-0xec7fffff
[    0.417335] pci 0000:00:1c.3:   PREFETCH window: 0x000000ea800000-0x000000eb7fffff
[    0.417432] pci 0000:0b:04.0: CardBus bridge, secondary bus 0000:0c
[    0.417502] pci 0000:0b:04.0:   IO window: 0x003000-0x0030ff
[    0.417574] pci 0000:0b:04.0:   IO window: 0x003400-0x0034ff
[    0.417647] pci 0000:0b:04.0:   PREFETCH window: 0xf0000000-0xf3ffffff
[    0.417721] pci 0000:0b:04.0:   MEM window: 0xf4000000-0xf7ffffff
[    0.417794] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:0b
[    0.417864] pci 0000:00:1e.0:   IO window: 0x3000-0x3fff
[    0.417937] pci 0000:00:1e.0:   MEM window: 0xe6000000-0xe80fffff
[    0.418010] pci 0000:00:1e.0:   PREFETCH window: 0x000000e0000000-0x000000e1ffffff
[    0.418113] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.418186] pci 0000:00:01.0: setting latency timer to 64
[    0.418198] pci 0000:00:1c.0: enabling device (0000 -> 0003)
[    0.418269] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.418344] pci 0000:00:1c.0: setting latency timer to 64
[    0.418360] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.418433] pci 0000:00:1c.1: setting latency timer to 64
[    0.418445] pci 0000:00:1c.3: enabling device (0000 -> 0003)
[    0.418518] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.418593] pci 0000:00:1c.3: setting latency timer to 64
[    0.418605] pci 0000:00:1e.0: setting latency timer to 64
[    0.418622] pci 0000:0b:04.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.418695] pci 0000:0b:04.0: setting latency timer to 64
[    0.418703] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.418709] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.418714] pci_bus 0000:01: resource 0 io:  [0x7000-0x7fff]
[    0.418719] pci_bus 0000:01: resource 1 mem: [0xe2000000-0xe4ffffff]
[    0.418724] pci_bus 0000:01: resource 2 mem: [0xc0000000-0xcfffffff]
[    0.418728] pci_bus 0000:01: resource 3 mem: [0x0-0x0]
[    0.418733] pci_bus 0000:02: resource 0 io:  [0x6000-0x6fff]
[    0.418738] pci_bus 0000:02: resource 1 mem: [0xed900000-0xee8fffff]
[    0.418743] pci_bus 0000:02: resource 2 mem: [0xe8800000-0xe97fffff]
[    0.418748] pci_bus 0000:02: resource 3 mem: [0x0-0x0]
[    0.418752] pci_bus 0000:06: resource 0 io:  [0x5000-0x5fff]
[    0.418757] pci_bus 0000:06: resource 1 mem: [0xec800000-0xed8fffff]
[    0.418762] pci_bus 0000:06: resource 2 mem: [0xe9800000-0xea7fffff]
[    0.418766] pci_bus 0000:06: resource 3 mem: [0x0-0x0]
[    0.418771] pci_bus 0000:08: resource 0 io:  [0x4000-0x4fff]
[    0.418776] pci_bus 0000:08: resource 1 mem: [0xeb800000-0xec7fffff]
[    0.418781] pci_bus 0000:08: resource 2 mem: [0xea800000-0xeb7fffff]
[    0.418785] pci_bus 0000:08: resource 3 mem: [0x0-0x0]
[    0.418790] pci_bus 0000:0b: resource 0 io:  [0x3000-0x3fff]
[    0.418795] pci_bus 0000:0b: resource 1 mem: [0xe6000000-0xe80fffff]
[    0.418799] pci_bus 0000:0b: resource 2 mem: [0xe0000000-0xe1ffffff]
[    0.418804] pci_bus 0000:0b: resource 3 io:  [0x00-0xffff]
[    0.418809] pci_bus 0000:0b: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.418814] pci_bus 0000:0c: resource 0 io:  [0x3000-0x30ff]
[    0.418818] pci_bus 0000:0c: resource 1 io:  [0x3400-0x34ff]
[    0.418823] pci_bus 0000:0c: resource 2 mem: [0xf0000000-0xf3ffffff]
[    0.418828] pci_bus 0000:0c: resource 3 mem: [0xf4000000-0xf7ffffff]
[    0.418924] NET: Registered protocol family 2
[    0.460132] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.461111] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.463414] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.464176] TCP: Hash tables configured (established 262144 bind 65536)
[    0.464247] TCP reno registered
[    0.476161] NET: Registered protocol family 1
[    0.476440] checking if image is initramfs...<7>Switched to high resolution mode on CPU 1
[    0.504008] Switched to high resolution mode on CPU 0
[    0.767765]  it is
[    1.068502] Freeing initrd memory: 3347k freed
[    1.070164] Simple Boot Flag value 0x5 read from CMOS RAM was invalid
[    1.070235] Simple Boot Flag at 0x44 set to 0x1
[    1.071237] PM: Adding info for No Bus:mcelog
[    1.071405] PM: Adding info for No Bus:msr0
[    1.071483] PM: Adding info for No Bus:msr1
[    1.071636] PM: Adding info for No Bus:cpu0
[    1.071715] PM: Adding info for No Bus:cpu1
[    1.072033] PM: Adding info for platform:pcspkr
[    1.072131] PM: Adding info for No Bus:microcode
[    1.072210] PM: Adding info for platform:microcode
[    1.072314] Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.072816] PM: Adding info for No Bus:snapshot
[    1.073573] Created ptmx node in devpts ino 2
[    1.073690] NTFS driver 2.1.29 [Flags: R/O].
[    1.073827] msgmni has been set to 7764
[    1.074209] alg: No test for stdrng (krng)
[    1.074382] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.074466] io scheduler noop registered
[    1.074531] io scheduler anticipatory registered
[    1.074598] io scheduler deadline registered
[    1.074694] io scheduler cfq registered (default)
[    1.074782] pci 0000:00:02.0: Boot video device
[    1.109359] pcieport-driver 0000:00:01.0: setting latency timer to 64
[    1.109460] pcieport-driver 0000:00:01.0: irq 24 for MSI/MSI-X
[    1.109492] PM: Adding info for pci_express:0000:00:01.0:pcie00
[    1.109576] PM: Adding info for pci_express:0000:00:01.0:pcie02
[    1.109656] PM: Adding info for pci_express:0000:00:01.0:pcie03
[    1.109787] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    1.109888] pcieport-driver 0000:00:1c.0: irq 25 for MSI/MSI-X
[    1.109923] PM: Adding info for pci_express:0000:00:1c.0:pcie00
[    1.110003] PM: Adding info for pci_express:0000:00:1c.0:pcie02
[    1.110079] PM: Adding info for pci_express:0000:00:1c.0:pcie03
[    1.110224] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    1.110326] pcieport-driver 0000:00:1c.1: irq 26 for MSI/MSI-X
[    1.110364] PM: Adding info for pci_express:0000:00:1c.1:pcie00
[    1.110442] PM: Adding info for pci_express:0000:00:1c.1:pcie02
[    1.110518] PM: Adding info for pci_express:0000:00:1c.1:pcie03
[    1.110662] pcieport-driver 0000:00:1c.3: setting latency timer to 64
[    1.110762] pcieport-driver 0000:00:1c.3: irq 27 for MSI/MSI-X
[    1.110797] PM: Adding info for pci_express:0000:00:1c.3:pcie00
[    1.110877] PM: Adding info for pci_express:0000:00:1c.3:pcie02
[    1.110951] PM: Adding info for pci_express:0000:00:1c.3:pcie03
[    1.112331] PM: Adding info for No Bus:AC
[    1.112414] ACPI: AC Adapter [AC] (off-line)
[    1.120594] PM: Adding info for No Bus:BAT0
[    1.126714] ACPI: Battery Slot [BAT0] (battery present)
[    1.126999] PM: Adding info for No Bus:input0
[    1.127129] input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    1.127223] ACPI: Power Button (CM) [PWRB]
[    1.127351] PM: Adding info for No Bus:input1
[    1.127438] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    1.128524] ACPI: Lid Switch [LID0]
[    1.130246] ACPI: SSDT BBB6EC18, 0265 (r1   Sony     VAIO 20080826 INTL 20051117)
[    1.131687] ACPI: SSDT BBB6C618, 05B8 (r1   Sony     VAIO 20080826 INTL 20051117)
[    1.133123] Monitor-Mwait will be used to enter C-1 state
[    1.133138] Monitor-Mwait will be used to enter C-2 state
[    1.133149] Monitor-Mwait will be used to enter C-3 state
[    1.133240] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    1.133523] PM: Adding info for No Bus:cooling_device0
[    1.133599] processor ACPI_CPU:00: registered as cooling_device0
[    1.133672] ACPI: Processor [CPU0] (supports 8 throttling states)
[    1.135093] ACPI: SSDT BBB6DE18, 01CF (r1   Sony     VAIO 20080826 INTL 20051117)
[    1.136450] ACPI: SSDT BBB6EF18, 008D (r1   Sony     VAIO 20080826 INTL 20051117)
[    1.138200] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    1.138473] PM: Adding info for No Bus:cooling_device1
[    1.138541] processor ACPI_CPU:01: registered as cooling_device1
[    1.138613] ACPI: Processor [CPU1] (supports 8 throttling states)
[    1.152734] PM: Adding info for No Bus:thermal_zone0
[    1.152857] PM: Adding info for No Bus:hwmon0
[    1.152964] thermal LNXTHERM:01: registered as thermal_zone0
[    1.155035] ACPI: Thermal Zone [ATF0] (29 C)
[    1.155229] PM: Adding info for No Bus:tty
[    1.155311] PM: Adding info for No Bus:console
[    1.155397] PM: Adding info for No Bus:tty0
[    1.155539] PM: Adding info for No Bus:vcs
[    1.155615] PM: Adding info for No Bus:vcsa
[    1.155699] PM: Adding info for No Bus:tty1
[    1.155775] PM: Adding info for No Bus:tty2
[    1.155852] PM: Adding info for No Bus:tty3
[    1.155932] PM: Adding info for No Bus:tty4
[    1.156017] PM: Adding info for No Bus:tty5
[    1.156095] PM: Adding info for No Bus:tty6
[    1.156175] PM: Adding info for No Bus:tty7
[    1.156255] PM: Adding info for No Bus:tty8
[    1.156333] PM: Adding info for No Bus:tty9
[    1.156414] PM: Adding info for No Bus:tty10
[    1.156493] PM: Adding info for No Bus:tty11
[    1.156574] PM: Adding info for No Bus:tty12
[    1.156654] PM: Adding info for No Bus:tty13
[    1.156735] PM: Adding info for No Bus:tty14
[    1.156817] PM: Adding info for No Bus:tty15
[    1.156902] PM: Adding info for No Bus:tty16
[    1.156985] PM: Adding info for No Bus:tty17
[    1.157092] PM: Adding info for No Bus:tty18
[    1.157178] PM: Adding info for No Bus:tty19
[    1.157267] PM: Adding info for No Bus:tty20
[    1.157353] PM: Adding info for No Bus:tty21
[    1.157440] PM: Adding info for No Bus:tty22
[    1.157537] PM: Adding info for No Bus:tty23
[    1.157623] PM: Adding info for No Bus:tty24
[    1.157708] PM: Adding info for No Bus:tty25
[    1.157795] PM: Adding info for No Bus:tty26
[    1.157883] PM: Adding info for No Bus:tty27
[    1.157971] PM: Adding info for No Bus:tty28
[    1.158057] PM: Adding info for No Bus:tty29
[    1.158141] PM: Adding info for No Bus:tty30
[    1.158226] PM: Adding info for No Bus:tty31
[    1.158313] PM: Adding info for No Bus:tty32
[    1.158401] PM: Adding info for No Bus:tty33
[    1.158489] PM: Adding info for No Bus:tty34
[    1.158580] PM: Adding info for No Bus:tty35
[    1.158669] PM: Adding info for No Bus:tty36
[    1.158756] PM: Adding info for No Bus:tty37
[    1.158843] PM: Adding info for No Bus:tty38
[    1.158931] PM: Adding info for No Bus:tty39
[    1.159020] PM: Adding info for No Bus:tty40
[    1.159106] PM: Adding info for No Bus:tty41
[    1.159193] PM: Adding info for No Bus:tty42
[    1.159280] PM: Adding info for No Bus:tty43
[    1.159370] PM: Adding info for No Bus:tty44
[    1.159461] PM: Adding info for No Bus:tty45
[    1.159552] PM: Adding info for No Bus:tty46
[    1.159641] PM: Adding info for No Bus:tty47
[    1.159730] PM: Adding info for No Bus:tty48
[    1.159817] PM: Adding info for No Bus:tty49
[    1.159907] PM: Adding info for No Bus:tty50
[    1.159998] PM: Adding info for No Bus:tty51
[    1.160102] PM: Adding info for No Bus:tty52
[    1.160190] PM: Adding info for No Bus:tty53
[    1.160280] PM: Adding info for No Bus:tty54
[    1.160367] PM: Adding info for No Bus:tty55
[    1.160457] PM: Adding info for No Bus:tty56
[    1.160554] PM: Adding info for No Bus:tty57
[    1.160644] PM: Adding info for No Bus:tty58
[    1.160731] PM: Adding info for No Bus:tty59
[    1.160821] PM: Adding info for No Bus:tty60
[    1.160910] PM: Adding info for No Bus:tty61
[    1.160999] PM: Adding info for No Bus:tty62
[    1.161091] PM: Adding info for No Bus:tty63
[    1.176232] PM: Adding info for No Bus:ptmx
[    1.176325] PM: Adding info for No Bus:hpet
[    1.176856] PM: Adding info for No Bus:nvram
[    1.176927] Non-volatile memory driver v1.3
[    1.177228] Linux agpgart interface v0.103
[    1.177316] agpgart-intel 0000:00:00.0: Intel Mobile Intel® GM45 Express Chipset
[    1.182576] agpgart-intel 0000:00:00.0: detected 65532K stolen memory
[    1.191632] PM: Adding info for No Bus:agpgart
[    1.191761] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    1.194213] PM: Adding info for No Bus:tpm0
[    1.194338] tpm_tis 00:0a: 1.2 TPM (device-id 0xB, rev-id 16)
[    1.508009] tpm_tis 00:0a: Operation Timed out
[    1.508243] [drm] Initialized drm 1.1.0 20060810
[    1.508553] PM: Adding info for No Bus:ram0
[    1.508655] PM: Adding info for No Bus:1:0
[    1.508763] PM: Adding info for No Bus:ram1
[    1.508854] PM: Adding info for No Bus:1:1
[    1.508955] PM: Adding info for No Bus:ram2
[    1.509048] PM: Adding info for No Bus:1:2
[    1.509146] PM: Adding info for No Bus:ram3
[    1.509239] PM: Adding info for No Bus:1:3
[    1.509340] PM: Adding info for No Bus:ram4
[    1.509432] PM: Adding info for No Bus:1:4
[    1.509535] PM: Adding info for No Bus:ram5
[    1.509634] PM: Adding info for No Bus:1:5
[    1.509733] PM: Adding info for No Bus:ram6
[    1.509828] PM: Adding info for No Bus:1:6
[    1.509928] PM: Adding info for No Bus:ram7
[    1.510021] PM: Adding info for No Bus:1:7
[    1.510122] PM: Adding info for No Bus:ram8
[    1.510218] PM: Adding info for No Bus:1:8
[    1.510321] PM: Adding info for No Bus:ram9
[    1.510414] PM: Adding info for No Bus:1:9
[    1.510511] PM: Adding info for No Bus:ram10
[    1.510607] PM: Adding info for No Bus:1:10
[    1.510708] PM: Adding info for No Bus:ram11
[    1.510803] PM: Adding info for No Bus:1:11
[    1.510908] PM: Adding info for No Bus:ram12
[    1.511005] PM: Adding info for No Bus:1:12
[    1.511103] PM: Adding info for No Bus:ram13
[    1.511198] PM: Adding info for No Bus:1:13
[    1.511301] PM: Adding info for No Bus:ram14
[    1.511396] PM: Adding info for No Bus:1:14
[    1.511499] PM: Adding info for No Bus:ram15
[    1.511593] PM: Adding info for No Bus:1:15
[    1.511677] brd: module loaded
[    1.511742] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
[    1.511809] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.511935] e1000e 0000:00:19.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.512025] e1000e 0000:00:19.0: setting latency timer to 64
[    1.512179] e1000e 0000:00:19.0: irq 28 for MSI/MSI-X
[    1.602392] PM: Adding info for No Bus:eth0
[    1.602807] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1a:80:d7:59:37
[    1.602890] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.602990] 0000:00:19.0: eth0: MAC: 6, PHY: 8, PBA No: ffffff-0ff
[    1.603164] Linux video capture interface: v2.00
[    1.603460] usbcore: registered new interface driver uvcvideo
[    1.603530] USB Video Class driver (v0.1.0)
[    1.603672] Driver 'sd' needs updating - please use bus_type methods
[    1.603810] Driver 'sr' needs updating - please use bus_type methods
[    1.604070] ahci 0000:00:1f.2: version 3.0
[    1.604090] ahci 0000:00:1f.2: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    1.604211] ahci 0000:00:1f.2: irq 29 for MSI/MSI-X
[    1.604335] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[    1.604420] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems 
[    1.604505] ahci 0000:00:1f.2: setting latency timer to 64
[    1.604901] scsi0 : ahci
[    1.605023] PM: Adding info for scsi:host0
[    1.605141] PM: Adding info for No Bus:host0
[    1.605250] scsi1 : ahci
[    1.605327] PM: Adding info for scsi:host1
[    1.605427] PM: Adding info for No Bus:host1
[    1.605534] scsi2 : ahci
[    1.605613] PM: Adding info for scsi:host2
[    1.605710] PM: Adding info for No Bus:host2
[    1.605812] scsi3 : ahci
[    1.605889] PM: Adding info for scsi:host3
[    1.605990] PM: Adding info for No Bus:host3
[    1.606095] scsi4 : ahci
[    1.606171] PM: Adding info for scsi:host4
[    1.606268] PM: Adding info for No Bus:host4
[    1.606370] scsi5 : ahci
[    1.606446] PM: Adding info for scsi:host5
[    1.606547] PM: Adding info for No Bus:host5
[    1.607431] ata1: SATA max UDMA/133 abar m2048@0xee925000 port 0xee925100 irq 29
[    1.607514] ata2: SATA max UDMA/133 abar m2048@0xee925000 port 0xee925180 irq 29
[    1.607594] ata3: DUMMY
[    1.607655] ata4: DUMMY
[    1.607717] ata5: SATA max UDMA/133 abar m2048@0xee925000 port 0xee925300 irq 29
[    1.607798] ata6: SATA max UDMA/133 abar m2048@0xee925000 port 0xee925380 irq 29
[    1.924026] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.924927] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    1.978672] ata1.00: ATA-8: TOSHIBA MK3252GSX, LV010A, max UDMA/100
[    1.978742] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.980026] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    1.980285] ata1.00: configured for UDMA/100
[    2.012173] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK3252GS LV01 PQ: 0 ANSI: 5
[    2.012272] PM: Adding info for scsi:target0:0:0
[    2.012387] PM: Adding info for scsi:0:0:0:0
[    2.012504] PM: Adding info for No Bus:0:0:0:0
[    2.012632] sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors: (320 GB/298 GiB)
[    2.012741] sd 0:0:0:0: [sda] Write Protect is off
[    2.012808] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.012859] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.012978] PM: Adding info for No Bus:sda
[    2.013052] sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors: (320 GB/298 GiB)
[    2.013160] sd 0:0:0:0: [sda] Write Protect is off
[    2.013227] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.013276] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.013360]  sda: sda1 sda2 sda3 sda4
[    2.062901] PM: Adding info for No Bus:sda1
[    2.062932] PM: Adding info for No Bus:sda2
[    2.062961] PM: Adding info for No Bus:sda3
[    2.062991] PM: Adding info for No Bus:sda4
[    2.063352] PM: Adding info for No Bus:8:0
[    2.063420] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.063505] PM: Adding info for No Bus:0:0:0:0
[    2.063604] PM: Adding info for No Bus:sg0
[    2.063670] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.063780] PM: Adding info for No Bus:0:0:0:0
[    2.380026] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.383376] ata2.00: ACPI cmd 00/00:00:00:00:00:a0 rejected by device (Stat=0x51 Err=0x04)
[    2.383462] ata2.00: ATAPI: MATSHITADVD-RAM UJ862AS, 1.21, max UDMA/33
[    2.387438] ata2.00: ACPI cmd 00/00:00:00:00:00:a0 rejected by device (Stat=0x51 Err=0x04)
[    2.387582] ata2.00: configured for UDMA/33
[    2.421831] scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ862AS  1.21 PQ: 0 ANSI: 5
[    2.421933] PM: Adding info for scsi:target1:0:0
[    2.422050] PM: Adding info for scsi:1:0:0:0
[    2.425690] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.425773] Uniform CD-ROM driver Revision: 3.20
[    2.425917] PM: Adding info for No Bus:sr0
[    2.426050] PM: Adding info for No Bus:11:0
[    2.426119] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.426143] PM: Adding info for No Bus:1:0:0:0
[    2.426242] PM: Adding info for No Bus:sg1
[    2.426309] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    2.426406] PM: Adding info for No Bus:1:0:0:0
[    2.776023] ata5: SATA link down (SStatus 0 SControl 300)
[    3.128023] ata6: SATA link down (SStatus 0 SControl 300)
[    3.160142] yenta_cardbus 0000:0b:04.0: CardBus bridge found [104d:9025]
[    3.288871] yenta_cardbus 0000:0b:04.0: ISA IRQ mask 0x00b8, PCI irq 20
[    3.288941] yenta_cardbus 0000:0b:04.0: Socket status: 30000006
[    3.289018] pci_bus 0000:0b: Raising subordinate bus# of parent bus (#0b) from #0c to #0f
[    3.289105] yenta_cardbus 0000:0b:04.0: pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
[    3.289189] yenta_cardbus 0000:0b:04.0: pcmcia: parent PCI bridge Memory window: 0xe6000000 - 0xe80fffff
[    3.289273] yenta_cardbus 0000:0b:04.0: pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe1ffffff
[    3.289541] PM: Adding info for No Bus:pcmcia_socket0
[    3.289892] PM: Adding info for No Bus:usbmon0
[    3.289957] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.290058] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 23 (level, low) -> IRQ 23
[    3.290146] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    3.290152] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    3.290244] PM: Adding info for No Bus:usb_host1
[    3.290365] PM: Adding info for No Bus:usbmon1
[    3.290430] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    3.294450] ehci_hcd 0000:00:1a.7: debug port 1
[    3.294522] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    3.294547] ehci_hcd 0000:00:1a.7: irq 23, io mem 0xee925c00
[    3.308015] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    3.308118] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.308188] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.308267] usb usb1: Product: EHCI Host Controller
[    3.308333] usb usb1: Manufacturer: Linux 2.6.29-rc2 ehci_hcd
[    3.308400] usb usb1: SerialNumber: 0000:00:1a.7
[    3.308519] PM: Adding info for usb:usb1
[    3.308612] usb usb1: configuration #1 chosen from 1 choice
[    3.308712] PM: Adding info for usb:1-0:1.0
[    3.308792] hub 1-0:1.0: USB hub found
[    3.308866] hub 1-0:1.0: 6 ports detected
[    3.309077] PM: Adding info for No Bus:usbdev1.1_ep81
[    3.309196] PM: Adding info for No Bus:usbdev1.1_ep00
[    3.309287] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.309375] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    3.309382] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    3.309472] PM: Adding info for No Bus:usb_host2
[    3.309577] PM: Adding info for No Bus:usbmon2
[    3.309641] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    3.313646] ehci_hcd 0000:00:1d.7: debug port 1
[    3.313718] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    3.313729] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xee925800
[    3.328015] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    3.328129] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.328199] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.328278] usb usb2: Product: EHCI Host Controller
[    3.328343] usb usb2: Manufacturer: Linux 2.6.29-rc2 ehci_hcd
[    3.328410] usb usb2: SerialNumber: 0000:00:1d.7
[    3.328532] PM: Adding info for usb:usb2
[    3.328619] usb usb2: configuration #1 chosen from 1 choice
[    3.328717] PM: Adding info for usb:2-0:1.0
[    3.328789] hub 2-0:1.0: USB hub found
[    3.328863] hub 2-0:1.0: 6 ports detected
[    3.329008] PM: Adding info for No Bus:usbdev2.1_ep81
[    3.329121] PM: Adding info for No Bus:usbdev2.1_ep00
[    3.329259] uhci_hcd: USB Universal Host Controller Interface driver
[    3.329371] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    3.329449] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.329455] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    3.329546] PM: Adding info for No Bus:usb_host3
[    3.329653] PM: Adding info for No Bus:usbmon3
[    3.329715] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    3.329829] uhci_hcd 0000:00:1a.0: irq 23, io base 0x000080e0
[    3.329964] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.330033] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.330113] usb usb3: Product: UHCI Host Controller
[    3.330178] usb usb3: Manufacturer: Linux 2.6.29-rc2 uhci_hcd
[    3.330245] usb usb3: SerialNumber: 0000:00:1a.0
[    3.330364] PM: Adding info for usb:usb3
[    3.330451] usb usb3: configuration #1 chosen from 1 choice
[    3.330549] PM: Adding info for usb:3-0:1.0
[    3.330623] hub 3-0:1.0: USB hub found
[    3.330697] hub 3-0:1.0: 2 ports detected
[    3.330812] PM: Adding info for No Bus:usbdev3.1_ep81
[    3.330927] PM: Adding info for No Bus:usbdev3.1_ep00
[    3.331026] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 23 (level, low) -> IRQ 23
[    3.331104] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    3.331110] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    3.331199] PM: Adding info for No Bus:usb_host4
[    3.331304] PM: Adding info for No Bus:usbmon4
[    3.331365] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    3.331477] uhci_hcd 0000:00:1a.1: irq 23, io base 0x000080c0
[    3.331608] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.331678] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.331758] usb usb4: Product: UHCI Host Controller
[    3.331823] usb usb4: Manufacturer: Linux 2.6.29-rc2 uhci_hcd
[    3.331890] usb usb4: SerialNumber: 0000:00:1a.1
[    3.332013] PM: Adding info for usb:usb4
[    3.332098] usb usb4: configuration #1 chosen from 1 choice
[    3.332194] PM: Adding info for usb:4-0:1.0
[    3.332267] hub 4-0:1.0: USB hub found
[    3.332341] hub 4-0:1.0: 2 ports detected
[    3.332455] PM: Adding info for No Bus:usbdev4.1_ep81
[    3.332583] PM: Adding info for No Bus:usbdev4.1_ep00
[    3.332679] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 23 (level, low) -> IRQ 23
[    3.332757] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    3.332763] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    3.332856] PM: Adding info for No Bus:usb_host5
[    3.332961] PM: Adding info for No Bus:usbmon5
[    3.333024] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    3.333139] uhci_hcd 0000:00:1a.2: irq 23, io base 0x000080a0
[    3.333268] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.333339] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.333418] usb usb5: Product: UHCI Host Controller
[    3.333484] usb usb5: Manufacturer: Linux 2.6.29-rc2 uhci_hcd
[    3.333551] usb usb5: SerialNumber: 0000:00:1a.2
[    3.333672] PM: Adding info for usb:usb5
[    3.333758] usb usb5: configuration #1 chosen from 1 choice
[    3.333853] PM: Adding info for usb:5-0:1.0
[    3.333928] hub 5-0:1.0: USB hub found
[    3.334003] hub 5-0:1.0: 2 ports detected
[    3.334118] PM: Adding info for No Bus:usbdev5.1_ep81
[    3.334230] PM: Adding info for No Bus:usbdev5.1_ep00
[    3.334330] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.334407] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.334413] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.334507] PM: Adding info for No Bus:usb_host6
[    3.334606] PM: Adding info for No Bus:usbmon6
[    3.334669] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    3.334781] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00008080
[    3.334911] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.334981] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.335061] usb usb6: Product: UHCI Host Controller
[    3.335126] usb usb6: Manufacturer: Linux 2.6.29-rc2 uhci_hcd
[    3.335192] usb usb6: SerialNumber: 0000:00:1d.0
[    3.335312] PM: Adding info for usb:usb6
[    3.335400] usb usb6: configuration #1 chosen from 1 choice
[    3.335495] PM: Adding info for usb:6-0:1.0
[    3.335568] hub 6-0:1.0: USB hub found
[    3.335642] hub 6-0:1.0: 2 ports detected
[    3.335757] PM: Adding info for No Bus:usbdev6.1_ep81
[    3.335876] PM: Adding info for No Bus:usbdev6.1_ep00
[    3.335976] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[    3.336054] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    3.336061] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.336152] PM: Adding info for No Bus:usb_host7
[    3.336252] PM: Adding info for No Bus:usbmon7
[    3.336313] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    3.336427] uhci_hcd 0000:00:1d.1: irq 20, io base 0x00008060
[    3.336556] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    3.338828] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.338908] usb usb7: Product: UHCI Host Controller
[    3.338973] usb usb7: Manufacturer: Linux 2.6.29-rc2 uhci_hcd
[    3.339040] usb usb7: SerialNumber: 0000:00:1d.1
[    3.339163] PM: Adding info for usb:usb7
[    3.339249] usb usb7: configuration #1 chosen from 1 choice
[    3.339345] PM: Adding info for usb:7-0:1.0
[    3.339420] hub 7-0:1.0: USB hub found
[    3.339494] hub 7-0:1.0: 2 ports detected
[    3.339618] PM: Adding info for No Bus:usbdev7.1_ep81
[    3.339731] PM: Adding info for No Bus:usbdev7.1_ep00
[    3.339827] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 20 (level, low) -> IRQ 20
[    3.339905] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    3.339911] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    3.340001] PM: Adding info for No Bus:usb_host8
[    3.340119] PM: Adding info for No Bus:usbmon8
[    3.340185] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    3.340297] uhci_hcd 0000:00:1d.2: irq 20, io base 0x00008040
[    3.340430] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    3.340500] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.340580] usb usb8: Product: UHCI Host Controller
[    3.340645] usb usb8: Manufacturer: Linux 2.6.29-rc2 uhci_hcd
[    3.340711] usb usb8: SerialNumber: 0000:00:1d.2
[    3.340831] PM: Adding info for usb:usb8
[    3.340919] usb usb8: configuration #1 chosen from 1 choice
[    3.341025] PM: Adding info for usb:8-0:1.0
[    3.341104] hub 8-0:1.0: USB hub found
[    3.341183] hub 8-0:1.0: 2 ports detected
[    3.341300] PM: Adding info for No Bus:usbdev8.1_ep81
[    3.341419] PM: Adding info for No Bus:usbdev8.1_ep00
[    3.341689] usbcore: registered new interface driver wusb-cbaf
[    3.341946] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
[    3.342129] PM: Adding info for platform:i8042
[    3.345654] i8042.c: Detected active multiplexing controller, rev 1.1.
[    3.348788] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.348862] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.348884] PM: Adding info for serio:serio0
[    3.348931] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.348997] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.349064] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.349163] PM: Adding info for No Bus:mice
[    3.349266] PM: Adding info for serio:serio1
[    3.349304] PM: Adding info for No Bus:psaux
[    3.349397] PM: Adding info for serio:serio2
[    3.349447] mice: PS/2 mouse device common for all mice
[    3.349590] PM: Adding info for serio:serio3
[    3.349685] PM: Adding info for serio:serio4
[    3.368047] PM: Adding info for No Bus:event0
[    3.384035] PM: Adding info for No Bus:event1
[    3.384330] PM: Adding info for No Bus:input2
[    3.384415] input: PC Speaker as /devices/platform/pcspkr/input/input2
[    3.398242] PM: Adding info for No Bus:input3
[    3.398343] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    3.412033] PM: Adding info for No Bus:event2
[    3.412198] rtc_cmos 00:03: RTC can wake from S4
[    3.412311] PM: Adding info for No Bus:rtc0
[    3.412380] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    3.412481] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.412647] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    3.412731] ACPI: I/O resource 0000:00:1f.3 [0x8000-0x801f] conflicts with ACPI region SMBI [0x8000-0x800f]
[    3.412815] ACPI: Device needs an ACPI driver
[    3.412926] PM: Adding info for No Bus:i2c-0
[    3.413132] PM: Adding info for platform:coretemp.0
[    3.413227] PM: Adding info for No Bus:hwmon1
[    3.413303] PM: Adding info for platform:coretemp.1
[    3.413403] PM: Adding info for No Bus:hwmon2
[    3.414026] cpuidle: using governor ladder
[    3.415019] cpuidle: using governor menu
[    3.415152] sdhci: Secure Digital Host Controller Interface driver
[    3.415221] sdhci: Copyright(c) Pierre Ossman
[    3.415311] sdhci-pci 0000:0b:04.2: SDHCI controller found [1180:0822] (rev 21)
[    3.415394] sdhci-pci 0000:0b:04.2: found 1 slot(s)
[    3.415411] sdhci-pci 0000:0b:04.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    3.416516] sdhci-pci 0000:0b:04.2: Will use DMA mode even though HW doesn't fully claim to support it.
[    3.416605] sdhci-pci 0000:0b:04.2: setting latency timer to 64
[    3.417005] Marking TSC unstable due to TSC halts in idle
[    3.417622] sdhci: ============== REGISTER DUMP ==============
[    3.417629] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[    3.417636] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    3.417642] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    3.417649] sdhci: Present:  0x01f20000 | Host ctl: 0x00000000
[    3.417655] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    3.417662] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[    3.417668] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    3.417675] sdhci: Int enab: 0x02ff00fb | Sig enab: 0x02ff00fb
[    3.417681] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    3.417688] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[    3.417691] sdhci: ===========================================
[    3.417715] PM: Adding info for No Bus:mmc0
[    3.417825] Registered led device: mmc0
[    3.417909] PM: Adding info for No Bus:mmc0
[    3.418017] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    3.419025] mmc0: SDHCI controller on PCI [0000:0b:04.2] using DMA
[    3.419067] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    3.419176] ricoh-mmc: Ricoh MMC Controller disabling driver
[    3.419244] ricoh-mmc: Copyright(c) Philip Langdale
[    3.420450] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.420520] TCP cubic registered
[    3.420584] NET: Registered protocol family 17
[    3.421060] mmc0: clock 128906Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.423051] mmc0: clock 128906Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    3.423309] PM: Adding info for No Bus:vcs1
[    3.423355] PM: Adding info for No Bus:cpu_dma_latency
[    3.423370] PM: Adding info for No Bus:vcsa1
[    3.423399] PM: Adding info for No Bus:network_latency
[    3.423630] PM: Removing info for No Bus:vcs1
[    3.423669] PM: Adding info for No Bus:network_throughput
[    3.423691] PM: Removing info for No Bus:vcsa1
[    3.423722] PM: Resume from partition /dev/sda4
[    3.423723] PM: Checking hibernation image.
[    3.424046] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    3.426049] mmc0: req done (CMD0): -123: 00000000 00000000 00000000 00000000
[    3.427044] mmc0: clock 128906Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.428039] mmc0: starting CMD8 arg 000001aa flags 000002f5
[    3.430040] mmc0: req done (CMD8): -123: 00000000 00000000 00000000 00000000
[    3.430099] mmc0: starting CMD5 arg 00000000 flags 000002e1
[    3.432091] mmc0: req failed (CMD5): -123, retrying...
[    3.434088] mmc0: req failed (CMD5): -123, retrying...
[    3.436080] mmc0: req failed (CMD5): -123, retrying...
[    3.438078] mmc0: req done (CMD5): -123: 00000000 00000000 00000000 00000000
[    3.438082] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.440056] PM: Adding info for No Bus:event3
[    3.440110] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
[    3.440114] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.442114] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
[    3.442131] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.444125] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
[    3.444128] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.446128] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
[    3.446134] mmc0: starting CMD1 arg 00000000 flags 000000e1
[    3.448126] mmc0: req done (CMD1): -123: 00000000 00000000 00000000 00000000
[    3.448129] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    3.460600] PM: Resume from disk failed.
[    3.460605] registered taskstats version 1
[    3.450125] mmc0: Reset 0x1 never completed.
[    3.450125] sdhci: ============== REGISTER DUMP ==============
[    3.450125] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[    3.450125] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    3.450125] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    3.450125] sdhci: Present:  0x00020000 | Host ctl: 0x00000000
[    3.450125] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[    3.450125] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[    3.450125] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    3.450125] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[    3.450125] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    3.450125] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[    3.450125] sdhci: ===========================================
[    3.547545] rtc_cmos 00:03: setting system clock to 2009-01-26 22:09:25 UTC (1233007765)
[    3.547645] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[    3.547810] Freeing unused kernel memory: 336k freed
[    3.547985] PM: Adding info for No Bus:vcs1
[    3.548025] PM: Adding info for No Bus:vcsa1
[    3.769032] usb 1-2: new high speed USB device using ehci_hcd and address 3
[    3.903048] usb 1-2: New USB device found, idVendor=05ca, idProduct=18b0
[    3.903110] usb 1-2: New USB device strings: Mfr=1, Product=0, SerialNumber=0
[    3.903169] usb 1-2: Manufacturer: Ricoh co. Ltd.
[    3.903266] PM: Adding info for usb:1-2
[    3.903286] usb 1-2: configuration #1 chosen from 1 choice
[    3.903428] PM: Adding info for usb:1-2:1.0
[    3.903935] uvcvideo: Found UVC 1.00 device <unnamed> (05ca:18b0)
[    3.904420] uvcvideo: UVC non compliance - GET_DEF(PROBE) not supported. Enabling workaround.
[    3.904927] PM: Adding info for No Bus:video0
[    3.904952] PM: Adding info for No Bus:input4
[    3.904967] input: UVC Camera (05ca:18b0) as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input4
[    3.920082] PM: Adding info for No Bus:event4
[    3.920137] PM: Adding info for No Bus:usbdev1.3_ep81
[    3.920164] PM: Adding info for usb:1-2:1.1
[    3.920213] PM: Adding info for No Bus:usbdev1.3_ep00
[    4.024722] PM: Starting manual resume from disk
[    4.024775] PM: Resume from partition 8:4
[    4.024776] PM: Checking hibernation image.
[    4.049606] PM: Resume from disk failed.
[    4.052645] PM: Marking nosave pages: 000000000009f000 - 0000000000100000
[    4.052649] PM: Marking nosave pages: 00000000ba20e000 - 00000000ba211000
[    4.052651] PM: Marking nosave pages: 00000000bbb6b000 - 00000000bbbbf000
[    4.052654] PM: Marking nosave pages: 00000000bbc73000 - 00000000bbcbf000
[    4.052656] PM: Marking nosave pages: 00000000bbce9000 - 00000000bbcff000
[    4.052658] PM: Marking nosave pages: 00000000bbd00000 - 0000000100000000
[    4.058361] PM: Basic memory bitmaps created
[    4.077434] PM: Basic memory bitmaps freed
[    4.082936] EXT3-fs: INFO: recovery required on readonly filesystem.
[    4.082992] EXT3-fs: write access will be enabled during recovery.
[    4.272048] usb 3-1: new full speed USB device using uhci_hcd and address 2
[    4.444940] usb 3-1: New USB device found, idVendor=147e, idProduct=1000
[    4.444999] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.445071] usb 3-1: Product: Fingerprint Sensor   
[    4.445144] usb 3-1: Manufacturer: TouchStrip        
[    4.445238] PM: Adding info for usb:3-1
[    4.445503] usb 3-1: configuration #1 chosen from 1 choice
[    4.446946] PM: Adding info for usb:3-1:1.0
[    4.447063] PM: Adding info for No Bus:usbdev3.2_ep81
[    4.447154] PM: Adding info for No Bus:usbdev3.2_ep02
[    4.447245] PM: Adding info for No Bus:usbdev3.2_ep83
[    4.447343] PM: Adding info for No Bus:usbdev3.2_ep00
[    4.684041] usb 8-2: new full speed USB device using uhci_hcd and address 2
[    4.850404] usb 8-2: New USB device found, idVendor=044e, idProduct=3017
[    4.850463] usb 8-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.850522] usb 8-2: Product: BCM2046 Bluetooth Device
[    4.850582] usb 8-2: Manufacturer: Broadcom Corp
[    4.850634] usb 8-2: SerialNumber: 001E3DF86FC8
[    4.850713] PM: Adding info for usb:8-2
[    4.850728] usb 8-2: configuration #1 chosen from 1 choice
[    4.852406] PM: Adding info for usb:8-2:1.0
[    4.852436] PM: Adding info for No Bus:usbdev8.2_ep81
[    4.852454] PM: Adding info for No Bus:usbdev8.2_ep82
[    4.852473] PM: Adding info for No Bus:usbdev8.2_ep02
[    4.852488] PM: Adding info for usb:8-2:1.1
[    4.852510] PM: Adding info for No Bus:usbdev8.2_ep83
[    4.852528] PM: Adding info for No Bus:usbdev8.2_ep03
[    4.852543] PM: Adding info for usb:8-2:1.2
[    4.852566] PM: Adding info for No Bus:usbdev8.2_ep84
[    4.852586] PM: Adding info for No Bus:usbdev8.2_ep04
[    4.852601] PM: Adding info for usb:8-2:1.3
[    4.852627] PM: Adding info for No Bus:usbdev8.2_ep00
[    4.864709] EXT3-fs: recovery complete.
[    4.864775] kjournald starting.  Commit interval 5 seconds
[    4.891110] EXT3-fs: mounted filesystem with ordered data mode.
[    4.901013] PM: Adding info for No Bus:input5
[    4.901040] input: PS/2 Mouse as /devices/platform/i8042/serio2/input/input5
[    4.916060] PM: Adding info for No Bus:mouse0
[    4.932073] PM: Adding info for No Bus:event5
[    4.948080] PM: Adding info for No Bus:input6
[    4.948106] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio2/input/input6
[    4.957060] PM: Adding info for No Bus:mouse1
[    4.969059] PM: Adding info for No Bus:event6
[    5.725290] PM: Removing info for No Bus:vcs1
[    5.725313] PM: Removing info for No Bus:vcsa1
[    5.725345] PM: Adding info for No Bus:vcs1
[    5.725356] PM: Adding info for No Bus:vcsa1
[    5.725370] PM: Removing info for No Bus:vcs1
[    5.725380] PM: Removing info for No Bus:vcsa1
[    5.741358] PM: Adding info for No Bus:vcs1
[    5.741375] PM: Adding info for No Bus:vcsa1
[    5.741432] PM: Removing info for No Bus:vcs1
[    5.741447] PM: Removing info for No Bus:vcsa1
[    5.741481] PM: Adding info for No Bus:vcs1
[    5.741498] PM: Adding info for No Bus:vcsa1
[    5.741552] PM: Removing info for No Bus:vcs1
[    5.741567] PM: Removing info for No Bus:vcsa1
[    5.741600] PM: Adding info for No Bus:vcs1
[    5.741610] PM: Adding info for No Bus:vcsa1
[    5.741699] PM: Removing info for No Bus:vcs1
[    5.741708] PM: Removing info for No Bus:vcsa1
[    5.764693] PM: Adding info for No Bus:vcs1
[    5.764704] PM: Adding info for No Bus:vcsa1
[   12.597472] udevd version 125 started
[   12.770513] PM: Adding info for No Bus:acpi_video0
[   12.772025] PM: Adding info for No Bus:cooling_device2
[   12.772034] acpi device:02: registered as cooling_device2
[   12.772125] PM: Adding info for No Bus:acpi_video0
[   12.772184] PM: Adding info for No Bus:acpi_video1
[   12.772242] PM: Adding info for No Bus:acpi_video2
[   12.772299] PM: Adding info for No Bus:acpi_video3
[   12.772393] PM: Adding info for No Bus:input7
[   12.772410] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:01/input/input7
[   12.802263] sony-laptop: Sony Programmable IO Control Driver v0.6.
[   12.802338] sony-laptop: detected Type2 model
[   12.802920] PM: Adding info for No Bus:input8
[   12.802940] input: Sony Vaio Keys as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:0f/SNY6001:00/input/input8
[   12.808045] PM: Adding info for No Bus:event7
[   12.808055] ACPI: Video Device [OVGA] (multi-head: yes  rom: no  post: no)
[   12.808244] PM: Adding info for No Bus:acpi_video4
[   12.808303] PM: Adding info for No Bus:acpi_video5
[   12.808361] PM: Adding info for No Bus:acpi_video6
[   12.808418] PM: Adding info for No Bus:acpi_video7
[   12.808482] PM: Adding info for No Bus:input9
[   12.808497] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:07/device:08/input/input9
[   12.840063] PM: Adding info for No Bus:event8
[   12.840079] ACPI: Video Device [DGPU] (multi-head: yes  rom: yes  post: no)
[   12.868055] PM: Adding info for No Bus:event9
[   12.868081] PM: Adding info for No Bus:input10
[   12.868096] input: Sony Vaio Jogdial as /devices/virtual/input/input10
[   12.884047] PM: Adding info for No Bus:mouse2
[   12.900071] PM: Adding info for No Bus:event10
[   12.900094] PM: Adding info for No Bus:sonypi
[   12.900099] sony-laptop: device allocated minor is 60
[   12.901106] PM: Adding info for platform:sony-laptop
[   12.901173] sony-laptop: Sony Notebook Control Driver v0.6.
[   12.907799] sony-laptop: brightness ignored, must be controlled by ACPI video driver
[   12.924038] PM: Adding info for platform:regulatory.0
[   12.924046] cfg80211: Calling CRDA to update world regulatory domain
[   12.951815] Bluetooth: Generic Bluetooth USB driver ver 0.4
[   12.951919] PM: Adding info for No Bus:hci0
[   12.951947] usbcore: registered new interface driver btusb
[   13.046831] firewire_ohci 0000:0b:04.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   13.046906] firewire_ohci 0000:0b:04.1: setting latency timer to 64
[   13.124060] firewire_ohci: Added fw-ohci device 0000:0b:04.1, OHCI version 1.0
[   13.322463] PM: Adding info for No Bus:timer
[   13.365906] PM: Adding info for No Bus:seq
[   13.401638] iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27ks
[   13.401706] iwlagn: Copyright(c) 2003-2008 Intel Corporation
[   13.401842] iwlagn 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   13.401929] iwlagn 0000:06:00.0: setting latency timer to 64
[   13.402017] iwlagn: Detected Intel Wireless WiFi Link 5100AGN REV=0x54
[   13.423644] iwlagn: Tunable channels: 13 802.11bg, 24 802.11a channels
[   13.423857] iwlagn 0000:06:00.0: PCI INT A disabled
[   13.423921] PM: Adding info for No Bus:phy0
[   13.424028] wmaster0 (iwlagn): not using net_device_ops yet
[   13.424118] PM: Adding info for No Bus:wmaster0
[   13.424281] phy0: Selected rate control algorithm 'iwl-agn-rs'
[   13.434169] PM: Adding info for No Bus:sequencer
[   13.434182] PM: Adding info for No Bus:sequencer2
[   13.445718] wlan0 (iwlagn): not using net_device_ops yet
[   13.445805] PM: Adding info for No Bus:wlan0
[   13.445972] PM: Adding info for No Bus:rfkill0
[   13.497765] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[   13.497862] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   13.566606] hda_codec: model 'sony-assamd' is selected
[   13.624114] PM: Adding info for firewire:fw0
[   13.624130] firewire_core: created device fw0: GUID 0800460302b0163b, S400
[   13.649132] PM: Adding info for No Bus:card0
[   13.649157] PM: Adding info for No Bus:pcmC0D0p
[   13.649182] PM: Adding info for No Bus:pcmC0D0c
[   13.649208] PM: Adding info for No Bus:dsp
[   13.649221] PM: Adding info for No Bus:audio
[   13.649238] PM: Adding info for No Bus:hwC0D1
[   13.649252] PM: Adding info for No Bus:hwC0D0
[   13.649277] PM: Adding info for No Bus:controlC0
[   13.649295] PM: Adding info for No Bus:mixer
[   14.238520] Adding 8830448k swap on /dev/sda4.  Priority:-1 extents:1 across:8830448k 
[   14.275049] EXT3 FS on sda3, internal journal
[   15.276978] PM: Adding info for No Bus:loop0
[   15.277014] PM: Adding info for No Bus:7:0
[   15.277033] PM: Adding info for No Bus:loop1
[   15.277048] PM: Adding info for No Bus:7:1
[   15.277066] PM: Adding info for No Bus:loop2
[   15.277080] PM: Adding info for No Bus:7:2
[   15.277096] PM: Adding info for No Bus:loop3
[   15.277109] PM: Adding info for No Bus:7:3
[   15.277125] PM: Adding info for No Bus:loop4
[   15.277138] PM: Adding info for No Bus:7:4
[   15.277157] PM: Adding info for No Bus:loop5
[   15.277171] PM: Adding info for No Bus:7:5
[   15.277188] PM: Adding info for No Bus:loop6
[   15.277204] PM: Adding info for No Bus:7:6
[   15.277220] PM: Adding info for No Bus:loop7
[   15.277233] PM: Adding info for No Bus:7:7
[   15.277240] loop: module loaded
[   15.300815] firewire_sbp2: Unknown parameter `serialize_io'
[   15.428914] vboxdrv: Trying to deactivate the NMI watchdog permanently...
[   15.428916] vboxdrv: Successfully done.
[   15.428917] vboxdrv: Found 2 processor cores.
[   15.428947] vboxdrv: fAsync=0 u64DiffCores=6878.
[   15.428983] PM: Adding info for No Bus:vboxdrv
[   15.428997] vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
[   15.429066] vboxdrv: Successfully loaded version 1.6.6_OSE (interface 0x00080000).
[   15.493755] PM: Adding info for No Bus:device-mapper
[   15.493775] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   15.705341] fuse init (API version 7.11)
[   15.705484] PM: Adding info for No Bus:fuse
[   16.085779] PM: Adding info for No Bus:8:2-fuseblk
[   16.211665] ISO 9660 Extensions: Microsoft Joliet Level 3
[   16.246294] ISO 9660 Extensions: RRIP_1991A
[   17.048067] PM: Adding info for No Bus:vcs2
[   17.048086] PM: Adding info for No Bus:vcsa2
[   17.055269] PM: Removing info for No Bus:vcs2
[   17.055288] PM: Removing info for No Bus:vcsa2
[   17.056300] PM: Adding info for No Bus:vcs3
[   17.056315] PM: Adding info for No Bus:vcsa3
[   17.063201] PM: Removing info for No Bus:vcs3
[   17.063217] PM: Removing info for No Bus:vcsa3
[   17.063862] PM: Adding info for No Bus:vcs4
[   17.063878] PM: Adding info for No Bus:vcsa4
[   17.070451] PM: Removing info for No Bus:vcs4
[   17.070466] PM: Removing info for No Bus:vcsa4
[   17.071457] PM: Adding info for No Bus:vcs5
[   17.071475] PM: Adding info for No Bus:vcsa5
[   17.078562] PM: Removing info for No Bus:vcs5
[   17.078577] PM: Removing info for No Bus:vcsa5
[   17.081831] PM: Adding info for No Bus:vcs2
[   17.081845] PM: Adding info for No Bus:vcsa2
[   17.088931] PM: Removing info for No Bus:vcs2
[   17.088948] PM: Removing info for No Bus:vcsa2
[   17.089488] PM: Adding info for No Bus:vcs3
[   17.089502] PM: Adding info for No Bus:vcsa3
[   17.096664] PM: Removing info for No Bus:vcs3
[   17.096680] PM: Removing info for No Bus:vcsa3
[   17.097332] PM: Adding info for No Bus:vcs4
[   17.097344] PM: Adding info for No Bus:vcsa4
[   17.103821] PM: Removing info for No Bus:vcs4
[   17.103836] PM: Removing info for No Bus:vcsa4
[   17.104488] PM: Adding info for No Bus:vcs5
[   17.104502] PM: Adding info for No Bus:vcsa5
[   17.111662] PM: Removing info for No Bus:vcs5
[   17.111677] PM: Removing info for No Bus:vcsa5
[   17.112362] PM: Adding info for No Bus:vcs6
[   17.112377] PM: Adding info for No Bus:vcsa6
[   17.119519] PM: Removing info for No Bus:vcs6
[   17.119534] PM: Removing info for No Bus:vcsa6
[   17.224686] PM: Adding info for No Bus:vcs2
[   17.224702] PM: Adding info for No Bus:vcsa2
[   17.225781] PM: Removing info for No Bus:vcs2
[   17.225797] PM: Removing info for No Bus:vcsa2
[   17.226623] PM: Adding info for No Bus:vcs2
[   17.226638] PM: Adding info for No Bus:vcsa2
[   17.233659] PM: Removing info for No Bus:vcs2
[   17.233673] PM: Removing info for No Bus:vcsa2
[   17.233894] PM: Adding info for No Bus:vcs3
[   17.233907] PM: Adding info for No Bus:vcsa3
[   17.234234] PM: Removing info for No Bus:vcs3
[   17.234247] PM: Removing info for No Bus:vcsa3
[   17.235718] PM: Adding info for No Bus:vcs3
[   17.235733] PM: Adding info for No Bus:vcsa3
[   17.243267] PM: Removing info for No Bus:vcs3
[   17.243282] PM: Removing info for No Bus:vcsa3
[   17.243632] PM: Adding info for No Bus:vcs4
[   17.243645] PM: Adding info for No Bus:vcsa4
[   17.243973] PM: Removing info for No Bus:vcs4
[   17.243986] PM: Removing info for No Bus:vcsa4
[   17.244802] PM: Adding info for No Bus:vcs4
[   17.244814] PM: Adding info for No Bus:vcsa4
[   17.251579] PM: Removing info for No Bus:vcs4
[   17.251594] PM: Removing info for No Bus:vcsa4
[   17.251923] PM: Adding info for No Bus:vcs5
[   17.251936] PM: Adding info for No Bus:vcsa5
[   17.252267] PM: Removing info for No Bus:vcs5
[   17.252280] PM: Removing info for No Bus:vcsa5
[   17.253135] PM: Adding info for No Bus:vcs5
[   17.253147] PM: Adding info for No Bus:vcsa5
[   17.260692] PM: Removing info for No Bus:vcs5
[   17.260708] PM: Removing info for No Bus:vcsa5
[   17.261050] PM: Adding info for No Bus:vcs6
[   17.261062] PM: Adding info for No Bus:vcsa6
[   17.261391] PM: Removing info for No Bus:vcs6
[   17.261403] PM: Removing info for No Bus:vcsa6
[   17.262189] PM: Adding info for No Bus:vcs6
[   17.262200] PM: Adding info for No Bus:vcsa6
[   17.270183] PM: Removing info for No Bus:vcs6
[   17.270197] PM: Removing info for No Bus:vcsa6
[   17.481361] PM: Removing info for No Bus:vcs1
[   17.481398] PM: Removing info for No Bus:vcsa1
[   17.512375] PM: Adding info for No Bus:vcs1
[   17.512389] PM: Adding info for No Bus:vcsa1
[   17.512437] PM: Removing info for No Bus:vcs1
[   17.512448] PM: Removing info for No Bus:vcsa1
[   17.512470] PM: Adding info for No Bus:vcs1
[   17.512480] PM: Adding info for No Bus:vcsa1
[   17.512528] PM: Removing info for No Bus:vcs1
[   17.512537] PM: Removing info for No Bus:vcsa1
[   17.512558] PM: Adding info for No Bus:vcs1
[   17.512569] PM: Adding info for No Bus:vcsa1
[   17.512659] PM: Removing info for No Bus:vcs1
[   17.512669] PM: Removing info for No Bus:vcsa1
[   17.520176] PM: Adding info for No Bus:vcs1
[   17.520191] PM: Adding info for No Bus:vcsa1
[   24.809671] e1000e 0000:00:19.0: irq 28 for MSI/MSI-X
[   24.864190] e1000e 0000:00:19.0: irq 28 for MSI/MSI-X
[   25.068058] kvm: disabled by bios
[   32.870637] iwlagn 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   32.870799] iwlagn 0000:06:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[   32.870911] iwlagn 0000:06:00.0: irq 30 for MSI/MSI-X
[   32.870995] iwlagn 0000:06:00.0: firmware: requesting iwlwifi-5000-1.ucode
[   32.871105] PM: Adding info for No Bus:0000:06:00.0
[   32.994652] PM: Removing info for No Bus:0000:06:00.0
[   32.994741] iwlagn loaded firmware version 5.4.1.16
[   33.155151] PM: Adding info for No Bus:iwl-phy0:radio
[   33.155196] Registered led device: iwl-phy0:radio
[   33.155283] PM: Adding info for No Bus:iwl-phy0:assoc
[   33.155303] Registered led device: iwl-phy0:assoc
[   33.155383] PM: Adding info for No Bus:iwl-phy0:RX
[   33.155402] Registered led device: iwl-phy0:RX
[   33.155487] PM: Adding info for No Bus:iwl-phy0:TX
[   33.155506] Registered led device: iwl-phy0:TX
[   35.027277] PM: Removing info for No Bus:iwl-phy0:assoc
[   35.027314] PM: Removing info for No Bus:iwl-phy0:RX
[   35.027335] PM: Removing info for No Bus:iwl-phy0:TX
[   35.027353] PM: Removing info for No Bus:iwl-phy0:radio
[   35.037665] iwlagn 0000:06:00.0: PCI INT A disabled
[   35.097277] warning: `ntpd' uses 32-bit capabilities (legacy support in use)
[   35.386268] iwlagn 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   35.386438] iwlagn 0000:06:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[   35.386549] iwlagn 0000:06:00.0: irq 30 for MSI/MSI-X
[   35.416000] PM: Adding info for No Bus:iwl-phy0:radio
[   35.416698] Registered led device: iwl-phy0:radio
[   35.416795] PM: Adding info for No Bus:iwl-phy0:assoc
[   35.416824] Registered led device: iwl-phy0:assoc
[   35.416908] PM: Adding info for No Bus:iwl-phy0:RX
[   35.416929] Registered led device: iwl-phy0:RX
[   35.418223] PM: Adding info for No Bus:iwl-phy0:TX
[   35.418248] Registered led device: iwl-phy0:TX
[   36.457697] wlan0: direct probe to AP 00:18:9b:71:22:da try 1
[   36.458099] wlan0: direct probe to AP 00:18:9b:71:22:da try 1
[   36.462982] wlan0 direct probe responded
[   36.462985] wlan0: authenticate with AP 00:18:9b:71:22:da
[   36.466817] wlan0: authenticated
[   36.466819] wlan0: associate with AP 00:18:9b:71:22:da
[   36.470314] wlan0: RX AssocResp from 00:18:9b:71:22:da (capab=0x11 status=0 aid=3)
[   36.470318] wlan0: associated
[   37.363458] Bluetooth: L2CAP ver 2.11
[   37.363528] Bluetooth: L2CAP socket layer initialized
[   37.428368] Bluetooth: RFCOMM socket layer initialized
[   37.428456] Bluetooth: RFCOMM TTY layer initialized
[   37.428522] Bluetooth: RFCOMM ver 1.10
[   37.984597] PM: Adding info for No Bus:vcs7
[   37.984654] PM: Adding info for No Bus:vcsa7
[   38.196903] PM: Removing info for No Bus:vcs7
[   38.197001] PM: Removing info for No Bus:vcsa7
[   38.293106] PM: Adding info for No Bus:vcs7
[   38.293180] PM: Adding info for No Bus:vcsa7
[   42.929065] PM: Adding info for No Bus:vcs4
[   42.929124] PM: Adding info for No Bus:vcsa4
[   42.930250] PM: Adding info for No Bus:vcs3
[   42.930291] PM: Adding info for No Bus:vcsa3
[   42.931533] PM: Adding info for No Bus:vcs2
[   42.931573] PM: Adding info for No Bus:vcsa2
[   42.932150] PM: Adding info for No Bus:vcs5
[   42.932191] PM: Adding info for No Bus:vcsa5
[   42.932488] PM: Adding info for No Bus:vcs6
[   42.932527] PM: Adding info for No Bus:vcsa6

--xHFwDpU9dbj6ez1V--
