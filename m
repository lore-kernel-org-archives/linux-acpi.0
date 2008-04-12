From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA branch - first try Core revision 20080321
Date: Sat, 12 Apr 2008 00:41:31 -0400
Message-ID: <200804120041.31583.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_71DAIHBgDEaX2eN"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56431 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYDLElu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Apr 2008 00:41:50 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

--Boundary-00=_71DAIHBgDEaX2eN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The acpica branch is based on 2.6.25-rc9.
Below is a dmesg diff of an HP nx6325 booting that baseline
vs. booting the acpica branch.

Two things jump out:

1. ACPI: Expecting a [Reference] package element, found type 14

2. memory coorruption:

slab error in verify_redzone_free(): cache `size-1024': memory outside object was overwritten

-Len


1c1
< Linux version 2.6.25-rc9 (lenb@t61) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #50 SMP Fri Apr 11 22:46:39 EDT 2008
---
> Linux version 2.6.25-rc9-00073-g8b56e6a (lenb@t61) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #33 SMP Sat Apr 12 00:07:51 EDT 2008
40c40
< early res: 2 [200000-8d9707] TEXT DATA BSS
---
> early res: 2 [200000-8d9747] TEXT DATA BSS
95a96
> spurious 8259A interrupt: IRQ7.
102c103
< Memory: 442500k/458560k available (3629k kernel code, 15672k reserved, 2023k data, 364k init)
---
> Memory: 442500k/458560k available (3632k kernel code, 15672k reserved, 2020k data, 364k init)
104c105
< Calibrating delay using timer specific routine.. 3194.17 BogoMIPS (lpj=1597086)
---
> Calibrating delay using timer specific routine.. 3194.25 BogoMIPS (lpj=1597129)
113c114
< ACPI: Core revision 20070126
---
> ACPI: Core revision 20080321
126c127
< Calibrating delay using timer specific routine.. 3191.63 BogoMIPS (lpj=1595818)
---
> Calibrating delay using timer specific routine.. 3191.59 BogoMIPS (lpj=1595798)
154,155c155,156
< Completing Region/Field/Buffer/Package initialization:................................................................................................................................................................
< Initialized 29/33 Regions 0/0 Fields 63/64 Buffers 68/78 Packages (1172 nodes)
---
> Completing Region/Field/Buffer/Package initialization:...............................................................................................................................................................
> Initialized 29/33 Regions 0/0 Fields 63/64 Buffers 67/78 Packages (1172 nodes)
160a162,168
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
228d235
< PCI: Bridge: 0000:00:05.0
232a240
> PCI: Bridge: 0000:00:05.0
381c389
< usb usb1: Manufacturer: Linux 2.6.25-rc9 ehci_hcd
---
> usb usb1: Manufacturer: Linux 2.6.25-rc9-00073-g8b56e6a ehci_hcd
394c402
< usb usb2: Manufacturer: Linux 2.6.25-rc9 ohci_hcd
---
> usb usb2: Manufacturer: Linux 2.6.25-rc9-00073-g8b56e6a ohci_hcd
406c414
< usb usb3: Manufacturer: Linux 2.6.25-rc9 ohci_hcd
---
> usb usb3: Manufacturer: Linux 2.6.25-rc9-00073-g8b56e6a ohci_hcd
448a457,463
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: LNXTHERM:01 is registered as thermal_zone0
> ACPI: Thermal Zone [TZ1] (67 C)
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: LNXTHERM:02 is registered as thermal_zone1
> ACPI: Thermal Zone [TZ2] (54 C)
452d466
< ACPI: AC Adapter [C1BD] (on-line)
459a474,477
> ACPI: AC Adapter [C1BD] (on-line)
> ACPI: Expecting a [Reference] package element, found type 14
> ACPI: LNXTHERM:03 is registered as thermal_zone2
> ACPI: Thermal Zone [TZ3] (29 C)
461a480,487
> ACPI: PNP0C0B:00 is registered as cooling_device2
> ACPI: Fan [C34F] (off)
> ACPI: PNP0C0B:01 is registered as cooling_device3
> ACPI: Fan [C350] (off)
> ACPI: PNP0C0B:02 is registered as cooling_device4
> ACPI: Fan [C351] (off)
> ACPI: PNP0C0B:03 is registered as cooling_device5
> ACPI: Fan [C352] (off)
471a498
> ACPI: WMI: Mapper loaded
481c508
< power_supply C1BF: prop VOLTAGE_NOW=12617000
---
> power_supply C1BF: prop VOLTAGE_NOW=12616000
490,507d516
< ACPI: WMI: Mapper loaded
< ACPI: LNXTHERM:01 is registered as thermal_zone0
< ACPI: Thermal Zone [TZ1] (54 C)
< ACPI: LNXTHERM:02 is registered as thermal_zone1
< ACPI: Thermal Zone [TZ2] (46 C)
< ACPI: LNXTHERM:03 is registered as thermal_zone2
< ACPI: Thermal Zone [TZ3] (28 C)
< ACPI: Transitioning device [C34F] to D3
< ACPI: PNP0C0B:00 is registered as cooling_device2
< ACPI: Fan [C34F] (off)
< ACPI: Transitioning device [C350] to D3
< ACPI: PNP0C0B:01 is registered as cooling_device3
< ACPI: Fan [C350] (off)
< ACPI: Transitioning device [C351] to D3
< ACPI: PNP0C0B:02 is registered as cooling_device4
< ACPI: Fan [C351] (off)
< ACPI: PNP0C0B:03 is registered as cooling_device5
< ACPI: Fan [C352] (on)
524c533
< Clocksource tsc unstable (delta = -245722066 ns)
---
> Clocksource tsc unstable (delta = -249928054 ns)
527a537,600
> ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 17
> slab error in verify_redzone_free(): cache `size-1024': memory outside object was overwritten
> Pid: 96, comm: kacpi_notify Not tainted 2.6.25-rc9-00073-g8b56e6a #33
> 
> Call Trace:
>  [<ffffffff8027f57b>] __slab_error+0x24/0x26
>  [<ffffffff8027fb72>] cache_free_debugcheck+0x136/0x207
>  [<ffffffff8037f2bc>] ? acpi_ev_asynch_enable_gpe+0x2b/0x2f
>  [<ffffffff80281afb>] kfree+0x9c/0x216
>  [<ffffffff80375e86>] ? acpi_os_execute_deferred+0x0/0x39
>  [<ffffffff8037f2bc>] acpi_ev_asynch_enable_gpe+0x2b/0x2f
>  [<ffffffff80375eb2>] acpi_os_execute_deferred+0x2c/0x39
>  [<ffffffff8023f480>] run_workqueue+0x7d/0x106
>  [<ffffffff8023fe41>] worker_thread+0xd8/0xe5
>  [<ffffffff80242913>] ? autoremove_wake_function+0x0/0x38
>  [<ffffffff8023fd69>] ? worker_thread+0x0/0xe5
>  [<ffffffff802427d4>] kthread+0x49/0x79
>  [<ffffffff8020bef8>] child_rip+0xa/0x12
>  [<ffffffff8024278b>] ? kthread+0x0/0x79
>  [<ffffffff8020beee>] ? child_rip+0x0/0x12
> 
> ffff81001b028e70: redzone 1:0x800, redzone 2:0x5a5a5a5a5a5a5a5a.
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:2906!
> invalid opcode: 0000 [1] SMP 
> CPU 0 
> Modules linked in: powernow_k8 pcmcia snd_hda_intel snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer yenta_socket rsrc_nonstatic snd_page_alloc wmi battery fan video backlight ac thermal
> Pid: 96, comm: kacpi_notify Not tainted 2.6.25-rc9-00073-g8b56e6a #33
> RIP: 0010:[<ffffffff8027fc0c>]  [<ffffffff8027fc0c>] cache_free_debugcheck+0x1d0/0x207
> RSP: 0018:ffff81001b037df0  EFLAGS: 00010016
> RAX: ffff81001b028d98 RBX: ffff81001b804ac0 RCX: ffff81001b028150
> RDX: 0000000000000003 RSI: ffff81001b028e70 RDI: ffff81001b804ac0
> RBP: ffff81001b037e20 R08: 09f911029d74e35b R09: 00000000ffffff20
> R10: 0000000000000010 R11: 0000000000000000 R12: 0000000000000800
> R13: ffff81001b028e70 R14: 5a5a5a5a5a5a5a5a R15: ffff81001b028100
> FS:  00000000409b4950(0000) GS:ffffffff80786000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 00000030ed8c6d80 CR3: 0000000019c38000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process kacpi_notify (pid: 96, threadinfo ffff81001b036000, task ffff81001bb06740)
> Stack:  ffffffff8037f2bc ffff81001b80b5e8 ffff81001b804ac0 ffff81001b028e78
>  ffffffff807f3bc0 0000000000000282 ffff81001b037e70 ffffffff80281afb
>  ffffffff807f3bc0 0000000000008025 ffff81001b028e78 ffff81001b028e78
> Call Trace:
>  [<ffffffff8037f2bc>] ? acpi_ev_asynch_enable_gpe+0x2b/0x2f
>  [<ffffffff80281afb>] kfree+0x9c/0x216
>  [<ffffffff80375e86>] ? acpi_os_execute_deferred+0x0/0x39
>  [<ffffffff8037f2bc>] acpi_ev_asynch_enable_gpe+0x2b/0x2f
>  [<ffffffff80375eb2>] acpi_os_execute_deferred+0x2c/0x39
>  [<ffffffff8023f480>] run_workqueue+0x7d/0x106
>  [<ffffffff8023fe41>] worker_thread+0xd8/0xe5
>  [<ffffffff80242913>] ? autoremove_wake_function+0x0/0x38
>  [<ffffffff8023fd69>] ? worker_thread+0x0/0xe5
>  [<ffffffff802427d4>] kthread+0x49/0x79
>  [<ffffffff8020bef8>] child_rip+0xa/0x12
>  [<ffffffff8024278b>] ? kthread+0x0/0x79
>  [<ffffffff8020beee>] ? child_rip+0x0/0x12
> 
> 
> Code: 29 c8 48 0f af c2 48 89 c2 48 c1 ea 20 3b 93 18 01 00 00 72 04 0f 0b eb fe 89 d0 0f af 83 0c 01 00 00 48 8d 04 01 49 39 c5 74 04 <0f> 0b eb fe 89 d0 41 c7 44 87 30 fe ff ff ff f6 83 15 01 00 00 
> RIP  [<ffffffff8027fc0c>] cache_free_debugcheck+0x1d0/0x207
>  RSP <ffff81001b037df0>
> ---[ end trace b34da6ee0b4cc39e ]---

