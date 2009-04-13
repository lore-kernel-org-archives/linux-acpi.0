From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: FAN Processor and Thermap
Date: Sun, 12 Apr 2009 23:56:46 -0600
Message-ID: <51f3faa70904122256wadabe78m190970794b3b9815@mail.gmail.com>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
	 <49DFE506.8040307@gmail.com>
	 <335b7d740904120419x548018caqd7f41c5b24639bec@mail.gmail.com>
	 <1239586644.5564.17.camel@localhost.localdomain>
	 <335b7d740904122031i2d1aa7d8s141e81baf2bfb087@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:58542 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbZDMF4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 01:56:48 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2078299ywb.1
        for <linux-acpi@vger.kernel.org>; Sun, 12 Apr 2009 22:56:46 -0700 (PDT)
In-Reply-To: <335b7d740904122031i2d1aa7d8s141e81baf2bfb087@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: yakui_zhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, Apr 12, 2009 at 9:31 PM, Ken Perl <kenperl@gmail.com> wrote:
> I have no idea if my board supports ACPI or not, what's the reason to
> try a older kernel? is it because older kernel supports older board?

Possibly there's been some regression causing ACPI to not be detected
on that board. But the board is old enough, I think it's quite likely
it doesn't support ACPI at all.

>
> I can not power off machine with my current kernel by issue
> "power_off" command, the power is still on after I see the
> message"system halted". Is this related to ACPI? but I remember older
> kernel can power off my machine.

If APM support is compiled in, I think that should be able to power
off the machine on shutdown. Didn't see any APM-related output in the
dmesg output, though..

>
> On Mon, Apr 13, 2009 at 9:37 AM, yakui_zhao <yakui.zhao@intel.com> wr=
ote:
>> On Sun, 2009-04-12 at 19:19 +0800, Ken Perl wrote:
>>> I entered the bios but don't find a option to enable/disable ACPI. =
the
>>> dmesg output is below,
>>
>> >From the dmesg log it seems that there exists the following warning
>> message:
>> =C2=A0 >=EF=BB=BFACPI Error (tbxfroot-0218): A valid RSDP was not fo=
und [20080321]
>> =C2=A0 It indicates that no ACPI table is found on this box. In such=
 case
>> the ACPI can't be initialized correctly. Of course the
>> FAN/Processor/Thermal driver can't be loaded correctly.
>> =C2=A0 So IMO this is a BIOS bug rather than ACPI bug.
>>
>> =C2=A0 Will you please try the previous kernel(for example: 2.6.23 )=
 and
>> attach the output of dmesg?
>>
>> =C2=A0 Thanks.
>>>
>>> [ =C2=A0 =C2=A00.000000] Initializing cgroup subsys cpuset
>>> [ =C2=A0 =C2=A00.000000] Initializing cgroup subsys cpu
>>> [ =C2=A0 =C2=A00.000000] Linux version 2.6.26-1-686 (Debian 2.6.26-=
13lenny2)
>>> (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian
>>> 4.1.2-25)) #1 SMP Fri Mar 13 18:08:45 UTC 2009
>>> [ =C2=A0 =C2=A00.000000] BIOS-provided physical RAM map:
>>> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000000000000 - 000000=
000009f800 (usable)
>>> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000000009f800 - 000000=
00000a0000 (reserved)
>>> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000000f0c00 - 000000=
0000100000 (reserved)
>>> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000000100000 - 000000=
0008000000 (usable)
>>> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000ffff0c00 - 000000=
0100000000 (reserved)
>>> [ =C2=A0 =C2=A00.000000] 0MB HIGHMEM available.
>>> [ =C2=A0 =C2=A00.000000] 128MB LOWMEM available.
>>> [ =C2=A0 =C2=A00.000000] Entering add_active_range(0, 0, 32768) 0 e=
ntries of 256 used
>>> [ =C2=A0 =C2=A00.000000] Zone PFN ranges:
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0 -> =C2=A0 =C2=A0 4096
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal =C2=A0 =C2=A0 =C2=A0 4096 ->=
 =C2=A0 =C2=A032768
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem =C2=A0 =C2=A0 32768 -> =C2=A0=
 =C2=A032768
