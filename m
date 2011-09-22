From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Thu, 22 Sep 2011 20:17:32 +0200
Message-ID: <4E7B7BBC.2080303@schinagl.nl>
References: <bug-42502-20552@https.bugzilla.kernel.org/> <201109072200.p87M0G5V011358@demeter1.kernel.org> <4E6805A7.7080806@schinagl.nl> <CAErSpo6iD443d1XRBdCxYFeAQeL=zAPGbW+S16w7fbY-CPwguA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010205010903000702080703"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:50287 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab1IVSRp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Sep 2011 14:17:45 -0400
Received: from localhost (7of9.schinagl.nl [127.0.0.1])
	by 7of9.are-b.org (Postfix) with ESMTP id 1E709E3EF
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 20:17:44 +0200 (CEST)
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Tl-tkcHvbmTL for <linux-acpi@vger.kernel.org>;
	Thu, 22 Sep 2011 20:17:35 +0200 (CEST)
Received: from [10.2.0.242] (unknown [10.2.0.242])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 78327E5AE
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 20:17:35 +0200 (CEST)
In-Reply-To: <CAErSpo6iD443d1XRBdCxYFeAQeL=zAPGbW+S16w7fbY-CPwguA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205010903000702080703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've tried mailing this to the list several times, but never got an 
answer. I re-subscribed today so hopefully it works this time around.

this is only the 64bit dmesg, as the list might not like huge messages.

On 09/13/11 19:54, Bjorn Helgaas wrote:
> On Wed, Sep 7, 2011 at 6:00 PM, Oliver Schinagl <oliver@schinagl.nl> wrote:
>> I've uploaded an error log to the bugzilla [1] ...
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=42502
> Hi Oliver,
>
> The kernel.org bugzilla is dead at the moment, so I can't look at your
> logs.  Can you attach them to an email response or put them somewhere
> else where we could get at them?  Just the 32-bit Ubuntu dmesg
> (attachment 71942) and the 64-bit Ubuntu dmesg (71952) should be
> enough to start with.
>
> Bjorn




--------------010205010903000702080703
Content-Type: text/plain;
 name="dmesg_64bit"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg_64bit"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.38-8-generic (buildd@allspice) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #42-Ubuntu SMP Mon Apr 11 03:31:24 UTC 2011 (Ubuntu 2.6.38-8.42-generic 2.6.38.2)