--Boundary-00=_71DAIHBgDEaX2eN
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg-2.6.25-rc9-00073-g8b56e6a"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.25-rc9-00073-g8b56e6a"

Linux version 2.6.25-rc9-00073-g8b56e6a (lenb@t61) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #33 SMP Sat Apr 12 00:07:51 EDT 2008
Command line: root=/dev/sda3 debug
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bfd0000 (usable)
 BIOS-e820: 000000001bfd0000 - 000000001bfe5600 (reserved)
 BIOS-e820: 000000001bfe5600 - 000000001bff8000 (ACPI NVS)
 BIOS-e820: 000000001bff8000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000ffbc0000 - 00000000ffcc0000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 114640) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP 000F7D30, 0024 (r2 HP    )
ACPI: XSDT 1BFE57B4, 0054 (r1 HP     0944      6070620 HP          1)
ACPI: FACP 1BFE5684, 00F4 (r4 HP     0944            3 HP          1)
ACPI: DSDT 1BFE58DC, EE7A (r1 HP        SB400    10000 MSFT  100000E)
ACPI: FACS 1BFF7E80, 0040
ACPI: APIC 1BFE5808, 0062 (r1 HP     0944            1 HP          1)
ACPI: MCFG 1BFE586C, 003C (r1 HP     0944            1 HP          1)
ACPI: TCPA 1BFE58A8, 0032 (r2 HP     0944            1 HP          1)
ACPI: SSDT 1BFF4756, 0059 (r1 HP       HPQNLP        1 MSFT  100000E)
ACPI: SSDT 1BFF47AF, 0182 (r1 HP     PSSTBLID        1 HP          1)
ACPI: DMI detected: Hewlett-Packard
Scanning NUMA topology in Northbridge 24
No NUMA configuration found
Faking a node at 0000000000000000-000000001bfd0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 114640) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000001bfd0000
  NODE_DATA [000000000000b000 - 0000000000011fff]
  bootmap [0000000000012000 -  00000000000157ff] pages 4
