From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 17 Jan 2017 20:10:37 +0800
Message-ID: <587E09BD.1040904@huawei.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
 <CAJZ5v0h_v-iER5Fffdoczj4CAhetGYqOfJOhdO561_kNCnsEFg@mail.gmail.com>
 <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
 <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com> <587CDB96.9000906@huawei.com>
 <20170116145312.GB24103@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116145312.GB24103@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>, harba@codeaurora.org, Jason Cooper <jason@lakedaemon.net>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rjwysocki@gmail.com, astone@redhat.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Charles Garcia Tobin <charles.garcia-tobin@arm.com>, Al Stone <ahs3@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 2017/1/16 22:53, Lorenzo Pieralisi wrote:
> On Mon, Jan 16, 2017 at 10:41:26PM +0800, Hanjun Guo wrote:
>> On 2017/1/16 22:14, Marc Zyngier wrote:
>>> On 16/01/17 14:07, Agustin Vega-Frias wrote:
>>>> Hi Rafael,
>>>>
>>>> On 2017-01-03 16:56, Rafael J. Wysocki wrote:
>>>>> On Tue, Jan 3, 2017 at 4:19 PM, Agustin Vega-Frias
>>>>> <agustinv@codeaurora.org> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Is there any more feedback on this beyond Lorenzo's suggestion to drop
>>>>>> the conditional check on the first patch?
>>>>>> How can we move forward on this series?
>>>>> Essentially, I need to convince myself that patches [1-2/3] are fine
>>>>> which hasn't happened yet.
>>>> Pinging again. Do you have any questions that might help with your
>>>> review? I have some minor changes I have to make to the driver itself
>>>> (patch 3) and I'd like to submit any changes you might want along with
>>>> those.
>>> I'd like to add that these two initial patches are now a prerequisite
>>> for Hanjun's series, so it'd be good to have an idea of where we're
>>> going on that front.
>> Is it helpful to test patch [1-2/3] on x86 machines (with different firmware) and
>> an IA64 machine (surely a different version of firmware :) ) with Lorenzo's suggestion
>> of removing  #ifdef CONFIG_ACPI_GENERIC_GSI for is_gsi()? If yes, I can do that as
>> I have such machines.
> Well, it is always helpful, as helpful as getting this change into -next
> as soon as possible, at the end of the day it is quite simple, as soon
> as (hopefully never) we find some firmware out there (x86/ia64) that
> misused the resource source field in the interrupt descriptor we will
> have to add that guard back, it is as simple as that.

As I said, I tested patch [1-2/3] with or without #ifdef CONFIG_ACPI_GENERIC_GSI for is_gsi()
on a x86 machine [1] and IA64 machine [2], both work fine as before, and no regressions in
the boot log.

Thanks
Hanjun

