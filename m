From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Thu, 22 Sep 2011 20:17:07 +0200
Message-ID: <4E7B7BA3.6050006@schinagl.nl>
References: <bug-42502-20552@https.bugzilla.kernel.org/> <201109072200.p87M0G5V011358@demeter1.kernel.org> <4E6805A7.7080806@schinagl.nl> <CAErSpo6iD443d1XRBdCxYFeAQeL=zAPGbW+S16w7fbY-CPwguA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020402030509050800020906"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:50278 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab1IVSRU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Sep 2011 14:17:20 -0400
Received: from localhost (7of9.schinagl.nl [127.0.0.1])
	by 7of9.are-b.org (Postfix) with ESMTP id 567D7E5AE
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 20:17:18 +0200 (CEST)
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lePuV2BR3TIx for <linux-acpi@vger.kernel.org>;
	Thu, 22 Sep 2011 20:17:10 +0200 (CEST)
Received: from [10.2.0.242] (unknown [10.2.0.242])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 11460E3EF
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 20:17:10 +0200 (CEST)
In-Reply-To: <CAErSpo6iD443d1XRBdCxYFeAQeL=zAPGbW+S16w7fbY-CPwguA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402030509050800020906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've tried mailing this to the list several times, but never got an 
answer. I re-subscribed today so hopefully it works this time around.

this is only the 32bit dmesg, as the list might not like huge messages.

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