early res: 0 [0-fff] BIOS data page
early res: 1 [6000-7fff] SMP_TRAMPOLINE
early res: 2 [200000-8d9747] TEXT DATA BSS
early res: 3 [9fc00-a0bff] EBDA
early res: 4 [8000-afff] PGTABLE
No mptable found.
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 on node 0
 [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 on node 0
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   114640
On node 0 totalpages: 114543
  DMA zone: 56 pages used for memmap
  DMA zone: 1760 pages reserved
  DMA zone: 2183 pages, LIFO batch:0
  DMA32 zone: 1511 pages used for memmap
  DMA32 zone: 109033 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
Detected use of extended apic ids on hypertransport bus
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 35648 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 111216
Policy zone: DMA32
Kernel command line: root=/dev/sda3 debug
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
Extended CMOS year: 2000
TSC calibrated against PM_TIMER
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 1595.999 MHz processor.
spurious 8259A interrupt: IRQ7.
Console: colour VGA+ 80x25
console [tty0] enabled
Checking aperture...
Node 0: aperture @ 9494000000 size 32 MB
Aperture beyond 4GB. Ignoring.
No AGP bridge found
Memory: 442500k/458560k available (3632k kernel code, 15672k reserved, 2020k data, 364k init)
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay using timer specific routine.. 3194.25 BogoMIPS (lpj=1597129)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
ACPI: Core revision 20080321
Parsing all Control Methods:
Table [DSDT](id 0001) - 1153 Objects with 113 Devices 337 Methods 33 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 2 Objects with 0 Devices 2 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0003) - 8 Objects with 0 Devices 0 Methods 0 Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Disabling APIC timer
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3191.59 BogoMIPS (lpj=1595798)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Turion(tm) 64 X2 Mobile Technology TL-50 stepping 02
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000001 00000002
  domain 1: span 00000003
   groups: 00000003