[1] IA64:
Linux version 4.10.0-rc4-0.7-default (root@node11) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #2 SMP Tue Jan 17 18:02:44 EST 2017
EFI v2.00 by HP:
efi:  SALsystab=0x3ee7a000  ACPI 2.0=0x3fde6000  SMBIOS=0x3ee7c000  HCDP=0x3fde4000
booting generic kernel on platform hpzx1
PCDP: v3 at 0x3fde4000
PCDP: VGA console
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x000000003FDE6000 000028 (v02 HP    )
ACPI: XSDT 0x000000003FDE602C 0000BC (v01 HP     rx2660   00000000 HP   00000000)
ACPI: FACP 0x000000003FDF7268 0000F4 (v03 HP     rx2660   00000000 HP   00000000)
ACPI: DSDT 0x000000003FDE61C8 00E566 (v01 HP     rx2660   00000007 INTL 20050309)
ACPI: FACS 0x000000003FDF7360 000040
ACPI: SPCR 0x000000003FDF73A0 000050 (v01 HP              00000000 HP   00000000)
ACPI: DBGP 0x000000003FDF73F0 000034 (v01 HP     rx2660   00000000 HP   00000000)
ACPI: APIC 0x000000003FDF7810 0000E8 (v01 HP     rx2660   00000000 HP   00000000)
ACPI: SPMI 0x000000003FDF7428 000050 (v04 HP     rx2660   00000000 HP   00000000)
ACPI: CPEP 0x000000003FDF76E0 000034 (v01 HP     rx2660   00000000 HP   00000000)
ACPI: SSDT 0x000000003FDF4738 0004B3 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF4BF8 000456 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF5058 000866 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF58C8 000866 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF6138 000866 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF69A8 000138 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF6AE8 0000E0 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF6BD8 00013C (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF6D18 0000E0 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF6E08 00013C (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF6F48 0000E0 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF7038 00013C (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: SSDT 0x000000003FDF7178 0000E0 (v01 HP     rx2660   00000006 INTL 20050309)
ACPI: Local APIC address c0000000fee00000
4 CPUs available, 8 CPUs total
SMP: Allowing 8 CPUs, 4 hotplug CPUs
Reserving 512MB of memory at 128MB for crashkernel (System RAM: 16347MB)
Initial ramdisk at: 0xe0000100fe228000 (14063453 bytes)
SAL 3.20: HP version 4.11
SAL Platform features:
 None
SAL: AP wakeup using external interrupt vector 0xff
MCA related initialization done
Virtual mem_map starts at 0xa07fffffc7c80000
Zone ranges:
  DMA      [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x00000100ffffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000001000000-0x000000003e67ffff]
  node   0: [mem 0x000000003eaf0000-0x000000003ee6ffff]
  node   0: [mem 0x000000003fc00000-0x000000003fd6ffff]
  node   0: [mem 0x0000000100000000-0x00000003ffffffff]
  node   0: [mem 0x0000010040000000-0x00000100ff1effff]
  node   0: [mem 0x00000100ff200000-0x00000100ffffffff]
Initmem setup node 0 [mem 0x0000000001000000-0x00000100ffffffff]
On node 0 totalpages: 261558
free_area_init_node: node 0, pgdat e000000001a00000, node_mem_map a07fffffc7c83800
  DMA zone: 56 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 15799 pages, LIFO batch:1
  Normal zone: 14336 pages used for memmap
  Normal zone: 245759 pages, LIFO batch:1
pcpu-alloc: s35992 r8192 d217960 u262144 alloc=4*65536
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 247166
Policy zone: Normal
Kernel command line: BOOT_IMAGE=dev000:\efi\SuSE\vmlinuz-4.10.0-rc4-0.7-default root=/dev/disk/by-id/scsi-35000cca00a9965f4-part2  splash=silent crashkernel=1024M-:512M
PID hash table entries: 4096 (order: -1, 32768 bytes)
Sorting __ex_table...
Memory: 16145472K/16739712K available (11591K kernel code, 5869K rwdata, 1932K rodata, 1472K init, 8367K bss, 594240K reserved, 0K cma-reserved)
Hierarchical RCU implementation.
    Build-time adjustment of leaf fanout to 64.
    RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=8.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
NR_IRQS:1024
ACPI: Local APIC address c0000000fee00000
GSI 25 (level, low) -> CPU 0 (0x0000) vector 49
CPU 0: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz
+/-150ppm
clocksource: itc: mask: 0xffffffffffffffff max_cycles: 0x5c0fd65174, max_idle_ns: 440795221447 ns
Console: colour VGA+ 80x25
console [tty0] enabled
Calibrating delay loop... 2834.43 BogoMIPS (lpj=5668864)
pid_max: default: 32768 minimum: 301
ACPI: Core revision 20160930
ACPI: 14 ACPI AML tables successfully acquired and loaded
Security Framework initialized
SELinux:  Disabled at boot.
AppArmor: AppArmor disabled by boot time parameter
Dentry cache hash table entries: 2097152 (order: 8, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 7, 8388608 bytes)
Mount-cache hash table entries: 32768 (order: 2, 262144 bytes)
Mountpoint-cache hash table entries: 32768 (order: 2, 262144 bytes)
Boot processor id 0x0/0x0
smp: Bringing up secondary CPUs ...
Fixed BSP b0 value from CPU 1
CPU 1: synchronized ITC with CPU 0 (last diff -7 cycles, maxerr 172 cycles)
CPU 1: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz
+/-150ppm
CPU 2: synchronized ITC with CPU 0 (last diff -7 cycles, maxerr 173 cycles)
CPU 2: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz
+/-150ppm
CPU 3: synchronized ITC with CPU 0 (last diff -7 cycles, maxerr 175 cycles)
CPU 3: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz
+/-150ppm
smp: Brought up 1 node, 4 CPUs
Total of 4 processors activated (11337.72 BogoMIPS).
devtmpfs: initialized
SMBIOS 2.4 present.
DMI: hp server rx2660                   , BIOS 04.11                                                            10/20/2008
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
NET: Registered protocol family 16
ACPI: bus type PCI registered
HugeTLB registered 256 MB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOSAPIC for interrupt routing
random: fast init done
ACPI: PCI Root Bridge [L000] (domain 0000 [bus 00])
acpi HWP0002:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HWP0002:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000000-0x100ffff window] (bus address [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff window]
pci_bus 0000:00: root bus resource [mem 0x80004000000-0x800ffffffff window]
pci_bus 0000:00: root bus resource [bus 00]
pci 0000:00:01.0: [103c:1303] type 00 class 0xff0000
pci 0000:00:01.1: [103c:1302] type 00 class 0x078000
pci 0000:00:01.1: reg 0x14: [mem 0x88034000-0x88034fff 64bit]
pci 0000:00:01.1: reg 0x1c: [mem 0x80080000000-0x8008001ffff 64bit pref]
pci 0000:00:01.2: [103c:1048] type 00 class 0x070002
pci 0000:00:01.2: reg 0x14: [mem 0x88033000-0x88033fff 64bit]
pci 0000:00:02.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:02.0: reg 0x10: [mem 0x88032000-0x88032fff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.1: [1033:0035] type 00 class 0x0c0310
pci 0000:00:02.1: reg 0x10: [mem 0x88031000-0x88031fff]
pci 0000:00:02.1: supports D1 D2
pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.2: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.2: reg 0x10: [mem 0x88030000-0x880300ff]
pci 0000:00:02.2: supports D1 D2
pci 0000:00:02.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:03.0: [1002:515e] type 00 class 0x030000
pci 0000:00:03.0: reg 0x10: [mem 0x80000000-0x87ffffff pref]
pci 0000:00:03.0: reg 0x14: [io  0x1001000-0x10010ff]
pci 0000:00:03.0: reg 0x18: [mem 0x88020000-0x8802ffff]
pci 0000:00:03.0: reg 0x30: [mem 0x88000000-0x8801ffff pref]
pci 0000:00:03.0: supports D1 D2
ACPI: PCI Root Bridge [L002] (domain 0000 [bus 01])
acpi HWP0002:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HWP0002:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0x2000000-0x200ffff window] (bus address [0x0000-0xffff])
pci_bus 0000:01: root bus resource [mem 0xa0000000-0xafffffff window]
pci_bus 0000:01: root bus resource [mem 0x80204000000-0x802ffffffff window]
pci_bus 0000:01: root bus resource [bus 01]
pci 0000:01:01.0: [1000:0054] type 00 class 0x010000
pci 0000:01:01.0: reg 0x10: [io  0x2001000-0x20010ff]
pci 0000:01:01.0: reg 0x14: [mem 0xa0470000-0xa0473fff 64bit]
pci 0000:01:01.0: reg 0x1c: [mem 0xa0460000-0xa046ffff 64bit]
pci 0000:01:01.0: reg 0x30: [mem 0xa0000000-0xa03fffff pref]
pci 0000:01:01.0: supports D1 D2
pci 0000:01:02.0: [14e4:1648] type 00 class 0x020000
pci 0000:01:02.0: reg 0x10: [mem 0xa0450000-0xa045ffff 64bit]
pci 0000:01:02.0: reg 0x30: [mem 0xa0420000-0xa043ffff pref]
pci 0000:01:02.0: PME# supported from D3hot D3cold
pci 0000:01:02.1: [14e4:1648] type 00 class 0x020000
pci 0000:01:02.1: reg 0x10: [mem 0xa0440000-0xa044ffff 64bit]
pci 0000:01:02.1: reg 0x30: [mem 0xa0400000-0xa041ffff pref]
pci 0000:01:02.1: PME# supported from D3hot D3cold
ACPI: PCI Root Bridge [L003] (domain 0000 [bus 02])
acpi HWP0002:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HWP0002:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
PCI host bridge to bus 0000:02
pci_bus 0000:02: root bus resource [io  0x3000000-0x300ffff window] (bus address [0x0000-0xffff])
pci_bus 0000:02: root bus resource [mem 0xb0000000-0xbfffffff window]
pci_bus 0000:02: root bus resource [mem 0x80304000000-0x803ffffffff window]
pci_bus 0000:02: root bus resource [bus 02]
pci 0000:02:01.0: [8086:1079] type 00 class 0x020000
pci 0000:02:01.0: reg 0x10: [mem 0xb0120000-0xb013ffff 64bit]
pci 0000:02:01.0: reg 0x18: [mem 0xb00c0000-0xb00fffff 64bit]
pci 0000:02:01.0: reg 0x20: [io  0x3001040-0x300107f]
pci 0000:02:01.0: reg 0x30: [mem 0xb0080000-0xb00bffff pref]
pci 0000:02:01.0: PME# supported from D0 D3hot
pci 0000:02:01.1: [8086:1079] type 00 class 0x020000
pci 0000:02:01.1: reg 0x10: [mem 0xb0100000-0xb011ffff 64bit]
pci 0000:02:01.1: reg 0x18: [mem 0xb0040000-0xb007ffff 64bit]
pci 0000:02:01.1: reg 0x20: [io  0x3001000-0x300103f]
pci 0000:02:01.1: reg 0x30: [mem 0xb0000000-0xb003ffff pref]
pci 0000:02:01.1: PME# supported from D0 D3hot
ACPI: PCI Root Bridge [L006] (domain 0000 [bus 03])
acpi HWP0002:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HWP0002:03: _OSC failed (AE_NOT_FOUND); disabling ASPM
PCI host bridge to bus 0000:03
pci_bus 0000:03: root bus resource [io  0x4000000-0x400ffff window] (bus address [0x0000-0xffff])
pci_bus 0000:03: root bus resource [mem 0xe0000000-0xefffffff window]
pci_bus 0000:03: root bus resource [mem 0x80604000000-0x806ffffffff window]
pci_bus 0000:03: root bus resource [bus 03]
pci 0000:03:01.0: [1000:0030] type 00 class 0x010000
pci 0000:03:01.0: reg 0x10: [io  0x4001100-0x40011ff]
pci 0000:03:01.0: reg 0x14: [mem 0xe0260000-0xe027ffff 64bit]
pci 0000:03:01.0: reg 0x1c: [mem 0xe0240000-0xe025ffff 64bit]
pci 0000:03:01.0: reg 0x30: [mem 0xe0100000-0xe01fffff pref]
pci 0000:03:01.0: supports D1 D2
pci 0000:03:01.1: [1000:0030] type 00 class 0x010000
pci 0000:03:01.1: reg 0x10: [io  0x4001000-0x40010ff]
pci 0000:03:01.1: reg 0x14: [mem 0xe0220000-0xe023ffff 64bit]
pci 0000:03:01.1: reg 0x1c: [mem 0xe0200000-0xe021ffff 64bit]
pci 0000:03:01.1: reg 0x30: [mem 0xe0000000-0xe00fffff pref]
pci 0000:03:01.1: supports D1 D2
ACPI: PCI Root Bridge [L007] (domain 0000 [bus 04])
acpi HWP0002:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HWP0002:04: _OSC failed (AE_NOT_FOUND); disabling ASPM
PCI host bridge to bus 0000:04
pci_bus 0000:04: root bus resource [io  0x5000000-0x500ffff window] (bus address [0x0000-0xffff])
pci_bus 0000:04: root bus resource [mem 0xf0000000-0xfdffffff window]
pci_bus 0000:04: root bus resource [mem 0x80704000000-0x807ffffffff window]
pci_bus 0000:04: root bus resource [bus 04]
pci 0000:04:01.0: [8086:1079] type 00 class 0x020000
pci 0000:04:01.0: reg 0x10: [mem 0xf0120000-0xf013ffff 64bit]
pci 0000:04:01.0: reg 0x18: [mem 0xf00c0000-0xf00fffff 64bit]
pci 0000:04:01.0: reg 0x20: [io  0x5001040-0x500107f]
pci 0000:04:01.0: reg 0x30: [mem 0xf0080000-0xf00bffff pref]
pci 0000:04:01.0: PME# supported from D0 D3hot
pci 0000:04:01.1: [8086:1079] type 00 class 0x020000
pci 0000:04:01.1: reg 0x10: [mem 0xf0100000-0xf011ffff 64bit]
pci 0000:04:01.1: reg 0x18: [mem 0xf0040000-0xf007ffff 64bit]
pci 0000:04:01.1: reg 0x20: [io  0x5001000-0x500103f]
pci 0000:04:01.1: reg 0x30: [mem 0xf0000000-0xf003ffff pref]
pci 0000:04:01.1: PME# supported from D0 D3hot
ACPI: Enabled 2 GPEs in block 10 to 1F
pci 0000:00:03.0: vgaarb: setting as boot VGA device
pci 0000:00:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:03.0: vgaarb: bridge control possible
vgaarb: loaded
Registered efivars operations
IOC: zx2 2.0 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
clocksource: Switched to clocksource itc
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
pnp: PnP ACPI init
GSI 24 (level, low) -> CPU 1 (0x0200) vector 50
pnp 00:00: Plug and Play ACPI device, IDs PNP0501 (active)
pnp: PnP ACPI: found 1 devices
NET: Registered protocol family 2
TCP established hash table entries: 131072 (order: 4, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 2, 262144 bytes)
UDP-Lite hash table entries: 8192 (order: 2, 262144 bytes)
NET: Registered protocol family 1
GSI 17 (level, low) -> CPU 2 (0x0400) vector 51
GSI 17 (level, low) -> CPU 2 (0x0400) vector 51 unregistered
GSI 18 (level, low) -> CPU 3 (0x0600) vector 51
GSI 18 (level, low) -> CPU 3 (0x0600) vector 51 unregistered
GSI 19 (level, low) -> CPU 0 (0x0000) vector 51
GSI 19 (level, low) -> CPU 0 (0x0000) vector 51 unregistered
pci 0000:00:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
PCI: CLS 128 bytes, default 128
Unpacking initramfs...
Freeing initrd memory: 13696kB freed
perfmon: version 2.0 IRQ 238
perfmon: Montecito PMU detected, 27 PMCs, 35 PMDs, 12 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
futex hash table entries: 2048 (order: 2, 262144 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1484695540.552:1): initialized
workingset: timestamp_bits=52 max_order=18 bucket_order=0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:00: ttyS0 at MMIO 0xff5e2000 (irq = 50, base_baud = 115200) is a 16550A
GSI 16 (level, low) -> CPU 1 (0x0200) vector 51
0000:00:01.2: ttyS1 at MMIO 0x88033000 (irq = 54, base_baud = 115200) is a 16550A
EFI Time Services Driver v0.4
libphy: Fixed MDIO Bus: probed
mousedev: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
registered taskstats version 1
Freeing unused kernel memory: 1472K
This architecture does not have kernel memory protection.
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: Thermal Zone [THM0] (27 C)
SCSI subsystem initialized
Fusion MPT base driver 3.04.20
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SPI Host driver 3.04.20
GSI 49 (level, low) -> CPU 2 (0x0400) vector 52
mptbase: ioc0: Initiating bringup
ioc0: LSI53C1030 C0: Capabilities={Initiator,Target}
scsi host0: ioc0: LSI53C1030 C0, FwRev=01032346h, Ports=1, MaxQ=255, IRQ=55
GSI 50 (level, low) -> CPU 3 (0x0600) vector 53
mptbase: ioc1: Initiating bringup
ioc1: LSI53C1030 C0: Capabilities={Initiator,Target}
scsi host1: ioc1: LSI53C1030 C0, FwRev=01032346h, Ports=1, MaxQ=255, IRQ=56
Fusion MPT SAS Host driver 3.04.20
GSI 27 (level, low) -> CPU 0 (0x0000) vector 54
mptbase: ioc2: Initiating bringup
ioc2: LSISAS1068 B0: Capabilities={Initiator}
random: crng init done
scsi host2: ioc2: LSISAS1068 B0, FwRev=01172a00h, Ports=1, MaxQ=163, IRQ=57
mptsas: ioc2: attaching ssp device: fw_channel 0, fw_id 8, phy 0, sas_addr 0x5000cca00a9965f5
scsi 2:0:0:0: Direct-Access     HP       DG0146FARVU      HPD6 PQ: 0 ANSI: 5
mptsas: ioc2: attaching ssp device: fw_channel 0, fw_id 7, phy 1, sas_addr 0x5000cca00a99675d
scsi 2:0:1:0: Direct-Access     HP       DG0146FARVU      HPD6 PQ: 0 ANSI: 5
udevd (187): /proc/187/oom_adj is deprecated, please use /proc/187/oom_score_adj instead.
udevd version 128 started
sd 2:0:0:0: [sda] 286749488 512-byte logical blocks: (147 GB/137 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: eb 00 10 08
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 2:0:1:0: [sdb] 286749488 512-byte logical blocks: (147 GB/137 GiB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: eb 00 10 08
sd 2:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
sd 2:0:0:0: [sda] Attached SCSI disk
sd 2:0:1:0: [sdb] Attached SCSI disk
EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr
udevd version 128 started
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: Sleep Button [SLPF]
ipmi message handler version 39.2
ipmi_si IPI0001:00: ipmi_si: probing via ACPI
ipmi_si IPI0001:00: [mem 0xff5bc000-0xff5bc003] regsize 1 spacing 1 irq 0
ipmi_si: Adding ACPI-specified kcs state machine
IPMI System Interface driver.
ipmi_si: probing via SPMI
ipmi_si: SPMI: mem 0xff5bc000 regsize 1 spacing 1 irq 0
ipmi_si: SPMI-specified kcs state machine: duplicate
ipmi_si: Trying ACPI-specified kcs state machine at mem address 0xff5bc000, slave address 0x0, irq 0
Fusion MPT misc device (ioctl) driver 3.04.20
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
e1000: Copyright (c) 1999-2006 Intel Corporation.
GSI 38 (level, low) -> CPU 1 (0x0200) vector 55
ipmi_si IPI0001:00: Found new BMC (man_id: 0x00000b, prod_id: 0x8201, dev_id: 0x32)
ipmi_si IPI0001:00: IPMI kcs interface initialized
e1000 0000:02:01.0 eth0: (PCI-X:133MHz:64-bit) 00:24:81:77:73:a4
e1000 0000:02:01.0 eth0: Intel(R) PRO/1000 Network Connection
GSI 39 (level, low) -> CPU 2 (0x0400) vector 56
sd 2:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:1:0: Attached scsi generic sg1 type 0
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PTP clock support registered
tg3.c:v3.137 (May 11, 2014)
GSI 29 (level, low) -> CPU 3 (0x0600) vector 57
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
e1000 0000:02:01.1 eth1: (PCI-X:133MHz:64-bit) 00:24:81:77:73:a5
e1000 0000:02:01.1 eth1: Intel(R) PRO/1000 Network Connection
GSI 60 (level, low) -> CPU 0 (0x0000) vector 58
ehci-pci: EHCI PCI platform driver
GSI 19 (level, low) -> CPU 1 (0x0200) vector 59
ehci-pci 0000:00:02.2: EHCI Host Controller
ehci-pci 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.2: irq 53, io mem 0x88030000
ehci-pci 0000:00:02.2: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 4.10.0-rc4-0.7-default ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
GSI 17 (level, low) -> CPU 2 (0x0400) vector 60
ohci-pci 0000:00:02.0: OHCI PCI host controller
ohci-pci 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci-pci 0000:00:02.0: irq 51, io mem 0x88032000
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI PCI host controller
usb usb2: Manufacturer: Linux 4.10.0-rc4-0.7-default ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
tg3 0000:01:02.0 eth2: Tigon3 [partno(BCM95700A6) rev 2100] (PCIX:66MHz:64-bit) MAC address 00:22:64:94:09:3f
tg3 0000:01:02.0 eth2: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
GSI 18 (level, low) -> CPU 3 (0x0600) vector 61
ohci-pci 0000:00:02.1: OHCI PCI host controller
ohci-pci 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci-pci 0000:00:02.1: irq 52, io mem 0x88031000
tg3 0000:01:02.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:01:02.0 eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
GSI 30 (level, low) -> CPU 0 (0x0000) vector 62
e1000 0000:04:01.0 eth3: (PCI-X:133MHz:64-bit) 00:24:81:77:75:70
e1000 0000:04:01.0 eth3: Intel(R) PRO/1000 Network Connection
GSI 61 (level, low) -> CPU 1 (0x0200) vector 63
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI PCI host controller
usb usb3: Manufacturer: Linux 4.10.0-rc4-0.7-default ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
tg3 0000:01:02.1 eth4: Tigon3 [partno(BCM95700A6) rev 2100] (PCIX:66MHz:64-bit) MAC address 00:22:64:94:09:3e
tg3 0000:01:02.1 eth4: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
tg3 0000:01:02.1 eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:01:02.1 eth4: dma_rwctrl[769f0000] dma_mask[64-bit]
tg3 0000:01:02.1 eth4_rename: renamed from eth4
tg3 0000:01:02.0 eth2_rename: renamed from eth2
usb 2-1: new full-speed USB device number 2 using ohci-pci
e1000 0000:04:01.1 eth2: (PCI-X:133MHz:64-bit) 00:24:81:77:75:71
e1000 0000:04:01.1 eth2: Intel(R) PRO/1000 Network Connection
e1000 0000:04:01.0 eth4: renamed from eth3
e1000 0000:02:01.0 eth0_rename: renamed from eth0
e1000 0000:02:01.1 eth3: renamed from eth1
e1000 0000:04:01.1 eth5: renamed from eth2
tg3 0000:01:02.1 eth1: renamed from eth4_rename
e1000 0000:02:01.0 eth2: renamed from eth0_rename
tg3 0000:01:02.0 eth0: renamed from eth2_rename
usb 2-1: New USB device found, idVendor=03f0, idProduct=1126
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=63
usb 2-1: Product: Virtual Management Device
usb 2-1: Manufacturer: HP
usb 2-1: SerialNumber: 0022649407fa
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
input: HP Virtual Management Device as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1:1.0/0003:03F0:1126.0001/input/input2
hid-generic 0003:03F0:1126.0001: input,hidraw0: USB HID v1.11 Keyboard [HP Virtual Management Device] on usb-0000:00:02.0-1/input0
input: HP Virtual Management Device as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1:1.1/0003:03F0:1126.0002/input/input3
hid-generic 0003:03F0:1126.0002: input,hidraw1: USB HID v1.01 Mouse [HP Virtual Management Device] on usb-0000:00:02.0-1/input1
usb 1-2: new high-speed USB device number 3 using ehci-pci
Adding 2104448k swap on /dev/sdb2.  Priority:-1 extents:1 across:2104448k
usb 1-2: New USB device found, idVendor=03f0, idProduct=0126
usb 1-2: New USB device strings: Mfr=51, Product=80, SerialNumber=67
usb 1-2: Product: INTEGRITY SERVER
usb 1-2: Manufacturer: HEWLETT PACKARD
usb 1-2: SerialNumber: A60020000001
usb-storage 1-2:1.0: USB Mass Storage device detected
scsi host3: usb-storage 1-2:1.0
usbcore: registered new interface driver usb-storage
usb 3-2: new low-speed USB device number 2 using ohci-pci
usb 3-2: New USB device found, idVendor=0557, idProduct=2221
usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-2: Product: UC-10KM V1.3.121
usb 3-2: Manufacturer: ATEN
usb 3-2: SerialNumber: USB Composite device
input: ATEN UC-10KM V1.3.121 as /devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0/0003:0557:2221.0003/input/input4
hid-generic 0003:0557:2221.0003: input,hidraw2: USB HID v1.10 Keyboard [ATEN UC-10KM V1.3.121] on usb-0000:00:02.1-2/input0
input: ATEN UC-10KM V1.3.121 as /devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.1/0003:0557:2221.0004/input/input5
hid-generic 0003:0557:2221.0004: input,hidraw3: USB HID v1.10 Mouse [ATEN UC-10KM V1.3.121] on usb-0000:00:02.1-2/input1
scsi 3:0:0:0: CD-ROM            TEAC     DVD-ROM DW-224EV K.DA PQ: 0 ANSI: 0
scsi 3:0:0:0: Attached scsi generic sg2 type 5
sr 3:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
loop: module loaded
FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
fuse init (API version 7.26)
ip_local_port_range: prefer different parity for start/end values.
hangcheck_timer: disagrees about version of symbol module_layout
tg3 0000:01:02.0 eth0: Link is up at 1000 Mbps, full duplex
tg3 0000:01:02.0 eth0: Flow control is off for TX and off for RX
NET: Registered protocol family 10
IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
Segment Routing with IPv6
tg3 0000:01:02.1 eth1: Link is up at 1000 Mbps, full duplex
tg3 0000:01:02.1 eth1: Flow control is off for TX and off for RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period (net a0000001015c6200)
GSI 20 (level, low) -> CPU 2 (0x0400) vector 64
gnome-settings-(4187): floating-point assist fault at ip 2000000006babdc2, isr 0000020000001001
gnome-settings-(4187): floating-point assist fault at ip 2000000006babdc2, isr 0000020000001001
gdm-simple-gree(4196): unaligned access to 0x600fffffffabf34c, ip=0x20000000012216a0
gdm-simple-gree(4196): floating-point assist fault at ip 2000000002fbbdc2, isr 0000020000001001
gdm-simple-gree(4196): floating-point assist fault at ip 2000000002fbbdc2, isr 0000020000001001

[2] x86:
[    0.000000] Linux version 4.10.0-rc4-mainline+ (root@linux-rh5885) (gcc version 4.9.0 (GCC) ) #2 SMP PREEMPT Fri Mar 10 16:13:12 CST 2017
[    0.000000] Command line: noexec=on nmi_watchdog=1 intel_iommu=off selinux=0 pci=realloc console=tty0 console=ttyS0,115200 nohz=off highres=on hpet=enable oops=panic panic=3 hugepagesz=2M
default_hugepagesz=2M crashkernel=192M@48M
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000079a94fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079a95000-0x0000000079b05fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079b06000-0x0000000079b11fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000079b12000-0x0000000079b76fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079b77000-0x0000000079b78fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079b79000-0x0000000079b79fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079b7a000-0x0000000079bb0fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079bb1000-0x0000000079bbdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079bbe000-0x0000000079beafff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079beb000-0x0000000079dedfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079dee000-0x0000000079ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107bffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: HUAWEI TECHNOLOGIES CO.,LTD. Tecal RH5885 V2/CH91RGPUC, BIOS RGPUC-BIOS-V036 10/26/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x107c000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D7FFF write-protect
[    0.000000]   D8000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00000000000 mask FF000000000 write-back
[    0.000000]   1 base 01000000000 mask FFF80000000 write-back
[    0.000000]   2 base 0007C000000 mask FFFFC000000 uncachable
[    0.000000]   3 base 00080000000 mask FFF80000000 uncachable
[    0.000000]   4 base 0107C000000 mask FFFFC000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT 
[    0.000000] e820: update [mem 0x7c000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd520-0x000fd52f] mapped at [ffff8800000fd520]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000096000] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x026ca000, 0x026cafff] PGTABLE
[    0.000000] BRK [0x026cb000, 0x026cbfff] PGTABLE
[    0.000000] BRK [0x026cc000, 0x026ccfff] PGTABLE
[    0.000000] BRK [0x026cd000, 0x026cdfff] PGTABLE
[    0.000000] BRK [0x026ce000, 0x026cefff] PGTABLE
[    0.000000] RAMDISK: [mem 0x36fb7000-0x37feffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0420 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000000079B060A0 00008C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x0000000079B0F6C0 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x0000000079B061B8 009502 (v02 ALASKA A M I    00000015 INTL 20051117)
[    0.000000] ACPI: FACS 0x0000000079BB5F40 000040
[    0.000000] ACPI: FACS 0x0000000079BB5F80 000040
[    0.000000] ACPI: APIC 0x0000000079B0F7B8 000304 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x0000000079B0FAC0 000A1E (v01 AMICPU PROC     00000001 MSFT 03000001)
[    0.000000] ACPI: MCFG 0x0000000079B104E0 00003C (v01 A M I  OEMMCFG. 01072009 MSFT 00000097)
[    0.000000] ACPI: SRAT 0x0000000079B10520 000830 (v01 A M I  AMI SRAT 00000001 AMI. 00000000)
[    0.000000] ACPI: SLIT 0x0000000079B10D50 00003C (v01 A M I  AMI SLIT 00000000 AMI. 00000000)
[    0.000000] ACPI: HPET 0x0000000079B10D90 000038 (v01 A M I  ICH7HPET 01072009 AMI. 00000003)
[    0.000000] ACPI: SPMI 0x0000000079B10DC8 000040 (v05 A M I  OEMSPMI  00000000 AMI. 00000000)
[    0.000000] ACPI: EINJ 0x0000000079B10E08 000130 (v01 AMI    AMI EINJ 00000000      00000000)
[    0.000000] ACPI: ERST 0x0000000079B10F38 000230 (v01 AMIER  AMI ERST 00000000      00000000)
[    0.000000] ACPI: HEST 0x0000000079B11168 0000A8 (v01 AMI    AMI HEST 00000000      00000000)
[    0.000000] ACPI: BERT 0x0000000079B11210 000030 (v01 AMI    AMI BERT 00000000      00000000)
[    0.000000] ACPI: DMAR 0x0000000079B11240 000198 (v01 A M I  OEMDMAR  00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x40 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x41 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x42 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x43 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x44 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x45 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x64 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x65 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x70 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x71 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x72 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x73 -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 0x80 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x81 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x82 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x83 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x84 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x85 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0xa4 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0xa5 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0xb0 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0xb1 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0xb2 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0xb3 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 0xc0 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xc1 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xc2 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xc3 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xc4 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xc5 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xe4 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xe5 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xf0 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xf1 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xf2 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0xf3 -> Node 3
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x47fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x480000000-0x87fffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x880000000-0xc7fffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0xc80000000-0x107fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=4
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x47fffffff] -> [mem 0x00000000-0x47fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x47ffcd000-0x47fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x87ffcd000-0x87fffffff]
[    0.000000] NODE_DATA(2) allocated [mem 0xc7ffcd000-0xc7fffffff]
[    0.000000] NODE_DATA(3) allocated [mem 0x107bfca000-0x107bffcfff]
[    0.000000] Reserving 192MB of memory at 48MB for crashkernel (System RAM: 65372MB)
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000107bffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000079a94fff]
[    0.000000]   node   0: [mem 0x0000000079b77000-0x0000000079b78fff]
[    0.000000]   node   0: [mem 0x0000000079dee000-0x0000000079ffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000047fffffff]
[    0.000000]   node   1: [mem 0x0000000480000000-0x000000087fffffff]
[    0.000000]   node   2: [mem 0x0000000880000000-0x0000000c7fffffff]
[    0.000000]   node   3: [mem 0x0000000c80000000-0x000000107bffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000047fffffff]
[    0.000000] On node 0 totalpages: 4168772
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7731 pages used for memmap
[    0.000000]   DMA32 zone: 494761 pages, LIFO batch:31
[    0.000000]   Normal zone: 57344 pages used for memmap
[    0.000000]   Normal zone: 3670016 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000480000000-0x000000087fffffff]
[    0.000000] On node 1 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
[    0.000000] Initmem setup node 2 [mem 0x0000000880000000-0x0000000c7fffffff]
[    0.000000] On node 2 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
[    0.000000] Initmem setup node 3 [mem 0x0000000c80000000-0x000000107bffffff]
[    0.000000] On node 3 totalpages: 4177920
[    0.000000]   Normal zone: 65280 pages used for memmap
[    0.000000]   Normal zone: 4177920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x20] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x22] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x24] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x26] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x28] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x21] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x23] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x25] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x27] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x29] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2f] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec81000, GSI 24-47
[    0.000000] IOAPIC[2]: apic_id 3, version 32, address 0xfec84000, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 48 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x79a95000-0x79b05fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79b06000-0x79b11fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79b12000-0x79b76fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79b79000-0x79b79fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79b7a000-0x79bb0fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79bb1000-0x79bbdfff]
[    0.000000] PM: Registered nosave memory: [mem 0x79bbe000-0x79beafff]
[    0.000000] PM: Registered nosave memory: [mem 0x79beb000-0x79dedfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a000000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0x8fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x90000000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:48 nr_cpu_ids:48 nr_node_ids:4
[    0.000000] percpu: Embedded 35 pages/cpu @ffff88046fa00000 s102936 r8192 d32232 u262144
[    0.000000] pcpu-alloc: s102936 r8192 d32232 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 24 25 [0] 26 27 28 29 -- -- -- --
[    0.000000] pcpu-alloc: [1] 06 07 08 09 10 11 30 31 [1] 32 33 34 35 -- -- -- --
[    0.000000] pcpu-alloc: [2] 12 13 14 15 16 17 36 37 [2] 38 39 40 41 -- -- -- --
[    0.000000] pcpu-alloc: [3] 18 19 20 21 22 23 42 43 [3] 44 45 46 47 -- -- -- --
[    0.000000] Built 4 zonelists in Node order, mobility grouping on.  Total pages: 16473788
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: noexec=on nmi_watchdog=1 intel_iommu=off selinux=0 pci=realloc console=tty0 console=ttyS0,115200 nohz=off highres=on hpet=enable oops=panic panic=3 hugepagesz=2M
default_hugepagesz=2M crashkernel=192M@48M
[    0.000000] log_buf_len individual max cpu contribution: 1048576 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 49283072 bytes
[    0.000000] log_buf_len min size: 1048576 bytes
[    0.000000] log_buf_len: 67108864 bytes
[    0.000000] early log buf free: 1030352(98%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 65516840K/66941200K available (7351K kernel code, 6432K rwdata, 3252K rodata, 2288K init, 2284K bss, 1424360K reserved, 0K cma-reserved)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]     Build-time adjustment of leaf fanout to 64.
[    0.000000]     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=48.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=48
[    0.000000]
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** trace_printk() being used. Allocating extra memory.  **
[    0.000000] **                                                      **
[    0.000000] ** This means that this is a DEBUG kernel and it is     **
[    0.000000] ** unsafe for production use.                           **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your vendor!  **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.000000] NR_IRQS:524544 nr_irqs:1624 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1866.775 MHz processor
[    0.000058] Calibrating delay loop (skipped), value calculated using timer frequency.. 3733.55 BogoMIPS (lpj=7467100)
[    0.011465] pid_max: default: 49152 minimum: 384
[    0.016517] ACPI: Core revision 20160930
[    0.045926] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.053117] Security Framework initialized
[    0.057538] AppArmor: AppArmor initialized
[    0.068264] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.102612] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.122425] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.130004] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.139848] CPU: Physical Processor ID: 0
[    0.144218] CPU: Processor Core ID: 1
[    0.148246] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.154561] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.162271] mce: CPU supports 24 MCE banks
[    0.166740] CPU0: Thermal monitoring enabled (TM1)
[    0.171969] process: using mwait in idle threads
[    0.176908] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.182717] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.189638] Freeing SMP alternatives memory: 28K
[    0.196165] ftrace: allocating 27151 entries in 107 pages
[    0.219801] smpboot: Max logical packages: 8
[    0.224414] Switched APIC routing to physical flat.
[    0.230464] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.383137] smpboot: CPU0: Intel(R) Xeon(R) CPU E7- 4807  @ 1.87GHz (family: 0x6, model: 0x2f, stepping: 0x2)
[    0.407147] Performance Events: PEBS fmt1+, Westmere events, 16-deep LBR, Intel PMU driver.
[    0.415830] core: CPUID marked event: 'bus cycles' unavailable
[    0.421830] ... version:                3
[    0.426008] ... bit width:              48
[    0.430270] ... generic registers:      4
[    0.434447] ... value mask:             0000ffffffffffff
[    0.439923] ... max period:             000000007fffffff
[    0.445397] ... fixed-purpose events:   3
[    0.449573] ... event mask:             000000070000000f
[    0.486526] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.495150] smp: Bringing up secondary CPUs ...
[    0.531516] x86: Booting SMP configuration:
[    0.535877] .... node  #0, CPUs:        #1  #2  #3  #4  #5
[    1.105335] .... node  #1, CPUs:    #6  #7  #8  #9 #10 #11
[    1.829272] .... node  #2, CPUs:   #12 #13 #14 #15 #16 #17
[    2.553238] .... node  #3, CPUs:   #18 #19 #20 #21 #22 #23
[    3.277040] .... node  #0, CPUs:   #24 #25 #26 #27 #28 #29
[    3.957189] .... node  #1, CPUs:   #30 #31 #32 #33 #34 #35
[    4.637125] .... node  #2, CPUs:   #36 #37 #38 #39 #40 #41
[    5.317082] .... node  #3, CPUs:   #42 #43 #44 #45 #46 #47
[    5.961223] smp: Brought up 4 nodes, 48 CPUs
[    5.971320] smpboot: Total of 48 processors activated (179210.32 BogoMIPS)
[    6.393575] devtmpfs: initialized
[    6.397291] x86/mm: Memory block size: 2048MB
[    6.405836] PM: Registering ACPI NVS region [mem 0x79a95000-0x79b05fff] (462848 bytes)
[    6.414068] PM: Registering ACPI NVS region [mem 0x79b79000-0x79b79fff] (4096 bytes)
[    6.422100] PM: Registering ACPI NVS region [mem 0x79bb1000-0x79bbdfff] (53248 bytes)
[    6.430220] PM: Registering ACPI NVS region [mem 0x79beb000-0x79dedfff] (2109440 bytes)
[    6.438910] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    6.449699] RTC time:  8:29:16, date: 03/10/17
[    6.455888] NET: Registered protocol family 16
[    6.474916] cpuidle: using governor ladder
[    6.479194] PCCT header not found.
[    6.482869] ACPI: bus type PCI registered
[    6.487355] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    6.496952] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    6.503951] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mapping due to MTRR override.
[    6.515545] PCI: Using configuration type 1 for base access
[    6.541785] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    6.548337] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    6.556603] ACPI: Added _OSI(Module Device)
[    6.560986] ACPI: Added _OSI(Processor Device)
[    6.565636] ACPI: Added _OSI(3.0 _SCP Extensions)
[    6.570528] ACPI: Added _OSI(Processor Aggregator Device)
[    6.576567] ACPI: Executed 1 blocks of module-level executable AML code
[    6.606240] ACPI: Dynamic OEM Table Load:
[    6.610462] ACPI: SSDT 0xFFFF88086C2BC000 002CF4 (v01 AMI    IST      00000001 MSFT 03000001)
[    6.625614] ACPI: Dynamic OEM Table Load:
[    6.629820] ACPI: SSDT 0xFFFF88046BD3D000 000924 (v01 AMI    CST      00000001 MSFT 03000001)
[    6.657883] ACPI: Interpreter enabled
[    6.661771] ACPI: (supports S0 S1 S5)
[    6.665621] ACPI: Using IOAPIC for interrupt routing
[    6.670920] HEST: Table parsing has been initialized.
[    6.676164] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    6.702566] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    6.721843] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
[    6.728221] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.737375] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    6.746138] PCI host bridge to bus 0000:00
[    6.750426] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    6.757398] pci_bus 0000:00: root bus resource [io  0x0d00-0x9fff window]
[    6.764367] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    6.772169] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000dffff window]
[    6.779971] pci_bus 0000:00: root bus resource [mem 0x7c000000-0xcfffffff window]
[    6.787774] pci_bus 0000:00: root bus resource [bus 00-7f]
[    6.793464] pci 0000:00:00.0: [8086:3407] type 00 class 0x060000
[    6.793561] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    6.793804] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    6.793889] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    6.794129] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    6.794213] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    6.794452] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    6.794533] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    6.794770] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    6.794854] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    6.795092] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    6.795174] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    6.795411] pci 0000:00:13.0: [8086:342d] type 00 class 0x080020
[    6.795426] pci 0000:00:13.0: reg 0x10: [mem 0xcf224000-0xcf224fff]
[    6.795496] pci 0000:00:13.0: PME# supported from D0 D3hot D3cold
[    6.795709] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    6.795969] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    6.796235] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    6.796493] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    6.796737] pci 0000:00:15.0: [8086:342f] type 00 class 0x080020
[    6.796999] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    6.797050] pci 0000:00:1a.0: reg 0x20: [io  0x90e0-0x90ff]
[    6.797291] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    6.803222] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    6.803273] pci 0000:00:1a.1: reg 0x20: [io  0x90c0-0x90df]
[    6.803509] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    6.809440] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    6.809491] pci 0000:00:1a.2: reg 0x20: [io  0x90a0-0x90bf]
[    6.809727] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    6.815671] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    6.815693] pci 0000:00:1a.7: reg 0x10: [mem 0xcf223000-0xcf2233ff]
[    6.815800] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    6.815960] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    6.821891] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    6.821989] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    6.822153] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    6.828087] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    6.828182] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    6.828346] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    6.834275] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    6.834326] pci 0000:00:1d.0: reg 0x20: [io  0x9080-0x909f]
[    6.834563] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    6.840492] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    6.840543] pci 0000:00:1d.1: reg 0x20: [io  0x9060-0x907f]
[    6.840781] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    6.846712] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    6.846763] pci 0000:00:1d.2: reg 0x20: [io  0x9040-0x905f]
[    6.847000] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    6.852938] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    6.852960] pci 0000:00:1d.7: reg 0x10: [mem 0xcf222000-0xcf2223ff]
[    6.853075] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    6.853234] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    6.859158] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    6.859375] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    6.865307] pci 0000:00:1f.0: [8086:3a18] type 00 class 0x060100
[    6.865644] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    6.865663] pci 0000:00:1f.2: reg 0x10: [io  0x9130-0x9137]
[    6.865673] pci 0000:00:1f.2: reg 0x14: [io  0x9120-0x9123]
[    6.865682] pci 0000:00:1f.2: reg 0x18: [io  0x9110-0x9117]
[    6.865692] pci 0000:00:1f.2: reg 0x1c: [io  0x9100-0x9103]
[    6.865701] pci 0000:00:1f.2: reg 0x20: [io  0x9020-0x903f]
[    6.865711] pci 0000:00:1f.2: reg 0x24: [mem 0xcf221000-0xcf2217ff]
[    6.865767] pci 0000:00:1f.2: PME# supported from D3hot
[    6.865994] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    6.866013] pci 0000:00:1f.3: reg 0x10: [mem 0xcf220000-0xcf2200ff 64bit]
[    6.866038] pci 0000:00:1f.3: reg 0x20: [io  0x9000-0x901f]
[    6.866345] pci 0000:00:01.0: PCI bridge to [bus 01-02]
[    6.871762] pci 0000:00:01.0:   bridge window [io  0x8000-0x8fff]
[    6.871766] pci 0000:00:01.0:   bridge window [mem 0xce000000-0xceffffff]
[    6.871772] pci 0000:00:01.0:   bridge window [mem 0xc7000000-0xc7ffffff 64bit pref]
[    6.871841] pci 0000:00:03.0: PCI bridge to [bus 03-04]
[    6.877254] pci 0000:00:03.0:   bridge window [io  0x7000-0x7fff]
[    6.877257] pci 0000:00:03.0:   bridge window [mem 0xcd000000-0xcdffffff]
[    6.877263] pci 0000:00:03.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
[    6.877342] pci 0000:05:00.0: [1000:005b] type 00 class 0x010400
[    6.877358] pci 0000:05:00.0: reg 0x10: [io  0x6000-0x60ff]
[    6.877371] pci 0000:05:00.0: reg 0x14: [mem 0xcf160000-0xcf163fff 64bit]
[    6.877384] pci 0000:05:00.0: reg 0x1c: [mem 0xcf100000-0xcf13ffff 64bit]
[    6.877400] pci 0000:05:00.0: reg 0x30: [mem 0xcf140000-0xcf15ffff pref]
[    6.877471] pci 0000:05:00.0: supports D1 D2
[    6.889008] pci 0000:00:05.0: PCI bridge to [bus 05]
[    6.894165] pci 0000:00:05.0:   bridge window [io  0x6000-0x6fff]
[    6.894168] pci 0000:00:05.0:   bridge window [mem 0xcf100000-0xcf1fffff]
[    6.894246] pci 0000:00:07.0: PCI bridge to [bus 06-07]
[    6.899660] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    6.899664] pci 0000:00:07.0:   bridge window [mem 0xcc000000-0xccffffff]
[    6.899670] pci 0000:00:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    6.899738] pci 0000:00:09.0: PCI bridge to [bus 08-09]
[    6.905154] pci 0000:00:09.0:   bridge window [io  0x4000-0x4fff]
[    6.905158] pci 0000:00:09.0:   bridge window [mem 0xcb000000-0xcbffffff]
[    6.905164] pci 0000:00:09.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    6.905258] pci 0000:0a:00.0: [19aa:e004] type 00 class 0x118000
[    6.905290] pci 0000:0a:00.0: reg 0x10: [mem 0xca000000-0xcaffffff]
[    6.905586] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    6.910742] pci 0000:00:1c.0:   bridge window [mem 0xca000000-0xcaffffff]
[    6.910838] pci 0000:0b:00.0: [18ca:0027] type 00 class 0x030000
[    6.910859] pci 0000:0b:00.0: reg 0x10: [mem 0xc0000000-0xc3ffffff pref]
[    6.910873] pci 0000:0b:00.0: reg 0x14: [mem 0xcf000000-0xcf03ffff]
[    6.910888] pci 0000:0b:00.0: reg 0x18: [io  0x3000-0x307f]
[    6.911013] pci 0000:0b:00.0: supports D1 D2
[    6.925011] pci 0000:00:1c.4: PCI bridge to [bus 0b]
[    6.930168] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    6.930172] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcf0fffff]
[    6.930179] pci 0000:00:1c.4:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    6.930284] pci 0000:00:1e.0: PCI bridge to [bus 0c] (subtractive decode)
[    6.937267] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    6.937269] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x9fff window] (subtractive decode)
[    6.937272] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    6.937274] pci 0000:00:1e.0:   bridge window [mem 0x000c8000-0x000dffff window] (subtractive decode)
[    6.937276] pci 0000:00:1e.0:   bridge window [mem 0x7c000000-0xcfffffff window] (subtractive decode)
[    6.938713] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
[    6.945088] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.954225] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    6.962941] PCI host bridge to bus 0000:80
[    6.967229] pci_bus 0000:80: root bus resource [io  0xa000-0xffff window]
[    6.974199] pci_bus 0000:80: root bus resource [mem 0xd0000000-0xfbffffff window]
[    6.982001] pci_bus 0000:80: root bus resource [bus 80-ff]
[    6.987683] pci 0000:80:00.0: [8086:3420] type 01 class 0x060400
[    6.987763] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    6.987931] pci 0000:80:01.0: [8086:3408] type 01 class 0x060400
[    6.988009] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    6.988173] pci 0000:80:03.0: [8086:340a] type 01 class 0x060400
[    6.988251] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    6.988410] pci 0000:80:05.0: [8086:340c] type 01 class 0x060400
[    6.988485] pci 0000:80:05.0: PME# supported from D0 D3hot D3cold
[    6.988646] pci 0000:80:07.0: [8086:340e] type 01 class 0x060400
[    6.988723] pci 0000:80:07.0: PME# supported from D0 D3hot D3cold
[    6.988883] pci 0000:80:09.0: [8086:3410] type 01 class 0x060400
[    6.988959] pci 0000:80:09.0: PME# supported from D0 D3hot D3cold
[    6.989134] pci 0000:80:13.0: [8086:342d] type 00 class 0x080020
[    6.989147] pci 0000:80:13.0: reg 0x10: [mem 0xfb300000-0xfb300fff]
[    6.989213] pci 0000:80:13.0: PME# supported from D0 D3hot D3cold
[    6.989352] pci 0000:80:14.0: [8086:342e] type 00 class 0x080000
[    6.989534] pci 0000:80:14.1: [8086:3422] type 00 class 0x080000
[    6.989713] pci 0000:80:14.2: [8086:3423] type 00 class 0x080000
[    6.989889] pci 0000:80:14.3: [8086:3438] type 00 class 0x080000
[    6.990118] pci 0000:80:00.0: PCI bridge to [bus 81]
[    6.995347] pci 0000:80:01.0: PCI bridge to [bus 82-83]
[    7.000759] pci 0000:80:01.0:   bridge window [io  0xf000-0xffff]
[    7.000763] pci 0000:80:01.0:   bridge window [mem 0xfa000000-0xfaffffff]
[    7.000769] pci 0000:80:01.0:   bridge window [mem 0xf6000000-0xf6ffffff 64bit pref]
[    7.000834] pci 0000:80:03.0: PCI bridge to [bus 84-85]
[    7.006246] pci 0000:80:03.0:   bridge window [io  0xe000-0xefff]
[    7.006250] pci 0000:80:03.0:   bridge window [mem 0xf9000000-0xf9ffffff]
[    7.006255] pci 0000:80:03.0:   bridge window [mem 0xf5000000-0xf5ffffff 64bit pref]
[    7.006338] pci 0000:86:00.0: [8086:150e] type 00 class 0x020000
[    7.006355] pci 0000:86:00.0: reg 0x10: [mem 0xfb180000-0xfb1fffff]
[    7.006372] pci 0000:86:00.0: reg 0x18: [io  0xd060-0xd07f]
[    7.006382] pci 0000:86:00.0: reg 0x1c: [mem 0xfb20c000-0xfb20ffff]
[    7.006475] pci 0000:86:00.0: PME# supported from D0 D3hot D3cold
[    7.006590] pci 0000:86:00.1: [8086:150e] type 00 class 0x020000
[    7.006606] pci 0000:86:00.1: reg 0x10: [mem 0xfb100000-0xfb17ffff]
[    7.006624] pci 0000:86:00.1: reg 0x18: [io  0xd040-0xd05f]
[    7.006634] pci 0000:86:00.1: reg 0x1c: [mem 0xfb208000-0xfb20bfff]
[    7.006721] pci 0000:86:00.1: PME# supported from D0 D3hot D3cold
[    7.006823] pci 0000:86:00.2: [8086:150e] type 00 class 0x020000
[    7.006839] pci 0000:86:00.2: reg 0x10: [mem 0xfb080000-0xfb0fffff]
[    7.006856] pci 0000:86:00.2: reg 0x18: [io  0xd020-0xd03f]
[    7.006866] pci 0000:86:00.2: reg 0x1c: [mem 0xfb204000-0xfb207fff]
[    7.006954] pci 0000:86:00.2: PME# supported from D0 D3hot D3cold
[    7.007058] pci 0000:86:00.3: [8086:150e] type 00 class 0x020000
[    7.007074] pci 0000:86:00.3: reg 0x10: [mem 0xfb000000-0xfb07ffff]
[    7.007091] pci 0000:86:00.3: reg 0x18: [io  0xd000-0xd01f]
[    7.007101] pci 0000:86:00.3: reg 0x1c: [mem 0xfb200000-0xfb203fff]
[    7.007188] pci 0000:86:00.3: PME# supported from D0 D3hot D3cold
[    7.021010] pci 0000:80:05.0: PCI bridge to [bus 86]
[    7.026168] pci 0000:80:05.0:   bridge window [io  0xd000-0xdfff]
[    7.026172] pci 0000:80:05.0:   bridge window [mem 0xfb000000-0xfb2fffff]
[    7.026246] pci 0000:80:07.0: PCI bridge to [bus 87-88]
[    7.031661] pci 0000:80:07.0:   bridge window [io  0xc000-0xcfff]
[    7.031664] pci 0000:80:07.0:   bridge window [mem 0xf8000000-0xf8ffffff]
[    7.031670] pci 0000:80:07.0:   bridge window [mem 0xf4000000-0xf4ffffff 64bit pref]
[    7.031738] pci 0000:80:09.0: PCI bridge to [bus 89-8a]
[    7.037155] pci 0000:80:09.0:   bridge window [io  0xb000-0xbfff]
[    7.037159] pci 0000:80:09.0:   bridge window [mem 0xf7000000-0xf7ffffff]
[    7.037164] pci 0000:80:09.0:   bridge window [mem 0xf3000000-0xf3ffffff 64bit pref]
[    7.037556] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    7.044774] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    7.051984] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12 14 15)
[    7.059194] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 10 11 12 14 15)
[    7.066403] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0
[    7.073790] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    7.081015] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0
[    7.088401] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
[    7.096559] ACPI: Enabled 4 GPEs in block 00 to 3F
[    7.102537] pci 0000:0b:00.0: vgaarb: setting as boot VGA device
[    7.108718] pci 0000:0b:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    7.117545] pci 0000:0b:00.0: vgaarb: bridge control possible
[    7.123457] vgaarb: loaded
[    7.126896] PCI: Using ACPI for IRQ routing
[    7.136888] PCI: Discovered peer bus fc
[    7.140895] PCI: root bus fc: using default resources
[    7.140899] PCI: Probing PCI hardware (bus fc)
[    7.141010] ACPI: \: failed to evaluate _DSM (0x1001)
[    7.146231] PCI host bridge to bus 0000:fc
[    7.150500] pci_bus 0000:fc: root bus resource [io  0x0000-0xffff]
[    7.156849] pci_bus 0000:fc: root bus resource [mem 0x00000000-0xfffffffffff]
[    7.164148] pci_bus 0000:fc: No busn resource found for root bus, will use [bus fc-ff]
[    7.172357] pci_bus 0000:fc: busn_res: can not insert [bus fc-ff] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.172368] pci 0000:fc:00.0: [8086:2b00] type 00 class 0x060000
[    7.172494] pci 0000:fc:00.2: [8086:2b02] type 00 class 0x060000
[    7.172598] pci 0000:fc:00.4: [8086:2b22] type 00 class 0x060000
[    7.172697] pci 0000:fc:00.6: [8086:2b2a] type 00 class 0x060000
[    7.172798] pci 0000:fc:01.0: [8086:2b04] type 00 class 0x060000
[    7.172902] pci 0000:fc:02.0: [8086:2b08] type 00 class 0x060000
[    7.173018] pci 0000:fc:03.0: [8086:2b0c] type 00 class 0x060000
[    7.173123] pci 0000:fc:04.0: [8086:2b10] type 00 class 0x060000
[    7.173227] pci 0000:fc:05.0: [8086:2b14] type 00 class 0x060000
[    7.173327] pci 0000:fc:05.2: [8086:2b16] type 00 class 0x060000
[    7.173424] pci 0000:fc:05.4: [8086:2b13] type 00 class 0x060000
[    7.173523] pci 0000:fc:05.6: [8086:2b53] type 00 class 0x060000
[    7.173623] pci 0000:fc:06.0: [8086:2b18] type 00 class 0x060000
[    7.173725] pci 0000:fc:07.0: [8086:2b1c] type 00 class 0x060000
[    7.173825] pci 0000:fc:07.2: [8086:2b1e] type 00 class 0x060000
[    7.173926] pci 0000:fc:07.4: [8086:2b1b] type 00 class 0x060000
[    7.174026] pci 0000:fc:07.6: [8086:2b5b] type 00 class 0x060000
[    7.174126] pci 0000:fc:08.0: [8086:2b20] type 00 class 0x060000
[    7.174230] pci 0000:fc:09.0: [8086:2b24] type 00 class 0x060000
[    7.174335] pci 0000:fc:0a.0: [8086:2b28] type 00 class 0x060000
[    7.174440] pci 0000:fc:0b.0: [8086:2b2c] type 00 class 0x060000
[    7.174547] pci 0000:fc:0c.0: [8086:2b30] type 00 class 0x060000
[    7.174650] pci 0000:fc:0d.0: [8086:2b34] type 00 class 0x060000
[    7.174753] pci 0000:fc:0e.0: [8086:2b38] type 00 class 0x060000
[    7.174856] pci 0000:fc:0f.0: [8086:2b3c] type 00 class 0x060000
[    7.174958] pci 0000:fc:10.0: [8086:2b40] type 00 class 0x060000
[    7.175055] pci 0000:fc:10.2: [8086:2b42] type 00 class 0x060000
[    7.175154] pci 0000:fc:10.4: [8086:2b32] type 00 class 0x060000
[    7.175252] pci 0000:fc:10.6: [8086:2b3a] type 00 class 0x060000
[    7.175348] pci 0000:fc:11.0: [8086:2b44] type 00 class 0x060000
[    7.175445] pci 0000:fc:11.2: [8086:2b46] type 00 class 0x060000
[    7.175546] pci 0000:fc:11.4: [8086:2b36] type 00 class 0x060000
[    7.175639] pci 0000:fc:11.6: [8086:2b3e] type 00 class 0x060000
[    7.175735] pci 0000:fc:12.0: [8086:2b48] type 00 class 0x060000
[    7.175838] pci 0000:fc:13.0: [8086:2b4c] type 00 class 0x060000
[    7.175944] pci 0000:fc:14.0: [8086:2b50] type 00 class 0x060000
[    7.176039] pci 0000:fc:14.2: [8086:2b52] type 00 class 0x060000
[    7.176136] pci 0000:fc:15.0: [8086:2b54] type 00 class 0x060000
[    7.176233] pci 0000:fc:15.2: [8086:2b56] type 00 class 0x060000
[    7.176340] pci 0000:fc:16.0: [8086:2b58] type 00 class 0x060000
[    7.176436] pci 0000:fc:16.2: [8086:2b5a] type 00 class 0x060000
[    7.176535] pci 0000:fc:17.0: [8086:2b5c] type 00 class 0x060000
[    7.176639] pci 0000:fc:17.2: [8086:2b5e] type 00 class 0x060000
[    7.176739] pci 0000:fc:18.0: [8086:2b60] type 00 class 0x060000
[    7.176836] pci 0000:fc:18.2: [8086:2b62] type 00 class 0x060000
[    7.176933] pci 0000:fc:19.0: [8086:2b64] type 00 class 0x060000
[    7.177046] pci 0000:fc:19.2: [8086:2b66] type 00 class 0x060000
[    7.177147] pci 0000:fc:1a.0: [8086:2b68] type 00 class 0x060000
[    7.177250] pci 0000:fc:1b.0: [8086:2b6c] type 00 class 0x060000
[    7.177352] pci_bus 0000:fc: busn_res: [bus fc-ff] end is updated to fc
[    7.177356] pci_bus 0000:fc: busn_res: can not insert [bus fc] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.177384] PCI: Discovered peer bus fd
[    7.181394] PCI: root bus fd: using default resources
[    7.181396] PCI: Probing PCI hardware (bus fd)
[    7.181470] ACPI: \: failed to evaluate _DSM (0x1001)
[    7.186694] PCI host bridge to bus 0000:fd
[    7.190963] pci_bus 0000:fd: root bus resource [io  0x0000-0xffff]
[    7.197309] pci_bus 0000:fd: root bus resource [mem 0x00000000-0xfffffffffff]
[    7.204607] pci_bus 0000:fd: No busn resource found for root bus, will use [bus fd-ff]
[    7.212814] pci_bus 0000:fd: busn_res: can not insert [bus fd-ff] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.212822] pci 0000:fd:00.0: [8086:2b00] type 00 class 0x060000
[    7.212925] pci 0000:fd:00.2: [8086:2b02] type 00 class 0x060000
[    7.213035] pci 0000:fd:00.4: [8086:2b22] type 00 class 0x060000
[    7.213130] pci 0000:fd:00.6: [8086:2b2a] type 00 class 0x060000
[    7.213229] pci 0000:fd:01.0: [8086:2b04] type 00 class 0x060000
[    7.213329] pci 0000:fd:02.0: [8086:2b08] type 00 class 0x060000
[    7.213428] pci 0000:fd:03.0: [8086:2b0c] type 00 class 0x060000
[    7.213532] pci 0000:fd:04.0: [8086:2b10] type 00 class 0x060000
[    7.213627] pci 0000:fd:05.0: [8086:2b14] type 00 class 0x060000
[    7.213726] pci 0000:fd:05.2: [8086:2b16] type 00 class 0x060000
[    7.213824] pci 0000:fd:05.4: [8086:2b13] type 00 class 0x060000
[    7.213917] pci 0000:fd:05.6: [8086:2b53] type 00 class 0x060000
[    7.214008] pci 0000:fd:06.0: [8086:2b18] type 00 class 0x060000
[    7.214112] pci 0000:fd:07.0: [8086:2b1c] type 00 class 0x060000
[    7.214211] pci 0000:fd:07.2: [8086:2b1e] type 00 class 0x060000
[    7.214306] pci 0000:fd:07.4: [8086:2b1b] type 00 class 0x060000
[    7.214400] pci 0000:fd:07.6: [8086:2b5b] type 00 class 0x060000
[    7.214500] pci 0000:fd:08.0: [8086:2b20] type 00 class 0x060000
[    7.214606] pci 0000:fd:09.0: [8086:2b24] type 00 class 0x060000
[    7.214705] pci 0000:fd:0a.0: [8086:2b28] type 00 class 0x060000
[    7.214805] pci 0000:fd:0b.0: [8086:2b2c] type 00 class 0x060000
[    7.214911] pci 0000:fd:0c.0: [8086:2b30] type 00 class 0x060000
[    7.215016] pci 0000:fd:0d.0: [8086:2b34] type 00 class 0x060000
[    7.215116] pci 0000:fd:0e.0: [8086:2b38] type 00 class 0x060000
[    7.215218] pci 0000:fd:0f.0: [8086:2b3c] type 00 class 0x060000
[    7.215323] pci 0000:fd:10.0: [8086:2b40] type 00 class 0x060000
[    7.215423] pci 0000:fd:10.2: [8086:2b42] type 00 class 0x060000
[    7.215517] pci 0000:fd:10.4: [8086:2b32] type 00 class 0x060000
[    7.215614] pci 0000:fd:10.6: [8086:2b3a] type 00 class 0x060000
[    7.215714] pci 0000:fd:11.0: [8086:2b44] type 00 class 0x060000
[    7.215816] pci 0000:fd:11.2: [8086:2b46] type 00 class 0x060000
[    7.215911] pci 0000:fd:11.4: [8086:2b36] type 00 class 0x060000
[    7.216009] pci 0000:fd:11.6: [8086:2b3e] type 00 class 0x060000
[    7.216110] pci 0000:fd:12.0: [8086:2b48] type 00 class 0x060000
[    7.216211] pci 0000:fd:13.0: [8086:2b4c] type 00 class 0x060000
[    7.216313] pci 0000:fd:14.0: [8086:2b50] type 00 class 0x060000
[    7.216410] pci 0000:fd:14.2: [8086:2b52] type 00 class 0x060000
[    7.216513] pci 0000:fd:15.0: [8086:2b54] type 00 class 0x060000
[    7.216609] pci 0000:fd:15.2: [8086:2b56] type 00 class 0x060000
[    7.216707] pci 0000:fd:16.0: [8086:2b58] type 00 class 0x060000
[    7.216806] pci 0000:fd:16.2: [8086:2b5a] type 00 class 0x060000
[    7.216911] pci 0000:fd:17.0: [8086:2b5c] type 00 class 0x060000
[    7.217022] pci 0000:fd:17.2: [8086:2b5e] type 00 class 0x060000
[    7.217123] pci 0000:fd:18.0: [8086:2b60] type 00 class 0x060000
[    7.217223] pci 0000:fd:18.2: [8086:2b62] type 00 class 0x060000
[    7.217326] pci 0000:fd:19.0: [8086:2b64] type 00 class 0x060000
[    7.217421] pci 0000:fd:19.2: [8086:2b66] type 00 class 0x060000
[    7.217519] pci 0000:fd:1a.0: [8086:2b68] type 00 class 0x060000
[    7.217626] pci 0000:fd:1b.0: [8086:2b6c] type 00 class 0x060000
[    7.217734] pci_bus 0000:fd: busn_res: [bus fd-ff] end is updated to fd
[    7.217737] pci_bus 0000:fd: busn_res: can not insert [bus fd] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.217765] PCI: Discovered peer bus fe
[    7.221776] PCI: root bus fe: using default resources
[    7.221777] PCI: Probing PCI hardware (bus fe)
[    7.221843] ACPI: \: failed to evaluate _DSM (0x1001)
[    7.227066] PCI host bridge to bus 0000:fe
[    7.231334] pci_bus 0000:fe: root bus resource [io  0x0000-0xffff]
[    7.237680] pci_bus 0000:fe: root bus resource [mem 0x00000000-0xfffffffffff]
[    7.244982] pci_bus 0000:fe: No busn resource found for root bus, will use [bus fe-ff]
[    7.253192] pci_bus 0000:fe: busn_res: can not insert [bus fe-ff] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.253200] pci 0000:fe:00.0: [8086:2b00] type 00 class 0x060000
[    7.253294] pci 0000:fe:00.2: [8086:2b02] type 00 class 0x060000
[    7.253385] pci 0000:fe:00.4: [8086:2b22] type 00 class 0x060000
[    7.253479] pci 0000:fe:00.6: [8086:2b2a] type 00 class 0x060000
[    7.253571] pci 0000:fe:01.0: [8086:2b04] type 00 class 0x060000
[    7.253661] pci 0000:fe:02.0: [8086:2b08] type 00 class 0x060000
[    7.253754] pci 0000:fe:03.0: [8086:2b0c] type 00 class 0x060000
[    7.253849] pci 0000:fe:04.0: [8086:2b10] type 00 class 0x060000
[    7.253942] pci 0000:fe:05.0: [8086:2b14] type 00 class 0x060000
[    7.254032] pci 0000:fe:05.2: [8086:2b16] type 00 class 0x060000
[    7.254126] pci 0000:fe:05.4: [8086:2b13] type 00 class 0x060000
[    7.254219] pci 0000:fe:05.6: [8086:2b53] type 00 class 0x060000
[    7.254308] pci 0000:fe:06.0: [8086:2b18] type 00 class 0x060000
[    7.254401] pci 0000:fe:07.0: [8086:2b1c] type 00 class 0x060000
[    7.254498] pci 0000:fe:07.2: [8086:2b1e] type 00 class 0x060000
[    7.254589] pci 0000:fe:07.4: [8086:2b1b] type 00 class 0x060000
[    7.254680] pci 0000:fe:07.6: [8086:2b5b] type 00 class 0x060000
[    7.254774] pci 0000:fe:08.0: [8086:2b20] type 00 class 0x060000
[    7.254874] pci 0000:fe:09.0: [8086:2b24] type 00 class 0x060000
[    7.254970] pci 0000:fe:0a.0: [8086:2b28] type 00 class 0x060000
[    7.255067] pci 0000:fe:0b.0: [8086:2b2c] type 00 class 0x060000
[    7.255165] pci 0000:fe:0c.0: [8086:2b30] type 00 class 0x060000
[    7.255262] pci 0000:fe:0d.0: [8086:2b34] type 00 class 0x060000
[    7.255363] pci 0000:fe:0e.0: [8086:2b38] type 00 class 0x060000
[    7.255458] pci 0000:fe:0f.0: [8086:2b3c] type 00 class 0x060000
[    7.255556] pci 0000:fe:10.0: [8086:2b40] type 00 class 0x060000
[    7.255648] pci 0000:fe:10.2: [8086:2b42] type 00 class 0x060000
[    7.255740] pci 0000:fe:10.4: [8086:2b32] type 00 class 0x060000
[    7.255832] pci 0000:fe:10.6: [8086:2b3a] type 00 class 0x060000
[    7.255927] pci 0000:fe:11.0: [8086:2b44] type 00 class 0x060000
[    7.256017] pci 0000:fe:11.2: [8086:2b46] type 00 class 0x060000
[    7.256113] pci 0000:fe:11.4: [8086:2b36] type 00 class 0x060000
[    7.256204] pci 0000:fe:11.6: [8086:2b3e] type 00 class 0x060000
[    7.256297] pci 0000:fe:12.0: [8086:2b48] type 00 class 0x060000
[    7.256394] pci 0000:fe:13.0: [8086:2b4c] type 00 class 0x060000
[    7.256494] pci 0000:fe:14.0: [8086:2b50] type 00 class 0x060000
[    7.256584] pci 0000:fe:14.2: [8086:2b52] type 00 class 0x060000
[    7.256682] pci 0000:fe:15.0: [8086:2b54] type 00 class 0x060000
[    7.256775] pci 0000:fe:15.2: [8086:2b56] type 00 class 0x060000
[    7.256873] pci 0000:fe:16.0: [8086:2b58] type 00 class 0x060000
[    7.256980] pci 0000:fe:16.2: [8086:2b5a] type 00 class 0x060000
[    7.257077] pci 0000:fe:17.0: [8086:2b5c] type 00 class 0x060000
[    7.257169] pci 0000:fe:17.2: [8086:2b5e] type 00 class 0x060000
[    7.257263] pci 0000:fe:18.0: [8086:2b60] type 00 class 0x060000
[    7.257359] pci 0000:fe:18.2: [8086:2b62] type 00 class 0x060000
[    7.257454] pci 0000:fe:19.0: [8086:2b64] type 00 class 0x060000
[    7.257547] pci 0000:fe:19.2: [8086:2b66] type 00 class 0x060000
[    7.257641] pci 0000:fe:1a.0: [8086:2b68] type 00 class 0x060000
[    7.257744] pci 0000:fe:1b.0: [8086:2b6c] type 00 class 0x060000
[    7.257846] pci_bus 0000:fe: busn_res: [bus fe-ff] end is updated to fe
[    7.257849] pci_bus 0000:fe: busn_res: can not insert [bus fe] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.257876] PCI: Discovered peer bus ff
[    7.261886] PCI: root bus ff: using default resources
[    7.261887] PCI: Probing PCI hardware (bus ff)
[    7.261953] ACPI: \: failed to evaluate _DSM (0x1001)
[    7.267175] PCI host bridge to bus 0000:ff
[    7.271441] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    7.277788] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffffffffff]
[    7.285089] pci_bus 0000:ff: No busn resource found for root bus, will use [bus ff-ff]
[    7.293297] pci_bus 0000:ff: busn_res: can not insert [bus ff] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.293305] pci 0000:ff:00.0: [8086:2b00] type 00 class 0x060000
[    7.293409] pci 0000:ff:00.2: [8086:2b02] type 00 class 0x060000
[    7.293510] pci 0000:ff:00.4: [8086:2b22] type 00 class 0x060000
[    7.293606] pci 0000:ff:00.6: [8086:2b2a] type 00 class 0x060000
[    7.293701] pci 0000:ff:01.0: [8086:2b04] type 00 class 0x060000
[    7.293796] pci 0000:ff:02.0: [8086:2b08] type 00 class 0x060000
[    7.293897] pci 0000:ff:03.0: [8086:2b0c] type 00 class 0x060000
[    7.293998] pci 0000:ff:04.0: [8086:2b10] type 00 class 0x060000
[    7.294098] pci 0000:ff:05.0: [8086:2b14] type 00 class 0x060000
[    7.294191] pci 0000:ff:05.2: [8086:2b16] type 00 class 0x060000
[    7.294290] pci 0000:ff:05.4: [8086:2b13] type 00 class 0x060000
[    7.294388] pci 0000:ff:05.6: [8086:2b53] type 00 class 0x060000
[    7.294488] pci 0000:ff:06.0: [8086:2b18] type 00 class 0x060000
[    7.294588] pci 0000:ff:07.0: [8086:2b1c] type 00 class 0x060000
[    7.294687] pci 0000:ff:07.2: [8086:2b1e] type 00 class 0x060000
[    7.294786] pci 0000:ff:07.4: [8086:2b1b] type 00 class 0x060000
[    7.294884] pci 0000:ff:07.6: [8086:2b5b] type 00 class 0x060000
[    7.294983] pci 0000:ff:08.0: [8086:2b20] type 00 class 0x060000
[    7.295087] pci 0000:ff:09.0: [8086:2b24] type 00 class 0x060000
[    7.295191] pci 0000:ff:0a.0: [8086:2b28] type 00 class 0x060000
[    7.295293] pci 0000:ff:0b.0: [8086:2b2c] type 00 class 0x060000
[    7.295395] pci 0000:ff:0c.0: [8086:2b30] type 00 class 0x060000
[    7.295498] pci 0000:ff:0d.0: [8086:2b34] type 00 class 0x060000
[    7.295603] pci 0000:ff:0e.0: [8086:2b38] type 00 class 0x060000
[    7.295705] pci 0000:ff:0f.0: [8086:2b3c] type 00 class 0x060000
[    7.295807] pci 0000:ff:10.0: [8086:2b40] type 00 class 0x060000
[    7.295905] pci 0000:ff:10.2: [8086:2b42] type 00 class 0x060000
[    7.296004] pci 0000:ff:10.4: [8086:2b32] type 00 class 0x060000
[    7.296100] pci 0000:ff:10.6: [8086:2b3a] type 00 class 0x060000
[    7.296195] pci 0000:ff:11.0: [8086:2b44] type 00 class 0x060000
[    7.296293] pci 0000:ff:11.2: [8086:2b46] type 00 class 0x060000
[    7.296391] pci 0000:ff:11.4: [8086:2b36] type 00 class 0x060000
[    7.296487] pci 0000:ff:11.6: [8086:2b3e] type 00 class 0x060000
[    7.296584] pci 0000:ff:12.0: [8086:2b48] type 00 class 0x060000
[    7.296687] pci 0000:ff:13.0: [8086:2b4c] type 00 class 0x060000
[    7.296791] pci 0000:ff:14.0: [8086:2b50] type 00 class 0x060000
[    7.296883] pci 0000:ff:14.2: [8086:2b52] type 00 class 0x060000
[    7.296995] pci 0000:ff:15.0: [8086:2b54] type 00 class 0x060000
[    7.297092] pci 0000:ff:15.2: [8086:2b56] type 00 class 0x060000
[    7.297193] pci 0000:ff:16.0: [8086:2b58] type 00 class 0x060000
[    7.297287] pci 0000:ff:16.2: [8086:2b5a] type 00 class 0x060000
[    7.297387] pci 0000:ff:17.0: [8086:2b5c] type 00 class 0x060000
[    7.297486] pci 0000:ff:17.2: [8086:2b5e] type 00 class 0x060000
[    7.297587] pci 0000:ff:18.0: [8086:2b60] type 00 class 0x060000
[    7.297681] pci 0000:ff:18.2: [8086:2b62] type 00 class 0x060000
[    7.297782] pci 0000:ff:19.0: [8086:2b64] type 00 class 0x060000
[    7.297882] pci 0000:ff:19.2: [8086:2b66] type 00 class 0x060000
[    7.297983] pci 0000:ff:1a.0: [8086:2b68] type 00 class 0x060000
[    7.298085] pci 0000:ff:1b.0: [8086:2b6c] type 00 class 0x060000
[    7.298186] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    7.298190] pci_bus 0000:ff: busn_res: can not insert [bus ff] under domain [bus 00-ff] (conflicts with (null) [bus 80-ff])
[    7.298217] PCI: pci_cache_line_size set to 64 bytes
[    7.298603] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    7.298606] e820: reserve RAM buffer [mem 0x79a95000-0x7bffffff]
[    7.298609] e820: reserve RAM buffer [mem 0x79b79000-0x7bffffff]
[    7.298611] e820: reserve RAM buffer [mem 0x7a000000-0x7bffffff]
[    7.298889] NetLabel: Initializing
[    7.302466] NetLabel:  domain hash size = 128
[    7.306991] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    7.312850] NetLabel:  unlabeled traffic allowed by default
[    7.318849] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    7.324163] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    7.332438] clocksource: Switched to clocksource hpet
[    7.367320] VFS: Disk quotas dquot_6.6.0
[    7.371612] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    7.378935] AppArmor: AppArmor Filesystem Enabled
[    7.383902] pnp: PnP ACPI init
[    7.387482] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    7.394271] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    7.401056] system 00:00: [mem 0xfe000000-0xfe9fffff] has been reserved
[    7.407841] system 00:00: [mem 0xfea00000-0xfea0001f] has been reserved
[    7.414624] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[    7.421411] system 00:00: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    7.428554] system 00:00: [mem 0xfed45000-0xfedfffff] has been reserved
[    7.435345] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    7.435785] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    7.436048] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    7.442147] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    7.442783] system 00:03: [io  0x0400-0x047f] has been reserved
[    7.448881] system 00:03: [io  0x1180-0x119f] has been reserved
[    7.454974] system 00:03: [io  0x0500-0x057f] has been reserved
[    7.461066] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    7.467850] system 00:03: [mem 0xfec00000-0xfecfffff] could not be reserved
[    7.474982] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
[    7.481772] system 00:03: Plug and Play ACPI device, IDs PNP0c01 (active)
[    7.482125] system 00:04: Plug and Play ACPI device, IDs PNP0c01 (active)
[    7.482649] pnp: PnP ACPI: found 5 devices
[    7.495128] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    7.504310] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    7.504388] pci 0000:00:1c.0: BAR 15: assigned [mem 0x7c000000-0x7c1fffff 64bit pref]
[    7.512518] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    7.518871] pci 0000:00:01.0: PCI bridge to [bus 01-02]
[    7.524270] pci 0000:00:01.0:   bridge window [io  0x8000-0x8fff]
[    7.530537] pci 0000:00:01.0:   bridge window [mem 0xce000000-0xceffffff]
[    7.537497] pci 0000:00:01.0:   bridge window [mem 0xc7000000-0xc7ffffff 64bit pref]
[    7.545539] pci 0000:00:03.0: PCI bridge to [bus 03-04]
[    7.550937] pci 0000:00:03.0:   bridge window [io  0x7000-0x7fff]
[    7.557202] pci 0000:00:03.0:   bridge window [mem 0xcd000000-0xcdffffff]
[    7.564161] pci 0000:00:03.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
[    7.572203] pci 0000:00:05.0: PCI bridge to [bus 05]
[    7.577341] pci 0000:00:05.0:   bridge window [io  0x6000-0x6fff]
[    7.583609] pci 0000:00:05.0:   bridge window [mem 0xcf100000-0xcf1fffff]
[    7.590573] pci 0000:00:07.0: PCI bridge to [bus 06-07]
[    7.595970] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    7.602236] pci 0000:00:07.0:   bridge window [mem 0xcc000000-0xccffffff]
[    7.609195] pci 0000:00:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    7.617237] pci 0000:00:09.0: PCI bridge to [bus 08-09]
[    7.622635] pci 0000:00:09.0:   bridge window [io  0x4000-0x4fff]
[    7.628901] pci 0000:00:09.0:   bridge window [mem 0xcb000000-0xcbffffff]
[    7.635859] pci 0000:00:09.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    7.643902] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    7.649040] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    7.655305] pci 0000:00:1c.0:   bridge window [mem 0xca000000-0xcaffffff]
[    7.662263] pci 0000:00:1c.0:   bridge window [mem 0x7c000000-0x7c1fffff 64bit pref]
[    7.670307] pci 0000:00:1c.4: PCI bridge to [bus 0b]
[    7.675444] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    7.681710] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcf0fffff]
[    7.688668] pci 0000:00:1c.4:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    7.696716] pci 0000:00:1e.0: PCI bridge to [bus 0c]
[    7.701862] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    7.701865] pci_bus 0000:00: resource 5 [io  0x0d00-0x9fff window]
[    7.701867] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    7.701869] pci_bus 0000:00: resource 7 [mem 0x000c8000-0x000dffff window]
[    7.701871] pci_bus 0000:00: resource 8 [mem 0x7c000000-0xcfffffff window]
[    7.701874] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    7.701876] pci_bus 0000:01: resource 1 [mem 0xce000000-0xceffffff]
[    7.701878] pci_bus 0000:01: resource 2 [mem 0xc7000000-0xc7ffffff 64bit pref]
[    7.701880] pci_bus 0000:03: resource 0 [io  0x7000-0x7fff]
[    7.701882] pci_bus 0000:03: resource 1 [mem 0xcd000000-0xcdffffff]
[    7.701884] pci_bus 0000:03: resource 2 [mem 0xc6000000-0xc6ffffff 64bit pref]
[    7.701886] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    7.701888] pci_bus 0000:05: resource 1 [mem 0xcf100000-0xcf1fffff]
[    7.701890] pci_bus 0000:06: resource 0 [io  0x5000-0x5fff]
[    7.701892] pci_bus 0000:06: resource 1 [mem 0xcc000000-0xccffffff]
[    7.701893] pci_bus 0000:06: resource 2 [mem 0xc5000000-0xc5ffffff 64bit pref]
[    7.701895] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    7.701897] pci_bus 0000:08: resource 1 [mem 0xcb000000-0xcbffffff]
[    7.701899] pci_bus 0000:08: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    7.701901] pci_bus 0000:0a: resource 0 [io  0x2000-0x2fff]
[    7.701903] pci_bus 0000:0a: resource 1 [mem 0xca000000-0xcaffffff]
[    7.701904] pci_bus 0000:0a: resource 2 [mem 0x7c000000-0x7c1fffff 64bit pref]
[    7.701907] pci_bus 0000:0b: resource 0 [io  0x3000-0x3fff]
[    7.701908] pci_bus 0000:0b: resource 1 [mem 0xcf000000-0xcf0fffff]
[    7.701910] pci_bus 0000:0b: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    7.701913] pci_bus 0000:0c: resource 4 [io  0x0000-0x0cf7 window]
[    7.701916] pci_bus 0000:0c: resource 5 [io  0x0d00-0x9fff window]
[    7.701918] pci_bus 0000:0c: resource 6 [mem 0x000a0000-0x000bffff window]
[    7.701920] pci_bus 0000:0c: resource 7 [mem 0x000c8000-0x000dffff window]
[    7.701922] pci_bus 0000:0c: resource 8 [mem 0x7c000000-0xcfffffff window]
[    7.702078] pci_bus 0000:80: max bus depth: 1 pci_try_num: 2
[    7.702124] pci 0000:80:00.0: PCI bridge to [bus 81]
[    7.707271] pci 0000:80:01.0: PCI bridge to [bus 82-83]
[    7.712671] pci 0000:80:01.0:   bridge window [io  0xf000-0xffff]
[    7.718938] pci 0000:80:01.0:   bridge window [mem 0xfa000000-0xfaffffff]
[    7.725898] pci 0000:80:01.0:   bridge window [mem 0xf6000000-0xf6ffffff 64bit pref]
[    7.733941] pci 0000:80:03.0: PCI bridge to [bus 84-85]
[    7.739341] pci 0000:80:03.0:   bridge window [io  0xe000-0xefff]
[    7.745606] pci 0000:80:03.0:   bridge window [mem 0xf9000000-0xf9ffffff]
[    7.752569] pci 0000:80:03.0:   bridge window [mem 0xf5000000-0xf5ffffff 64bit pref]
[    7.760612] pci 0000:80:05.0: PCI bridge to [bus 86]
[    7.765750] pci 0000:80:05.0:   bridge window [io  0xd000-0xdfff]
[    7.772014] pci 0000:80:05.0:   bridge window [mem 0xfb000000-0xfb2fffff]
[    7.778979] pci 0000:80:07.0: PCI bridge to [bus 87-88]
[    7.784379] pci 0000:80:07.0:   bridge window [io  0xc000-0xcfff]
[    7.790646] pci 0000:80:07.0:   bridge window [mem 0xf8000000-0xf8ffffff]
[    7.797606] pci 0000:80:07.0:   bridge window [mem 0xf4000000-0xf4ffffff 64bit pref]
[    7.805648] pci 0000:80:09.0: PCI bridge to [bus 89-8a]
[    7.814175] pci 0000:80:09.0:   bridge window [io  0xb000-0xbfff]
[    7.820445] pci 0000:80:09.0:   bridge window [mem 0xf7000000-0xf7ffffff]
[    7.827402] pci 0000:80:09.0:   bridge window [mem 0xf3000000-0xf3ffffff 64bit pref]
[    7.835444] pci_bus 0000:80: resource 4 [io  0xa000-0xffff window]
[    7.835446] pci_bus 0000:80: resource 5 [mem 0xd0000000-0xfbffffff window]
[    7.835449] pci_bus 0000:82: resource 0 [io  0xf000-0xffff]
[    7.835451] pci_bus 0000:82: resource 1 [mem 0xfa000000-0xfaffffff]
[    7.835453] pci_bus 0000:82: resource 2 [mem 0xf6000000-0xf6ffffff 64bit pref]
[    7.835455] pci_bus 0000:84: resource 0 [io  0xe000-0xefff]
[    7.835457] pci_bus 0000:84: resource 1 [mem 0xf9000000-0xf9ffffff]
[    7.835460] pci_bus 0000:84: resource 2 [mem 0xf5000000-0xf5ffffff 64bit pref]
[    7.835462] pci_bus 0000:86: resource 0 [io  0xd000-0xdfff]
[    7.835464] pci_bus 0000:86: resource 1 [mem 0xfb000000-0xfb2fffff]
[    7.835466] pci_bus 0000:87: resource 0 [io  0xc000-0xcfff]
[    7.835469] pci_bus 0000:87: resource 1 [mem 0xf8000000-0xf8ffffff]
[    7.835470] pci_bus 0000:87: resource 2 [mem 0xf4000000-0xf4ffffff 64bit pref]
[    7.835473] pci_bus 0000:89: resource 0 [io  0xb000-0xbfff]
[    7.835475] pci_bus 0000:89: resource 1 [mem 0xf7000000-0xf7ffffff]
[    7.835477] pci_bus 0000:89: resource 2 [mem 0xf3000000-0xf3ffffff 64bit pref]
[    7.835550] pci_bus 0000:fc: max bus depth: 0 pci_try_num: 1
[    7.835558] pci_bus 0000:fc: resource 4 [io  0x0000-0xffff]
[    7.835560] pci_bus 0000:fc: resource 5 [mem 0x00000000-0xfffffffffff]
[    7.835562] pci_bus 0000:fd: max bus depth: 0 pci_try_num: 1
[    7.835569] pci_bus 0000:fd: resource 4 [io  0x0000-0xffff]
[    7.835571] pci_bus 0000:fd: resource 5 [mem 0x00000000-0xfffffffffff]
[    7.835574] pci_bus 0000:fe: max bus depth: 0 pci_try_num: 1
[    7.835582] pci_bus 0000:fe: resource 4 [io  0x0000-0xffff]
[    7.835583] pci_bus 0000:fe: resource 5 [mem 0x00000000-0xfffffffffff]
[    7.835586] pci_bus 0000:ff: max bus depth: 0 pci_try_num: 1
[    7.835594] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    7.835595] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffffff]
[    7.835985] NET: Registered protocol family 2
[    7.841761] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    7.851058] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    7.858282] TCP: Hash tables configured (established 524288 bind 65536)
[    7.865242] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    7.872137] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    7.879717] NET: Registered protocol family 1
[    7.948765] pci 0000:05:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    7.959604] pci 0000:0b:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    7.968786] PCI: CLS 64 bytes, default 64
[    7.968935] Unpacking initramfs...
[    8.381767] Freeing initrd memory: 16612K
[    8.386024] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    8.392640] software IO TLB [mem 0x75a95000-0x79a95000] (64MB) mapped at [ffff880075a95000-ffff880079a94fff]
[    8.411620] Scanning for low memory corruption every 60 seconds
[    8.420445] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    8.427420] ====[ backtrace testing ]===========
[    8.432229] Testing a backtrace from process context.
[    8.437468] The following trace is a kernel self test and not a bug!
[    8.444011] CPU: 18 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc4-mainline+ #2
[    8.451551] Hardware name: HUAWEI TECHNOLOGIES CO.,LTD. Tecal RH5885 V2/CH91RGPUC, BIOS RGPUC-BIOS-V036 10/26/2013
[    8.462210] Call Trace:
[    8.464860]  dump_stack+0x85/0xc0
[    8.468368]  ? backtrace_test_irq_callback+0x20/0x20
[    8.473514]  backtrace_regression_test+0x3c/0x100
[    8.478407]  ? proc_create_data+0x76/0xc0
[    8.482611]  ? trace_event_define_fields_module_request+0x8b/0x8b
[    8.488888]  do_one_initcall+0x53/0x1b0
[    8.492911]  kernel_init_freeable+0x1e2/0x26f
[    8.497458]  ? rest_init+0x90/0x90
[    8.501043]  kernel_init+0xe/0x110
[    8.504634]  ret_from_fork+0x31/0x40
[    8.508418] Testing a backtrace from irq context.
[    8.513314] The following trace is a kernel self test and not a bug!
[    8.519862] CPU: 18 PID: 122 Comm: ksoftirqd/18 Not tainted 4.10.0-rc4-mainline+ #2
[    8.527833] Hardware name: HUAWEI TECHNOLOGIES CO.,LTD. Tecal RH5885 V2/CH91RGPUC, BIOS RGPUC-BIOS-V036 10/26/2013
[    8.538492] Call Trace:
[    8.541127]  dump_stack+0x85/0xc0
[    8.544626]  backtrace_test_irq_callback+0xe/0x20
[    8.549518]  tasklet_action+0x170/0x180
[    8.553541]  __do_softirq+0x12b/0x35f
[    8.557387]  run_ksoftirqd+0x33/0x50
[    8.561154]  smpboot_thread_fn+0x1a0/0x270
[    8.565435]  kthread+0x114/0x150
[    8.568847]  ? sort_range+0x30/0x30
[    8.572521]  ? kthread_create_on_node+0x40/0x40
[    8.577234]  ret_from_fork+0x31/0x40
[    8.581009] Testing a saved backtrace.
[    8.584952] The following trace is a kernel self test and not a bug!
[    8.591495] 
[    8.591500] [<ffffffff8102d2ab>] save_stack_trace+0x1b/0x20
[    8.599033] 
[    8.599036] [<ffffffff810ff4c1>] backtrace_regression_test+0xe1/0x100
[    8.607432] 
[    8.607434] [<ffffffff81000463>] do_one_initcall+0x53/0x1b0
[    8.614963] 
[    8.614965] [<ffffffff822641b8>] kernel_init_freeable+0x1e2/0x26f
[    8.623017] 
[    8.623020] [<ffffffff8171afae>] kernel_init+0xe/0x110
[    8.630114] 
[    8.630117] [<ffffffff81728d01>] ret_from_fork+0x31/0x40
[    8.637379] 
[    8.637382] [<ffffffffffffffff>] 0xffffffffffffffff
[    8.644214] ====[ end of backtrace testing ]====
[    8.649119] audit: initializing netlink subsys (disabled)
[    8.654849] audit: type=2000 audit(1489134555.992:1): initialized
[    8.655121] Kprobe smoke test: started
[    8.868471] Kprobe smoke test: passed successfully
[    8.875153] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    8.884571] SGI XFS with ACLs, security attributes, realtime, debug enabled
[    8.901196] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    8.909099] io scheduler noop registered
[    8.913220] io scheduler deadline registered
[    8.917692] io scheduler cfq registered (default)
[    8.923369] rbtree testing
[    9.428394] tsc: Refined TSC clocksource calibration: 1866.732 MHz
[    9.437710] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x35d0d1b66a8, max_idle_ns: 881590563120 ns
[    9.967530]  -> 19491 cycles
[   10.043363] augmented rbtree testing
[   10.448661] clocksource: Switched to clocksource tsc
[   11.449728]  -> 26253 cycles
[   11.552927] pcieport 0000:00:01.0: AER enabled with IRQ 25
[   11.558653] pcieport 0000:00:03.0: AER enabled with IRQ 27
[   11.564374] pcieport 0000:00:05.0: AER enabled with IRQ 29
[   11.570092] pcieport 0000:00:07.0: AER enabled with IRQ 31
[   11.575808] pcieport 0000:00:09.0: AER enabled with IRQ 33
[   11.581526] pcieport 0000:80:00.0: AER enabled with IRQ 37
[   11.587243] pcieport 0000:80:01.0: AER enabled with IRQ 39
[   11.592958] pcieport 0000:80:03.0: AER enabled with IRQ 41
[   11.598674] pcieport 0000:80:05.0: AER enabled with IRQ 43
[   11.604390] pcieport 0000:80:07.0: AER enabled with IRQ 45
[   11.610106] pcieport 0000:80:09.0: AER enabled with IRQ 47
[   11.615809] pcieport 0000:00:01.0: Signaling PME with IRQ 25
[   11.621674] pcieport 0000:00:03.0: Signaling PME with IRQ 27
[   11.627537] pcieport 0000:00:05.0: Signaling PME with IRQ 29
[   11.633402] pcieport 0000:00:07.0: Signaling PME with IRQ 31
[   11.639267] pcieport 0000:00:09.0: Signaling PME with IRQ 33
[   11.645151] pcieport 0000:00:1c.0: Signaling PME with IRQ 34
[   11.651035] pcieport 0000:00:1c.4: Signaling PME with IRQ 35
[   11.656900] pcieport 0000:80:00.0: Signaling PME with IRQ 37
[   11.662762] pcieport 0000:80:01.0: Signaling PME with IRQ 39
[   11.668626] pcieport 0000:80:03.0: Signaling PME with IRQ 41
[   11.674489] pcieport 0000:80:05.0: Signaling PME with IRQ 43
[   11.680353] pcieport 0000:80:07.0: Signaling PME with IRQ 45
[   11.686216] pcieport 0000:80:09.0: Signaling PME with IRQ 47
[   11.692091] pciehp 0000:00:01.0:pcie004: Slot #1 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.704903] pciehp 0000:00:03.0:pcie004: Slot #2 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.717706] pciehp 0000:00:07.0:pcie004: Slot #3 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.730511] pciehp 0000:00:09.0:pcie004: Slot #4 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.743314] pciehp 0000:00:1c.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[   11.756118] pciehp 0000:00:1c.4:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[   11.768923] pciehp 0000:80:01.0:pcie004: Slot #5 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.781727] pciehp 0000:80:03.0:pcie004: Slot #6 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.794528] pciehp 0000:80:07.0:pcie004: Slot #7 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.807327] pciehp 0000:80:09.0:pcie004: Slot #8 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   11.820249] intel_idle: MWAIT substates: 0x1120
[   11.820251] intel_idle: v0.4.1 model 0x2F
[   11.825581] intel_idle: lapic_timer_reliable_states 0xffffffff
[   11.841790] ERST: Error Record Serialization Table (ERST) support is initialized.
[   11.849604] pstore: using zlib compression
[   11.853896] pstore: Registered erst as persistent store backend
[   11.860170] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[   11.866775] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[   11.893830] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   11.904903] Non-volatile memory driver v1.3
[   11.909390] Linux agpgart interface v0.103
[   11.929400] lkdtm: No crash points registered, enable through debugfs
[   11.936135] libphy: Fixed MDIO Bus: probed
[   11.940474] i8042: PNP: No PS/2 controller found.
[   11.945568] mousedev: PS/2 mouse device common for all mice
[   11.951625] Key type dns_resolver registered
[   11.969412] microcode: sig=0x206f2, pf=0x4, revision=0x36
[   11.978575] microcode: Microcode Update Driver: v2.2.
[   11.978886] registered taskstats version 1
[   11.992506] Key type encrypted registered
[   11.996717] AppArmor: AppArmor sha1 policy hashing enabled
[   12.004464] BERT: Can't request iomem region <0000000079bbcd18-0000000079bbcd2b>.
[   12.012284]   Magic number: 9:504:472
[   12.016468] acpi LNXSYSTM:00: hash matches
[   12.020912] PM: Hibernation image not present or could not be loaded.
[   12.031488] Freeing unused kernel memory: 2288K
[   12.036210] Write protecting the kernel read-only data: 12288k
[   12.052884] Freeing unused kernel memory: 828K
[   12.065263] Freeing unused kernel memory: 844K
[   12.180121] SCSI subsystem initialized
[   12.209593] megasas: 06.812.07.00-rc1
[   12.215118] megaraid_sas 0000:05:00.0: FW now in Ready state
[   12.221390] megaraid_sas 0000:05:00.0: firmware supports msix    : (16)
[   12.227918] megaraid_sas 0000:05:00.0: current msix/online cpus    : (16/48)
[   12.234873] megaraid_sas 0000:05:00.0: RDPQ mode    : (disabled)
[   12.240795] megaraid_sas 0000:05:00.0: Current firmware maximum commands: 1008     LDIO threshold: 0
[   12.251517] megaraid_sas 0000:05:00.0: FW supports sync cache    : No
[   12.284528] megaraid_sas 0000:05:00.0: Init cmd success
[   12.316506] megaraid_sas 0000:05:00.0: firmware type    : Legacy(64 VD) firmware
[   12.323817] megaraid_sas 0000:05:00.0: controller type    : MR(1024MB)
[   12.330252] megaraid_sas 0000:05:00.0: Online Controller Reset(OCR)    : Enabled
[   12.337551] megaraid_sas 0000:05:00.0: Secure JBOD support    : No
[   12.372850] megaraid_sas 0000:05:00.0: INIT adapter done
[   12.378337] megaraid_sas 0000:05:00.0: Jbod map is not supported megasas_setup_jbod_map 4947
[   12.389008] megaraid_sas 0000:05:00.0: pci id        : (0x1000)/(0x005b)/(0x1000)/(0x9270)
[   12.397054] megaraid_sas 0000:05:00.0: unevenspan support    : no
[   12.403054] megaraid_sas 0000:05:00.0: firmware crash dump    : no
[   12.409141] megaraid_sas 0000:05:00.0: jbod sync map        : no
[   12.414798] scsi host0: Avago SAS based MegaRAID driver
[   12.664933] scsi 0:2:0:0: Direct-Access     LSI      MR9270-8i        3.23 PQ: 0 ANSI: 5
[   13.087962] libata version 3.00 loaded.
[   13.138181] ahci 0000:00:1f.2: version 3.0
[   13.138671] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[   13.147186] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ccc ems sxs
[   13.218108] scsi host1: ahci
[   13.221901] scsi host2: ahci
[   13.225789] scsi host3: ahci
[   13.229549] scsi host4: ahci
[   13.233317] scsi host5: ahci
[   13.237152] scsi host6: ahci
[   13.240323] ata1: SATA max UDMA/133 abar m2048@0xcf221000 port 0xcf221100 irq 64
[   13.248043] ata2: SATA max UDMA/133 abar m2048@0xcf221000 port 0xcf221180 irq 64
[   13.255760] ata3: SATA max UDMA/133 abar m2048@0xcf221000 port 0xcf221200 irq 64
[   13.263479] ata4: SATA max UDMA/133 abar m2048@0xcf221000 port 0xcf221280 irq 64
[   13.271196] ata5: SATA max UDMA/133 abar m2048@0xcf221000 port 0xcf221300 irq 64
[   13.278914] ata6: SATA max UDMA/133 abar m2048@0xcf221000 port 0xcf221380 irq 64
[   13.604966] ata2: SATA link down (SStatus 0 SControl 300)
[   13.610571] ata3: SATA link down (SStatus 0 SControl 300)
[   13.616188] ata1: SATA link down (SStatus 0 SControl 300)
[   13.621784] ata6: SATA link down (SStatus 0 SControl 300)
[   13.627379] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   13.633773] ata4: SATA link down (SStatus 0 SControl 300)
[   13.639369] ata5.00: ATAPI: TSSTcorp CDDVDW SN-208DB, CH00, max UDMA/100
[   13.656071] ata5.00: configured for UDMA/100
[   13.671096] scsi 5:0:0:0: CD-ROM            TSSTcorp CDDVDW SN-208DB  CH00 PQ: 0 ANSI: 5
[   13.756069] Fusion MPT base driver 3.04.20
[   13.760344] Copyright (c) 1999-2008 LSI Corporation
[   13.809979] Fusion MPT SAS Host driver 3.04.20
[   13.978928] Uniform Multi-Platform E-IDE driver
[   14.086394] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   14.106588] udev: starting version 147
[   14.162382] sd 0:2:0:0: [sda] 3509059584 512-byte logical blocks: (1.80 TB/1.63 TiB)
[   14.170456] sd 0:2:0:0: [sda] 4096-byte physical blocks
[   14.175982] sd 0:2:0:0: [sda] Write Protect is off
[   14.180972] sd 0:2:0:0: [sda] Mode Sense: 1f 00 00 08
[   14.181213] sd 0:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   14.191024] random: fast init done
[   14.195430]  sda: sda1 sda2
[   14.199474] sd 0:2:0:0: [sda] Attached SCSI disk
[   14.211971] ACPI: bus type USB registered
[   14.216259] usbcore: registered new interface driver usbfs
[   14.221979] usbcore: registered new interface driver hub
[   14.227637] usbcore: registered new device driver usb
[   14.272983] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   14.310703] uhci_hcd: USB Universal Host Controller Interface driver
[   14.317813] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   14.323225] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   14.330938] uhci_hcd 0000:00:1a.0: detected 2 ports
[   14.336035] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000090e0
[   14.342048] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   14.349010] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.356528] usb usb1: Product: UHCI Host Controller
[   14.361580] usb usb1: Manufacturer: Linux 4.10.0-rc4-mainline+ uhci_hcd
[   14.368367] usb usb1: SerialNumber: 0000:00:1a.0
[   14.373726] hub 1-0:1.0: USB hub found
[   14.377693] hub 1-0:1.0: 2 ports detected
[   14.382638] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   14.388064] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
[   14.395793] uhci_hcd 0000:00:1a.1: detected 2 ports
[   14.400903] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000090c0
[   14.406926] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[   14.413904] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.421451] usb usb2: Product: UHCI Host Controller
[   14.426521] usb usb2: Manufacturer: Linux 4.10.0-rc4-mainline+ uhci_hcd
[   14.433322] usb usb2: SerialNumber: 0000:00:1a.1
[   14.438582] hub 2-0:1.0: USB hub found
[   14.442540] hub 2-0:1.0: 2 ports detected
[   14.447204] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[   14.452649] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 3
[   14.460377] uhci_hcd 0000:00:1a.2: detected 2 ports
[   14.465482] uhci_hcd 0000:00:1a.2: irq 18, io base 0x000090a0
[   14.471488] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[   14.478468] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.486080] usb usb3: Product: UHCI Host Controller
[   14.491150] usb usb3: Manufacturer: Linux 4.10.0-rc4-mainline+ uhci_hcd
[   14.497952] usb usb3: SerialNumber: 0000:00:1a.2
[   14.503169] hub 3-0:1.0: USB hub found
[   14.507123] hub 3-0:1.0: 2 ports detected
[   14.511775] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   14.517198] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[   14.524929] uhci_hcd 0000:00:1d.0: detected 2 ports
[   14.530029] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00009080
[   14.536033] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[   14.543009] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.550612] usb usb4: Product: UHCI Host Controller
[   14.555680] usb usb4: Manufacturer: Linux 4.10.0-rc4-mainline+ uhci_hcd
[   14.562482] usb usb4: SerialNumber: 0000:00:1d.0
[   14.567693] hub 4-0:1.0: USB hub found
[   14.571650] hub 4-0:1.0: 2 ports detected
[   14.576291] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   14.581715] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
[   14.589446] uhci_hcd 0000:00:1d.1: detected 2 ports
[   14.594544] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00009060
[   14.600550] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[   14.607524] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.615127] usb usb5: Product: UHCI Host Controller
[   14.620198] usb usb5: Manufacturer: Linux 4.10.0-rc4-mainline+ uhci_hcd
[   14.627000] usb usb5: SerialNumber: 0000:00:1d.1
[   14.632214] hub 5-0:1.0: USB hub found
[   14.636168] hub 5-0:1.0: 2 ports detected
[   14.640804] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   14.646228] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
[   14.653959] uhci_hcd 0000:00:1d.2: detected 2 ports
[   14.659046] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009040
[   14.665053] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[   14.672030] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.679630] usb usb6: Product: UHCI Host Controller
[   14.684702] usb usb6: Manufacturer: Linux 4.10.0-rc4-mainline+ uhci_hcd
[   14.691502] usb usb6: SerialNumber: 0000:00:1d.2
[   14.696698] hub 6-0:1.0: USB hub found
[   14.700681] hub 6-0:1.0: 2 ports detected
[   14.781665] xgifb: module is from the staging directory, the quality is unknown, you have been warned.
[   14.809751] xgifb 0000:0b:00.0: Relocate IO address: 3000 [00003030]
[   14.816295] xgifb 0000:0b:00.0: chipid = 32
[   14.820659] xgifb: SR14=51 DramSzie 2000000 ChannelNum 1
[   14.826293] xgifb 0000:0b:00.0: Framebuffer at 0xc0000000, mapped to 0xffffc9000a000000, size 32768k
[   14.835721] xgifb 0000:0b:00.0: MMIO at 0xcf000000, mapped to 0xffffc90007ec0000, size 256k
[   14.884540] xgifb 0000:0b:00.0: No or unknown bridge type detected
[   14.890887] xgifb: Default mode is 800x600x16 (60Hz)
[   14.896499] fbcon: XGI (fb0) is primary device
[   14.905823] Console: switching to colour frame buffer device 100x37
[   15.040456] usb 6-1: new full-speed USB device number 2 using uhci_hcd
[   15.134703] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
[   15.211686] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   15.288447] EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr
[   19.870850] random: crng init done
[   20.036013] udev: starting version 147
[   20.268808] rtc_cmos 00:01: RTC can wake from S4
[   20.276165] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[   20.284703] rtc_cmos 00:01: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[   20.486572] input: PC Speaker as /devices/platform/pcspkr/input/input0
[   20.544184] ipmi message handler version 39.2
[   20.701044] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[   20.712329] ACPI: Sleep Button [SLPB]
[   20.718959] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[   20.730622] ACPI: Power Button [PWRB]
[   20.737470] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   20.748367] ACPI: Power Button [PWRF]
[   20.776696] sd 0:2:0:0: Attached scsi generic sg0 type 0
[   20.785655] scsi 5:0:0:0: Attached scsi generic sg1 type 5
[   20.830805] IPMI System Interface driver.
[   20.838471] ipmi_si: probing via SMBIOS
[   20.845814] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[   20.852005] sr 5:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   20.852008] cdrom: Uniform CD-ROM driver Revision: 3.20
[   20.852325] sr 5:0:0:0: Attached scsi CD-ROM sr0
[   20.876541] ipmi_si: Adding SMBIOS-specified bt state machine
[   20.886019] ipmi_si: probing via SPMI
[   20.893354] ipmi_si: SPMI: io 0xe4 regsize 1 spacing 1 irq 0
[   20.902631] ipmi_si: SPMI-specified kcs state machine: duplicate
[   20.912216] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x20, irq 0
[   21.000254] IPMI BT: using default values
[   21.007858] IPMI BT: req2rsp=5 secs retries=2
[   21.037174] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   21.060255] EDAC MC: Ver: 3.0.0
[   21.071955] iTCO_vendor_support: vendor-support=0
[   21.071991] ehci-pci: EHCI PCI platform driver
[   21.109627] pps_core: LinuxPPS API ver. 1 registered
[   21.117838] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   21.160306] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   21.160630] ehci-pci 0000:00:1a.7: EHCI Host Controller
[   21.160642] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 7
[   21.160661] ehci-pci 0000:00:1a.7: debug port 1
[   21.164602] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[   21.164616] ehci-pci 0000:00:1a.7: irq 18, io mem 0xcf223000
[   21.180218] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[   21.180354] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
[   21.180357] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.180360] usb usb7: Product: EHCI Host Controller
[   21.180362] usb usb7: Manufacturer: Linux 4.10.0-rc4-mainline+ ehci_hcd
[   21.180364] usb usb7: SerialNumber: 0000:00:1a.7
[   21.180790] hub 7-0:1.0: USB hub found
[   21.180804] hub 7-0:1.0: 6 ports detected
[   21.208372] hub 1-0:1.0: USB hub found
[   21.208394] hub 1-0:1.0: 2 ports detected
[   21.236367] hub 2-0:1.0: USB hub found
[   21.236381] hub 2-0:1.0: 2 ports detected
[   21.236385] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0007db, prod_id: 0xaa81, dev_id: 0x01)
[   21.236406] ipmi_si ipmi_si.0: IPMI bt interface initialized
[   21.264316] hub 3-0:1.0: USB hub found
[   21.264327] hub 3-0:1.0: 2 ports detected
[   21.279717] PTP clock support registered
[   21.338717] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   21.432285] NET: Registered protocol family 10
[   21.442396] Segment Routing with IPv6
[   21.632319] dca service started, version 1.12.1
[   21.897990] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[   21.907576] igb: Copyright (c) 2007-2014 Intel Corporation.
[   21.969355] igb 0000:86:00.0: added PHC on eth0
[   21.976602] igb 0000:86:00.0: Intel(R) Gigabit Ethernet Network Connection
[   21.986196] igb 0000:86:00.0: eth0: (PCIe:5.0Gb/s:Width x4) f8:4a:bf:56:47:31
[   21.996061] igb 0000:86:00.0: eth0: PBA No: Unknown
[   22.003752] igb 0000:86:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   22.067707] igb 0000:86:00.1: added PHC on eth1
[   22.075005] igb 0000:86:00.1: Intel(R) Gigabit Ethernet Network Connection
[   22.084627] igb 0000:86:00.1: eth1: (PCIe:5.0Gb/s:Width x4) f8:4a:bf:56:47:32
[   22.094444] igb 0000:86:00.1: eth1: PBA No: Unknown
[   22.101982] igb 0000:86:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   22.165254] igb 0000:86:00.2: added PHC on eth2
[   22.172446] igb 0000:86:00.2: Intel(R) Gigabit Ethernet Network Connection
[   22.182002] igb 0000:86:00.2: eth2: (PCIe:5.0Gb/s:Width x4) f8:4a:bf:56:47:33
[   22.191848] igb 0000:86:00.2: eth2: PBA No: Unknown
[   22.199424] igb 0000:86:00.2: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   22.263603] igb 0000:86:00.3: added PHC on eth3
[   22.270856] igb 0000:86:00.3: Intel(R) Gigabit Ethernet Network Connection
[   22.280455] igb 0000:86:00.3: eth3: (PCIe:5.0Gb/s:Width x4) f8:4a:bf:56:47:34
[   22.290324] igb 0000:86:00.3: eth3: PBA No: Unknown
[   22.297912] igb 0000:86:00.3: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   25.462012] usb 6-1: New USB device found, idVendor=12d1, idProduct=0003
[   25.471599] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   25.481640] usb 6-1: Product: HUAWEI Keyboard/Mouse KVM 1.1
[   35.815292] usb 6-1: USB disconnect, device number 2
[   35.824027] ehci-pci 0000:00:1d.7: EHCI Host Controller
[   35.832285] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 8
[   35.842705] ehci-pci 0000:00:1d.7: debug port 1
[   35.854133] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[   35.854150] ehci-pci 0000:00:1d.7: irq 23, io mem 0xcf222000
[   35.875959] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[   35.884749] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[   35.894541] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   35.904725] usb usb8: Product: EHCI Host Controller
[   35.912522] usb usb8: Manufacturer: Linux 4.10.0-rc4-mainline+ ehci_hcd
[   35.922069] usb usb8: SerialNumber: 0000:00:1d.7
[   35.930137] hub 8-0:1.0: USB hub found
[   35.936824] hub 8-0:1.0: 6 ports detected
[   35.972087] hub 4-0:1.0: USB hub found
[   35.978641] hub 4-0:1.0: 2 ports detected
[   36.012077] hub 5-0:1.0: USB hub found
[   36.018559] hub 5-0:1.0: 2 ports detected
[   36.052077] hub 6-0:1.0: USB hub found
[   36.058453] hub 6-0:1.0: 2 ports detected
[   36.284068] hidraw: raw HID events driver (C) Jiri Kosina
[   36.415203] usbcore: registered new interface driver usbhid
[   36.423372] usbhid: USB HID core driver
[   36.535919] usb 6-1: new full-speed USB device number 3 using uhci_hcd
[   46.965916] usb 6-1: New USB device found, idVendor=12d1, idProduct=0003
[   46.975284] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   46.985061] usb 6-1: Product: HUAWEI Keyboard/Mouse KVM 1.1
[   57.668794] input: HUAWEI Keyboard/Mouse KVM 1.1 as /devices/pci0000:00/0000:00:1d.2/usb6/6-1/6-1:1.0/0003:12D1:0003.0001/input/input4
[   57.744371] hid-generic 0003:12D1:0003.0001: input,hidraw0: USB HID v1.10 Keyboard [HUAWEI Keyboard/Mouse KVM 1.1] on usb-0000:00:1d.2-1/input0
[   57.763237] input: HUAWEI Keyboard/Mouse KVM 1.1 as /devices/pci0000:00/0000:00:1d.2/usb6/6-1/6-1:1.1/0003:12D1:0003.0002/input/input5
[   57.781978] hid-generic 0003:12D1:0003.0002: input,hidraw1: USB HID v1.10 Mouse [HUAWEI Keyboard/Mouse KVM 1.1] on usb-0000:00:1d.2-1/input1
[   67.321484] Adding 20971516k swap on /home/swap.  Priority:-1 extents:15337 across:114679716k
[   71.210679] device-mapper: uevent: version 1.0.3
[   71.221051] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[   71.617611] loop: module loaded
[   72.069124] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   72.103994] EXT4-fs (sda1): warning: maximal mount count reached, running e2fsck is recommended
[   72.116617] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   74.255315] fuse init (API version 7.26)
[   80.036603] audit: type=1400 audit(1489134627.372:2): apparmor="STATUS" operation="profile_load" name="/bin/ping" pid=2931 comm="apparmor_parser"
[   80.085085] audit: type=1400 audit(1489134627.420:3): apparmor="STATUS" operation="profile_load" name="/sbin/klogd" pid=2936 comm="apparmor_parser"
[   80.172680] audit: type=1400 audit(1489134627.508:4): apparmor="STATUS" operation="profile_load" name="/sbin/syslog-ng" pid=2940 comm="apparmor_parser"
[   80.277695] audit: type=1400 audit(1489134627.612:5): apparmor="STATUS" operation="profile_load" name="/sbin/syslogd" pid=2944 comm="apparmor_parser"
[   80.327579] audit: type=1400 audit(1489134627.664:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-explicit-grant-helper" pid=2949 comm="apparmor_parser"
[   80.379802] audit: type=1400 audit(1489134627.716:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-grant-helper" pid=2953 comm="apparmor_parser"
[   80.475024] audit: type=1400 audit(1489134627.812:8): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-grant-helper-pam" pid=2957 comm="apparmor_parser"
[   80.529758] audit: type=1400 audit(1489134627.864:9): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-read-auth-helper" pid=2961 comm="apparmor_parser"
[   80.567260] audit: type=1400 audit(1489134627.904:10): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-resolve-exe-helper" pid=2965 comm="apparmor_parser"
[   80.623452] audit: type=1400 audit(1489134627.960:11): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-revoke-helper" pid=2969 comm="apparmor_parser"
[   87.595682] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   87.804381] klogd (3172): Attempt to access syslog with CAP_SYS_ADMIN but no CAP_SYSLOG (deprecated).
[   87.804447] kauditd_printk_skb: 24 callbacks suppressed
[   87.804450] audit: type=1400 audit(1489134635.140:20): apparmor="DENIED" operation="capable" profile="/sbin/klogd" pid=3172 comm="klogd" capability=34  capname="syslog"
[   90.619062] igb 0000:86:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   90.619252] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  116.113879] auditd (5202): /proc/5202/oom_adj is deprecated, please use /proc/5202/oom_score_adj instead.
[  121.926364] RPC: Registered named UNIX socket transport module.
[  121.926367] RPC: Registered udp transport module.
[  121.926368] RPC: Registered tcp transport module.
[  121.926370] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  122.272430] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