>>> [ =C2=A0 =C2=A00.000000] Movable zone start PFN for each node
>>> [ =C2=A0 =C2=A00.000000] early_node_map[1] active PFN ranges
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 0: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0 -> =C2=A0 =C2=A032768
>>> [ =C2=A0 =C2=A00.000000] On node 0 totalpages: 32768
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 32 pages used for memmap
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 0 pages reserved
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 4064 pages, LIFO batch:0
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 224 pages used for mem=
map
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 28448 pages, LIFO batc=
h:7
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem zone: 0 pages used for memm=
ap
>>> [ =C2=A0 =C2=A00.000000] =C2=A0 Movable zone: 0 pages used for memm=
ap
>>> [ =C2=A0 =C2=A00.000000] DMI not present or invalid.
>>> [ =C2=A0 =C2=A00.000000] ACPI Error (tbxfroot-0218): A valid RSDP w=
as not found [20080321]
>>> [ =C2=A0 =C2=A00.000000] Allocating PCI resources starting at 10000=
000 (gap:
>>> 08000000:f7ff0c00)
>>> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 000000000009=
f000 - 00000000000a0000
>>> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 00000000000a=
0000 - 00000000000f1000
>>> [ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: 00000000000f=
1000 - 0000000000100000
>>> [ =C2=A0 =C2=A00.000000] SMP: Allowing 0 CPUs, 0 hotplug CPUs
>>> [ =C2=A0 =C2=A00.000000] PERCPU: Allocating 37960 bytes of per cpu =
data
>>> [ =C2=A0 =C2=A00.000000] NR_CPUS: 8, nr_cpu_ids: 1
>>> [ =C2=A0 =C2=A00.000000] Built 1 zonelists in Zone order, mobility =
grouping on.
>>> Total pages: 32512
>>> [ =C2=A0 =C2=A00.000000] Kernel command line: root=3D/dev/hda1 ro q=
uiet
>>> console=3DttyS0,115200n8
>>> [ =C2=A0 =C2=A00.000000] Local APIC disabled by BIOS -- you can ena=
ble it with "lapic"
>>> [ =C2=A0 =C2=A00.000000] mapped APIC to ffffb000 (0110c000)
>>> [ =C2=A0 =C2=A00.000000] Enabling fast FPU save and restore... done=
=2E
>>> [ =C2=A0 =C2=A00.000000] Initializing CPU#0
>>> [ =C2=A0 =C2=A00.000000] PID hash table entries: 512 (order: 9, 204=
8 bytes)
>>> [ =C2=A0 =C2=A00.000000] Detected 267.283 MHz processor.
>>> [ =C2=A0 =C2=A00.004000] Console: colour VGA+ 80x25
>>> [ =C2=A0 =C2=A00.004000] console [ttyS0] enabled
>>> [ =C2=A0 =C2=A00.004000] Dentry cache hash table entries: 16384 (or=
der: 4, 65536 bytes)
>>> [ =C2=A0 =C2=A00.004000] Inode-cache hash table entries: 8192 (orde=
r: 3, 32768 bytes)
>>> [ =C2=A0 =C2=A00.004000] Memory: 120060k/131072k available (1769k k=
ernel code,
>>> 10456k reserved, 752k data, 244k init, 0k highmem)
>>> [ =C2=A0 =C2=A00.004000] virtual kernel memory layout:
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 fixmap =C2=A0: 0xfff4c000 - =
0xfffff000 =C2=A0 ( 716 kB)
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 pkmap =C2=A0 : 0xff800000 - =
0xffc00000 =C2=A0 (4096 kB)
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 vmalloc : 0xc8800000 - 0xff7=
fe000 =C2=A0 ( 879 MB)
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 lowmem =C2=A0: 0xc0000000 - =
0xc8000000 =C2=A0 ( 128 MB)
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 =C2=A0 .init : 0xc037f000 - =
0xc03bc000 =C2=A0 ( 244 kB)
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 =C2=A0 .data : 0xc02ba4d3 - =
0xc0376620 =C2=A0 ( 752 kB)
>>> [ =C2=A0 =C2=A00.004000] =C2=A0 =C2=A0 =C2=A0 .text : 0xc0100000 - =
0xc02ba4d3 =C2=A0 (1769 kB)
>>> [ =C2=A0 =C2=A00.004000] Checking if this processor honours the WP =
bit even in
>>> supervisor mode...Ok.
>>> [ =C2=A0 =C2=A00.004000] CPA: page pool initialized 1 of 1 pages pr=
eallocated
>>> [ =C2=A0 =C2=A00.085108] Calibrating delay using timer specific rou=
tine.. 536.59
>>> BogoMIPS (lpj=3D1073195)
>>> [ =C2=A0 =C2=A00.085466] Security Framework initialized
>>> [ =C2=A0 =C2=A00.085517] SELinux: =C2=A0Disabled at boot.
>>> [ =C2=A0 =C2=A00.085550] Capability LSM initialized
>>> [ =C2=A0 =C2=A00.085708] Mount-cache hash table entries: 512
>>> [ =C2=A0 =C2=A00.087018] Initializing cgroup subsys ns
>>> [ =C2=A0 =C2=A00.087061] Initializing cgroup subsys cpuacct
>>> [ =C2=A0 =C2=A00.087085] Initializing cgroup subsys devices
>>> [ =C2=A0 =C2=A00.087292] CPU: L1 I cache: 16K, L1 D cache: 16K
>>> [ =C2=A0 =C2=A00.087337] Intel machine check architecture supported=
=2E
>>> [ =C2=A0 =C2=A00.087369] Intel machine check reporting enabled on C=
PU#0.
>>> [ =C2=A0 =C2=A00.087471] Checking 'hlt' instruction... OK.
>>> [ =C2=A0 =C2=A00.101247] SMP alternatives: switching to UP code
>>> [ =C2=A0 =C2=A00.133922] Freeing SMP alternatives: 16k freed
>>> [ =C2=A0 =C2=A00.133956] ACPI: Core revision 20080321
>>> [ =C2=A0 =C2=A00.134291] ACPI Exception (tbxface-0629): AE_NO_ACPI_=
TABLES, While
>>> loading namespace from ACPI tables [20080321]
>>> [ =C2=A0 =C2=A00.134339] ACPI: Unable to load the System Descriptio=
n Tables
>>> [ =C2=A0 =C2=A00.140008] weird, boot CPU (#0) not listedby the BIOS=
=2E
>>> [ =C2=A0 =C2=A00.140008] SMP motherboard not detected.
>>> [ =C2=A0 =C2=A00.140008] Local APIC not detected. Using dummy APIC =
emulation.
>>> [ =C2=A0 =C2=A00.140008] SMP disabled
>>> [ =C2=A0 =C2=A00.140607] Brought up 1 CPUs
>>> [ =C2=A0 =C2=A00.140637] Total of 1 processors activated (536.59 Bo=
goMIPS).
>>> [ =C2=A0 =C2=A00.140698] CPU0 attaching sched-domain:
>>> [ =C2=A0 =C2=A00.140720] =C2=A0domain 0: span 0
>>> [ =C2=A0 =C2=A00.140739] =C2=A0 groups: 0
>>> [ =C2=A0 =C2=A00.143270] net_namespace: 660 bytes
>>> [ =C2=A0 =C2=A00.143314] Booting paravirtualized kernel on bare har=
dware
>>> [ =C2=A0 =C2=A00.145944] NET: Registered protocol family 16
>>> [ =C2=A0 =C2=A00.153024] PCI: PCI BIOS revision 2.10 entry at 0xfd9=
cc, last bus=3D1
>>> [ =C2=A0 =C2=A00.153057] PCI: Using configuration type 1 for base a=
ccess
>>> [ =C2=A0 =C2=A00.153082] Setting up standard PCI resources
>>> [ =C2=A0 =C2=A00.168352] ACPI: Interpreter disabled.
>>> [ =C2=A0 =C2=A00.168386] Linux Plug and Play Support v0.97 (c) Adam=
 Belay
>>> [ =C2=A0 =C2=A00.169043] pnp: PnP ACPI: disabled
>>> [ =C2=A0 =C2=A00.169077] PnPBIOS: Scanning system for PnP BIOS supp=
ort...
>>> [ =C2=A0 =C2=A00.169243] PnPBIOS: Found PnP BIOS installation struc=
ture at 0xc00f7b90
>>> [ =C2=A0 =C2=A00.169273] PnPBIOS: PnP BIOS version 1.0, entry 0xf00=
00:0xa38b, dseg 0x400
>>> [ =C2=A0 =C2=A00.189159] PnPBIOS: 15 nodes reported by PnP BIOS; 15=
 recorded by driver
>>> [ =C2=A0 =C2=A00.195069] PCI: Probing PCI hardware
>>> [ =C2=A0 =C2=A00.195103] PCI: Probing PCI hardware (bus 00)
>>> [ =C2=A0 =C2=A00.196527] * Found PM-Timer Bug on the chipset. Due t=
o workarounds
>>> for a bug,
>>> [ =C2=A0 =C2=A00.196547] * this clock source is slow. Consider tryi=
ng other clock sources
>>> [ =C2=A0 =C2=A00.196674] pci 0000:00:07.3: quirk: region 8000-803f =
claimed by PIIX4 ACPI
>>> [ =C2=A0 =C2=A00.196705] pci 0000:00:07.3: quirk: region 2180-218f =
claimed by PIIX4 SMB
>>> [ =C2=A0 =C2=A00.204349] PCI: Using IRQ router PIIX/ICH [8086/7110]=
 at 0000:00:07.0
>>> [ =C2=A0 =C2=A00.204473] PCI: setting IRQ 9 as level-triggered
>>> [ =C2=A0 =C2=A00.204499] PCI: Found IRQ 9 for device 0000:00:0f.0
>>> [ =C2=A0 =C2=A00.204565] PCI: Sharing IRQ 9 with 0000:00:14.0
>>> [ =C2=A0 =C2=A00.206313] system 00:00: iomem range 0xfff80000-0xfff=
fffff could
>>> not be reserved
>>> [ =C2=A0 =C2=A00.206407] system 00:01: iomem range 0x0-0x9ffff coul=
d not be reserved
>>> [ =C2=A0 =C2=A00.206438] system 00:01: iomem range 0xe0000-0xfffff =
could not be reserved
>>> [ =C2=A0 =C2=A00.206466] system 00:01: iomem range 0x100000-0x7ffff=
ff could not
>>> be reserved
>>> [ =C2=A0 =C2=A00.206572] system 00:0a: ioport range 0x4d0-0x4d1 has=
 been reserved
>>> [ =C2=A0 =C2=A00.206603] system 00:0a: ioport range 0x8000-0x803f h=
as been reserved
>>> [ =C2=A0 =C2=A00.206629] system 00:0a: ioport range 0x2180-0x218f h=
as been reserved
>>> [ =C2=A0 =C2=A00.214772] PCI: Bridge: 0000:00:01.0
>>> [ =C2=A0 =C2=A00.214802] =C2=A0 IO window: disabled.
>>> [ =C2=A0 =C2=A00.214825] =C2=A0 MEM window: disabled.
>>> [ =C2=A0 =C2=A00.214844] =C2=A0 PREFETCH window: disabled.
>>> [ =C2=A0 =C2=A00.215125] NET: Registered protocol family 2
>>> [ =C2=A0 =C2=A00.216435] IP route cache hash table entries: 1024 (o=
rder: 0, 4096 bytes)
>>> [ =C2=A0 =C2=A00.218451] TCP established hash table entries: 4096 (=
order: 3, 32768 bytes)
>>> [ =C2=A0 =C2=A00.218758] TCP bind hash table entries: 4096 (order: =
3, 32768 bytes)
>>> [ =C2=A0 =C2=A00.219079] TCP: Hash tables configured (established 4=
096 bind 4096)
>>> [ =C2=A0 =C2=A00.219103] TCP reno registered
>>> [ =C2=A0 =C2=A00.220088] NET: Registered protocol family 1
>>> [ =C2=A0 =C2=A00.221113] checking if image is initramfs... it is
>>> [ =C2=A0 =C2=A05.337205] Freeing initrd memory: 6023k freed
>>> [ =C2=A0 =C2=A05.344636] audit: initializing netlink socket (disabl=
ed)
>>> [ =C2=A0 =C2=A05.344731] type=3D2000 audit(1239528267.344:1): initi=
alized
>>> [ =C2=A0 =C2=A05.345896] Total HugeTLB memory allocated, 0
>>> [ =C2=A0 =C2=A05.346815] VFS: Disk quotas dquot_6.5.1
>>> [ =C2=A0 =C2=A05.347114] Dquot-cache hash table entries: 1024 (orde=
r 0, 4096 bytes)
>>> [ =C2=A0 =C2=A05.347555] msgmni has been set to 246
>>> [ =C2=A0 =C2=A05.349105] Block layer SCSI generic (bsg) driver vers=
ion 0.4
>>> loaded (major 253)
>>> [ =C2=A0 =C2=A05.349145] io scheduler noop registered
>>> [ =C2=A0 =C2=A05.349163] io scheduler anticipatory registered
>>> [ =C2=A0 =C2=A05.349181] io scheduler deadline registered
>>> [ =C2=A0 =C2=A05.349344] io scheduler cfq registered (default)
>>> [ =C2=A0 =C2=A05.349412] pci 0000:00:00.0: Limiting direct PCI/PCI =
transfers
>>> [ =C2=A0 =C2=A05.349538] pci 0000:00:14.0: Boot video device
>>> [ =C2=A0 =C2=A05.355215] isapnp: Scanning for PnP cards...
>>> [ =C2=A0 =C2=A05.465580] =C2=A001:01: card 'CRD4237B-5'
>>> [ =C2=A0 =C2=A05.465612] isapnp: 1 Plug & Play card detected total
>>> [ =C2=A0 =C2=A05.517472] Serial: 8250/16550 driver $Revision: 1.90 =
$ 4 ports,
>>> IRQ sharing enabled
>>> [ =C2=A0 =C2=A05.518390] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4)=
 is a 16550A
>>> [ =C2=A0 =C2=A05.524339] 00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a=
 16550A
>>> [ =C2=A0 =C2=A05.552352] brd: module loaded
>>> [ =C2=A0 =C2=A05.553992] PNP: PS/2 Controller [PNP0303,PNP0f13] at =
0x60,0x64 irq 1,12
>>> [ =C2=A0 =C2=A05.558114] serio: i8042 KBD port at 0x60,0x64 irq 1
>>> [ =C2=A0 =C2=A05.558181] serio: i8042 AUX port at 0x60,0x64 irq 12
>>> [ =C2=A0 =C2=A05.560886] mice: PS/2 mouse device common for all mic=
e
>>> [ =C2=A0 =C2=A05.562978] rtc_cmos 00:05: rtc core: registered rtc_c=
mos as rtc0
>>> [ =C2=A0 =C2=A05.563073] rtc0: alarms up to one day
>>> [ =C2=A0 =C2=A05.563770] cpuidle: using governor ladder
>>> [ =C2=A0 =C2=A05.563801] cpuidle: using governor menu
>>> [ =C2=A0 =C2=A05.563860] No iBFT detected.
>>> [ =C2=A0 =C2=A05.567791] TCP cubic registered
>>> [ =C2=A0 =C2=A05.567829] NET: Registered protocol family 17
>>> [ =C2=A0 =C2=A05.567887] Using IPI No-Shortcut mode
>>> [ =C2=A0 =C2=A05.570094] registered taskstats version 1
>>> [ =C2=A0 =C2=A05.570719] rtc_cmos 00:05: setting system clock to 20=
09-04-12
>>> 09:24:28 UTC (1239528268)
>>> [ =C2=A0 =C2=A05.572525] Freeing unused kernel memory: 244k freed
>>> [ =C2=A0 =C2=A06.671691] thermal: Unknown symbol acpi_processor_set=
_thermal_limit
>>> [ =C2=A0 11.279535] FDC 0 is a post-1991 82077
>>> [ =C2=A0 11.288680] usbcore: registered new interface driver usbfs
>>> [ =C2=A0 11.288981] usbcore: registered new interface driver hub
>>> [ =C2=A0 11.289542] usbcore: registered new device driver usb
>>> [ =C2=A0 11.418063] SCSI subsystem initialized
>>> [ =C2=A0 11.457426] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22=
, 2004)
>>> [ =C2=A0 11.457577] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10)=
 is not