CPU1 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000002 00000001
  domain 1: span 00000003
   groups: 00000003
net_namespace: 296 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x15
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 3 Wake, Enabled 11 Runtime GPEs in this block
ACPI: EC: Look up EC in DSDT
ACPI: EC: non-query interrupt received, switching to interrupt mode
Completing Region/Field/Buffer/Package initialization:...............................................................................................................................................................
Initialized 29/33 Regions 0/0 Fields 63/64 Buffers 67/78 Packages (1172 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:.......
Executed 7 _INI methods requiring 2 _STA executions (examined 120 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: EC: GPE = 0x11, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [C074] (0000:00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.C074._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C074.C075._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C074.C0DF._PRT]
ACPI: PCI Interrupt Link [C125] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C126] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C127] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C128] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C129] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C12A] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [C12B] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C12C] (IRQs *10 11)
ACPI: Power Resource [C223] (off)
ACPI: Power Resource [C1FE] (off)
ACPI: Power Resource [C217] (on)
ACPI: Power Resource [C34B] (off)
ACPI: Power Resource [C34C] (off)
ACPI: Power Resource [C34D] (off)
ACPI: Power Resource [C34E] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:14.2
DMAR:parse DMAR table failure.
system 00:00: iomem range 0x0-0x9ffff could not be reserved
system 00:00: iomem range 0xe0000-0xfffff could not be reserved
system 00:00: iomem range 0x100000-0x1bffffff could not be reserved
system 00:0a: ioport range 0x40b-0x40b has been reserved
system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
system 00:0a: ioport range 0x4d6-0x4d6 has been reserved
system 00:0a: ioport range 0x500-0x51f has been reserved
system 00:0a: ioport range 0xc00-0xc01 has been reserved
system 00:0a: ioport range 0xc14-0xc14 has been reserved
system 00:0a: ioport range 0xc50-0xc51 has been reserved
system 00:0a: ioport range 0xc52-0xc52 has been reserved
system 00:0a: ioport range 0xc6c-0xc6c has been reserved
system 00:0a: ioport range 0xc6f-0xc6f has been reserved
system 00:0a: ioport range 0xcd4-0xcdf has been reserved
system 00:0a: iomem range 0xffb00000-0xffbfffff could not be reserved
system 00:0a: iomem range 0xfff00000-0xffffffff could not be reserved
system 00:0b: ioport range 0x8000-0x802f has been reserved
system 00:0b: ioport range 0x8100-0x811f has been reserved
system 00:0b: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:0c: iomem range 0xcf000-0xcffff has been reserved
system 00:0c: iomem range 0x1c000000-0x1fffffff could not be reserved
system 00:0c: iomem range 0xfee00000-0xfee00fff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 6000-6fff
  MEM window: 0xd0300000-0xd03fffff
  PREFETCH window: 0x00000000c0000000-0x00000000c3ffffff
