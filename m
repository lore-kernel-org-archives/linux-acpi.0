From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: PROBLEM: USB 1.1 (and up) not working on AMD R900 Series chipset
Date: Thu, 22 Dec 2011 11:31:30 +0100
Message-ID: <4EF30702.90002@schinagl.nl>
References: <4E66777E.5060307@schinagl.nl> <20110906204623.GA24553@kroah.com> <4EF19E23.3060502@schinagl.nl> <2DEEA3AB13739D45A22ADDB5086AEA0B023E406E@sshaexmb1.amd.com> <4EF1B98B.2040609@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070100020703050806060101"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EF1B98B.2040609-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070100020703050806060101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've updated the bios, I think I've used the same settings as I did 
before (IOMMU etc all enabled) and USB is finally working now! The bios 
is from earlier this month, so quite fresh actually.

The DSDT errors remained the same, so cleaned those up again and am 
loading them through the kernel for now, I wonder if it would be 
sensible to somehow, just try once to get the patch towards asus ...

I've attached the diff between the previous DSDT of the current bios 
version and the previous version, if anybody smarter then myself can 
spot the how or why this would fix it? (If it's not the DSDT it may very 
well be somewhere deep inside the bios?)

Also for completness sake i've attached my current gentoo 64bit dmesg, 
in case someone wants to compare that to the non-working previous dmesg 
somewhere in the linux-acpi mail archive.

Oliver

On 21-12-11 11:48, Oliver Schinagl wrote:



    On 21-12-11 10:22, Xu, Andiry wrote:
>>     -----Original Message-----
>>     From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-
>>     owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Oliver Schinagl
>>     Sent: Wednesday, December 21, 2011 4:52 PM
>>     To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>     Subject: Re: PROBLEM: USB 1.1 (and up) not working on AMD R900
>>     Series
>>     chipset
>>
>>     A while ago I wrote this list with the below quoted message. I was
>>     referred to the linux-acpi list and after submitting some
>>     information 
>     on
>>     request by Bjorn there has been no solution since. Just before the
>>     bugzilla died, I did submit a ticket there, but it seems the
>>     bugzilla
>>     won't be back for time to come.
>>
>>     Meanwhile I found that Tomi Orava had also some issue with USB on
>>     the
>>     same motherboard [1], but actually got it working just fine. I am
>>     not
>>     sure if he was running 64bit or an 32bit kernel but did notice a 
>     comment
>>     about the r8169 module requiring use_dac=1, which is the same
>>     issue I
>>     have, but only on the 64bit kernel.
>>
>>     Is there meanwhile anything else I can look at. I've become somewhat
>>     used of having no USB on my PC for all this time, but do start to
>>     miss
>>     it at times.
>>
>>     P.S. linux-acpi list didn't think that there was a routing issue
>>     with
>>     IRQ's, or at least that's how I understood it.
>>
>>     Thanks for your time and help,
>>
>>     oliver
>     I do remember Tomi Orava updated BIOS for his motherboard and
>     resolved
>     all the strange USB issues he had.
>     Have you tried update BIOS? 
    I should have mentioned this, but yes, I've updated the bios a few
    months ago and even fixed my dsdt to compile without any errors or
    warnings. That said, I saw there is a new bios update available
    which I will flash the moment I get home from work tonight :)
>
>     Thanks,
>     Andiry
>
>
>>     [1] http://article.gmane.org/gmane.linux.usb.general/54928/match=
>>
>>     On 06-09-11 22:46, Greg KH wrote: 

<snip> deleted due to size