>>> an 8139C+ compatible chip
>>> [ =C2=A0 11.466112] 8139cp 0000:00:0f.0: Try the "8139too" driver i=
nstead.
>>> [ =C2=A0 11.502056] USB Universal Host Controller Interface driver =
v3.0
>>> [ =C2=A0 11.502334] uhci_hcd 0000:00:07.2: enabling device (0000 ->=
 0001)
>>> [ =C2=A0 11.502388] PCI: setting IRQ 10 as level-triggered
>>> [ =C2=A0 11.502409] PCI: Assigned IRQ 10 for device 0000:00:07.2
>>> [ =C2=A0 11.502514] uhci_hcd 0000:00:07.2: UHCI Host Controller
>>> [ =C2=A0 11.503231] uhci_hcd 0000:00:07.2: new USB bus registered, =
assigned
>>> bus number 1
>>> [ =C2=A0 11.503355] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000fc=
c0
>>> [ =C2=A0 11.504347] usb usb1: configuration #1 chosen from 1 choice
>>> [ =C2=A0 11.504738] hub 1-0:1.0: USB hub found
>>> [ =C2=A0 11.504850] hub 1-0:1.0: 2 ports detected
>>> [ =C2=A0 11.574015] 8139too Fast Ethernet driver 0.9.28
>>> [ =C2=A0 11.823971] usb usb1: New USB device found, idVendor=3D1d6b=
, idProduct=3D0001
>>> [ =C2=A0 11.824009] usb usb1: New USB device strings: Mfr=3D3, Prod=
uct=3D2,
>>> SerialNumber=3D1
>>> [ =C2=A0 11.824033] usb usb1: Product: UHCI Host Controller
>>> [ =C2=A0 11.824052] usb usb1: Manufacturer: Linux 2.6.26-1-686 uhci=
_hcd
>>> [ =C2=A0 11.824071] usb usb1: SerialNumber: 0000:00:07.2
>>> [ =C2=A0 11.824865] 8139too 0000:00:0f.0: enabling device (0000 -> =
0003)
>>> [ =C2=A0 11.824913] PCI: Found IRQ 9 for device 0000:00:0f.0
>>> [ =C2=A0 11.824988] PCI: Sharing IRQ 9 with 0000:00:14.0
>>> [ =C2=A0 11.827560] eth0: RealTek RTL8139 at 0xf800, 00:05:1c:15:b0=
:6e, IRQ 9
>>> [ =C2=A0 11.827594] eth0: =C2=A0Identified 8139 chip type 'RTL-8100=
B/8139D'
>>> [ =C2=A0 11.850569] libata version 3.00 loaded.
>>> [ =C2=A0 12.059682] Uniform Multi-Platform E-IDE driver
>>> [ =C2=A0 12.059729] ide: Assuming 33MHz system bus speed for PIO mo=
des;
>>> override with idebus=3Dxx
>>> [ =C2=A0 12.080991] PIIX4: IDE controller (0x8086:0x7111 rev 0x01) =
at =C2=A0PCI
>>> slot 0000:00:07.1
>>> [ =C2=A0 12.081072] PIIX4: not 100% native mode: will probe irqs la=
ter
>>> [ =C2=A0 12.081123] =C2=A0 =C2=A0 ide0: BM-DMA at 0xfcf0-0xfcf7
>>> [ =C2=A0 12.081178] =C2=A0 =C2=A0 ide1: BM-DMA at 0xfcf8-0xfcff
>>> [ =C2=A0 12.081213] Probing IDE interface ide0...
>>> [ =C2=A0 12.368571] hda: ST310211A, ATA DISK drive
>>> [ =C2=A0 13.040659] hda: host max PIO4 wanted PIO255(auto-tune) sel=
ected PIO4
>>> [ =C2=A0 13.040884] hda: UDMA/33 mode selected
>>> [ =C2=A0 13.040985] Probing IDE interface ide1...
>>> [ =C2=A0 13.776653] hdc: LEOPTICS CD-ROM 24X v2.2C, ATAPI CD/DVD-RO=
M drive
>>> [ =C2=A0 14.112666] hdc: host max PIO4 wanted PIO255(auto-tune) sel=
ected PIO4
>>> [ =C2=A0 14.112836] hdc: MWDMA2 mode selected
>>> [ =C2=A0 14.113091] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>> [ =C2=A0 14.113323] ide1 at 0x170-0x177,0x376 on irq 15
>>> [ =C2=A0 14.448439] hda: max request size: 128KiB
>>> [ =C2=A0 14.534166] hda: 19541088 sectors (10005 MB) w/1024KiB Cach=
e, CHS=3D19386/16/63
>>> [ =C2=A0 14.534210] hda: cache flushes not supported
>>> [ =C2=A0 14.534526] =C2=A0hda: hda1 hda2 < hda5 >
>>> [ =C2=A0 14.594238] hdc: ATAPI 20X CD-ROM drive, 128kB Cache
>>> [ =C2=A0 14.594288] Uniform CD-ROM driver Revision: 3.20
>>> [ =C2=A0 15.136450] PM: Starting manual resume from disk
>>> [ =C2=A0 15.394219] EXT3-fs: INFO: recovery required on readonly fi=
lesystem.
>>> [ =C2=A0 15.394256] EXT3-fs: write access will be enabled during re=
covery.
>>> [ =C2=A0 16.694052] kjournald starting. =C2=A0Commit interval 5 sec=
onds
>>> [ =C2=A0 16.694167] EXT3-fs: hda1: orphan cleanup on readonly fs
>>> [ =C2=A0 16.694230] ext3_orphan_cleanup: deleting unreferenced inod=
e 286729
>>> [ =C2=A0 16.694429] ext3_orphan_cleanup: deleting unreferenced inod=
e 286728
>>> [ =C2=A0 16.694533] ext3_orphan_cleanup: deleting unreferenced inod=
e 286727
>>> [ =C2=A0 16.694631] ext3_orphan_cleanup: deleting unreferenced inod=
e 286726
>>> [ =C2=A0 16.694857] ext3_orphan_cleanup: deleting unreferenced inod=
e 286725
>>> [ =C2=A0 16.694944] EXT3-fs: hda1: 5 orphan inodes deleted
>>> [ =C2=A0 16.694968] EXT3-fs: recovery complete.
>>> [ =C2=A0 16.735943] EXT3-fs: mounted filesystem with ordered data m=
ode.
>>> [ =C2=A0 17.859848] spurious 8259A interrupt: IRQ7.
>>> [ =C2=A0 20.248151] udevd version 125 started
>>> [ =C2=A0 26.125560] input: PC Speaker as /class/input/input0
>>> [ =C2=A0 30.281356] Linux agpgart interface v0.103
>>> [ =C2=A0 30.422789] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>>> [ =C2=A0 30.669684] shpchp: Standard Hot Plug PCI Controller Driver=
 version: 0.4