PCI: Bridge: 0000:00:04.0
  IO window: 4000-5fff
  MEM window: 0xcc000000-0xcfffffff
  PREFETCH window: disabled.
Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 0
Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 1
PCI: Bridge: 0000:00:05.0
  IO window: 2000-3fff
  MEM window: 0xc8000000-0xcbffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: 0xc4000000-0xc40fffff
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:04.0
  IO window: 0x00001000-0x000010ff
  IO window: 0x00001400-0x000014ff
  PREFETCH window: 0x30000000-0x33ffffff
  MEM window: 0x38000000-0x3bffffff
PCI: Bridge: 0000:00:14.4
  IO window: 1000-1fff
  MEM window: 0xd0000000-0xd02fffff
  PREFETCH window: 0x0000000030000000-0x0000000033ffffff
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 20
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:00.0: MSI quirk detected; MSI disabled
pci 0000:01:05.0: Boot video device
PCI: Setting latency timer of device 0000:00:04.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie01]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
Allocate Port Service[0000:00:05.0:pcie01]
Allocate Port Service[0000:00:05.0:pcie03]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie01]
Allocate Port Service[0000:00:06.0:pcie03]
AER service couldn't init device 0000:00:04.0:pcie01 - no _OSC support
AER service couldn't init device 0000:00:05.0:pcie01 - no _OSC support
AER service couldn't init device 0000:00:06.0:pcie01 - no _OSC support
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (CM) as /class/input/input1
ACPI: Sleep Button (CM) [C25A]
input: Lid Switch as /class/input/input2
ACPI: Lid Switch [C25B]
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Processor [C000] (supports 8 throttling states)
ACPI: ACPI0007:01 is registered as cooling_device1
ACPI: Processor [C001] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Floppy drive(s): fd0 is 1.44M
Clockevents: could not switch to one-shot mode:<6>Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 1
 lapic is not functional.