--------------020402030509050800020906
Content-Type: text/plain;
 name="dmesg_32bit"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg_32bit"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.38-11-generic-pae (buildd@rothera) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu4) ) #48-Ubuntu SMP Fri Jul 29 20:51:21 UTC 2011 (Ubuntu 2.6.38-11.48-generic-pae 2.6.38.8)
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
[    0.000000] last_pfn = 0x240000 max_arch_pfn = 0x1000000
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
[    0.000000] initial memory mapped : 0 - 01e00000
[    0.000000] init_memory_mapping: 0000000000000000-0000000037bfe000
[    0.000000]  0000000000 - 0000200000 page 4k
[    0.000000]  0000200000 - 0037a00000 page 2M
[    0.000000]  0037a00000 - 0037bfe000 page 4k
[    0.000000] kernel direct mapping tables up to 37bfe000 @ 1dfb000-1e00000
[    0.000000] RAMDISK: 366c6000 - 3735b000
[    0.000000] ACPI: RSDP 000f0450 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT bd99c068 0004C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP bd9a2a68 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110112/tbfadt-557)
[    0.000000] ACPI: DSDT bd99c140 06924 (v02 ALASKA    A M I 00000000 INTL 20051117)
[    0.000000] ACPI: FACS bdb0bf80 00040
[    0.000000] ACPI: APIC bd9a2b60 0009E (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG bd9a2c00 0003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
[    0.000000] ACPI: HPET bd9a2c40 00038 (v01 ALASKA    A M I 01072009 AMI  00000004)
[    0.000000] ACPI: SSDT bd9a2c78 00DDA (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 8324MB HIGHMEM available.
[    0.000000] 891MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 37bfe000
[    0.000000]   low ram: 0 - 37bfe000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x00037bfe
[    0.000000]   HighMem  0x00037bfe -> 0x00240000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000bd94d
[    0.000000]     0: 0x000bdd73 -> 0x000bdf00
[    0.000000]     0: 0x00100001 -> 0x00240000
[    0.000000] On node 0 totalpages: 2087526
[    0.000000] free_area_init_node: node 0, pgdat c17bac40, node_mem_map f1ec6200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3949 pages, LIFO batch:0
[    0.000000]   Normal zone: 1752 pages used for memmap
[    0.000000]   Normal zone: 222502 pages, LIFO batch:31
[    0.000000]   HighMem zone: 16649 pages used for memmap
[    0.000000]   HighMem zone: 1842642 pages, LIFO batch:31
[    0.000000] Using APIC driver default
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
[    0.000000] Allocating PCI resources starting at bdf00000 (gap: bdf00000:3a100000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @f7800000 s32320 r0 d20928 u262144
[    0.000000] pcpu-alloc: s32320 r0 d20928 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2069093
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.38-11-generic-pae root=UUID=6d351741-09db-4c02-8a37-6d7910d9d4da ro quiet splash vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] allocated 47185600 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Initializing HighMem for node 0 (00037bfe:00240000)
[    0.000000] Memory: 8206480k/9437184k available (5351k kernel code, 143624k reserved, 2597k data, 720k init, 7437164k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff16000 - 0xfffff000   ( 932 kB)
[    0.000000]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf83fe000 - 0xffbfe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf7bfe000   ( 891 MB)
[    0.000000]       .init : 0xc17c4000 - 0xc1878000   ( 720 kB)
[    0.000000]       .data : 0xc1539e95 - 0xc17c35c0   (2597 kB)
[    0.000000]       .text : 0xc1000000 - 0xc1539e95   (5351 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] NR_IRQS:2304 nr_irqs:1288 16
[    0.000000] CPU 0 irqstacks, hard=f740a000 soft=f740c000
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] vt handoff: transparent VT on vt#7
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3210.863 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using timer frequency.. 6421.72 BogoMIPS (lpj=12843452)
[    0.004007] pid_max: default: 32768 minimum: 301
[    0.004024] Security Framework initialized
[    0.004036] AppArmor: AppArmor initialized
[    0.004037] Yama: becoming mindful.
[    0.004080] Mount-cache hash table entries: 512
[    0.004172] Initializing cgroup subsys ns
[    0.004174] ns_cgroup deprecated: consider using the 'clone_children' flag without the ns_cgroup.
[    0.004177] Initializing cgroup subsys cpuacct
[    0.004181] Initializing cgroup subsys memory
[    0.004187] Initializing cgroup subsys devices
[    0.004189] Initializing cgroup subsys freezer
[    0.004191] Initializing cgroup subsys net_cls
[    0.004193] Initializing cgroup subsys blkio
[    0.004214] CPU: Physical Processor ID: 0
[    0.004216] CPU: Processor Core ID: 0
[    0.004218] mce: CPU supports 6 MCE banks
[    0.004225] using C1E aware idle routine
[    0.005942] ACPI: Core revision 20110112
[    0.012009] ftrace: allocating 24259 entries in 48 pages
[    0.020048] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[    0.020345] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.060821] CPU0: AMD Phenom(tm) II X6 1090T Processor stepping 00
[    0.064003] Performance Events: AMD PMU driver.
[    0.064003] ... version:                0
[    0.064003] ... bit width:              48
[    0.064003] ... generic registers:      4
[    0.064003] ... value mask:             0000ffffffffffff
[    0.064003] ... max period:             00007fffffffffff
[    0.064003] ... fixed-purpose events:   0
[    0.064003] ... event mask:             000000000000000f
[    0.064003] CPU 1 irqstacks, hard=f74ae000 soft=f74b8000
[    0.064003] Booting Node   0, Processors  #1
[    0.008000] Initializing CPU#1
[    0.152019] System has AMD C1E enabled
[    0.152028] Switch to broadcast mode on CPU1
[    0.152051] CPU 2 irqstacks, hard=f74e2000 soft=f74e4000
[    0.152053]  #2
[    0.008000] Initializing CPU#2
[    0.244026] Switch to broadcast mode on CPU2
[    0.244063] CPU 3 irqstacks, hard=f74ee000 soft=f74f0000
[    0.244065]  #3
[    0.008000] Initializing CPU#3
[    0.336050] Switch to broadcast mode on CPU3
[    0.336087] CPU 4 irqstacks, hard=f7506000 soft=f7508000
[    0.336089]  #4
[    0.008000] Initializing CPU#4
[    0.428056] Switch to broadcast mode on CPU4
[    0.428099] CPU 5 irqstacks, hard=f7526000 soft=f7528000
[    0.428100]  #5
[    0.008000] Initializing CPU#5
[    0.520062] Brought up 6 CPUs
[    0.520071] Total of 6 processors activated (38529.53 BogoMIPS).
[    0.520058] Switch to broadcast mode on CPU5
[    0.523700] Switch to broadcast mode on CPU0
[    0.523700] devtmpfs: initialized
[    0.524581] print_constraints: dummy: 
[    0.524600] Time: 22:52:03  Date: 09/07/11
[    0.524634] NET: Registered protocol family 16
[    0.524701] EISA bus registered
[    0.524718] node 0 link 0: io port [d000, ffff]
[    0.524721] TOM: 00000000c0000000 aka 3072M
[    0.524722] Fam 10h mmconf [e0000000, efffffff]
[    0.524724] node 0 link 0: mmio [c0000000, fef0ffff] ==> [c0000000, dfffffff] and [f0000000, fef0ffff]
[    0.524729] TOM2: 0000000240000000 aka 9216M
[    0.524730] bus: [00, 1f] on node 0 link 0
[    0.524732] bus: 00 index 0 [io  0x0000-0xffff]
[    0.524734] bus: 00 index 1 [mem 0xc0000000-0xdfffffff]
[    0.524736] bus: 00 index 2 [mem 0xf0000000-0xffffffff]
[    0.524737] bus: 00 index 3 [mem 0x240000000-0xfcffffffff]
[    0.524745] Extended Config Space enabled on 1 nodes
[    0.524778] ACPI: bus type pci registered
[    0.524641] Trying to unpack rootfs image as initramfs...
[    0.524828] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.524830] PCI: not using MMCONFIG
[    0.550083] PCI: Using configuration type 1 for base access
[    0.550084] PCI: Using configuration type 1 for extended access
[    0.550543] bio: create slab <bio-0> at 0
[    0.550543] ACPI: EC: Look up EC in DSDT
[    0.550543] ACPI: Executed 3 blocks of module-level executable AML code
[    0.553668] ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
[    0.553672] ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region) (20110112/nsinit-349)
[    0.580285] ACPI: Interpreter enabled
[    0.580290] ACPI: (supports S0 S1 S3 S4 S5)
[    0.580305] ACPI: Using IOAPIC for interrupt routing
[    0.580414] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.580441] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.580443] PCI: Using MMCONFIG for extended config space
[    0.583404] ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
[    0.612115] ACPI: No dock devices found.
[    0.612119] HEST: Table not found.
[    0.612122] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.612260] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.612430] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    0.612432] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    0.612434] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    0.612435] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.612437] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.612439] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
[    0.612441] pci_root PNP0A03:00: host bridge window [mem 0xc0000000-0xffffffff]
[    0.612454] pci 0000:00:00.0: [1002:5a14] type 0 class 0x000600
[    0.612500] pci 0000:00:02.0: [1002:5a16] type 1 class 0x000604
[    0.612522] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.612525] pci 0000:00:02.0: PME# disabled
[    0.612536] pci 0000:00:04.0: [1002:5a18] type 1 class 0x000604
[    0.612557] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.612559] pci 0000:00:04.0: PME# disabled
[    0.612571] pci 0000:00:07.0: [1002:5a1b] type 1 class 0x000604
[    0.612604] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.612606] pci 0000:00:07.0: PME# disabled
[    0.612629] pci 0000:00:11.0: [1002:4391] type 0 class 0x000106
[    0.612645] pci 0000:00:11.0: reg 10: [io  0xf040-0xf047]
[    0.612653] pci 0000:00:11.0: reg 14: [io  0xf030-0xf033]
[    0.612660] pci 0000:00:11.0: reg 18: [io  0xf020-0xf027]
[    0.612668] pci 0000:00:11.0: reg 1c: [io  0xf010-0xf013]
[    0.612676] pci 0000:00:11.0: reg 20: [io  0xf000-0xf00f]
[    0.612684] pci 0000:00:11.0: reg 24: [mem 0xfeb0b000-0xfeb0b3ff]
[    0.612720] pci 0000:00:12.0: [1002:4397] type 0 class 0x000c03
[    0.612731] pci 0000:00:12.0: reg 10: [mem 0xfeb0a000-0xfeb0afff]
[    0.612787] pci 0000:00:12.2: [1002:4396] type 0 class 0x000c03
[    0.612802] pci 0000:00:12.2: reg 10: [mem 0xfeb09000-0xfeb090ff]
[    0.612858] pci 0000:00:12.2: supports D1 D2
[    0.612859] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.612862] pci 0000:00:12.2: PME# disabled
[    0.612879] pci 0000:00:13.0: [1002:4397] type 0 class 0x000c03
[    0.612889] pci 0000:00:13.0: reg 10: [mem 0xfeb08000-0xfeb08fff]
[    0.612945] pci 0000:00:13.2: [1002:4396] type 0 class 0x000c03
[    0.612960] pci 0000:00:13.2: reg 10: [mem 0xfeb07000-0xfeb070ff]
[    0.613016] pci 0000:00:13.2: supports D1 D2
[    0.613018] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.613021] pci 0000:00:13.2: PME# disabled
[    0.613037] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
[    0.613098] pci 0000:00:14.2: [1002:4383] type 0 class 0x000403
[    0.613115] pci 0000:00:14.2: reg 10: [mem 0xfeb00000-0xfeb03fff 64bit]
[    0.613161] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.613164] pci 0000:00:14.2: PME# disabled
[    0.613174] pci 0000:00:14.3: [1002:439d] type 0 class 0x000601
[    0.613234] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
[    0.613267] pci 0000:00:14.5: [1002:4399] type 0 class 0x000c03
[    0.613277] pci 0000:00:14.5: reg 10: [mem 0xfeb06000-0xfeb06fff]
[    0.613330] pci 0000:00:16.0: [1002:4397] type 0 class 0x000c03
[    0.613341] pci 0000:00:16.0: reg 10: [mem 0xfeb05000-0xfeb05fff]
[    0.613397] pci 0000:00:16.2: [1002:4396] type 0 class 0x000c03
[    0.613412] pci 0000:00:16.2: reg 10: [mem 0xfeb04000-0xfeb040ff]
[    0.613468] pci 0000:00:16.2: supports D1 D2
[    0.613469] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.613472] pci 0000:00:16.2: PME# disabled
[    0.613487] pci 0000:00:18.0: [1022:1200] type 0 class 0x000600
[    0.613499] pci 0000:00:18.1: [1022:1201] type 0 class 0x000600
[    0.613508] pci 0000:00:18.2: [1022:1202] type 0 class 0x000600
[    0.613518] pci 0000:00:18.3: [1022:1203] type 0 class 0x000600
[    0.613529] pci 0000:00:18.4: [1022:1204] type 0 class 0x000600
[    0.613570] pci 0000:01:00.0: [1002:6758] type 0 class 0x000300
[    0.613582] pci 0000:01:00.0: reg 10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.613593] pci 0000:01:00.0: reg 18: [mem 0xfea20000-0xfea3ffff 64bit]
[    0.613599] pci 0000:01:00.0: reg 20: [io  0xe000-0xe0ff]
[    0.613612] pci 0000:01:00.0: reg 30: [mem 0xfea00000-0xfea1ffff pref]
[    0.613629] pci 0000:01:00.0: supports D1 D2
[    0.613648] pci 0000:01:00.1: [1002:aa90] type 0 class 0x000403
[    0.613660] pci 0000:01:00.1: reg 10: [mem 0xfea40000-0xfea43fff 64bit]
[    0.613704] pci 0000:01:00.1: supports D1 D2
[    0.620055] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.620060] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.620063] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.620066] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.620099] pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
[    0.620112] pci 0000:02:00.0: reg 10: [io  0xd000-0xd0ff]
[    0.620131] pci 0000:02:00.0: reg 18: [mem 0xd0004000-0xd0004fff 64bit pref]
[    0.620143] pci 0000:02:00.0: reg 20: [mem 0xd0000000-0xd0003fff 64bit pref]
[    0.620177] pci 0000:02:00.0: supports D1 D2
[    0.620178] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.620182] pci 0000:02:00.0: PME# disabled
[    0.628059] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.628064] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.628066] pci 0000:00:04.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.628069] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.628106] pci 0000:03:00.0: [1b21:1042] type 0 class 0x000c03
[    0.628123] pci 0000:03:00.0: reg 10: [mem 0xfe900000-0xfe907fff 64bit]
[    0.628193] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.628197] pci 0000:03:00.0: PME# disabled
[    0.636056] pci 0000:00:07.0: PCI bridge to [bus 03-03]
[    0.636060] pci 0000:00:07.0:   bridge window [io  0xfff000-0x0000] (disabled)
[    0.636063] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.636066] pci 0000:00:07.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.636120] pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive decode)
[    0.636124] pci 0000:00:14.4:   bridge window [io  0xf000-0x0000] (disabled)
[    0.636127] pci 0000:00:14.4:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.636131] pci 0000:00:14.4:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.636133] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.636135] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.636137] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.636138] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.636140] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.636142] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.636144] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff] (subtractive decode)
[    0.636155] pci_bus 0000:00: on NUMA node 0
[    0.636159] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.636259] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.636314] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC02._PRT]
[    0.636334] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC04._PRT]
[    0.636356] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC07._PRT]
[    0.636384]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.639252] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.639293] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.639334] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.639374] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 10 11 14 15) *0
[    0.639404] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.639427] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.639449] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.639472] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.639542] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.639544] vgaarb: loaded
[    0.639651] SCSI subsystem initialized
[    0.639668] libata version 3.00 loaded.
[    0.639668] usbcore: registered new interface driver usbfs
[    0.639668] usbcore: registered new interface driver hub
[    0.639668] usbcore: registered new device driver usb
[    0.639668] wmi: Mapper loaded
[    0.639668] PCI: Using ACPI for IRQ routing
[    0.639668] PCI: pci_cache_line_size set to 64 bytes
[    0.639668] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    0.639668] reserve RAM buffer: 00000000bd94d000 - 00000000bfffffff 
[    0.639668] reserve RAM buffer: 00000000bdf00000 - 00000000bfffffff 
[    0.640100] NetLabel: Initializing
[    0.640101] NetLabel:  domain hash size = 128
[    0.640102] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.640110] NetLabel:  unlabeled traffic allowed by default
[    0.640134] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.640137] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.642152] Switching to clocksource hpet
[    0.642269] Switched to NOHz mode on CPU #1
[    0.642160] Switched to NOHz mode on CPU #3
[    0.642155] Switched to NOHz mode on CPU #2
[    0.642170] Switched to NOHz mode on CPU #5
[    0.642268] Switched to NOHz mode on CPU #0
[    0.642165] Switched to NOHz mode on CPU #4
[    0.644072] AppArmor: AppArmor Filesystem Enabled
[    0.644086] pnp: PnP ACPI init
[    0.644096] ACPI: bus type pnp registered
[    0.644194] pnp 00:00: [bus 00-ff]
[    0.644196] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.644198] pnp 00:00: [io  0x0000-0x03af window]
[    0.644200] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    0.644201] pnp 00:00: [io  0x03b0-0x03df window]
[    0.644203] pnp 00:00: [io  0x0d00-0xffff window]
[    0.644204] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.644207] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    0.644209] pnp 00:00: [mem 0xc0000000-0xffffffff window]
[    0.644210] pnp 00:00: [mem 0x00000000 window]
[    0.644245] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.644266] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    0.644299] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.644301] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.644563] pnp 00:02: [io  0x040b]
[    0.644564] pnp 00:02: [io  0x04d6]
[    0.644565] pnp 00:02: [io  0x0c00-0x0c01]
[    0.644567] pnp 00:02: [io  0x0c14]
[    0.644568] pnp 00:02: [io  0x0c50-0x0c51]
[    0.644569] pnp 00:02: [io  0x0c52]
[    0.644570] pnp 00:02: [io  0x0c6c]
[    0.644572] pnp 00:02: [io  0x0c6f]
[    0.644573] pnp 00:02: [io  0x0cd0-0x0cd1]
[    0.644574] pnp 00:02: [io  0x0cd2-0x0cd3]
[    0.644576] pnp 00:02: [io  0x0cd4-0x0cd5]
[    0.644577] pnp 00:02: [io  0x0cd6-0x0cd7]
[    0.644578] pnp 00:02: [io  0x0cd8-0x0cdf]
[    0.644580] pnp 00:02: [io  0x0800-0x089f]
[    0.644581] pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
[    0.644583] pnp 00:02: [io  0x0000-0x000f]
[    0.644584] pnp 00:02: [io  0x0b20-0x0b3f]
[    0.644586] pnp 00:02: [io  0x0900-0x090f]
[    0.644587] pnp 00:02: [io  0x0910-0x091f]
[    0.644588] pnp 00:02: [io  0xfe00-0xfefe]
[    0.644590] pnp 00:02: [io  0x0060-0x005f disabled]
[    0.644591] pnp 00:02: [io  0x0064-0x0063 disabled]
[    0.644593] pnp 00:02: [mem 0xfec00000-0xfec00fff]
[    0.644594] pnp 00:02: [mem 0xfee00000-0xfee00fff]
[    0.644596] pnp 00:02: [mem 0xfed80000-0xfed8ffff]
[    0.644597] pnp 00:02: [mem 0xfed61000-0xfed70fff]
[    0.644599] pnp 00:02: [mem 0xfec10000-0xfec10fff]
[    0.644600] pnp 00:02: [mem 0xfed00000-0xfed00fff]
[    0.644610] pnp 00:02: [mem 0xffc00000-0xffffffff]
[    0.644651] system 00:02: [io  0x040b] has been reserved
[    0.644653] system 00:02: [io  0x04d6] has been reserved
[    0.644654] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.644656] system 00:02: [io  0x0c14] has been reserved
[    0.644658] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    0.644659] system 00:02: [io  0x0c52] has been reserved
[    0.644661] system 00:02: [io  0x0c6c] has been reserved
[    0.644662] system 00:02: [io  0x0c6f] has been reserved
[    0.644664] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.644666] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.644667] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.644669] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.644671] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.644672] system 00:02: [io  0x0800-0x089f] has been reserved
[    0.644674] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.644676] system 00:02: [io  0x0900-0x090f] has been reserved
[    0.644678] system 00:02: [io  0x0910-0x091f] has been reserved
[    0.644679] system 00:02: [io  0xfe00-0xfefe] has been reserved
[    0.644682] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.644684] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.644686] system 00:02: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.644688] system 00:02: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.644690] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.644691] system 00:02: [mem 0xfed00000-0xfed00fff] has been reserved
[    0.644693] system 00:02: [mem 0xffc00000-0xffffffff] has been reserved
[    0.644695] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.644764] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.644766] pnp 00:03: [io  0x0290-0x02af]
[    0.644767] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.644793] system 00:03: [io  0x0290-0x02af] has been reserved
[    0.644795] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.644804] pnp 00:04: [dma 4]
[    0.644806] pnp 00:04: [io  0x0000-0x000f]
[    0.644808] pnp 00:04: [io  0x0081-0x0083]
[    0.644809] pnp 00:04: [io  0x0087]
[    0.644810] pnp 00:04: [io  0x0089-0x008b]
[    0.644811] pnp 00:04: [io  0x008f]
[    0.644812] pnp 00:04: [io  0x00c0-0x00df]
[    0.644828] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.644835] pnp 00:05: [io  0x0070-0x0071]
[    0.644842] pnp 00:05: [irq 8]
[    0.644858] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.644864] pnp 00:06: [io  0x0061]
[    0.644879] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.644893] pnp 00:07: [io  0x0010-0x001f]
[    0.644894] pnp 00:07: [io  0x0022-0x003f]
[    0.644895] pnp 00:07: [io  0x0044-0x005f]
[    0.644896] pnp 00:07: [io  0x0062-0x0063]
[    0.644898] pnp 00:07: [io  0x0065-0x006f]
[    0.644899] pnp 00:07: [io  0x0072-0x007f]
[    0.644900] pnp 00:07: [io  0x0080]
[    0.644901] pnp 00:07: [io  0x0084-0x0086]
[    0.644902] pnp 00:07: [io  0x0088]
[    0.644903] pnp 00:07: [io  0x008c-0x008e]
[    0.644904] pnp 00:07: [io  0x0090-0x009f]
[    0.644906] pnp 00:07: [io  0x00a2-0x00bf]
[    0.644907] pnp 00:07: [io  0x00e0-0x00ef]
[    0.644908] pnp 00:07: [io  0x04d0-0x04d1]
[    0.644938] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    0.644940] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.644945] pnp 00:08: [io  0x00f0-0x00ff]
[    0.644948] pnp 00:08: [irq 13]
[    0.644967] pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.644999] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.645011] pnp 00:0a: [io  0x0060]
[    0.645012] pnp 00:0a: [io  0x0064]
[    0.645015] pnp 00:0a: [irq 1]
[    0.645032] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.645051] pnp 00:0b: [irq 12]
[    0.645068] pnp 00:0b: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.645173] pnp 00:0c: [io  0x03f8-0x03ff]
[    0.645176] pnp 00:0c: [irq 4]
[    0.645177] pnp 00:0c: [dma 0 disabled]
[    0.645209] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.645246] pnp 00:0d: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.645276] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.645325] pnp 00:0e: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.645327] pnp 00:0e: [mem 0xfec20000-0xfec200ff]
[    0.645359] system 00:0e: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.645360] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.645437] pnp 00:0f: [mem 0xfed00000-0xfed003ff]
[    0.645460] pnp 00:0f: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.645464] pnp: PnP ACPI: found 16 devices
[    0.645465] ACPI: ACPI bus type pnp unregistered
[    0.645467] PnPBIOS: Disabled by ACPI PNP
[    0.680945] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.680948] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.680950] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.680953] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.680955] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.680957] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.680959] pci 0000:00:04.0:   bridge window [mem disabled]
[    0.680961] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.680964] pci 0000:00:07.0: PCI bridge to [bus 03-03]
[    0.680965] pci 0000:00:07.0:   bridge window [io  disabled]
[    0.680967] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.680969] pci 0000:00:07.0:   bridge window [mem pref disabled]
[    0.680972] pci 0000:00:14.4: PCI bridge to [bus 04-04]
[    0.680973] pci 0000:00:14.4:   bridge window [io  disabled]
[    0.680977] pci 0000:00:14.4:   bridge window [mem disabled]
[    0.680980] pci 0000:00:14.4:   bridge window [mem pref disabled]
[    0.680994] pci 0000:00:02.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
[    0.680997] pci 0000:00:02.0: setting latency timer to 64
[    0.681000] pci 0000:00:04.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
[    0.681002] pci 0000:00:04.0: setting latency timer to 64
[    0.681008] pci 0000:00:07.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
[    0.681009] pci 0000:00:07.0: setting latency timer to 64
[    0.681015] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.681017] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.681018] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.681019] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.681021] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.681023] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.681024] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff]
[    0.681026] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.681027] pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.681029] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.681030] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.681032] pci_bus 0000:02: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.681034] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.681035] pci_bus 0000:04: resource 4 [io  0x0000-0x03af]
[    0.681037] pci_bus 0000:04: resource 5 [io  0x03e0-0x0cf7]
[    0.681038] pci_bus 0000:04: resource 6 [io  0x03b0-0x03df]
[    0.681040] pci_bus 0000:04: resource 7 [io  0x0d00-0xffff]
[    0.681041] pci_bus 0000:04: resource 8 [mem 0x000a0000-0x000bffff]
[    0.681042] pci_bus 0000:04: resource 9 [mem 0x000c0000-0x000dffff]
[    0.681044] pci_bus 0000:04: resource 10 [mem 0xc0000000-0xffffffff]
[    0.681068] NET: Registered protocol family 2
[    0.681111] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.681250] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.681553] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.681706] TCP: Hash tables configured (established 131072 bind 65536)
[    0.681707] TCP reno registered
[    0.681709] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.681715] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.681771] NET: Registered protocol family 1
[    1.490779] Freeing initrd memory: 12884k freed
[    1.524117] pci 0000:01:00.0: Boot video device
[    1.524141] PCI: CLS 64 bytes, default 64
[    1.524499] cpufreq-nforce2: No nForce2 chipset.
[    1.524585] audit: initializing netlink socket (disabled)
[    1.524592] type=2000 audit(1315435924.524:1): initialized
[    1.530778] highmem bounce pool size: 64 pages
[    1.530782] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.531862] VFS: Disk quotas dquot_6.5.2
[    1.531898] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.532352] fuse init (API version 7.16)
[    1.532408] msgmni has been set to 1527
[    1.532636] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.532667] io scheduler noop registered
[    1.532668] io scheduler deadline registered
[    1.532679] io scheduler cfq registered (default)
[    1.532810] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.532826] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.532932] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    1.596092] ACPI: Power Button [PWRB]
[    1.596141] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.596144] ACPI: Power Button [PWRF]
[    1.596260] ACPI: acpi_idle registered with cpuidle
[    1.596275] ACPI: processor limited to max C-state 1
[    1.597292] ERST: Table is not found!
[    1.597314] isapnp: Scanning for PnP cards...
[    1.597359] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.617758] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.951064] isapnp: No Plug & Play device found
[    2.056644] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.060284] Linux agpgart interface v0.103
[    2.061085] brd: module loaded
[    2.061395] loop: module loaded
[    2.061445] i2c-core: driver [adp5520] using legacy suspend method
[    2.061446] i2c-core: driver [adp5520] using legacy resume method
[    2.061691] Fixed MDIO Bus: probed
[    2.061708] PPP generic driver version 2.4.2
[    2.061728] tun: Universal TUN/TAP device driver, 1.6
[    2.061729] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.061779] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.061796] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    2.061805] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    2.061828] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
[    2.064107] ehci_hcd 0000:00:12.2: QUIRK: Enable exception for AMD Hudson ASPM
[    2.064111] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.064128] ehci_hcd 0000:00:12.2: debug port 1
[    2.064146] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfeb09000
[    2.076087] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.076177] hub 1-0:1.0: USB hub found
[    2.076180] hub 1-0:1.0: 5 ports detected
[    2.076232] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    2.076250] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    2.076271] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
[    2.076313] ehci_hcd 0000:00:13.2: QUIRK: Enable exception for AMD Hudson ASPM
[    2.076317] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.076333] ehci_hcd 0000:00:13.2: debug port 1
[    2.076344] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
[    2.088084] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.088174] hub 2-0:1.0: USB hub found
[    2.088176] hub 2-0:1.0: 5 ports detected
[    2.088224] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    2.088233] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    2.088254] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
[    2.092108] ehci_hcd 0000:00:16.2: QUIRK: Enable exception for AMD Hudson ASPM
[    2.092112] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.092129] ehci_hcd 0000:00:16.2: debug port 1
[    2.092141] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
[    2.104086] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    2.104175] hub 3-0:1.0: USB hub found
[    2.104177] hub 3-0:1.0: 4 ports detected
[    2.104223] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.104237] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    2.104246] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    2.104267] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
[    2.108122] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
[    2.168139] hub 4-0:1.0: USB hub found
[    2.168145] hub 4-0:1.0: 5 ports detected
[    2.168191] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    2.168200] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    2.168224] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
[    2.168272] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
[    2.228138] hub 5-0:1.0: USB hub found
[    2.228143] hub 5-0:1.0: 5 ports detected
[    2.228189] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.228198] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    2.228220] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
[    2.232115] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
[    2.292138] hub 6-0:1.0: USB hub found
[    2.292143] hub 6-0:1.0: 2 ports detected
[    2.292185] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    2.292194] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    2.292220] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
[    2.292268] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
[    2.352139] hub 7-0:1.0: USB hub found
[    2.352144] hub 7-0:1.0: 4 ports detected
[    2.352189] uhci_hcd: USB Universal Host Controller Interface driver
[    2.356130] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    2.356492] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.356497] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.356617] mousedev: PS/2 mouse device common for all mice
[    2.356701] rtc_cmos 00:05: RTC can wake from S4
[    2.361105] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.361126] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.361175] device-mapper: uevent: version 1.0.3
[    2.361222] device-mapper: ioctl: 4.19.1-ioctl (2011-01-07) initialised: dm-devel@redhat.com
[    2.361327] device-mapper: multipath: version 1.2.0 loaded
[    2.361329] device-mapper: multipath round-robin: version 1.0.0 loaded
[    2.361375] EISA: Probing bus 0 at eisa.0
[    2.361377] EISA: Cannot allocate resource for mainboard
[    2.361378] Cannot allocate resource for EISA slot 1
[    2.361380] Cannot allocate resource for EISA slot 2
[    2.361381] Cannot allocate resource for EISA slot 3
[    2.361382] Cannot allocate resource for EISA slot 4
[    2.361383] Cannot allocate resource for EISA slot 5
[    2.361384] Cannot allocate resource for EISA slot 6
[    2.361386] Cannot allocate resource for EISA slot 7
[    2.361387] Cannot allocate resource for EISA slot 8
[    2.361388] EISA: Detected 0 cards.
[    2.361455] cpuidle: using governor ladder
[    2.361456] cpuidle: using governor menu
[    2.361630] TCP cubic registered
[    2.361711] NET: Registered protocol family 10
[    2.362069] NET: Registered protocol family 17
[    2.362078] Registering the dns_resolver key type
[    2.362138] powernow-k8: Found 1 AMD Phenom(tm) II X6 1090T Processor (6 cpu cores) (version 2.20.00)
[    2.362152] powernow-k8: Core Performance Boosting: on.
[    2.362180] powernow-k8:    0 : pstate 0 (3200 MHz)
[    2.362181] powernow-k8:    1 : pstate 1 (2400 MHz)
[    2.362182] powernow-k8:    2 : pstate 2 (1600 MHz)
[    2.362183] powernow-k8:    3 : pstate 3 (800 MHz)
[    2.362530] Using IPI No-Shortcut mode
[    2.362597] PM: Hibernation image not present or could not be loaded.
[    2.362602] registered taskstats version 1
[    2.362794]   Magic number: 11:218:906
[    2.362862] rtc_cmos 00:05: setting system clock to 2011-09-07 22:52:05 UTC (1315435925)
[    2.362864] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.362866] EDD information not available.
[    2.363000] Freeing unused kernel memory: 720k freed
[    2.363194] Write protecting the kernel text: 5352k
[    2.363238] Write protecting the kernel read-only data: 2192k
[    2.363240] NX-protecting the kernel data: 4888k
[    2.375661] <30>udev[76]: starting version 167
[    2.376763] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    2.379551] md: linear personality registered for level -1
[    2.383944] md: multipath personality registered for level -4
[    2.385661] md: raid0 personality registered for level 0
[    2.388594] md: raid1 personality registered for level 1
[    2.389882] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 50 (level, low) -> IRQ 50
[    2.389902] xhci_hcd 0000:03:00.0: setting latency timer to 64
[    2.389906] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.389959] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
[    2.391033] async_tx: api initialized (async)
[    2.391581] xor: automatically using best checksumming function: pIII_sse
[    2.394096] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.394114] r8169 0000:02:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
[    2.394146] r8169 0000:02:00.0: setting latency timer to 64
[    2.394152] r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
[    2.394201] r8169 0000:02:00.0: irq 72 for MSI/MSI-X
[    2.394550] r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xf8438000, 14:da:e9:03:e9:b7, XID 0c900800 IRQ 72
[    2.404083] ahci 0000:00:11.0: version 3.0
[    2.404100] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    2.404208] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.404211] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.406331] scsi0 : ahci
[    2.406523] scsi1 : ahci
[    2.406595] scsi2 : ahci
[    2.406675] scsi3 : ahci
[    2.406907] scsi4 : ahci
[    2.406979] scsi5 : ahci
[    2.407037] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b100 irq 19
[    2.407040] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b180 irq 19
[    2.407043] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19
[    2.407046] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b280 irq 19
[    2.407049] ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b300 irq 19
[    2.407051] ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b380 irq 19
[    2.408029]    pIII_sse  : 12815.000 MB/sec
[    2.408031] xor: using function: pIII_sse (12815.000 MB/sec)
[    2.416084] usb 3-2: new high speed USB device using ehci_hcd and address 2
[    2.421806] xhci_hcd 0000:03:00.0: irq 50, io mem 0xfe900000
[    2.421846] xhci_hcd 0000:03:00.0: irq 73 for MSI/MSI-X
[    2.421849] xhci_hcd 0000:03:00.0: irq 74 for MSI/MSI-X
[    2.421852] xhci_hcd 0000:03:00.0: irq 75 for MSI/MSI-X
[    2.421854] xhci_hcd 0000:03:00.0: irq 76 for MSI/MSI-X
[    2.421857] xhci_hcd 0000:03:00.0: irq 77 for MSI/MSI-X
[    2.421859] xhci_hcd 0000:03:00.0: irq 78 for MSI/MSI-X
[    2.421862] xhci_hcd 0000:03:00.0: irq 79 for MSI/MSI-X
[    2.421928] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
[    2.422007] xHCI xhci_add_endpoint called for root hub
[    2.422008] xHCI xhci_check_bandwidth called for root hub
[    2.422027] hub 8-0:1.0: USB hub found
[    2.422029] hub 8-0:1.0: 4 ports detected
[    2.524090] Refined TSC clocksource calibration: 3210.781 MHz.
[    2.524095] Switching to clocksource tsc
[    2.551901] usbcore: registered new interface driver uas
[    2.724098] ata6: SATA link down (SStatus 0 SControl 300)
[    2.724131] ata4: SATA link down (SStatus 0 SControl 300)
[    2.724209] ata3: SATA link down (SStatus 0 SControl 300)
[    2.896101] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.896128] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.896150] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.897147] ata5.00: ATA-7: HDS725050KLA360, K2AOAH0A, max UDMA/133
[    2.897150] ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.898378] ata5.00: configured for UDMA/133
[    2.902498] ata1.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
[    2.902501] ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.904094] ata2.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
[    2.904096] ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.908459] ata1.00: configured for UDMA/133
[    2.908593] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
[    2.908709] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.908774] sd 0:0:0:0: [sda] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[    2.908838] sd 0:0:0:0: [sda] Write Protect is off
[    2.908841] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.908864] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.912082] ata2.00: configured for UDMA/133
[    2.912167] scsi 1:0:0:0: Direct-Access     ATA      WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
[    2.912273] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.912276] sd 1:0:0:0: [sdb] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[    2.912371] sd 1:0:0:0: [sdb] Write Protect is off
[    2.912374] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.912411] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.912434] scsi 4:0:0:0: Direct-Access     ATA      HDS725050KLA360  K2AO PQ: 0 ANSI: 5
[    2.912558] sd 4:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.912574] sd 4:0:0:0: Attached scsi generic sg2 type 0
[    2.912621] sd 4:0:0:0: [sdc] Write Protect is off
[    2.912624] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.912648] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.934720]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
[    2.935091] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.936849]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
[    2.937184] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.947087]  sdc: sdc1 sdc2 sdc4
[    2.947353] sd 4:0:0:0: [sdc] Attached SCSI disk
[    2.951631] Initializing USB Mass Storage driver...
[    2.951744] scsi6 : usb-storage 3-2:1.0
[    2.951813] usbcore: registered new interface driver usb-storage
[    2.951815] USB Mass Storage support registered.
[    3.016029] raid6: int32x1   1564 MB/s
[    3.054298] md: bind<sdb3>
[    3.060159] md: bind<sdb4>
[    3.068103] md: bind<sdb5>
[    3.084056] raid6: int32x2   1621 MB/s
[    3.147848] md: bind<sdb6>
[    3.152055] raid6: int32x4   1233 MB/s
[    3.220016] raid6: int32x8    954 MB/s
[    3.288037] raid6: mmxx1     2958 MB/s
[    3.356021] raid6: mmxx2     5559 MB/s
[    3.424025] raid6: sse1x1    2490 MB/s
[    3.492021] raid6: sse1x2    3934 MB/s
[    3.560057] raid6: sse2x1    4696 MB/s
[    3.628057] raid6: sse2x2    7811 MB/s
[    3.628058] raid6: using algorithm sse2x2 (7811 MB/s)
[    3.632241] md: raid6 personality registered for level 6
[    3.632243] md: raid5 personality registered for level 5
[    3.632245] md: raid4 personality registered for level 4
[    3.636739] md: raid10 personality registered for level 10
[    3.644138] md: bind<sda6>
[    3.645313] bio: create slab <bio-1> at 1
[    3.645381] md/raid10:md124: active with 2 out of 2 devices
[    3.645395] md124: detected capacity change from 0 to 233556410368
[    3.649917]  md124: unknown partition table
[    3.669793] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[    3.704196] md: bind<sda4>
[    3.713148] md/raid10:md126: active with 2 out of 2 devices
[    3.713163] md126: detected capacity change from 0 to 17453285376
[    3.751013] md: bind<sda5>
[    3.751034] md: md123 stopped.
[    3.751037] md: unbind<sda5>
[    3.780193] md: export_rdev(sda5)
[    3.780545] md: array md127 already has disks!
[    3.948554] scsi 6:0:0:0: Direct-Access     WG       Corner Office    8.02 PQ: 0 ANSI: 0 CCS
[    3.948900] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    3.949424] sd 6:0:0:0: [sdd] 3907583 512-byte logical blocks: (2.00 GB/1.86 GiB)
[    3.949928] sd 6:0:0:0: [sdd] Write Protect is off
[    3.949931] sd 6:0:0:0: [sdd] Mode Sense: 45 00 00 08
[    3.949932] sd 6:0:0:0: [sdd] Assuming drive cache: write through
[    3.951302] sd 6:0:0:0: [sdd] Assuming drive cache: write through
[    3.952054]  sdd: sdd1
[    3.953678] sd 6:0:0:0: [sdd] Assuming drive cache: write through
[    3.953680] sd 6:0:0:0: [sdd] Attached SCSI removable disk
[   15.142747] <30>udev[376]: starting version 167
[   15.184337] <30>udev[392]: renamed network interface eth0 to eth2
[   15.204144]  md126: unknown partition table
[   15.237076] Adding 4000180k swap on /dev/sdc4.  Priority:-1 extents:1 across:4000180k 
[   15.331295] type=1400 audit(1315435938.465:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=523 comm="apparmor_parser"
[   15.331306] type=1400 audit(1315435938.465:3): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=532 comm="apparmor_parser"
[   15.331515] type=1400 audit(1315435938.465:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=523 comm="apparmor_parser"
[   15.331528] type=1400 audit(1315435938.465:5): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=532 comm="apparmor_parser"
[   15.331656] type=1400 audit(1315435938.465:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=523 comm="apparmor_parser"
[   15.331673] type=1400 audit(1315435938.465:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=532 comm="apparmor_parser"
[   15.465350] md: bind<sda5>
[   15.543897] md/raid10:md125: active with 2 out of 2 devices
[   15.543916] md125: detected capacity change from 0 to 34907881472
[   15.549723]  md125: unknown partition table
[   15.556190] md: bind<sda3>
[   15.557320] md/raid1:md127: active with 2 out of 2 mirrors
[   15.557335] md127: detected capacity change from 0 to 1090453504
[   15.592659]  md127: unknown partition table
[   15.761610] lp: driver loaded but no devices found
[   15.803961] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   15.834759] SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
[   15.834811] SP5100 TCO timer: mmio address 0xbafe00 already in use
[   15.848020] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input3
[   15.903820] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[   15.903823] Disabling lock debugging due to kernel taint
[   15.942323] [fglrx] Maximum main memory to use for locked dma buffers: 3769 MBytes.
[   15.942418] [fglrx]   vendor: 1002 device: 6758 count: 1
[   15.942760] [fglrx] ioport: bar 4, base 0xe000, size: 0x100
[   15.942777] pci 0000:01:00.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
[   15.942781] pci 0000:01:00.0: setting latency timer to 64
[   15.943048] [fglrx] Kernel PAT support is enabled
[   15.943062] [fglrx] module loaded - fglrx 8.84.60 [Mar 24 2011] with 1 minors
[   16.306369] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   16.328178] hda-intel: Enable sync_write for AMD chipset
[   16.379715] hda_codec: ALC887-VD: BIOS auto-probing.
[   16.389307] input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
[   16.389419] HDA Intel 0000:01:00.1: PCI INT B -> GSI 25 (level, low) -> IRQ 25
[   16.389467] HDA Intel 0000:01:00.1: irq 80 for MSI/MSI-X
[   16.389487] HDA Intel 0000:01:00.1: setting latency timer to 64
[   16.404154] hda-intel: Enable sync_write for AMD chipset
[   16.544341] EXT4-fs (sdc1): re-mounted. Opts: errors=remount-ro
[   16.708163] input: ImExPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input5
[   16.740193] EXT4-fs (sdc2): mounted filesystem with ordered data mode. Opts: (null)
[   18.572526] type=1400 audit(1315435941.709:8): apparmor="STATUS" operation="profile_load" name="/usr/share/gdm/guest-session/Xsession" pid=1005 comm="apparmor_parser"
[   18.573622] type=1400 audit(1315435941.709:9): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=1010 comm="apparmor_parser"
[   18.573929] type=1400 audit(1315435941.709:10): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=1010 comm="apparmor_parser"
[   18.575954] type=1400 audit(1315435941.709:11): apparmor="STATUS" operation="profile_load" name="/usr/bin/freshclam" pid=1009 comm="apparmor_parser"
[   18.588768] r8169 0000:02:00.0: eth2: link down
[   18.588776] r8169 0000:02:00.0: eth2: link down
[   18.588973] ADDRCONF(NETDEV_UP): eth2: link is not ready
[   18.592408] ppdev: user-space parallel port driver
[   19.133400] fglrx_pci 0000:01:00.0: irq 81 for MSI/MSI-X
[   19.133837] [fglrx] Firegl kernel thread PID: 1375
[   19.133873] [fglrx] Firegl kernel thread PID: 1376
[   19.133908] [fglrx] Firegl kernel thread PID: 1377
[   19.134305] [fglrx] IRQ 81 Enabled
[   19.405505] [fglrx] Gart USWC size:1280 M.
[   19.405508] [fglrx] Gart cacheable size:508 M.
[   19.405511] [fglrx] Reserved FB block: Shared offset:0, size:1000000 
[   19.405513] [fglrx] Reserved FB block: Unshared offset:f8fd000, size:403000 
[   19.405515] [fglrx] Reserved FB block: Unshared offset:3fff4000, size:c000 
[   19.749519] EXT4-fs (sdc1): re-mounted. Opts: errors=remount-ro,commit=0
[   19.823640] EXT4-fs (sdc2): re-mounted. Opts: commit=0
[   21.648144] r8169 0000:02:00.0: eth2: link up
[   21.648319] ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
[   22.032036] hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
[   23.061912] EXT4-fs (sdc1): re-mounted. Opts: errors=remount-ro,commit=0
[   24.128514] EXT4-fs (sdc2): re-mounted. Opts: commit=0
[   31.664022] eth2: no IPv6 routers present
[  200.460415] usb 3-2: USB disconnect, address 2
[  206.892087] usb 4-1: new full speed USB device using ohci_hcd and address 2
[  208.402247] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-1/4-1:1.0/input/input6
[  208.402533] generic-usb 0003:1532:0101.0001: input,hidraw0: USB HID v10.01 Mouse [Razer Razer Copperhead Laser Mouse] on usb-0000:00:12.0-1/input0
[  208.406633] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-1/4-1:1.1/input/input7
[  208.406848] generic-usb 0003:1532:0101.0002: input,hidraw1: USB HID v10.01 Keyboard [Razer Razer Copperhead Laser Mouse] on usb-0000:00:12.0-1/input1
[  208.406886] usbcore: registered new interface driver usbhid
[  208.406891] usbhid: USB HID core driver




--------------020402030509050800020906--