>>> [ =C2=A0 31.741028] agpgart: Detected an Intel 440LX Chipset.
>>> [ =C2=A0 31.750189] agpgart: AGP aperture is 64M @ 0xf4000000
>>> [ =C2=A0 32.839954] piix4_smbus 0000:00:07.3: Found 0000:00:07.3 de=
vice
>>> [ =C2=A0 33.188787] Error: Driver 'pcspkr' is already registered, a=
borting...
>>> [ =C2=A0 33.425456] parport_pc 00:10: reported by Plug and Play BIO=
S
>>> [ =C2=A0 33.425536] parport0: PC-style at 0x378, irq 7 [PCSPP,TRIST=
ATE,EPP]
>>> [ =C2=A0 34.034629] ns558 01:01.01: activated
>>> [ =C2=A0 34.063541] gameport: NS558 PnP Gameport is pnp01:01.01/gam=
eport0,
>>> io 0x200, speed 727kHz
>>> [ =C2=A0 34.179454] cs4236_isapnp 01:01.00: activated
>>> [ =C2=A0 34.182287] cs4236_isapnp 01:01.02: activated
>>> [ =C2=A0 34.185549] cs4236_isapnp 01:01.03: activated
>>> [ =C2=A0 38.965548] Adding 465844k swap on /dev/hda5. =C2=A0Priorit=
y:-1
>>> extents:1 across:465844k
>>> [ =C2=A0 39.618203] EXT3 FS on hda1, internal journal
>>> [ =C2=A0 40.922052] loop: module loaded
>>> [ =C2=A0 43.891563] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>>> [ =C2=A0 48.185069] NET: Registered protocol family 10
>>> [ =C2=A0 48.189408] lo: Disabled Privacy Extensions
>>> [ =C2=A0 58.985185] eth0: no IPv6 routers present
>>>
>>>
>>> On Sat, Apr 11, 2009 at 8:32 AM, Robert Hancock <hancockrwd@gmail.c=
om> wrote:
>>> > Ken Perl wrote:
>>> >>
>>> >> After I replaced my mainboard, then I can see errors related to =
ACPI
>>> >> during the Linux booting, I can also reproduce it with command b=
elow,
>>> >>
>>> >> moproble fan processor thermap
>>> >>
>>> >> I got error "no such device", =C2=A0I ever tried to append follo=
wing lines
>>> >> to the /etc/modprobe.d/blacklist but can not succeed, I can stil=
l see
>>> >> same error during boot, another error is "ACPI unable to load sy=
stem
>>> >> description tables",
>>> >>
>>> >> blacklist fan
>>> >> blacklist processor
>>> >> blacklist thermap
>>> >>
>>> >> Do these a big problem? Can anyone tell how I can fix the issue?
>>> >>
>>> >
>>> > Can you post your dmesg output? Make sure that the motherboard do=
esn't have
>>> > ACPI disabled in the BIOS or something (I don't think many even h=
ave that
>>> > option anymore, but who knows).
>>> >
>>>
>>>
>>>
>>> --
>>> perl -e 'print unpack(u,"62V5N\"FME;G\!E<FQ`9VUA:6PN8V]M\"\@``
>>> ")'
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>
>>
>
>
>
> --
> perl -e 'print unpack(u,"62V5N\"FME;G\!E<FQ`9VUA:6PN8V]M\"\@``
> ")'
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