--------------070100020703050806060101
Content-Type: text/x-c++;
 name="gentoo_dmesg_64bit_working.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gentoo_dmesg_64bit_working.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.1.1-gentoo (root@valexia) (gcc version 4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #4 SMP PREEMPT Wed Dec 21 20:32:17 CET 2011
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.1.1-gentoo root=/dev/md0 ro r8169.use_dac=1
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bd94d000 (usable)
[    0.000000]  BIOS-e820: 00000000bd94d000 - 00000000bd99d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bd99d000 - 00000000bd9a6000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bd9a6000 - 00000000bdade000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdade000 - 00000000bdaef000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdaef000 - 00000000bdb02000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb02000 - 00000000bdb04000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdb04000 - 00000000bdb0d000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb0d000 - 00000000bdb13000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdb13000 - 00000000bdb75000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdb75000 - 00000000bdd78000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdd78000 - 00000000bdf00000 (usable)
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
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0901 11/24/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x240000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-EBFFF uncachable
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000BDF00000 mask FFFFFFF00000 uncachable
[    0.000000]   3 base 0000BE000000 mask FFFFFE000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000240000000 aka 9216M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000bdf00000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xbdf00 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20480
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000bdf00000
[    0.000000]  0000000000 - 0080000000 page 1G
[    0.000000]  0080000000 - 00bde00000 page 2M
[    0.000000]  00bde00000 - 00bdf00000 page 4k
[    0.000000] kernel direct mapping tables up to bdf00000 @ 1fffd000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-0000000240000000
[    0.000000]  0100000000 - 0240000000 page 1G
[    0.000000] kernel direct mapping tables up to 240000000 @ bdeff000-bdf00000
[    0.000000] ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000bd99d068 00054 (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000bd9a4040 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110623/tbfadt-560)
[    0.000000] ACPI: Override [DSDT-   A M I], this is unsafe: tainting kernel
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] ACPI: DSDT @ 0x00000000bd99d150 Table override, replaced with:
[    0.000000] ACPI: DSDT ffffffff81541040 06ECA (v02 ALASKA    A M I 00000000 INTL 20110922)
[    0.000000] ACPI: FACS 00000000bdb0df80 00040
[    0.000000] ACPI: APIC 00000000bd9a4138 0009E (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000bd9a41d8 0003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 00000000bd9a4218 00038 (v01 ALASKA    A M I 01072009 AMI  00000004)
[    0.000000] ACPI: IVRS 00000000bd9a4250 000C0 (v01  AMD     RD890S 00202031 AMD  00000000)
[    0.000000] ACPI: SSDT 00000000bd9a4310 00E10 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0008ffffff] PMD -> [ffff880237600000-ffff88023f5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000001 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00240000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000001 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000bd94d
[    0.000000]     0: 0x000bdd78 -> 0x000bdf00
[    0.000000]     0: 0x00100001 -> 0x00240000
[    0.000000] On node 0 totalpages: 2087536
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3927 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 756501 pages, LIFO batch:31
[    0.000000]   Normal zone: 20480 pages used for memmap
[    0.000000]   Normal zone: 1290239 pages, LIFO batch:31
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
[    0.000000] PM: Registered nosave memory: 00000000bd94d000 - 00000000bd99d000
[    0.000000] PM: Registered nosave memory: 00000000bd99d000 - 00000000bd9a6000
[    0.000000] PM: Registered nosave memory: 00000000bd9a6000 - 00000000bdade000
[    0.000000] PM: Registered nosave memory: 00000000bdade000 - 00000000bdaef000
[    0.000000] PM: Registered nosave memory: 00000000bdaef000 - 00000000bdb02000
[    0.000000] PM: Registered nosave memory: 00000000bdb02000 - 00000000bdb04000
[    0.000000] PM: Registered nosave memory: 00000000bdb04000 - 00000000bdb0d000
[    0.000000] PM: Registered nosave memory: 00000000bdb0d000 - 00000000bdb13000
[    0.000000] PM: Registered nosave memory: 00000000bdb13000 - 00000000bdb75000
[    0.000000] PM: Registered nosave memory: 00000000bdb75000 - 00000000bdd78000
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
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 24 pages/cpu @ffff88023fc00000 s68864 r8192 d21248 u262144
[    0.000000] pcpu-alloc: s68864 r8192 d21248 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2050667
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.1.1-gentoo root=/dev/md0 ro r8169.use_dac=1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ f8000000 size 64 MB
[    0.000000] Memory: 8133248k/9437184k available (3713k kernel code, 1087040k absent, 216896k reserved, 1856k data, 448k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:512
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3210.894 MHz processor.
[    0.001003] Calibrating delay loop (skipped), value calculated using timer frequency.. 6421.78 BogoMIPS (lpj=3210894)
[    0.001063] pid_max: default: 32768 minimum: 301
[    0.001132] Mount-cache hash table entries: 256
[    0.001277] Initializing cgroup subsys cpuacct
[    0.001311] Initializing cgroup subsys devices
[    0.001340] Initializing cgroup subsys freezer
[    0.001369] Initializing cgroup subsys blkio
[    0.001400] Initializing cgroup subsys perf_event
[    0.001450] tseg: 00bdf00000
[    0.001451] CPU: Physical Processor ID: 0
[    0.001480] CPU: Processor Core ID: 0
[    0.001508] mce: CPU supports 6 MCE banks
[    0.001541] using AMD E400 aware idle routine
[    0.002022] ACPI: Core revision 20110623
[    0.004322] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.014697] CPU0: AMD Phenom(tm) II X6 1090T Processor stepping 00
[    0.014998] Performance Events: AMD PMU driver.
[    0.014998] ... version:                0
[    0.014998] ... bit width:              48
[    0.014998] ... generic registers:      4
[    0.014998] ... value mask:             0000ffffffffffff
[    0.014998] ... max period:             00007fffffffffff
[    0.014998] ... fixed-purpose events:   0
[    0.014998] ... event mask:             000000000000000f
[    0.014998] System has AMD C1E enabled
[    0.014998] Switch to broadcast mode on CPU0
[    0.026019] Booting Node   0, Processors  #1
[    0.026070] smpboot cpu 1: start_ip = 98000
[    0.098008] Switch to broadcast mode on CPU1
[    0.102022]  #2
[    0.102048] smpboot cpu 2: start_ip = 98000
[    0.173999] Switch to broadcast mode on CPU2
[    0.178022]  #3
[    0.178048] smpboot cpu 3: start_ip = 98000
[    0.250006] Switch to broadcast mode on CPU3
[    0.254011]  #4
[    0.254037] smpboot cpu 4: start_ip = 98000
[    0.325998] Switch to broadcast mode on CPU4
[    0.330004]  #5
[    0.330029] smpboot cpu 5: start_ip = 98000
[    0.401991] Switch to broadcast mode on CPU5
[    0.401995] Brought up 6 CPUs
[    0.401998] Total of 6 processors activated (38529.42 BogoMIPS).
[    0.403013] devtmpfs: initialized
[    0.403070] PM: Registering ACPI NVS region at bd94d000 (327680 bytes)
[    0.403104] PM: Registering ACPI NVS region at bdade000 (69632 bytes)
[    0.403134] PM: Registering ACPI NVS region at bdb02000 (8192 bytes)
[    0.403164] PM: Registering ACPI NVS region at bdb0d000 (24576 bytes)
[    0.403952] PM: Registering ACPI NVS region at bdb75000 (2109440 bytes)
[    0.404059] NET: Registered protocol family 16
[    0.404098] node 0 link 0: io port [d000, ffff]
[    0.404098] TOM: 00000000c0000000 aka 3072M
[    0.404098] Fam 10h mmconf [e0000000, efffffff]
[    0.404098] node 0 link 0: mmio [c0000000, fef0ffff] ==> [c0000000, dfffffff] and [f0000000, fef0ffff]
[    0.404098] TOM2: 0000000240000000 aka 9216M
[    0.404098] bus: [00, 1f] on node 0 link 0
[    0.404098] bus: 00 index 0 [io  0x0000-0xffff]
[    0.404098] bus: 00 index 1 [mem 0xc0000000-0xdfffffff]
[    0.404098] bus: 00 index 2 [mem 0xf0000000-0xffffffff]
[    0.404098] bus: 00 index 3 [mem 0x240000000-0xfcffffffff]
[    0.404098] Extended Config Space enabled on 1 nodes
[    0.404129] ACPI: bus type pci registered
[    0.404163] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.410950] PCI: not using MMCONFIG
[    0.410978] PCI: Using configuration type 1 for base access
[    0.411007] PCI: Using configuration type 1 for extended access
[    0.414972] bio: create slab <bio-0> at 0
[    0.415963] ACPI: Added _OSI(Module Device)
[    0.415993] ACPI: Added _OSI(Processor Device)
[    0.416022] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.416051] ACPI: Added _OSI(Processor Aggregator Device)
[    0.416590] ACPI: EC: Look up EC in DSDT
[    0.416590] ACPI: Executed 2 blocks of module-level executable AML code
[    0.422049] ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110623/psargs-359)
[    0.422156] ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region) (20110623/nsinit-349)
[    0.422531] ACPI: Interpreter enabled
[    0.422561] ACPI: (supports S0 S1 S3 S4 S5)
[    0.422716] ACPI: Using IOAPIC for interrupt routing
[    0.422834] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.422834] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.455959] ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
[    0.455997] HEST: Table not found.
[    0.455997] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.456118] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.456175] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    0.456175] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    0.456175] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    0.456175] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.456179] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.456214] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
[    0.456250] pci_root PNP0A03:00: host bridge window [mem 0xc0000000-0xffffffff]
[    0.456297] pci 0000:00:00.0: [1002:5a14] type 0 class 0x000600
[    0.456332] pci 0000:00:00.2: [1002:5a23] type 0 class 0x000806
[    0.456369] pci 0000:00:02.0: [1002:5a16] type 1 class 0x000604
[    0.456389] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.456391] pci 0000:00:02.0: PME# disabled
[    0.456404] pci 0000:00:04.0: [1002:5a18] type 1 class 0x000604
[    0.456423] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.456425] pci 0000:00:04.0: PME# disabled
[    0.456437] pci 0000:00:07.0: [1002:5a1b] type 1 class 0x000604
[    0.456456] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.456458] pci 0000:00:07.0: PME# disabled
[    0.456481] pci 0000:00:11.0: [1002:4391] type 0 class 0x000106
[    0.456494] pci 0000:00:11.0: reg 10: [io  0xf040-0xf047]
[    0.456501] pci 0000:00:11.0: reg 14: [io  0xf030-0xf033]
[    0.456508] pci 0000:00:11.0: reg 18: [io  0xf020-0xf027]
[    0.456514] pci 0000:00:11.0: reg 1c: [io  0xf010-0xf013]
[    0.456524] pci 0000:00:11.0: reg 20: [io  0xf000-0xf00f]
[    0.456524] pci 0000:00:11.0: reg 24: [mem 0xfeb0b000-0xfeb0b3ff]
[    0.456524] pci 0000:00:12.0: [1002:4397] type 0 class 0x000c03
[    0.456524] pci 0000:00:12.0: reg 10: [mem 0xfeb0a000-0xfeb0afff]
[    0.456524] pci 0000:00:12.2: [1002:4396] type 0 class 0x000c03
[    0.456524] pci 0000:00:12.2: reg 10: [mem 0xfeb09000-0xfeb090ff]
[    0.456524] pci 0000:00:12.2: supports D1 D2
[    0.456524] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.456524] pci 0000:00:12.2: PME# disabled
[    0.456524] pci 0000:00:13.0: [1002:4397] type 0 class 0x000c03
[    0.456524] pci 0000:00:13.0: reg 10: [mem 0xfeb08000-0xfeb08fff]
[    0.456524] pci 0000:00:13.2: [1002:4396] type 0 class 0x000c03
[    0.456524] pci 0000:00:13.2: reg 10: [mem 0xfeb07000-0xfeb070ff]
[    0.456524] pci 0000:00:13.2: supports D1 D2
[    0.456524] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.456524] pci 0000:00:13.2: PME# disabled
[    0.456524] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
[    0.456524] pci 0000:00:14.2: [1002:4383] type 0 class 0x000403
[    0.456524] pci 0000:00:14.2: reg 10: [mem 0xfeb00000-0xfeb03fff 64bit]
[    0.456524] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.456524] pci 0000:00:14.2: PME# disabled
[    0.456524] pci 0000:00:14.3: [1002:439d] type 0 class 0x000601
[    0.456524] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
[    0.456524] pci 0000:00:14.5: [1002:4399] type 0 class 0x000c03
[    0.456524] pci 0000:00:14.5: reg 10: [mem 0xfeb06000-0xfeb06fff]
[    0.456534] pci 0000:00:16.0: [1002:4397] type 0 class 0x000c03
[    0.456543] pci 0000:00:16.0: reg 10: [mem 0xfeb05000-0xfeb05fff]
[    0.456591] pci 0000:00:16.2: [1002:4396] type 0 class 0x000c03
[    0.456604] pci 0000:00:16.2: reg 10: [mem 0xfeb04000-0xfeb040ff]
[    0.456652] pci 0000:00:16.2: supports D1 D2
[    0.456653] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.456656] pci 0000:00:16.2: PME# disabled
[    0.456669] pci 0000:00:18.0: [1022:1200] type 0 class 0x000600
[    0.456680] pci 0000:00:18.1: [1022:1201] type 0 class 0x000600
[    0.456689] pci 0000:00:18.2: [1022:1202] type 0 class 0x000600
[    0.456698] pci 0000:00:18.3: [1022:1203] type 0 class 0x000600
[    0.456709] pci 0000:00:18.4: [1022:1204] type 0 class 0x000600
[    0.456748] pci 0000:01:00.0: [1002:6758] type 0 class 0x000300
[    0.456761] pci 0000:01:00.0: reg 10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.456771] pci 0000:01:00.0: reg 18: [mem 0xfea20000-0xfea3ffff 64bit]
[    0.456778] pci 0000:01:00.0: reg 20: [io  0xe000-0xe0ff]
[    0.456790] pci 0000:01:00.0: reg 30: [mem 0xfea00000-0xfea1ffff pref]
[    0.456806] pci 0000:01:00.0: supports D1 D2
[    0.456828] pci 0000:01:00.1: [1002:aa90] type 0 class 0x000403
[    0.456840] pci 0000:01:00.1: reg 10: [mem 0xfea40000-0xfea43fff 64bit]
[    0.456883] pci 0000:01:00.1: supports D1 D2
[    0.458956] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.458989] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.458991] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.458994] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.459027] pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
[    0.459039] pci 0000:02:00.0: reg 10: [io  0xd000-0xd0ff]
[    0.459057] pci 0000:02:00.0: reg 18: [mem 0xd4004000-0xd4004fff 64bit pref]
[    0.459069] pci 0000:02:00.0: reg 20: [mem 0xd4000000-0xd4003fff 64bit pref]
[    0.459101] pci 0000:02:00.0: supports D1 D2
[    0.459103] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.459106] pci 0000:02:00.0: PME# disabled
[    0.460955] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.460987] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.460991] pci 0000:00:04.0:   bridge window [mem 0xd4000000-0xd40fffff 64bit pref]
[    0.461027] pci 0000:03:00.0: [1b21:1042] type 0 class 0x000c03
[    0.461044] pci 0000:03:00.0: reg 10: [mem 0xfe900000-0xfe907fff 64bit]
[    0.461114] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.461118] pci 0000:03:00.0: PME# disabled
[    0.462954] pci 0000:00:07.0: PCI bridge to [bus 03-03]
[    0.462987] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.463015] pci 0000:04:05.0: [4444:0016] type 0 class 0x000400
[    0.463033] pci 0000:04:05.0: reg 10: [mem 0xd0000000-0xd3ffffff pref]
[    0.463139] pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive decode)
[    0.463173] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd3ffffff pref]
[    0.463175] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.463177] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.463179] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.463180] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.463182] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.463184] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.463186] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff] (subtractive decode)
[    0.463196] pci_bus 0000:00: on NUMA node 0
[    0.463200] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.463283] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.463324] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC02._PRT]
[    0.463340] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC04._PRT]
[    0.463357] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC07._PRT]
[    0.463375]  pci0000:00: Requesting ACPI _OSC control (0x15)
[    0.463405]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x15
[    0.463441] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.466971] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.467247] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.467518] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.467518] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 10 11 14 15) *0
[    0.467518] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.467579] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.467832] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.468114] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.468965] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.468986] vgaarb: loaded
[    0.469014] vgaarb: bridge control possible 0000:01:00.0
[    0.469072] SCSI subsystem initialized
[    0.469072] libata version 3.00 loaded.
[    0.469072] usbcore: registered new interface driver usbfs
[    0.469967] usbcore: registered new interface driver hub
[    0.469972] usbcore: registered new device driver usb
[    0.469973] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    0.469976] PCI: Using ACPI for IRQ routing
[    0.475357] PCI: pci_cache_line_size set to 64 bytes
[    0.475414] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    0.475416] reserve RAM buffer: 00000000bd94d000 - 00000000bfffffff 
[    0.475419] reserve RAM buffer: 00000000bdf00000 - 00000000bfffffff 
[    0.475969] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.476074] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.477957] Switching to clocksource hpet
[    0.478030] Switched to NOHz mode on CPU #3
[    0.478077] Switched to NOHz mode on CPU #1
[    0.478038] Switched to NOHz mode on CPU #5
[    0.478079] Switched to NOHz mode on CPU #0
[    0.478046] Switched to NOHz mode on CPU #4
[    0.478079] Switched to NOHz mode on CPU #2
[    0.482711] pnp: PnP ACPI init
[    0.482743] ACPI: bus type pnp registered
[    0.482854] pnp 00:00: [bus 00-ff]
[    0.482856] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.482859] pnp 00:00: [io  0x0000-0x03af window]
[    0.482860] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    0.482862] pnp 00:00: [io  0x03b0-0x03df window]
[    0.482863] pnp 00:00: [io  0x0d00-0xffff window]
[    0.482865] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.482866] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    0.482868] pnp 00:00: [mem 0xc0000000-0xffffffff window]
[    0.482869] pnp 00:00: [mem 0x00000000 window]
[    0.482974] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.482993] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    0.483079] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.483110] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.483366] pnp 00:02: [io  0x040b]
[    0.483367] pnp 00:02: [io  0x04d6]
[    0.483369] pnp 00:02: [io  0x0c00-0x0c01]
[    0.483370] pnp 00:02: [io  0x0c14]
[    0.483371] pnp 00:02: [io  0x0c50-0x0c51]
[    0.483372] pnp 00:02: [io  0x0c52]
[    0.483374] pnp 00:02: [io  0x0c6c]
[    0.483375] pnp 00:02: [io  0x0c6f]
[    0.483376] pnp 00:02: [io  0x0cd0-0x0cd1]
[    0.483377] pnp 00:02: [io  0x0cd2-0x0cd3]
[    0.483379] pnp 00:02: [io  0x0cd4-0x0cd5]
[    0.483380] pnp 00:02: [io  0x0cd6-0x0cd7]
[    0.483381] pnp 00:02: [io  0x0cd8-0x0cdf]
[    0.483382] pnp 00:02: [io  0x0800-0x089f]
[    0.483384] pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
[    0.483385] pnp 00:02: [io  0x0000-0x000f]
[    0.483387] pnp 00:02: [io  0x0b20-0x0b3f]
[    0.483388] pnp 00:02: [io  0x0900-0x090f]
[    0.483389] pnp 00:02: [io  0x0910-0x091f]
[    0.483391] pnp 00:02: [io  0xfe00-0xfefe]
[    0.483392] pnp 00:02: [io  0x0060-0x005f disabled]
[    0.483394] pnp 00:02: [io  0x0064-0x0063 disabled]
[    0.483395] pnp 00:02: [mem 0xfec00000-0xfec00fff]
[    0.483397] pnp 00:02: [mem 0xfee00000-0xfee00fff]
[    0.483398] pnp 00:02: [mem 0xfed80000-0xfed8ffff]
[    0.483399] pnp 00:02: [mem 0xfed61000-0xfed70fff]
[    0.483401] pnp 00:02: [mem 0xfec10000-0xfec10fff]
[    0.483402] pnp 00:02: [mem 0xfed00000-0xfed00fff]
[    0.483404] pnp 00:02: [mem 0xffc00000-0xffffffff]
[    0.483511] system 00:02: [io  0x040b] has been reserved
[    0.483541] system 00:02: [io  0x04d6] has been reserved
[    0.483571] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.483600] system 00:02: [io  0x0c14] has been reserved
[    0.483630] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    0.483659] system 00:02: [io  0x0c52] has been reserved
[    0.483689] system 00:02: [io  0x0c6c] has been reserved
[    0.483718] system 00:02: [io  0x0c6f] has been reserved
[    0.483747] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.483777] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.483807] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.483836] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.483866] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.483896] system 00:02: [io  0x0800-0x089f] has been reserved
[    0.483926] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.483956] system 00:02: [io  0x0900-0x090f] has been reserved
[    0.483985] system 00:02: [io  0x0910-0x091f] has been reserved
[    0.484031] system 00:02: [io  0xfe00-0xfefe] has been reserved
[    0.484077] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.484107] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.484138] system 00:02: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.484169] system 00:02: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.484199] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.484230] system 00:02: [mem 0xfed00000-0xfed00fff] has been reserved
[    0.484260] system 00:02: [mem 0xffc00000-0xffffffff] has been reserved
[    0.484291] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.484366] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.484368] pnp 00:03: [io  0x0290-0x02af]
[    0.484369] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.484451] system 00:03: [io  0x0290-0x02af] has been reserved
[    0.484481] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.484490] pnp 00:04: [dma 4]
[    0.484492] pnp 00:04: [io  0x0000-0x000f]
[    0.484494] pnp 00:04: [io  0x0081-0x0083]
[    0.484495] pnp 00:04: [io  0x0087]
[    0.484496] pnp 00:04: [io  0x0089-0x008b]
[    0.484498] pnp 00:04: [io  0x008f]
[    0.484499] pnp 00:04: [io  0x00c0-0x00df]
[    0.484547] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.484552] pnp 00:05: [io  0x0070-0x0071]
[    0.484558] pnp 00:05: [irq 8]
[    0.484605] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.484610] pnp 00:06: [io  0x0061]
[    0.484656] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.484669] pnp 00:07: [io  0x0010-0x001f]
[    0.484671] pnp 00:07: [io  0x0022-0x003f]
[    0.484672] pnp 00:07: [io  0x0044-0x005f]
[    0.484673] pnp 00:07: [io  0x0062-0x0063]
[    0.484675] pnp 00:07: [io  0x0065-0x006f]
[    0.484676] pnp 00:07: [io  0x0072-0x007f]
[    0.484677] pnp 00:07: [io  0x0080]
[    0.484678] pnp 00:07: [io  0x0084-0x0086]
[    0.484679] pnp 00:07: [io  0x0088]
[    0.484680] pnp 00:07: [io  0x008c-0x008e]
[    0.484682] pnp 00:07: [io  0x0090-0x009f]
[    0.484683] pnp 00:07: [io  0x00a2-0x00bf]
[    0.484684] pnp 00:07: [io  0x00e0-0x00ef]
[    0.484685] pnp 00:07: [io  0x04d0-0x04d1]
[    0.484746] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    0.484777] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.484782] pnp 00:08: [io  0x00f0-0x00ff]
[    0.484785] pnp 00:08: [irq 13]
[    0.484832] pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.484896] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.484908] pnp 00:0a: [io  0x0060]
[    0.484909] pnp 00:0a: [io  0x0064]
[    0.484912] pnp 00:0a: [irq 1]
[    0.484961] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.484979] pnp 00:0b: [irq 12]
[    0.485058] pnp 00:0b: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.485163] pnp 00:0c: [io  0x03f8-0x03ff]
[    0.485167] pnp 00:0c: [irq 4]
[    0.485168] pnp 00:0c: [dma 0 disabled]
[    0.485264] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.485328] pnp 00:0d: [mem 0xfeb20000-0xfeb23fff]
[    0.485390] system 00:0d: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.485421] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.485466] pnp 00:0e: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.485467] pnp 00:0e: [mem 0xfec20000-0xfec200ff]
[    0.485541] system 00:0e: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.485571] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.485642] pnp 00:0f: [mem 0xfed00000-0xfed003ff]
[    0.485732] pnp 00:0f: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.485736] pnp: PnP ACPI: found 16 devices
[    0.485765] ACPI: ACPI bus type pnp unregistered
[    0.490399] PCI: max bus depth: 1 pci_try_num: 2
[    0.490412] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.490441] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.490471] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.490501] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.490537] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.490566] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.490596] pci 0000:00:04.0:   bridge window [mem 0xd4000000-0xd40fffff 64bit pref]
[    0.490632] pci 0000:00:07.0: PCI bridge to [bus 03-03]
[    0.490662] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.490692] pci 0000:00:14.4: PCI bridge to [bus 04-04]
[    0.490725] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd3ffffff pref]
[    0.490768] pci 0000:00:02.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
[    0.490799] pci 0000:00:02.0: setting latency timer to 64
[    0.490802] pci 0000:00:04.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
[    0.490832] pci 0000:00:04.0: setting latency timer to 64
[    0.490836] pci 0000:00:07.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
[    0.490866] pci 0000:00:07.0: setting latency timer to 64
[    0.490871] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.490873] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.490875] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.490876] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.490878] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.490879] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.490881] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff]
[    0.490883] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.490885] pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.490887] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.490888] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.490890] pci_bus 0000:02: resource 2 [mem 0xd4000000-0xd40fffff 64bit pref]
[    0.490892] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.490894] pci_bus 0000:04: resource 2 [mem 0xd0000000-0xd3ffffff pref]
[    0.490896] pci_bus 0000:04: resource 4 [io  0x0000-0x03af]
[    0.490897] pci_bus 0000:04: resource 5 [io  0x03e0-0x0cf7]
[    0.490899] pci_bus 0000:04: resource 6 [io  0x03b0-0x03df]
[    0.490901] pci_bus 0000:04: resource 7 [io  0x0d00-0xffff]
[    0.490902] pci_bus 0000:04: resource 8 [mem 0x000a0000-0x000bffff]
[    0.490904] pci_bus 0000:04: resource 9 [mem 0x000c0000-0x000dffff]
[    0.490906] pci_bus 0000:04: resource 10 [mem 0xc0000000-0xffffffff]
[    0.490928] NET: Registered protocol family 2
[    0.490984] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.491381] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.492424] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.492698] TCP: Hash tables configured (established 262144 bind 65536)
[    0.492728] TCP reno registered
[    0.492757] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.492822] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.492939] NET: Registered protocol family 1
[    0.493089] RPC: Registered named UNIX socket transport module.
[    0.493128] RPC: Registered udp transport module.
[    0.493156] RPC: Registered tcp transport module.
[    0.493186] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.325140] pci 0000:01:00.0: Boot video device
[    1.325176] PCI: CLS 64 bytes, default 64
[    1.325389] pci 0000:00:00.2: PCI INT A -> GSI 55 (level, low) -> IRQ 55
[    1.325449] pci 0000:00:00.2: irq 72 for MSI/MSI-X
[    1.325529] AMD-Vi: Enabling IOMMU at 0000:00:00.2 cap 0x40
[    1.385962] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.385992] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.386031] Placing 64MB software IO TLB between ffff8800b994d000 - ffff8800bd94d000
[    1.386067] software IO TLB at phys 0xb994d000 - 0xbd94d000
[    1.406022] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.444996] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.445053] msgmni has been set to 15885
[    1.445373] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.445410] io scheduler noop registered
[    1.445492] io scheduler cfq registered (default)
[    1.445851] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[    1.466436] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.511826] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.520414] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    1.520464] Hangcheck: Using getrawmonotonic().
[    1.520566] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    1.520604] ACPI: Power Button [PWRB]
[    1.520696] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.520732] ACPI: Power Button [PWRF]
[    1.520841] ACPI: acpi_idle registered with cpuidle
[    1.520865] ACPI: processor limited to max C-state 1
[    1.584412] ERST: Table is not found!
[    1.584485] [drm] Initialized drm 1.1.0 20060810
[    1.586438] brd: module loaded
[    1.587479] loop: module loaded
[    1.587810] ahci 0000:00:11.0: version 3.0
[    1.587820] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.587972] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    1.588023] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.589131] scsi0 : ahci
[    1.589283] scsi1 : ahci
[    1.589418] scsi2 : ahci
[    1.589553] scsi3 : ahci
[    1.589687] scsi4 : ahci
[    1.589821] scsi5 : ahci
[    1.590089] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b100 irq 19
[    1.596754] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b180 irq 19
[    1.596790] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19
[    1.596826] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b280 irq 19
[    1.596861] ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b300 irq 19
[    1.596897] ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b380 irq 19
[    1.597288] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.597339] r8169 0000:02:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
[    1.597391] r8169 0000:02:00.0: setting latency timer to 64
[    1.597438] r8169 0000:02:00.0: irq 73 for MSI/MSI-X
[    1.597660] r8169 0000:02:00.0: eth0: RTL8168evl/8111evl at 0xffffc90000008000, 14:da:e9:03:e9:b7, XID 0c900800 IRQ 73
[    1.597778] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.597816] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.597853] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    1.597885] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.597925] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.597977] QUIRK: Enable AMD PLL fix
[    1.597985] ehci_hcd 0000:00:12.2: debug port 1
[    1.598047] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfeb09000
[    1.605084] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.605131] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.605161] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.605202] usb usb1: Product: EHCI Host Controller
[    1.605231] usb usb1: Manufacturer: Linux 3.1.1-gentoo ehci_hcd
[    1.605259] usb usb1: SerialNumber: 0000:00:12.2
[    1.605467] hub 1-0:1.0: USB hub found
[    1.605498] hub 1-0:1.0: 5 ports detected
[    1.605574] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.605622] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    1.605653] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.605692] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.605742] ehci_hcd 0000:00:13.2: debug port 1
[    1.605784] ehci_hcd 0000:00:13.2: irq 21, io mem 0xfeb07000
[    1.611092] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.611138] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.611167] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.611203] usb usb2: Product: EHCI Host Controller
[    1.611232] usb usb2: Manufacturer: Linux 3.1.1-gentoo ehci_hcd
[    1.611261] usb usb2: SerialNumber: 0000:00:13.2
[    1.611491] hub 2-0:1.0: USB hub found
[    1.611520] hub 2-0:1.0: 5 ports detected
[    1.611595] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 23 (level, low) -> IRQ 23
[    1.611633] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    1.611664] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.611708] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.611758] ehci_hcd 0000:00:16.2: debug port 1
[    1.611799] ehci_hcd 0000:00:16.2: irq 23, io mem 0xfeb04000
[    1.617091] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.617147] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.617177] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.617213] usb usb3: Product: EHCI Host Controller
[    1.617242] usb usb3: Manufacturer: Linux 3.1.1-gentoo ehci_hcd
[    1.617271] usb usb3: SerialNumber: 0000:00:16.2
[    1.617474] hub 3-0:1.0: USB hub found
[    1.617504] hub 3-0:1.0: 4 ports detected
[    1.617606] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.617645] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.617691] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    1.617722] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
[    1.617774] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
[    1.672115] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.672145] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.672181] usb usb4: Product: OHCI Host Controller
[    1.672210] usb usb4: Manufacturer: Linux 3.1.1-gentoo ohci_hcd
[    1.672239] usb usb4: SerialNumber: 0000:00:12.0
[    1.672469] hub 4-0:1.0: USB hub found
[    1.672501] hub 4-0:1.0: 5 ports detected
[    1.672574] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    1.672613] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    1.672647] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
[    1.672708] ohci_hcd 0000:00:13.0: irq 20, io mem 0xfeb08000
[    1.727112] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.727143] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.727177] usb usb5: Product: OHCI Host Controller
[    1.727206] usb usb5: Manufacturer: Linux 3.1.1-gentoo ohci_hcd
[    1.727235] usb usb5: SerialNumber: 0000:00:13.0
[    1.727465] hub 5-0:1.0: USB hub found
[    1.727497] hub 5-0:1.0: 5 ports detected
[    1.727568] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.727606] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    1.727637] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
[    1.727686] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
[    1.782112] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    1.782143] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.782179] usb usb6: Product: OHCI Host Controller
[    1.782208] usb usb6: Manufacturer: Linux 3.1.1-gentoo ohci_hcd
[    1.782237] usb usb6: SerialNumber: 0000:00:14.5
[    1.782466] hub 6-0:1.0: USB hub found
[    1.782498] hub 6-0:1.0: 2 ports detected
[    1.782568] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    1.782607] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    1.782638] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
[    1.782697] ohci_hcd 0000:00:16.0: irq 22, io mem 0xfeb05000
[    1.837112] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    1.837143] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.837179] usb usb7: Product: OHCI Host Controller
[    1.837208] usb usb7: Manufacturer: Linux 3.1.1-gentoo ohci_hcd
[    1.837237] usb usb7: SerialNumber: 0000:00:16.0
[    1.837464] hub 7-0:1.0: USB hub found
[    1.837496] hub 7-0:1.0: 4 ports detected
[    1.837614] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 50 (level, low) -> IRQ 50
[    1.837666] xhci_hcd 0000:03:00.0: setting latency timer to 64
[    1.837669] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    1.837700] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
[    1.847357] xhci_hcd 0000:03:00.0: irq 50, io mem 0xfe900000
[    1.847413] xhci_hcd 0000:03:00.0: irq 74 for MSI/MSI-X
[    1.847415] xhci_hcd 0000:03:00.0: irq 75 for MSI/MSI-X
[    1.847418] xhci_hcd 0000:03:00.0: irq 76 for MSI/MSI-X
[    1.847420] xhci_hcd 0000:03:00.0: irq 77 for MSI/MSI-X
[    1.847422] xhci_hcd 0000:03:00.0: irq 78 for MSI/MSI-X
[    1.847424] xhci_hcd 0000:03:00.0: irq 79 for MSI/MSI-X
[    1.847426] xhci_hcd 0000:03:00.0: irq 80 for MSI/MSI-X
[    1.847491] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[    1.847520] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.847556] usb usb8: Product: xHCI Host Controller
[    1.847585] usb usb8: Manufacturer: Linux 3.1.1-gentoo xhci_hcd
[    1.847614] usb usb8: SerialNumber: 0000:03:00.0
[    1.847786] xHCI xhci_add_endpoint called for root hub
[    1.847787] xHCI xhci_check_bandwidth called for root hub
[    1.847833] hub 8-0:1.0: USB hub found
[    1.847864] hub 8-0:1.0: 2 ports detected
[    1.847924] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    1.847955] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 9
[    1.848016] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[    1.848054] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.848090] usb usb9: Product: xHCI Host Controller
[    1.848120] usb usb9: Manufacturer: Linux 3.1.1-gentoo xhci_hcd
[    1.848149] usb usb9: SerialNumber: 0000:03:00.0
[    1.848300] xHCI xhci_add_endpoint called for root hub
[    1.848301] xHCI xhci_check_bandwidth called for root hub
[    1.848348] hub 9-0:1.0: USB hub found
[    1.848379] hub 9-0:1.0: 2 ports detected
[    1.848472] Initializing USB Mass Storage driver...
[    1.848584] usbcore: registered new interface driver usb-storage
[    1.848614] USB Mass Storage support registered.
[    1.848708] usbcore: registered new interface driver libusual
[    1.848814] usbcore: registered new interface driver usbserial
[    1.848880] USB Serial support registered for generic
[    1.901101] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.902108] ata4: SATA link down (SStatus 0 SControl 300)
[    1.902169] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.902221] ata3: SATA link down (SStatus 0 SControl 300)
[    1.902274] ata5: SATA link down (SStatus 0 SControl 300)
[    1.902329] ata6: SATA link down (SStatus 0 SControl 300)
[    1.907107] ata1.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
[    1.907139] ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.909354] ata2.00: ATA-8: WDC WD3000HLFS-01G6U4, 04.04V06, max UDMA/133
[    1.909386] ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.914158] ata1.00: configured for UDMA/133
[    1.914288] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
[    1.914577] sd 0:0:0:0: [sda] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[    1.914722] sd 0:0:0:0: [sda] Write Protect is off
[    1.914752] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.914781] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.917362] ata2.00: configured for UDMA/133
[    1.917511] scsi 1:0:0:0: Direct-Access     ATA      WDC WD3000HLFS-0 04.0 PQ: 0 ANSI: 5
[    1.917775] sd 1:0:0:0: [sdb] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[    1.917904] sd 1:0:0:0: [sdb] Write Protect is off
[    1.917938] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.917975] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.919104] usb 3-2: new high speed USB device number 2 using ehci_hcd
[    1.940961]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
[    1.941731] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.942382]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
[    1.950030] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.037460] usb 3-2: New USB device found, idVendor=05dc, idProduct=a400
[    2.037491] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.037521] usb 3-2: Product: JUMPDRIVE SECURE
[    2.037550] usb 3-2: Manufacturer: LEXAR MEDIA
[    2.037579] usb 3-2: SerialNumber: 0A4F1006214746281004
[    2.038118] scsi6 : usb-storage 3-2:1.0
[    2.038360] usbcore: registered new interface driver usbserial_generic
[    2.038392] usbserial: USB Serial Driver core
[    2.038520] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    2.038949] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.038999] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.039199] mousedev: PS/2 mouse device common for all mice
[    2.039492] rtc_cmos 00:05: RTC can wake from S4
[    2.039624] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.039669] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.039736] i2c /dev entries driver
[    2.039814] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    2.040036] it87: Found IT8721F chip at 0x290, revision 1
[    2.040414] md: raid0 personality registered for level 0
[    2.040443] md: raid1 personality registered for level 1
[    2.040472] md: raid10 personality registered for level 10
[    2.040503] cpuidle: using governor ladder
[    2.040532] cpuidle: using governor menu
[    2.041307] usbcore: registered new interface driver usbhid
[    2.041337] usbhid: USB HID core driver
[    2.041460] snd_hda_intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.053489] hda_codec: ALC887-VD: BIOS auto-probing.
[    2.059985] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    2.061414] input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input3
[    2.061572] snd_hda_intel 0000:01:00.1: PCI INT B -> GSI 25 (level, low) -> IRQ 25
[    2.061641] snd_hda_intel 0000:01:00.1: irq 81 for MSI/MSI-X
[    2.061658] snd_hda_intel 0000:01:00.1: setting latency timer to 64
[    2.065413] HDMI status: Codec=0 Pin=3 Presence_Detect=0 ELD_Valid=0
[    2.065728] input: HD-Audio Generic HDMI/DP as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input4
[    2.065928] ALSA device list:
[    2.065956]   #0: HDA ATI SB at 0xfeb00000 irq 16
[    2.065985]   #1: HD-Audio Generic at 0xfea40000 irq 81
[    2.066048] TCP cubic registered
[    2.066313] NET: Registered protocol family 10
[    2.066452] NET: Registered protocol family 17
[    2.066486] Registering the dns_resolver key type
[    2.066725] registered taskstats version 1
[    2.084849] rtc_cmos 00:05: setting system clock to 2011-12-21 19:33:58 UTC (1324496038)
[    2.084906] powernow-k8: Found 1 AMD Phenom(tm) II X6 1090T Processor (6 cpu cores) (version 2.20.00)
[    2.084957] powernow-k8: Core Performance Boosting: on.
[    2.085031] powernow-k8:    0 : pstate 0 (3200 MHz)
[    2.085061] powernow-k8:    1 : pstate 1 (2400 MHz)
[    2.085090] powernow-k8:    2 : pstate 2 (1600 MHz)
[    2.085121] powernow-k8:    3 : pstate 3 (800 MHz)
[    2.232538] alps.c: E6 report: 7a 03 c8
[    2.388153] Refined TSC clocksource calibration: 3210.781 MHz.
[    2.388207] Switching to clocksource tsc
[    2.855193] input: ImExPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input5
[    2.858877] md: Waiting for all devices to be available before autodetect
[    2.858909] md: If you don't use raid, use raid=noautodetect
[    2.859443] md: Autodetecting RAID arrays.
[    2.876855] md: invalid raid superblock magic on sda4
[    2.876901] md: sda4 does not have a valid v0.90 superblock, not importing!
[    2.881078] md: invalid raid superblock magic on sda5
[    2.881123] md: sda5 does not have a valid v0.90 superblock, not importing!
[    2.892081] md: invalid raid superblock magic on sda6
[    2.892113] md: sda6 does not have a valid v0.90 superblock, not importing!
[    2.912805] md: invalid raid superblock magic on sdb4
[    2.912850] md: sdb4 does not have a valid v0.90 superblock, not importing!
[    2.919899] md: invalid raid superblock magic on sdb5
[    2.919944] md: sdb5 does not have a valid v0.90 superblock, not importing!
[    2.930121] md: invalid raid superblock magic on sdb6
[    2.930166] md: sdb6 does not have a valid v0.90 superblock, not importing!
[    2.930226] md: Scanned 8 and added 2 devices.
[    2.930263] md: autorun ...
[    2.930298] md: considering sdb3 ...
[    2.930343] md:  adding sdb3 ...
[    2.930384] md:  adding sda3 ...
[    2.930424] md: created md0
[    2.930459] md: bind<sda3>
[    2.930518] md: bind<sdb3>
[    2.930567] md: running: <sdb3><sda3>
[    2.931073] bio: create slab <bio-1> at 1
[    2.931316] md/raid1:md0: active with 2 out of 2 mirrors
[    2.931398] md0: detected capacity change from 0 to 1090453504
[    2.931597] md: ... autorun DONE.
[    2.943373]  md0: unknown partition table
[    2.967148] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
[    2.967221] VFS: Mounted root (ext4 filesystem) readonly on device 9:0.
[    2.978717] devtmpfs: mounted
[    2.978939] Freeing unused kernel memory: 448k freed
[    3.038991] scsi 6:0:0:0: Direct-Access     LEXAR    JUMPDRIVE SECURE 1000 PQ: 0 ANSI: 0 CCS
[    3.040401] scsi: killing requests for dead queue
[    3.040973] sd 6:0:0:0: [sdc] 248928 512-byte logical blocks: (127 MB/121 MiB)
[    3.041038] scsi: killing requests for dead queue
[    3.042046] sd 6:0:0:0: [sdc] Write Protect is off
[    3.042058] scsi: killing requests for dead queue
[    3.042128] sd 6:0:0:0: [sdc] Mode Sense: 43 00 00 00
[    3.042996] sd 6:0:0:0: [sdc] No Caching mode page present
[    3.043025] scsi: killing requests for dead queue
[    3.043098] sd 6:0:0:0: [sdc] Assuming drive cache: write through
[    3.043325] scsi: killing requests for dead queue
[    3.044400] scsi: killing requests for dead queue
[    3.045065] scsi: killing requests for dead queue
[    3.046815] sd 6:0:0:0: [sdc] No Caching mode page present
[    3.046846] sd 6:0:0:0: [sdc] Assuming drive cache: write through
[    3.048090]  sdc: sdc1 sdc2
[    3.052083] sd 6:0:0:0: [sdc] No Caching mode page present
[    3.052128] sd 6:0:0:0: [sdc] Assuming drive cache: write through
[    3.052169] sd 6:0:0:0: [sdc] Attached SCSI disk
[    4.131381] udevd[984]: starting version 171
[    4.423708] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    4.442211] Error: Driver 'pcspkr' is already registered, aborting...
[    4.447296] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.447430] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    4.447573] sd 6:0:0:0: Attached scsi generic sg2 type 0
[    4.475714] Linux video capture interface: v2.00
[    4.521057] ivtv: Start initialization, version 1.4.3
[    4.521159] ivtv0: Initializing card 0
[    4.521168] ivtv0: Autodetected Hauppauge card (cx23416 based)
[    4.521325] ivtv 0000:04:05.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    4.521342] ivtv0: Unreasonably low latency timer, setting to 64 (was 32)
[    4.582284] tveeprom 1-0050: Hauppauge model 26559, rev B260, serial# 7666186
[    4.582286] tveeprom 1-0050: tuner model is LG S001D MK3 (idx 60, type 38)
[    4.582289] tveeprom 1-0050: TV standards PAL(B/G) PAL(I) SECAM(L/L') PAL(D/D1/K) (eeprom 0x74)
[    4.582291] tveeprom 1-0050: audio processor is CX25843 (idx 37)
[    4.582293] tveeprom 1-0050: decoder processor is CX25843 (idx 30)
[    4.582295] tveeprom 1-0050: has radio
[    4.582296] ivtv0: Autodetected Hauppauge WinTV PVR-150
[    4.608296] cx25840 1-0044: cx25843-23 found @ 0x88 (ivtv i2c driver #0)
[    4.623129] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[    4.628105] i2c-core: driver [tuner] using legacy suspend method
[    4.628113] i2c-core: driver [tuner] using legacy resume method
[    4.695384] [fglrx] Maximum main memory to use for locked dma buffers: 7711 MBytes.
[    4.695510] [fglrx]   vendor: 1002 device: 6758 count: 1
[    4.695621] tda9887 1-0043: creating new instance
[    4.695630] tda9887 1-0043: tda988[5/6/7] found
[    4.696063] [fglrx] ioport: bar 4, base 0xe000, size: 0x100
[    4.696081] pci 0000:01:00.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
[    4.696085] pci 0000:01:00.0: setting latency timer to 64
[    4.696422] [fglrx] Kernel PAT support is enabled
[    4.696439] [fglrx] module loaded - fglrx 8.91.4 [Oct 25 2011] with 1 minors
[    4.697042] tuner 1-0043: Tuner 74 found with type(s) Radio TV.
[    4.699793] tuner 1-0061: Tuner -1 found with type(s) Radio TV.
[    4.720239] wm8775 1-001b: chip found @ 0x36 (ivtv i2c driver #0)
[    4.739526] md: bind<sdb4>
[    4.753677] tuner-simple 1-0061: creating new instance
[    4.753682] tuner-simple 1-0061: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3))
[    4.756812] ivtv0: Registered device video0 for encoder MPG (4096 kB)
[    4.756938] ivtv0: Registered device video32 for encoder YUV (2048 kB)
[    4.757022] ivtv0: Registered device vbi0 for encoder VBI (1024 kB)
[    4.757097] ivtv0: Registered device video24 for encoder PCM (320 kB)
[    4.757174] ivtv0: Registered device radio0 for encoder radio
[    4.757180] ivtv0: Initialized card: Hauppauge WinTV PVR-150
[    4.757214] ivtv: End initialization
[    4.759589] md: bind<sdb5>
[    4.788607] md: bind<sdb6>
[    4.804060] md: bind<sda6>
[    4.807186] md/raid10:md3: active with 2 out of 2 devices
[    4.807245] md3: detected capacity change from 0 to 233556410368
[    4.814675] md: bind<sda4>
[    4.817724] md/raid10:md1: active with 2 out of 2 devices
[    4.817773] md1: detected capacity change from 0 to 17453285376
[    4.822103]  md3: unknown partition table
[    4.837868]  md1: unknown partition table
[    4.949708] md: bind<sda5>
[    4.952737] md/raid10:md2: active with 2 out of 2 devices
[    4.952787] md2: detected capacity change from 0 to 34907881472
[    4.973423]  md2: unknown partition table
[    5.459448] ivtv0: Loaded v4l-cx2341x-enc.fw firmware (376836 bytes)
[    5.659297] ivtv0: Encoder revision: 0x02060039
[    9.282358] cx25840 1-0044: loaded v4l-cx25840.fw firmware (16382 bytes)
[   10.463394] EXT4-fs (md0): re-mounted. Opts: (null)
[   10.609959] EXT4-fs (md1): mounted filesystem with ordered data mode. Opts: (null)
[   10.666254] EXT4-fs (md2): mounted filesystem with ordered data mode. Opts: (null)
[   10.713233] EXT4-fs (md3): mounted filesystem with ordered data mode. Opts: (null)
[   12.189600] Adding 4228092k swap on /dev/sda7.  Priority:-1 extents:1 across:4228092k 
[   12.501164] r8169 0000:02:00.0: eth0: unable to load firmware patch rtl_nic/rtl8168e-3.fw (-2)
[   12.509031] r8169 0000:02:00.0: eth0: link down
[   12.509062] r8169 0000:02:00.0: eth0: link down
[   12.511260] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   14.641522] r8169 0000:02:00.0: eth0: link up
[   14.643686] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   25.074055] eth0: no IPv6 routers present
[   28.614320] fglrx_pci 0000:01:00.0: irq 82 for MSI/MSI-X
[   28.614771] [fglrx] Firegl kernel thread PID: 2310
[   28.614828] [fglrx] Firegl kernel thread PID: 2311
[   28.614883] [fglrx] Firegl kernel thread PID: 2312
[   28.614966] [fglrx] IRQ 82 Enabled
[   29.564194] [fglrx] Gart USWC size:1280 M.
[   29.564197] [fglrx] Gart cacheable size:508 M.
[   29.564200] [fglrx] Reserved FB block: Shared offset:0, size:1000000 
[   29.564202] [fglrx] Reserved FB block: Unshared offset:f8fd000, size:403000 
[   29.564204] [fglrx] Reserved FB block: Unshared offset:3fff4000, size:c000 
[   33.379407] fuse init (API version 7.17)
[   37.069918] ata1.00: configured for UDMA/133
[   37.069931] ata1: EH complete
[   37.509193] ata2.00: configured for UDMA/133
[   37.509205] ata2: EH complete
[   37.967061] usb 3-2: reset high speed USB device number 2 using ehci_hcd
[   38.186091] usb 3-2: reset high speed USB device number 2 using ehci_hcd
[   38.405092] usb 3-2: reset high speed USB device number 2 using ehci_hcd
[   38.624129] usb 3-2: reset high speed USB device number 2 using ehci_hcd
[   38.872069] EXT4-fs (md0): re-mounted. Opts: commit=0
[   38.883837] EXT4-fs (md1): re-mounted. Opts: commit=0
[   38.997085] EXT4-fs (md2): re-mounted. Opts: commit=0
[   39.001307] EXT4-fs (md3): re-mounted. Opts: commit=0
[  796.866060] usb 4-3: new full speed USB device number 2 using ohci_hcd
[  797.017141] usb 4-3: New USB device found, idVendor=1532, idProduct=0101
[  797.017154] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  797.017163] usb 4-3: Product: Razer Copperhead Laser Mouse
[  797.017169] usb 4-3: Manufacturer: Razer
[  798.356343] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.0/input/input7
[  798.356581] generic-usb 0003:1532:0101.0001: input: USB HID v10.01 Mouse [Razer Razer Copperhead Laser Mouse] on usb-0000:00:12.0-3/input0
[  798.360589] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.1/input/input8
[  798.360719] generic-usb 0003:1532:0101.0002: input: USB HID v10.01 Keyboard [Razer Razer Copperhead Laser Mouse] on usb-0000:00:12.0-3/input1