Could not switch to high resolution mode on CPU 0
floppy0: no floppy controllers found
brd: module loaded
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
tg3.c:v3.89 (April 03, 2008)
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 23 (level, low) -> IRQ 23
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:17:08:30:e4:ee
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[0] TSOcap[1]
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
console [netcon0] enabled
netconsole: network logging started
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller (0x1002:0x4376 rev 0x80) at  PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:DMA, hdb:PIO
ATIIXP: simplex device: DMA disabled
ide1: ATIIXP Bus-Master DMA disabled (BIOS)
Probing IDE interface ide0...
hda: TSSTcorpCDW/DVD TS-L462C, ATAPI CD/DVD-ROM drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: MWDMA2 mode selected
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 1536kB Cache
Uniform CD-ROM driver Revision: 3.20
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
megasas: 00.00.03.16-rc1 Thu. Nov. 07 10:09:32 PDT 2007
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
sata_sil 0000:00:12.0: version 2.3
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 16 (level, low) -> IRQ 16
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 mmio m512@0xd0409000 tf 0xd0409080 irq 16
ata2: SATA max UDMA/100 mmio m512@0xd0409000 tf 0xd04090c0 irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: FUJITSU MHT2040BH, 0000104A, max UDMA/100
ata1.00: 78140160 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHT2040B 0000 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 78140160 512-byte hardware sectors (40008 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 78140160 512-byte hardware sectors (40008 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
Fusion MPT base driver 3.04.06
Copyright (c) 1999-2007 LSI Corporation
Fusion MPT SPI Host driver 3.04.06
Fusion MPT SAS Host driver 3.04.06
ACPI: PCI Interrupt 0000:02:04.1[A] -> GSI 20 (level, low) -> IRQ 20
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[d0011000-d00117ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: raw1394: /dev/raw1394 device initialized
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 19, io mem 0xd0403000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-rc9-00073-g8b56e6a ehci_hcd
usb usb1: SerialNumber: 0000:00:13.2
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 19, io mem 0xd0401000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.25-rc9-00073-g8b56e6a ohci_hcd
usb usb2: SerialNumber: 0000:00:13.0
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 19, io mem 0xd0402000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.25-rc9-00073-g8b56e6a ohci_hcd
usb usb3: SerialNumber: 0000:00:13.1
USB Universal Host Controller Interface driver v3.0
usb 3-1: new full speed USB device using ohci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: New USB device found, idVendor=08ff, idProduct=2580
usb 3-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 3-1: Product: Fingerprint Sensor
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:C214,PNP0f13:C215] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31 16:40:16 2008 UTC).
ALSA device list:
  No soundcards found.
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input4
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 364k freed
ACPI: Expecting a [Reference] package element, found type 14
ACPI: Expecting a [Reference] package element, found type 14
ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [TZ1] (67 C)
ACPI: Expecting a [Reference] package element, found type 14
ACPI: LNXTHERM:02 is registered as thermal_zone1
ACPI: Thermal Zone [TZ2] (54 C)
power_supply C1BD: uevent
power_supply C1BD: No power supply yet
power_supply C1BD: power_supply_changed
power_supply C1BD: power_supply_changed_work
power_supply C1BD: power_supply_update_gen_leds 1
power_supply C1BD: uevent
power_supply C1BD: POWER_SUPPLY_NAME=C1BD
power_supply C1BD: Static prop TYPE=Mains
power_supply C1BD: 1 dynamic props
power_supply C1BD: prop ONLINE=1
ACPI: AC Adapter [C1BD] (on-line)
ACPI: Expecting a [Reference] package element, found type 14
ACPI: LNXTHERM:03 is registered as thermal_zone2
ACPI: Thermal Zone [TZ3] (29 C)
input: Video Bus as /class/input/input5
ACPI: Video Device [C076] (multi-head: yes  rom: no  post: no)
ACPI: PNP0C0B:00 is registered as cooling_device2
ACPI: Fan [C34F] (off)
ACPI: PNP0C0B:01 is registered as cooling_device3
ACPI: Fan [C350] (off)
ACPI: PNP0C0B:02 is registered as cooling_device4
ACPI: Fan [C351] (off)
ACPI: PNP0C0B:03 is registered as cooling_device5
ACPI: Fan [C352] (off)
power_supply C1BF: uevent
power_supply C1BF: No power supply yet
power_supply C1BF: power_supply_changed
power_supply C1BF: power_supply_changed_work
Yenta: CardBus bridge found at 0000:02:04.0 [103c:30b0]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x01a11002, devctl 0x64
ACPI: Battery Slot [C1BF] (battery present)
ACPI: WMI: Mapper loaded
power_supply C1BF: power_supply_update_bat_leds 4
power_supply C1BF: uevent
power_supply C1BF: POWER_SUPPLY_NAME=C1BF
power_supply C1BF: Static prop TYPE=Battery
power_supply C1BF: 12 dynamic props
power_supply C1BF: prop STATUS=Full
power_supply C1BF: prop PRESENT=1
power_supply C1BF: prop TECHNOLOGY=Li-ion
power_supply C1BF: prop VOLTAGE_MIN_DESIGN=10800000
power_supply C1BF: prop VOLTAGE_NOW=12616000
power_supply C1BF: prop CURRENT_NOW=0
power_supply C1BF: prop CHARGE_FULL_DESIGN=4679000
power_supply C1BF: prop CHARGE_FULL=4679000
power_supply C1BF: prop CHARGE_NOW=4679000
power_supply C1BF: prop MODEL_NAME=Primary
power_supply C1BF: prop MANUFACTURER=Hewlett-Packard
power_supply C1BF: prop SERIAL_NUMBER=39279 2006/08/07
ACPI: Battery Slot [C1BE] (battery absent)
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
Yenta: ISA IRQ mask 0x0ef8, PCI irq 20
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2096472k swap on /dev/sda2.  Priority:-1 extents:1 across:2096472k
warning: process `kudzu' used the deprecated sysctl system call with 1.23.
powernow-k8: Found 1 AMD Turion(tm) 64 X2 Mobile Technology TL-50 processors (2 cpu cores) (version 2.20.00)
powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x13
powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x1e
Clocksource tsc unstable (delta = -249928054 ns)
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
warning: `dbus-daemon' uses 32-bit capabilities (legacy support in use)
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 17
slab error in verify_redzone_free(): cache `size-1024': memory outside object was overwritten
Pid: 96, comm: kacpi_notify Not tainted 2.6.25-rc9-00073-g8b56e6a #33

Call Trace:
 [<ffffffff8027f57b>] __slab_error+0x24/0x26
 [<ffffffff8027fb72>] cache_free_debugcheck+0x136/0x207
 [<ffffffff8037f2bc>] ? acpi_ev_asynch_enable_gpe+0x2b/0x2f
 [<ffffffff80281afb>] kfree+0x9c/0x216
 [<ffffffff80375e86>] ? acpi_os_execute_deferred+0x0/0x39
 [<ffffffff8037f2bc>] acpi_ev_asynch_enable_gpe+0x2b/0x2f
 [<ffffffff80375eb2>] acpi_os_execute_deferred+0x2c/0x39
 [<ffffffff8023f480>] run_workqueue+0x7d/0x106
 [<ffffffff8023fe41>] worker_thread+0xd8/0xe5
 [<ffffffff80242913>] ? autoremove_wake_function+0x0/0x38
 [<ffffffff8023fd69>] ? worker_thread+0x0/0xe5
 [<ffffffff802427d4>] kthread+0x49/0x79
 [<ffffffff8020bef8>] child_rip+0xa/0x12
 [<ffffffff8024278b>] ? kthread+0x0/0x79
 [<ffffffff8020beee>] ? child_rip+0x0/0x12

ffff81001b028e70: redzone 1:0x800, redzone 2:0x5a5a5a5a5a5a5a5a.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2906!
invalid opcode: 0000 [1] SMP 
CPU 0 
Modules linked in: powernow_k8 pcmcia snd_hda_intel snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer yenta_socket rsrc_nonstatic snd_page_alloc wmi battery fan video backlight ac thermal
Pid: 96, comm: kacpi_notify Not tainted 2.6.25-rc9-00073-g8b56e6a #33
RIP: 0010:[<ffffffff8027fc0c>]  [<ffffffff8027fc0c>] cache_free_debugcheck+0x1d0/0x207
RSP: 0018:ffff81001b037df0  EFLAGS: 00010016
RAX: ffff81001b028d98 RBX: ffff81001b804ac0 RCX: ffff81001b028150
RDX: 0000000000000003 RSI: ffff81001b028e70 RDI: ffff81001b804ac0
RBP: ffff81001b037e20 R08: 09f911029d74e35b R09: 00000000ffffff20
R10: 0000000000000010 R11: 0000000000000000 R12: 0000000000000800
R13: ffff81001b028e70 R14: 5a5a5a5a5a5a5a5a R15: ffff81001b028100
FS:  00000000409b4950(0000) GS:ffffffff80786000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000030ed8c6d80 CR3: 0000000019c38000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process kacpi_notify (pid: 96, threadinfo ffff81001b036000, task ffff81001bb06740)
Stack:  ffffffff8037f2bc ffff81001b80b5e8 ffff81001b804ac0 ffff81001b028e78
 ffffffff807f3bc0 0000000000000282 ffff81001b037e70 ffffffff80281afb
 ffffffff807f3bc0 0000000000008025 ffff81001b028e78 ffff81001b028e78
Call Trace:
 [<ffffffff8037f2bc>] ? acpi_ev_asynch_enable_gpe+0x2b/0x2f
 [<ffffffff80281afb>] kfree+0x9c/0x216
 [<ffffffff80375e86>] ? acpi_os_execute_deferred+0x0/0x39
 [<ffffffff8037f2bc>] acpi_ev_asynch_enable_gpe+0x2b/0x2f
 [<ffffffff80375eb2>] acpi_os_execute_deferred+0x2c/0x39
 [<ffffffff8023f480>] run_workqueue+0x7d/0x106
 [<ffffffff8023fe41>] worker_thread+0xd8/0xe5
 [<ffffffff80242913>] ? autoremove_wake_function+0x0/0x38
 [<ffffffff8023fd69>] ? worker_thread+0x0/0xe5
 [<ffffffff802427d4>] kthread+0x49/0x79
 [<ffffffff8020bef8>] child_rip+0xa/0x12
 [<ffffffff8024278b>] ? kthread+0x0/0x79
 [<ffffffff8020beee>] ? child_rip+0x0/0x12


Code: 29 c8 48 0f af c2 48 89 c2 48 c1 ea 20 3b 93 18 01 00 00 72 04 0f 0b eb fe 89 d0 0f af 83 0c 01 00 00 48 8d 04 01 49 39 c5 74 04 <0f> 0b eb fe 89 d0 41 c7 44 87 30 fe ff ff ff f6 83 15 01 00 00 
RIP  [<ffffffff8027fc0c>] cache_free_debugcheck+0x1d0/0x207
 RSP <ffff81001b037df0>
---[ end trace b34da6ee0b4cc39e ]---

--Boundary-00=_71DAIHBgDEaX2eN--