[    0.000000] Command line: tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=true vga=normal initrd=/images/ubuntu/11.04/mini-iso/64bit/initrd.gz -- quiet BOOT_IMAGE=/images/ubuntu/11.04/mini-iso/64bit/linux 
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bd94d000 (usable)
[    0.000000]  BIOS-e820: 00000000bd94d000 - 00000000bd99c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bd99c000 - 00000000bd9a4000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bd9a4000 - 00000000bdadc000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdadc000 - 00000000bdaed000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdaed000 - 00000000bdb00000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb00000 - 00000000bdb02000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdb02000 - 00000000bdb0b000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb0b000 - 00000000bdb11000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdb11000 - 00000000bdb70000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb70000 - 00000000bdd73000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdd73000 - 00000000bdf00000 (usable)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec10000 - 00000000fec11000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec20000 - 00000000fec21000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed61000 - 00000000fed71000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed80000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fef00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100001000 - 0000000240000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0503 05/30/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x240000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-D0FFF write-protect
[    0.000000]   D1000-EBFFF uncachable
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF00000000 write-back
[    0.000000]   1 base 0000BDF00000 mask FFFFFFF00000 uncachable
[    0.000000]   2 base 0000BE000000 mask FFFFFE000000 uncachable
[    0.000000]   3 base 0000C0000000 mask FFFFC0000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000240000000 aka 9216M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000bdf00000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xbdf00 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000bdf00000
[    0.000000]  0000000000 - 0080000000 page 1G
[    0.000000]  0080000000 - 00bde00000 page 2M
[    0.000000]  00bde00000 - 00bdf00000 page 4k
[    0.000000] kernel direct mapping tables up to bdf00000 @ 1fffd000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-0000000240000000
[    0.000000]  0100000000 - 0240000000 page 1G
[    0.000000] kernel direct mapping tables up to 240000000 @ bdeff000-bdf00000
[    0.000000] RAMDISK: 7f738000 - 80000000
[    0.000000] ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000bd99c068 0004C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000bd9a2a68 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110112/tbfadt-557)
[    0.000000] ACPI: DSDT 00000000bd99c140 06924 (v02 ALASKA    A M I 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000bdb0bf80 00040
[    0.000000] ACPI: APIC 00000000bd9a2b60 0009E (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000bd9a2c00 0003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 00000000bd9a2c40 00038 (v01 ALASKA    A M I 01072009 AMI  00000004)
[    0.000000] ACPI: SSDT 00000000bd9a2c78 00DDA (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000240000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000240000000
[    0.000000]   NODE_DATA [000000023fffb000 - 000000023fffffff]
[    0.000000]  [ffffea0000000000-ffffea0007dfffff] PMD -> [ffff880237e00000-ffff88023edfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00240000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000bd94d
[    0.000000]     0: 0x000bdd73 -> 0x000bdf00
[    0.000000]     0: 0x00100001 -> 0x00240000
[    0.000000] On node 0 totalpages: 2087526
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 7 pages reserved
[    0.000000]   DMA zone: 3918 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 758546 pages, LIFO batch:31
[    0.000000]   Normal zone: 17920 pages used for memmap
[    0.000000]   Normal zone: 1292799 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x07] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 7, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec20000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 8, version 33, address 0xfec20000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 72
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bd94d000 - 00000000bd99c000
[    0.000000] PM: Registered nosave memory: 00000000bd99c000 - 00000000bd9a4000
[    0.000000] PM: Registered nosave memory: 00000000bd9a4000 - 00000000bdadc000
[    0.000000] PM: Registered nosave memory: 00000000bdadc000 - 00000000bdaed000
[    0.000000] PM: Registered nosave memory: 00000000bdaed000 - 00000000bdb00000
[    0.000000] PM: Registered nosave memory: 00000000bdb00000 - 00000000bdb02000
[    0.000000] PM: Registered nosave memory: 00000000bdb02000 - 00000000bdb0b000
[    0.000000] PM: Registered nosave memory: 00000000bdb0b000 - 00000000bdb11000
[    0.000000] PM: Registered nosave memory: 00000000bdb11000 - 00000000bdb70000
[    0.000000] PM: Registered nosave memory: 00000000bdb70000 - 00000000bdd73000
[    0.000000] PM: Registered nosave memory: 00000000bdf00000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fec10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fec11000
[    0.000000] PM: Registered nosave memory: 00000000fec11000 - 00000000fec20000
[    0.000000] PM: Registered nosave memory: 00000000fec20000 - 00000000fec21000
[    0.000000] PM: Registered nosave memory: 00000000fec21000 - 00000000fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed01000
[    0.000000] PM: Registered nosave memory: 00000000fed01000 - 00000000fed61000
[    0.000000] PM: Registered nosave memory: 00000000fed61000 - 00000000fed71000
[    0.000000] PM: Registered nosave memory: 00000000fed71000 - 00000000fed80000
[    0.000000] PM: Registered nosave memory: 00000000fed80000 - 00000000fed90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 00000000fef00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 0000000100000000
[    0.000000] PM: Registered nosave memory: 0000000100000000 - 0000000100001000
[    0.000000] Allocating PCI resources starting at bdf00000 (gap: bdf00000:3a100000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff8800bd600000 s84416 r8192 d22080 u262144
[    0.000000] pcpu-alloc: s84416 r8192 d22080 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2055263
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=true vga=normal initrd=/images/ubuntu/11.04/mini-iso/64bit/initrd.gz -- quiet BOOT_IMAGE=/images/ubuntu/11.04/mini-iso/64bit/linux 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ f8000000 size 64 MB
[    0.000000] Memory: 8145952k/9437184k available (5940k kernel code, 1087080k absent, 204152k reserved, 5017k data, 956k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] NR_IRQS:16640 nr_irqs:1288 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 83886080 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3211.088 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 6422.17 BogoMIPS (lpj=32110880)
[    0.000006] pid_max: default: 32768 minimum: 301
[    0.000021] Security Framework initialized
[    0.000031] AppArmor: AppArmor initialized
[    0.000032] Yama: becoming mindful.
[    0.000528] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.011768] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.012633] Mount-cache hash table entries: 256
[    0.012721] Initializing cgroup subsys ns
[    0.012723] ns_cgroup deprecated: consider using the 'clone_children' flag without the ns_cgroup.
[    0.012725] Initializing cgroup subsys cpuacct
[    0.012728] Initializing cgroup subsys memory
[    0.012734] Initializing cgroup subsys devices
[    0.012736] Initializing cgroup subsys freezer
[    0.012737] Initializing cgroup subsys net_cls
[    0.012738] Initializing cgroup subsys blkio
[    0.012760] tseg: 00bdf00000
[    0.012762] CPU: Physical Processor ID: 0
[    0.012763] CPU: Processor Core ID: 0
[    0.012764] mce: CPU supports 6 MCE banks
[    0.012771] using C1E aware idle routine
[    0.013856] ACPI: Core revision 20110112
[    0.020017] ftrace: allocating 24314 entries in 96 pages
[    0.030055] Setting APIC routing to flat
[    0.030353] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.130957] CPU0: AMD Phenom(tm) II X6 1090T Processor stepping 00
[    0.140000] Performance Events: AMD PMU driver.
[    0.140000] ... version:                0
[    0.140000] ... bit width:              48
[    0.140000] ... generic registers:      4
[    0.140000] ... value mask:             0000ffffffffffff
[    0.140000] ... max period:             00007fffffffffff
[    0.140000] ... fixed-purpose events:   0
[    0.140000] ... event mask:             000000000000000f
[    0.140000] Booting Node   0, Processors  #1
[    0.300011] System has AMD C1E enabled
[    0.300022] Switch to broadcast mode on CPU1
[    0.300047]  #2
[    0.470014] Switch to broadcast mode on CPU2
[    0.470052]  #3
[    0.640029] Switch to broadcast mode on CPU3
[    0.640070]  #4
[    0.810026] Switch to broadcast mode on CPU4
[    0.810076]  #5
[    0.980030] Brought up 6 CPUs
[    0.980039] Total of 6 processors activated (38530.17 BogoMIPS).
[    0.980018] Switch to broadcast mode on CPU5
[    0.982940] Switch to broadcast mode on CPU0
[    0.982940] devtmpfs: initialized
[    0.982940] print_constraints: dummy: 
[    0.982940] Time: 23:05:30  Date: 09/07/11
[    0.982940] NET: Registered protocol family 16
[    0.982940] node 0 link 0: io port [d000, ffff]
[    0.982940] TOM: 00000000c0000000 aka 3072M
[    0.982940] Fam 10h mmconf [e0000000, efffffff]
[    0.982940] node 0 link 0: mmio [c0000000, fef0ffff] ==> [c0000000, dfffffff] and [f0000000, fef0ffff]
[    0.982940] TOM2: 0000000240000000 aka 9216M
[    0.982940] bus: [00, 1f] on node 0 link 0
[    0.982940] bus: 00 index 0 [io  0x0000-0xffff]
[    0.982940] bus: 00 index 1 [mem 0xc0000000-0xdfffffff]
[    0.982940] bus: 00 index 2 [mem 0xf0000000-0xffffffff]
[    0.982940] bus: 00 index 3 [mem 0x240000000-0xfcffffffff]
[    0.982940] Extended Config Space enabled on 1 nodes
[    0.982940] Trying to unpack rootfs image as initramfs...
[    0.982940] ACPI: bus type pci registered
[    0.982940] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.982940] PCI: not using MMCONFIG
[    0.982940] PCI: Using configuration type 1 for base access
[    0.982940] PCI: Using configuration type 1 for extended access
[    0.982940] bio: create slab <bio-0> at 0
[    0.982940] ACPI: EC: Look up EC in DSDT
[    0.982940] ACPI: Executed 3 blocks of module-level executable AML code
[    0.982940] ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
[    0.982940] ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region) (20110112/nsinit-349)
[    1.070297] ACPI: Interpreter enabled
[    1.070301] ACPI: (supports S0 S1 S3 S4 S5)
[    1.070316] ACPI: Using IOAPIC for interrupt routing
[    1.070423] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    1.070450] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    1.093630] ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
[    1.092880] Freeing initrd memory: 8992k freed
[    1.130079] ACPI: No dock devices found.
[    1.130082] HEST: Table not found.
[    1.130085] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.130231] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.130404] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    1.130406] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    1.130408] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    1.130409] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    1.130411] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.130413] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
[    1.130414] pci_root PNP0A03:00: host bridge window [mem 0xc0000000-0xffffffff]
[    1.130428] pci 0000:00:00.0: [1002:5a14] type 0 class 0x000600
[    1.130471] pci 0000:00:02.0: [1002:5a16] type 1 class 0x000604
[    1.130493] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.130495] pci 0000:00:02.0: PME# disabled
[    1.130507] pci 0000:00:04.0: [1002:5a18] type 1 class 0x000604
[    1.130528] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    1.130530] pci 0000:00:04.0: PME# disabled
[    1.130541] pci 0000:00:07.0: [1002:5a1b] type 1 class 0x000604
[    1.130561] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.130563] pci 0000:00:07.0: PME# disabled
[    1.130587] pci 0000:00:11.0: [1002:4391] type 0 class 0x000106
[    1.130602] pci 0000:00:11.0: reg 10: [io  0xf040-0xf047]
[    1.130610] pci 0000:00:11.0: reg 14: [io  0xf030-0xf033]
[    1.130627] pci 0000:00:11.0: reg 18: [io  0xf020-0xf027]
[    1.130634] pci 0000:00:11.0: reg 1c: [io  0xf010-0xf013]
[    1.130642] pci 0000:00:11.0: reg 20: [io  0xf000-0xf00f]
[    1.130649] pci 0000:00:11.0: reg 24: [mem 0xfeb0b000-0xfeb0b3ff]
[    1.130686] pci 0000:00:12.0: [1002:4397] type 0 class 0x000c03
[    1.130696] pci 0000:00:12.0: reg 10: [mem 0xfeb0a000-0xfeb0afff]
[    1.130751] pci 0000:00:12.2: [1002:4396] type 0 class 0x000c03
[    1.130766] pci 0000:00:12.2: reg 10: [mem 0xfeb09000-0xfeb090ff]
[    1.130822] pci 0000:00:12.2: supports D1 D2
[    1.130823] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    1.130826] pci 0000:00:12.2: PME# disabled
[    1.130842] pci 0000:00:13.0: [1002:4397] type 0 class 0x000c03
[    1.130852] pci 0000:00:13.0: reg 10: [mem 0xfeb08000-0xfeb08fff]
[    1.130909] pci 0000:00:13.2: [1002:4396] type 0 class 0x000c03
[    1.130924] pci 0000:00:13.2: reg 10: [mem 0xfeb07000-0xfeb070ff]
[    1.130979] pci 0000:00:13.2: supports D1 D2
[    1.130980] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    1.130983] pci 0000:00:13.2: PME# disabled
[    1.130999] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
[    1.131060] pci 0000:00:14.2: [1002:4383] type 0 class 0x000403
[    1.131077] pci 0000:00:14.2: reg 10: [mem 0xfeb00000-0xfeb03fff 64bit]
[    1.131122] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    1.131125] pci 0000:00:14.2: PME# disabled
[    1.131135] pci 0000:00:14.3: [1002:439d] type 0 class 0x000601
[    1.131194] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
[    1.131225] pci 0000:00:14.5: [1002:4399] type 0 class 0x000c03
[    1.131236] pci 0000:00:14.5: reg 10: [mem 0xfeb06000-0xfeb06fff]
[    1.131288] pci 0000:00:16.0: [1002:4397] type 0 class 0x000c03
[    1.131298] pci 0000:00:16.0: reg 10: [mem 0xfeb05000-0xfeb05fff]
[    1.131353] pci 0000:00:16.2: [1002:4396] type 0 class 0x000c03
[    1.131368] pci 0000:00:16.2: reg 10: [mem 0xfeb04000-0xfeb040ff]
[    1.131423] pci 0000:00:16.2: supports D1 D2
[    1.131425] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    1.131427] pci 0000:00:16.2: PME# disabled
[    1.131443] pci 0000:00:18.0: [1022:1200] type 0 class 0x000600
[    1.131454] pci 0000:00:18.1: [1022:1201] type 0 class 0x000600
[    1.131463] pci 0000:00:18.2: [1022:1202] type 0 class 0x000600
[    1.131472] pci 0000:00:18.3: [1022:1203] type 0 class 0x000600
[    1.131482] pci 0000:00:18.4: [1022:1204] type 0 class 0x000600
[    1.131521] pci 0000:01:00.0: [1002:6758] type 0 class 0x000300
[    1.131534] pci 0000:01:00.0: reg 10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.131544] pci 0000:01:00.0: reg 18: [mem 0xfea20000-0xfea3ffff 64bit]
[    1.131550] pci 0000:01:00.0: reg 20: [io  0xe000-0xe0ff]
[    1.131562] pci 0000:01:00.0: reg 30: [mem 0xfea00000-0xfea1ffff pref]
[    1.131579] pci 0000:01:00.0: supports D1 D2
[    1.131598] pci 0000:01:00.1: [1002:aa90] type 0 class 0x000403
[    1.131610] pci 0000:01:00.1: reg 10: [mem 0xfea40000-0xfea43fff 64bit]
[    1.131653] pci 0000:01:00.1: supports D1 D2
[    1.150022] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    1.150026] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    1.150029] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    1.150032] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.150065] pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
[    1.150077] pci 0000:02:00.0: reg 10: [io  0xd000-0xd0ff]
[    1.150095] pci 0000:02:00.0: reg 18: [mem 0xd0004000-0xd0004fff 64bit pref]
[    1.150107] pci 0000:02:00.0: reg 20: [mem 0xd0000000-0xd0003fff 64bit pref]
[    1.150139] pci 0000:02:00.0: supports D1 D2
[    1.150141] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.150144] pci 0000:02:00.0: PME# disabled
[    1.170022] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    1.170026] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    1.170028] pci 0000:00:04.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.170031] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    1.170070] pci 0000:03:00.0: [1b21:1042] type 0 class 0x000c03
[    1.170088] pci 0000:03:00.0: reg 10: [mem 0xfe900000-0xfe907fff 64bit]
[    1.170157] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    1.170161] pci 0000:03:00.0: PME# disabled
[    1.190022] pci 0000:00:07.0: PCI bridge to [bus 03-03]
[    1.190026] pci 0000:00:07.0:   bridge window [io  0xfff000-0x0000] (disabled)
[    1.190028] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    1.190031] pci 0000:00:07.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.190085] pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive decode)
[    1.190089] pci 0000:00:14.4:   bridge window [io  0xf000-0x0000] (disabled)
[    1.190092] pci 0000:00:14.4:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.190096] pci 0000:00:14.4:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.190098] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    1.190099] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    1.190101] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    1.190102] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    1.190104] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.190106] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    1.190107] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff] (subtractive decode)
[    1.190120] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.190202] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    1.190249] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC02._PRT]
[    1.190267] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC04._PRT]
[    1.190286] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC07._PRT]
[    1.190309]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.193020] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    1.193062] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    1.193102] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    1.193141] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 10 11 14 15) *0
[    1.193172] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    1.193195] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    1.193218] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    1.193240] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    1.193308] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.193310] vgaarb: loaded
[    1.193409] SCSI subsystem initialized
[    1.193429] libata version 3.00 loaded.
[    1.193429] usbcore: registered new interface driver usbfs
[    1.193429] usbcore: registered new interface driver hub
[    1.193429] usbcore: registered new device driver usb
[    1.193429] wmi: Mapper loaded
[    1.193429] PCI: Using ACPI for IRQ routing
[    1.193429] PCI: pci_cache_line_size set to 64 bytes
[    1.193429] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    1.193429] reserve RAM buffer: 00000000bd94d000 - 00000000bfffffff 
[    1.193429] reserve RAM buffer: 00000000bdf00000 - 00000000bfffffff 
[    1.193429] NetLabel: Initializing
[    1.193429] NetLabel:  domain hash size = 128
[    1.193429] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.193429] NetLabel:  unlabeled traffic allowed by default
[    1.193429] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.193429] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.193429] Switching to clocksource hpet
[    1.196208] AppArmor: AppArmor Filesystem Enabled
[    1.196223] pnp: PnP ACPI init
[    1.196232] ACPI: bus type pnp registered
[    1.196327] pnp 00:00: [bus 00-ff]
[    1.196332] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.196336] pnp 00:00: [io  0x0000-0x03af window]
[    1.196337] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    1.196338] pnp 00:00: [io  0x03b0-0x03df window]
[    1.196340] pnp 00:00: [io  0x0d00-0xffff window]
[    1.196341] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.196343] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    1.196343] Switched to NOHz mode on CPU #0
[    1.194094] Switched to NOHz mode on CPU #5
[    1.196343] pnp 00:00: [mem 0xc0000000-0xffffffff window]
[    1.194099] Switched to NOHz mode on CPU #1
[    1.196343] pnp 00:00: [mem 0x00000000 window]
[    1.194105] Switched to NOHz mode on CPU #3
[    1.194109] Switched to NOHz mode on CPU #4
[    1.194112] Switched to NOHz mode on CPU #2
[    1.196343] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    1.196343] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    1.196343] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    1.196343] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.196343] pnp 00:02: [io  0x040b]
[    1.196343] pnp 00:02: [io  0x04d6]
[    1.196343] pnp 00:02: [io  0x0c00-0x0c01]
[    1.196343] pnp 00:02: [io  0x0c14]
[    1.196343] pnp 00:02: [io  0x0c50-0x0c51]
[    1.196343] pnp 00:02: [io  0x0c52]
[    1.196343] pnp 00:02: [io  0x0c6c]
[    1.196343] pnp 00:02: [io  0x0c6f]
[    1.196343] pnp 00:02: [io  0x0cd0-0x0cd1]
[    1.196343] pnp 00:02: [io  0x0cd2-0x0cd3]
[    1.196343] pnp 00:02: [io  0x0cd4-0x0cd5]
[    1.196343] pnp 00:02: [io  0x0cd6-0x0cd7]
[    1.196343] pnp 00:02: [io  0x0cd8-0x0cdf]
[    1.196343] pnp 00:02: [io  0x0800-0x089f]
[    1.196343] pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
[    1.196343] pnp 00:02: [io  0x0000-0x000f]
[    1.196343] pnp 00:02: [io  0x0b20-0x0b3f]
[    1.196343] pnp 00:02: [io  0x0900-0x090f]
[    1.196343] pnp 00:02: [io  0x0910-0x091f]
[    1.196343] pnp 00:02: [io  0xfe00-0xfefe]
[    1.196343] pnp 00:02: [io  0x0060-0x005f disabled]
[    1.196343] pnp 00:02: [io  0x0064-0x0063 disabled]
[    1.196343] pnp 00:02: [mem 0xfec00000-0xfec00fff]
[    1.196343] pnp 00:02: [mem 0xfee00000-0xfee00fff]
[    1.196343] pnp 00:02: [mem 0xfed80000-0xfed8ffff]
[    1.196343] pnp 00:02: [mem 0xfed61000-0xfed70fff]
[    1.196343] pnp 00:02: [mem 0xfec10000-0xfec10fff]
[    1.196343] pnp 00:02: [mem 0xfed00000-0xfed00fff]
[    1.196343] pnp 00:02: [mem 0xffc00000-0xffffffff]
[    1.196343] system 00:02: [io  0x040b] has been reserved
[    1.196343] system 00:02: [io  0x04d6] has been reserved
[    1.196343] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    1.196343] system 00:02: [io  0x0c14] has been reserved
[    1.196343] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    1.196343] system 00:02: [io  0x0c52] has been reserved
[    1.196343] system 00:02: [io  0x0c6c] has been reserved
[    1.196343] system 00:02: [io  0x0c6f] has been reserved
[    1.196343] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    1.196343] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    1.196343] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    1.196343] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    1.196343] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    1.196343] system 00:02: [io  0x0800-0x089f] has been reserved
[    1.196343] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    1.196343] system 00:02: [io  0x0900-0x090f] has been reserved
[    1.196343] system 00:02: [io  0x0910-0x091f] has been reserved
[    1.196343] system 00:02: [io  0xfe00-0xfefe] has been reserved
[    1.196343] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.196343] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.196343] system 00:02: [mem 0xfed80000-0xfed8ffff] has been reserved
[    1.196343] system 00:02: [mem 0xfed61000-0xfed70fff] has been reserved
[    1.196343] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserved
[    1.196343] system 00:02: [mem 0xfed00000-0xfed00fff] has been reserved
[    1.196343] system 00:02: [mem 0xffc00000-0xffffffff] has been reserved
[    1.196343] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.196343] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    1.196343] pnp 00:03: [io  0x0290-0x02af]
[    1.196343] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    1.196343] system 00:03: [io  0x0290-0x02af] has been reserved
[    1.196343] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.196343] pnp 00:04: [dma 4]
[    1.196343] pnp 00:04: [io  0x0000-0x000f]
[    1.196343] pnp 00:04: [io  0x0081-0x0083]
[    1.196343] pnp 00:04: [io  0x0087]
[    1.196343] pnp 00:04: [io  0x0089-0x008b]
[    1.196343] pnp 00:04: [io  0x008f]
[    1.196343] pnp 00:04: [io  0x00c0-0x00df]
[    1.196343] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.196343] pnp 00:05: [io  0x0070-0x0071]
[    1.196343] pnp 00:05: [irq 8]
[    1.196343] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.196343] pnp 00:06: [io  0x0061]
[    1.196343] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    1.196343] pnp 00:07: [io  0x0010-0x001f]
[    1.196343] pnp 00:07: [io  0x0022-0x003f]
[    1.196343] pnp 00:07: [io  0x0044-0x005f]
[    1.196343] pnp 00:07: [io  0x0062-0x0063]
[    1.196343] pnp 00:07: [io  0x0065-0x006f]
[    1.196343] pnp 00:07: [io  0x0072-0x007f]
[    1.196343] pnp 00:07: [io  0x0080]
[    1.196343] pnp 00:07: [io  0x0084-0x0086]
[    1.196343] pnp 00:07: [io  0x0088]
[    1.196343] pnp 00:07: [io  0x008c-0x008e]
[    1.196343] pnp 00:07: [io  0x0090-0x009f]
[    1.196343] pnp 00:07: [io  0x00a2-0x00bf]
[    1.196343] pnp 00:07: [io  0x00e0-0x00ef]
[    1.196343] pnp 00:07: [io  0x04d0-0x04d1]
[    1.196343] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    1.196343] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.196343] pnp 00:08: [io  0x00f0-0x00ff]
[    1.196343] pnp 00:08: [irq 13]
[    1.196343] pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.196343] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.196343] pnp 00:0a: [io  0x0060]
[    1.196343] pnp 00:0a: [io  0x0064]
[    1.196343] pnp 00:0a: [irq 1]
[    1.196343] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    1.196343] pnp 00:0b: [irq 12]
[    1.196343] pnp 00:0b: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    1.196343] pnp 00:0c: [io  0x03f8-0x03ff]
[    1.196343] pnp 00:0c: [irq 4]
[    1.196343] pnp 00:0c: [dma 0 disabled]
[    1.196343] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.196343] pnp 00:0d: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.196343] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.196343] pnp 00:0e: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.196343] pnp 00:0e: [mem 0xfec20000-0xfec200ff]
[    1.196343] system 00:0e: [mem 0xfec20000-0xfec200ff] could not be reserved
[    1.196343] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.196343] pnp 00:0f: [mem 0xfed00000-0xfed003ff]
[    1.196343] pnp 00:0f: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.196343] pnp: PnP ACPI: found 16 devices
[    1.196343] ACPI: ACPI bus type pnp unregistered
[    1.200781] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    1.200783] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    1.200785] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    1.200787] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.200790] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    1.200791] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    1.200794] pci 0000:00:04.0:   bridge window [mem disabled]
[    1.200795] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    1.200798] pci 0000:00:07.0: PCI bridge to [bus 03-03]
[    1.200799] pci 0000:00:07.0:   bridge window [io  disabled]
[    1.200801] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    1.200803] pci 0000:00:07.0:   bridge window [mem pref disabled]
[    1.200805] pci 0000:00:14.4: PCI bridge to [bus 04-04]
[    1.200806] pci 0000:00:14.4:   bridge window [io  disabled]
[    1.200810] pci 0000:00:14.4:   bridge window [mem disabled]
[    1.200813] pci 0000:00:14.4:   bridge window [mem pref disabled]
[    1.200827] pci 0000:00:02.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
[    1.200829] pci 0000:00:02.0: setting latency timer to 64
[    1.200832] pci 0000:00:04.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
[    1.200834] pci 0000:00:04.0: setting latency timer to 64
[    1.200839] pci 0000:00:07.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
[    1.200841] pci 0000:00:07.0: setting latency timer to 64
[    1.200847] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    1.200848] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    1.200849] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    1.200850] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    1.200852] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    1.200853] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    1.200855] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff]
[    1.200856] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    1.200857] pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
[    1.200859] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.200860] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    1.200862] pci_bus 0000:02: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
[    1.200863] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    1.200865] pci_bus 0000:04: resource 4 [io  0x0000-0x03af]
[    1.200866] pci_bus 0000:04: resource 5 [io  0x03e0-0x0cf7]
[    1.200868] pci_bus 0000:04: resource 6 [io  0x03b0-0x03df]
[    1.200869] pci_bus 0000:04: resource 7 [io  0x0d00-0xffff]
[    1.200870] pci_bus 0000:04: resource 8 [mem 0x000a0000-0x000bffff]
[    1.200872] pci_bus 0000:04: resource 9 [mem 0x000c0000-0x000dffff]
[    1.200873] pci_bus 0000:04: resource 10 [mem 0xc0000000-0xffffffff]
[    1.200894] NET: Registered protocol family 2
[    1.201041] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.201986] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.203785] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.204004] TCP: Hash tables configured (established 524288 bind 65536)
[    1.204005] TCP reno registered
[    1.204015] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.204056] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.204158] NET: Registered protocol family 1
[    1.204384] pci 0000:01:00.0: Boot video device
[    1.204419] PCI: CLS 64 bytes, default 64
[    1.205622] PCI-DMA: Disabling AGP.
[    1.207886] PCI-DMA: aperture base @ f8000000 size 65536 KB
[    1.207888] init_memory_mapping: 00000000f8000000-00000000fc000000
[    1.207891]  00f8000000 - 00fc000000 page 2M
[    1.207896] PCI-DMA: using GART IOMMU.
[    1.207898] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    1.211177] audit: initializing netlink socket (disabled)
[    1.211191] type=2000 audit(1315436729.210:1): initialized
[    1.219338] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.220533] VFS: Disk quotas dquot_6.5.2
[    1.220566] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.220960] fuse init (API version 7.16)
[    1.221007] msgmni has been set to 16056
[    1.221213] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.221242] io scheduler noop registered
[    1.221243] io scheduler deadline registered
[    1.221266] io scheduler cfq registered (default)
[    1.221525] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.221539] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.221629] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    1.410101] ACPI: Power Button [PWRB]
[    1.410148] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.410151] ACPI: Power Button [PWRF]
[    1.410263] ACPI: acpi_idle registered with cpuidle
[    1.410291] ACPI: processor limited to max C-state 1
[    1.411309] ERST: Table is not found!
[    1.411355] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.431901] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.810745] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.810947] Linux agpgart interface v0.103
[    1.811556] brd: module loaded
[    1.811825] loop: module loaded
[    1.811876] i2c-core: driver [adp5520] using legacy suspend method
[    1.811878] i2c-core: driver [adp5520] using legacy resume method
[    1.812088] Fixed MDIO Bus: probed
[    1.812105] PPP generic driver version 2.4.2
[    1.812123] tun: Universal TUN/TAP device driver, 1.6
[    1.812124] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.812169] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.812286] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.812321] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    1.812366] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.880103] ehci_hcd 0000:00:12.2: QUIRK: Enable exception for AMD Hudson ASPM
[    1.880107] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.880128] ehci_hcd 0000:00:12.2: debug port 1
[    1.880146] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfeb09000
[    1.900086] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.900172] hub 1-0:1.0: USB hub found
[    1.900175] hub 1-0:1.0: 5 ports detected
[    1.900332] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.900343] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    1.900370] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.900399] ehci_hcd 0000:00:13.2: QUIRK: Enable exception for AMD Hudson ASPM
[    1.900401] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.900417] ehci_hcd 0000:00:13.2: debug port 1
[    1.900428] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
[    1.920084] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.920159] hub 2-0:1.0: USB hub found
[    1.920163] hub 2-0:1.0: 5 ports detected
[    1.920295] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.920306] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    1.920331] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.920358] ehci_hcd 0000:00:16.2: QUIRK: Enable exception for AMD Hudson ASPM
[    1.920361] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.920377] ehci_hcd 0000:00:16.2: debug port 1
[    1.920387] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
[    1.940084] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.940167] hub 3-0:1.0: USB hub found
[    1.940170] hub 3-0:1.0: 4 ports detected
[    1.940242] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.940331] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.940341] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    1.940368] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
[    1.940407] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
[    2.004173] hub 4-0:1.0: USB hub found
[    2.004179] hub 4-0:1.0: 5 ports detected
[    2.004332] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    2.004343] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    2.004368] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
[    2.004400] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
[    2.064155] hub 5-0:1.0: USB hub found
[    2.064160] hub 5-0:1.0: 5 ports detected
[    2.064318] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.064329] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    2.064359] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
[    2.064391] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
[    2.124157] hub 6-0:1.0: USB hub found
[    2.124162] hub 6-0:1.0: 2 ports detected
[    2.124313] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    2.124324] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    2.124350] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
[    2.124382] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
[    2.184154] hub 7-0:1.0: USB hub found
[    2.184159] hub 7-0:1.0: 4 ports detected
[    2.184239] uhci_hcd: USB Universal Host Controller Interface driver
[    2.210091] Refined TSC clocksource calibration: 3210.781 MHz.
[    2.210094] Switching to clocksource tsc
[    2.270106] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    2.270449] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.270455] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.270571] mousedev: PS/2 mouse device common for all mice
[    2.270651] rtc_cmos 00:05: RTC can wake from S4
[    2.291111] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    2.360107] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.360128] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.360198] device-mapper: uevent: version 1.0.3
[    2.360241] device-mapper: ioctl: 4.19.1-ioctl (2011-01-07) initialised: dm-devel@redhat.com
[    2.360328] device-mapper: multipath: version 1.2.0 loaded
[    2.360330] device-mapper: multipath round-robin: version 1.0.0 loaded
[    2.360407] cpuidle: using governor ladder
[    2.360408] cpuidle: using governor menu
[    2.360563] TCP cubic registered
[    2.360636] NET: Registered protocol family 10
[    2.360961] NET: Registered protocol family 17
[    2.360970] Registering the dns_resolver key type
[    2.361028] powernow-k8: Found 1 AMD Phenom(tm) II X6 1090T Processor (6 cpu cores) (version 2.20.00)
[    2.361035] powernow-k8: Core Performance Boosting: on.
[    2.361065] powernow-k8:    0 : pstate 0 (3200 MHz)
[    2.361067] powernow-k8:    1 : pstate 1 (2400 MHz)
[    2.361068] powernow-k8:    2 : pstate 2 (1600 MHz)
[    2.361069] powernow-k8:    3 : pstate 3 (800 MHz)
[    2.361477] PM: Hibernation image not present or could not be loaded.
[    2.361484] registered taskstats version 1
[    2.361672]   Magic number: 11:497:99
[    2.361726] rtc_cmos 00:05: setting system clock to 2011-09-07 23:05:31 UTC (1315436731)
[    2.361729] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.361730] EDD information not available.
[    2.362857] Freeing unused kernel memory: 956k freed
[    2.363032] Write protecting the kernel read-only data: 10240k
[    2.363605] Freeing unused kernel memory: 184k freed
[    2.366792] Freeing unused kernel memory: 1444k freed
[    2.385410] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.385436] r8169 0000:02:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
[    2.385475] r8169 0000:02:00.0: setting latency timer to 64
[    2.385480] r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
[    2.385530] r8169 0000:02:00.0: irq 72 for MSI/MSI-X
[    2.385896] r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xffffc90011794000, 14:da:e9:03:e9:b7, XID 0c900880 IRQ 72
[    2.832201] vga16fb: initializing
[    2.832204] vga16fb: mapped to 0xffff8800000a0000
[    3.016784] Console: switching to colour frame buffer device 80x30
[    3.019218] fb0: VGA16 VGA frame buffer device
[   78.630082] usb 3-1: new high speed USB device using ehci_hcd and address 2
[   78.750084] usb 3-1: device descriptor read/64, error -32
[   78.980075] usb 3-1: device descriptor read/64, error -32
[   79.210076] usb 3-1: new high speed USB device using ehci_hcd and address 3
[   79.330074] usb 3-1: device descriptor read/64, error -32
[   79.560073] usb 3-1: device descriptor read/64, error -32
[   79.790071] usb 3-1: new high speed USB device using ehci_hcd and address 4
[   80.210087] usb 3-1: device not accepting address 4, error -32
[   80.330074] usb 3-1: new high speed USB device using ehci_hcd and address 5
[   80.750070] usb 3-1: device not accepting address 5, error -32
[   80.750081] hub 3-0:1.0: unable to enumerate USB device on port 1
[   81.160077] usb 7-1: new full speed USB device using ohci_hcd and address 2
[   81.310067] usb 7-1: device descriptor read/64, error -32
[   81.570067] usb 7-1: device descriptor read/64, error -32
[   81.850067] usb 7-1: new full speed USB device using ohci_hcd and address 3
[   82.000069] usb 7-1: device descriptor read/64, error -32
[   82.260069] usb 7-1: device descriptor read/64, error -32
[   82.540080] usb 7-1: new full speed USB device using ohci_hcd and address 4
[   82.960066] usb 7-1: device not accepting address 4, error -32
[   83.130082] usb 7-1: new full speed USB device using ohci_hcd and address 5
[   83.550069] usb 7-1: device not accepting address 5, error -32
[   83.550099] hub 7-0:1.0: unable to enumerate USB device on port 1
[  177.508164] Initializing USB Mass Storage driver...
[  177.508203] usbcore: registered new interface driver usb-storage
[  177.508204] USB Mass Storage support registered.
[  178.780788] r8169 0000:02:00.0: eth0: link down
[  178.780798] r8169 0000:02:00.0: eth0: link down
[  178.781419] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  179.980845] r8169 0000:02:00.0: eth0: link down
[  179.981463] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  183.041036] r8169 0000:02:00.0: eth0: link up
[  183.041636] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  224.180142] r8169 0000:02:00.0: PCI INT A disabled
[  232.432360] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[  232.432375] r8169 0000:02:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
[  232.432409] r8169 0000:02:00.0: setting latency timer to 64
[  232.432415] r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
[  232.432465] r8169 0000:02:00.0: irq 72 for MSI/MSI-X
[  232.432761] r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xffffc90011794000, 14:da:e9:03:e9:b7, XID 0c900800 IRQ 72
[  241.500609] r8169 0000:02:00.0: eth0: link down
[  241.500621] r8169 0000:02:00.0: eth0: link down
[  241.501236] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  245.241944] r8169 0000:02:00.0: eth0: link up
[  245.242491] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  282.778235] usbcore: deregistering interface driver usb-storage
[  286.740023] ahci 0000:00:11.0: version 3.0
[  286.740043] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[  286.740158] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[  286.740161] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[  286.740906] scsi0 : ahci
[  286.741117] scsi1 : ahci
[  286.741171] scsi2 : ahci
[  286.741220] scsi3 : ahci
[  286.741288] scsi4 : ahci
[  286.741407] scsi5 : ahci
[  286.741515] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b100 irq 19
[  286.741517] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b180 irq 19
[  286.741520] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19
[  286.741523] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b280 irq 19
[  286.741525] ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b300 irq 19
[  286.741528] ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b380 irq 19
[  287.090093] ata4: SATA link down (SStatus 0 SControl 300)
[  287.090138] ata6: SATA link down (SStatus 0 SControl 300)
[  287.090184] ata3: SATA link down (SStatus 0 SControl 300)
[  287.290092] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  287.290113] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  287.296002] ata1.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
[  287.296005] ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[  287.297103] ata2.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
[  287.297106] ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[  287.300142] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  287.302003] ata1.00: configured for UDMA/133
[  287.302127] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
[  287.302267] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  287.302300] sd 0:0:0:0: [sda] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[  287.302329] sd 0:0:0:0: [sda] Write Protect is off
[  287.302332] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  287.302343] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  287.305183] ata2.00: configured for UDMA/133
[  287.305308] scsi 1:0:0:0: Direct-Access     ATA      WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
[  287.305424] sd 1:0:0:0: Attached scsi generic sg1 type 0
[  287.305427] sd 1:0:0:0: [sdb] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[  287.305507] sd 1:0:0:0: [sdb] Write Protect is off
[  287.305509] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  287.305539] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  287.313302] ata5.00: ATA-7: HDS725050KLA360, K2AOAH0A, max UDMA/133
[  287.313304] ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[  287.314532] ata5.00: configured for UDMA/133
[  287.314645] scsi 4:0:0:0: Direct-Access     ATA      HDS725050KLA360  K2AO PQ: 0 ANSI: 5
[  287.314750] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  287.314764] sd 4:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[  287.314858] sd 4:0:0:0: [sdc] Write Protect is off
[  287.314860] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  287.314883] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  287.323667]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
[  287.323934] sd 0:0:0:0: [sda] Attached SCSI disk
[  287.330424]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
[  287.330746] sd 1:0:0:0: [sdb] Attached SCSI disk
[  287.358645]  sdc: sdc1 sdc2 sdc4
[  287.358914] sd 4:0:0:0: [sdc] Attached SCSI disk
[  287.799167] Initializing USB Mass Storage driver...
[  287.799206] usbcore: registered new interface driver usb-storage
[  287.799207] USB Mass Storage support registered.
[  290.804535] NTFS driver 2.1.30 [Flags: R/O MODULE].
[  290.815408] Btrfs loaded
[  290.827063] JFS: nTxBlock = 8192, nTxLock = 65536
[  290.847163] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[  290.847791] SGI XFS Quota Management subsystem
[  290.991709] md: md0 stopped.
[  290.992167] md: bind<sdb3>
[  290.992240] md: bind<sda3>
[  290.994146] md: raid1 personality registered for level 1
[  290.994315] bio: create slab <bio-1> at 1
[  290.994370] md/raid1:md0: active with 2 out of 2 mirrors
[  290.994384] md0: detected capacity change from 0 to 1090453504
[  290.995239]  md0: unknown partition table
[  291.003936] md: md127 stopped.
[  291.004355] md: bind<sdb4>
[  291.004448] md: bind<sda4>
[  291.006331] md: raid10 personality registered for level 10
[  291.006525] md/raid10:md127: active with 2 out of 2 devices
[  291.006539] md127: detected capacity change from 0 to 17453285376
[  291.024816]  md127: unknown partition table
[  291.221043] md: md126 stopped.
[  291.221453] md: bind<sdb5>
[  291.221552] md: bind<sda5>
[  291.222206] md/raid10:md126: active with 2 out of 2 devices
[  291.222221] md126: detected capacity change from 0 to 34907881472
[  291.226381]  md126: unknown partition table
[  291.453463] md: md125 stopped.
[  291.453929] md: bind<sdb6>
[  291.454055] md: bind<sda6>
[  291.455245] md/raid10:md125: active with 2 out of 2 devices
[  291.455260] md125: detected capacity change from 0 to 233556410368
[  291.459019]  md125: unknown partition table
[  295.031091] EXT3-fs (md0): error: couldn't mount because of unsupported optional features (240)
[  295.100395] EXT2-fs (md0): error: couldn't mount because of unsupported optional features (240)
[  295.177335] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
[  295.331768] EXT3-fs (md125): error: couldn't mount because of unsupported optional features (240)
[  295.400246] EXT2-fs (md125): error: couldn't mount because of unsupported optional features (240)
[  295.492882] EXT4-fs (md125): mounted filesystem with ordered data mode. Opts: (null)
[  295.585351] EXT3-fs (md126): error: couldn't mount because of unsupported optional features (240)
[  295.660249] EXT2-fs (md126): error: couldn't mount because of unsupported optional features (240)
[  295.749162] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: (null)
[  295.840186] EXT3-fs (md127): error: couldn't mount because of unsupported optional features (240)
[  295.920245] EXT2-fs (md127): error: couldn't mount because of unsupported optional features (240)
[  296.004234] EXT4-fs (md127): mounted filesystem with ordered data mode. Opts: (null)
[  296.131945] EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
[  296.210234] EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
[  296.296084] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[  296.658924] EXT3-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
[  296.700306] EXT2-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
[  296.786843] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[  296.973542] EXT3-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
[  297.050291] EXT2-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
[  297.173025] EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: (null)
[  297.423632] EXT3-fs (md0): error: couldn't mount because of unsupported optional features (240)
[  297.470301] EXT2-fs (md0): error: couldn't mount because of unsupported optional features (240)
[  297.533528] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
[  297.621997] EXT3-fs (md125): error: couldn't mount because of unsupported optional features (240)
[  297.700287] EXT2-fs (md125): error: couldn't mount because of unsupported optional features (240)
[  297.778938] EXT4-fs (md125): mounted filesystem with ordered data mode. Opts: (null)
[  297.839414] EXT3-fs (md126): error: couldn't mount because of unsupported optional features (240)
[  297.873764] EXT2-fs (md126): error: couldn't mount because of unsupported optional features (240)
[  297.945241] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: (null)
[  298.021797] EXT3-fs (md127): error: couldn't mount because of unsupported optional features (240)
[  298.074119] EXT2-fs (md127): error: couldn't mount because of unsupported optional features (240)
[  298.152298] EXT4-fs (md127): mounted filesystem with ordered data mode. Opts: (null)
[  298.240814] EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
[  298.296127] EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
[  298.366149] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[  298.509891] EXT3-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
[  298.570316] EXT2-fs (sdc1): error: couldn't mount because of unsupported optional features (240)
[  298.634845] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[  298.688405] EXT3-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
[  298.730316] EXT2-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
[  298.816612] EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: (null)
[  308.577766] EXT3-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
[  308.640318] EXT2-fs (sdc2): error: couldn't mount because of unsupported optional features (240)
[  308.706275] EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: 




--------------010205010903000702080703--