--------------070100020703050806060101
Content-Type: text/x-c;
 name="dsdt_M5A97_0901_0705.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dsdt_M5A97_0901_0705.diff"

--- dsdt_newbios.dsl	2011-12-21 20:25:56.016056740 +0100
+++ dsdt_M5A97.dsl	2011-11-27 23:58:04.724297733 +0100
@@ -3,13 +3,13 @@
  * AML Disassembler version 20110922-64 [Nov 27 2011]
  * Copyright (c) 2000 - 2011 Intel Corporation
  * 
- * Disassembly of dsdt_newbios.dat, Wed Dec 21 20:20:47 2011
+ * Disassembly of dsdt_m5.dat, Sun Nov 27 22:47:37 2011
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00006EF0 (28400)
+ *     Length           0x00006EF1 (28401)
  *     Revision         0x02
- *     Checksum         0x1E
+ *     Checksum         0x4E
  *     OEM ID           "ALASKA"
  *     OEM Table ID     "A M I"
  *     OEM Revision     0x00000000 (0)
@@ -17,7 +17,7 @@
  *     Compiler Version 0x20051117 (537202967)
  */
 
-DefinitionBlock ("dsdt_newbios.aml", "DSDT", 2, "ALASKA", "A M I", 0x00000000)
+DefinitionBlock ("dsdt_m5.aml", "DSDT", 2, "ALASKA", "A M I", 0x00000000)
 {
     Name (SP1O, 0x2E)
     Name (IO1B, 0x0290)
@@ -44,8 +44,6 @@
     Name (GIOB, 0xFED80100)
     Name (IOMB, 0xFED80D00)
     Name (SMIB, 0xFED80200)
-    Name (PEBS, 0xE0000000)
-    Name (PEBL, 0x10000000)
     Name (ACPH, 0xDE)
     Name (ASSB, Zero)
     Name (AOTB, Zero)
@@ -58,6 +56,8 @@
     Name (ITKE, Zero)
     Name (MBEC, 0xFFFF)
     Name (AMWV, 0x09)
+    Name (PEBS, 0xE0000000)
+    Name (PEBL, 0x10000000)
     Name (SMIP, 0xB2)
     Name (PICM, Zero)
     Method (_PIC, 1, NotSerialized)
@@ -2334,6 +2334,7 @@
             })
             Method (_CRS, 0, NotSerialized)
             {
+                BreakPoint
                 If (CPRB)
                 {
                     CreateWordField (CRS1, \_SB.PCI0._Y00._MIN, MIN0)
@@ -6360,67 +6361,6 @@
         }
     }
 
-    If (OSCF)
-    {
-        Scope (_SB.PCI0)
-        {
-            Method (_OSC, 4, NotSerialized)
-            {
-                Name (SUPP, Zero)
-                Name (CTRL, Zero)
-                If (LEqual (Arg0, Buffer (0x10)
-                        {
-                            /* 0000 */    0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 
-                            /* 0008 */    0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
-                        }))
-                {
-                    CreateDWordField (Arg3, Zero, CDW1)
-                    CreateDWordField (Arg3, 0x04, CDW2)
-                    CreateDWordField (Arg3, 0x08, CDW3)
-                    Store (CDW2, SUPP)
-                    Store (CDW3, CTRL)
-                    If (LNotEqual (And (SUPP, 0x16), 0x16))
-                    {
-                    }
-
-                    And (CTRL, 0x1D, CTRL)
-                    If (Not (And (CDW1, One)))
-                    {
-                        If (And (CTRL, One)) {}
-                        If (And (CTRL, 0x04))
-                        {
-                            Store (One, EPNM)
-                        }
-                        Else
-                        {
-                            Store (Zero, EPNM)
-                        }
-
-                        If (And (CTRL, 0x10)) {}
-                    }
-
-                    If (LNotEqual (Arg1, One))
-                    {
-                        Or (CDW1, 0x08, CDW1)
-                    }
-
-                    If (LNotEqual (CDW3, CTRL))
-                    {
-                        Or (CDW1, 0x10, CDW1)
-                    }
-
-                    Store (CTRL, CDW3)
-                    Return (Arg3)
-                }
-                Else
-                {
-                    Or (CDW1, 0x04, CDW1)
-                    Return (Arg3)
-                }
-            }
-        }
-    }
-
     Scope (_SB)
     {
         Scope (PCI0)
@@ -7536,6 +7476,67 @@
         }
     }
 
+    If (OSCF)
+    {
+        Scope (_SB.PCI0)
+        {
+            Method (_OSC, 4, NotSerialized)
+            {
+                Name (SUPP, Zero)
+                Name (CTRL, Zero)
+                If (LEqual (Arg0, Buffer (0x10)
+                        {
+                            /* 0000 */    0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 
+                            /* 0008 */    0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
+                        }))
+                {
+                    CreateDWordField (Arg3, Zero, CDW1)
+                    CreateDWordField (Arg3, 0x04, CDW2)
+                    CreateDWordField (Arg3, 0x08, CDW3)
+                    Store (CDW2, SUPP)
+                    Store (CDW3, CTRL)
+                    If (LNotEqual (And (SUPP, 0x16), 0x16))
+                    {
+                    }
+
+                    And (CTRL, 0x1D, CTRL)
+                    If (Not (And (CDW1, One)))
+                    {
+                        If (And (CTRL, One)) {}
+                        If (And (CTRL, 0x04))
+                        {
+                            Store (One, EPNM)
+                        }
+                        Else
+                        {
+                            Store (Zero, EPNM)
+                        }
+
+                        If (And (CTRL, 0x10)) {}
+                    }
+
+                    If (LNotEqual (Arg1, One))
+                    {
+                        Or (CDW1, 0x08, CDW1)
+                    }
+
+                    If (LNotEqual (CDW3, CTRL))
+                    {
+                        Or (CDW1, 0x10, CDW1)
+                    }
+
+                    Store (CTRL, CDW3)
+                    Return (Arg3)
+                }
+                Else
+                {
+                    Or (CDW1, 0x04, CDW1)
+                    Return (Arg3)
+                }
+            }
+        }
+    }
+
     Name (_S0, Package (0x04)
     {
         Zero, 
@@ -7589,8 +7590,8 @@
         {
             SPTS (Arg0)
             \_SB.PCI0.SBRG.IPTS (Arg0)
-            \_SB.PCI0.NPTS (Arg0)
             \_SB.SARM (Arg0)
+            \_SB.PCI0.NPTS (Arg0)
             \_SB.PCI0.SBRG.SIOS (Arg0)
         }
     }

--------------070100020703050806060101--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
