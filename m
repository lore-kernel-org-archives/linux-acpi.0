From: Andrew McMillan <andrew@morphoss.com>
Subject: ACPI issues in Dell Studio model 1558
Date: Tue, 07 Sep 2010 10:15:05 +1200
Message-ID: <1283811305.17765.129.camel@dave.home.mcmillan.net.nz>
Reply-To: andrew@morphoss.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hoppy.mcmillan.net.nz ([202.78.240.82]:41537 "EHLO
	mail.morphoss.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab0IFW2v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Sep 2010 18:28:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.morphoss.com (Postfix) with ESMTP id 977AD203E3
	for <linux-acpi@vger.kernel.org>; Tue,  7 Sep 2010 10:19:45 +1200 (NZST)
Received: from mail.morphoss.com ([127.0.0.1])
	by localhost (hoppy.mcmillan.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hRHNpFtgrBSV for <linux-acpi@vger.kernel.org>;
	Tue,  7 Sep 2010 10:19:37 +1200 (NZST)
Received: from [192.168.55.25] (home.mcmillan.net.nz [202.160.48.75])
	(Authenticated sender: andrew@mail.morphoss.com)
	by mail.morphoss.com (Postfix) with ESMTPSA id F33FE203E5
	for <linux-acpi@vger.kernel.org>; Tue,  7 Sep 2010 10:19:36 +1200 (NZST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

Hi,

I just received a new laptop and am having several problems with it
which I believe are related to ACPI, as follows:

1) The fan runs continuously and fairly noisily, without changing when I
max out all four cores by compiling a kernel, or if I just booted from
cold.

2) The contents of /sys/class/thermal/thermal_zone*/temp do not change -
one thermal zone always shows '0' and the other always shows '26800'.

3) When I run PowerTop it appears to underestimate both my battery
capacity and my current power use by a factor of roughly 11 - the
battery is shown as 7.8Wh, but in fact it is 85Wh.

E.g.:

karora@dave:/sys/class/power_supply/BAT0$ cat current_now voltage_now power_now 
2645000
12164000
2645000

4) The backlight setting does not seem to be readable.  At boot Linux
claims that: [Firmware Bug]: ACPI: ACPI brightness control misses _BQC
function.  So I guess that's that one :-)


I've downloaded the latest BIOS from Dell and jumped through all the
hoops needed to install that, but it made no noticeable change.

Here is a selection of output during the boot - there's a more
comprehensive sample at the bottom of the e-mail also.

There are many of these:
[    1.049936] \_SB_.PCI0:_OSC invalid UUID

Lots of these kinds of things too:
[    1.052202] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.052210] pci 0000:00:1c.0: PME# disabled

[    1.065228] pci 0000:07:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    1.065237] pci 0000:07:00.2: PME# disabled

Only one of these
[    1.079086] Unable to assume PCIe control: Disabling ASPM

[    1.086412] HEST: Table is not found!

[    1.249906] ACPI: Fan [FAN0] (off)
[    1.249959] ACPI: Fan [FAN1] (off)


[    1.259118] acpi device:02: registered as cooling_device2
[    1.262132] thermal LNXTHERM:01: registered as thermal_zone0
[    1.262139] ACPI: Thermal Zone [TZ00] (27 C)
[    1.262561] thermal LNXTHERM:02: registered as thermal_zone1
[    1.262571] ACPI: Thermal Zone [TZ01] (0 C)

[    1.262598] ERST: Table is not found!

[    2.769664] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.769670] ACPI: resource 0000:00:1f.3 [io  0x1840-0x185f] conflicts with ACPI
                         region SMBI [bus 1840-184f pref window disabled]
[    2.769672] ACPI: If an ACPI driver is available for this device, you should use it
                         instead of the native driver


The CPU in the system is an Intel Core i7 740QM, and most stuff seems to
work fine - it's really just the thermal management that seems
particularly broken.

I'm currently running 2.6.36-rc3, although the issues are much the same
with the stock Debian kernel (though maybe powertop gives different
results there - I haven't checked that on both kernels).


Any guidance in where to look to resolve the issues would be greatly
appreciated.  I haven't provided the full details of dmesg or lspci -v
etc, because I felt they were a bit much to spam a mailing list with,
but I'm happy to do so if that's the right approach :-)

I would also dearly love to be able to control those fans so the system
used as much passive cooling as possible.  From the set points in the
thermal zones it appears to be configured primarily for active cooling,
viz:

karora@dave:/sys/class/thermal/thermal_zone1$ cat trip_point_*
100000
critical
95000
passive
71000
active
55000
active

So the icing on the cake for me would be if I could shuffle these points
around to put the passive cooling trip point lower and discourage the
fans from starting up at all.  I don't see any way to do that though.

Thanks,
					Andrew McMillan.


=============== lspci =================
00:00.0 Host bridge: Intel Corporation Core Processor DMI (rev 11)
00:03.0 PCI bridge: Intel Corporation Core Processor PCI Express Root Port 1 (rev 11)
00:08.0 System peripheral: Intel Corporation Core Processor System Management Registers (rev 11)
00:08.1 System peripheral: Intel Corporation Core Processor Semaphore and Scratchpad Registers (rev 11)
00:08.2 System peripheral: Intel Corporation Core Processor System Control and Status Registers (rev 11)
00:08.3 System peripheral: Intel Corporation Core Processor Miscellaneous Registers (rev 11)
00:10.0 System peripheral: Intel Corporation Core Processor QPI Link (rev 11)
00:10.1 System peripheral: Intel Corporation Core Processor QPI Routing and Protocol Registers (rev 11)
00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series Chipset HECI Controller (rev 06)
00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller (rev 06)
00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 06)
00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 1 (rev 06)
00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 2 (rev 06)
00:1c.3 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 4 (rev 06)
00:1c.4 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 5 (rev 06)
00:1c.5 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 6 (rev 06)
00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller (rev 06)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a6)
00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC Interface Controller (rev 06)
00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset 4 port SATA AHCI Controller (rev 06)
00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus Controller (rev 06)
02:00.0 VGA compatible controller: ATI Technologies Inc Manhattan [Mobility Radeon HD 5000 Series]
02:00.1 Audio device: ATI Technologies Inc Manhattan HDMI Audio [Mobility Radeon HD 5000 Series]
04:00.0 Network controller: Broadcom Corporation BCM43224 802.11a/b/g/n (rev 01)
07:00.0 SD Host controller: Ricoh Co Ltd Device e822 (rev 01)
07:00.1 System peripheral: Ricoh Co Ltd Device e230 (rev 01)
07:00.2 System peripheral: Ricoh Co Ltd Device e852 (rev 01)
09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath Architecture Generic Non-Core Registers (rev 04)
ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath Architecture System Address Decoder (rev 04)
ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 04)
ff:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (rev 04)
ff:03.0 Host bridge: Intel Corporation Core Processor Integrated Memory Controller (rev 04)
ff:03.1 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Target Address Decoder (rev 04)
ff:03.4 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Test Registers (rev 04)
ff:04.0 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Control Registers (rev 04)
ff:04.1 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Address Registers (rev 04)
ff:04.2 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Rank Registers (rev 04)
ff:04.3 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Thermal Control Registers (rev 04)
ff:05.0 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Control Registers (rev 04)
ff:05.1 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Address Registers (rev 04)
ff:05.2 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Rank Registers (rev 04)
ff:05.3 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Thermal Control Registers (rev 04)


=========== dmesg | egrep -i '(acpi|bios|^\[    [01]\.)' ============

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.36-rc3-dave (karora@dave) (gcc version 4.4.5 20100902 (prerelease) (Debian 4.4.4-12) ) #1 SMP Mon Sep 6 10:31:17 NZST 2010
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-2.6.36-rc3-dave root=UUID=11178110-bf06-441d-ba14-61f55d6abe1f ro quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
[    0.000000]  BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000c3a7c000 (usable)
[    0.000000]  BIOS-e820: 00000000c3a7c000 - 00000000c3a82000 (reserved)
[    0.000000]  BIOS-e820: 00000000c3a82000 - 00000000c3be5000 (usable)
[    0.000000]  BIOS-e820: 00000000c3be5000 - 00000000c3c0f000 (reserved)
[    0.000000]  BIOS-e820: 00000000c3c0f000 - 00000000c3c6f000 (usable)
[    0.000000]  BIOS-e820: 00000000c3c6f000 - 00000000c3c70000 (reserved)
[    0.000000]  BIOS-e820: 00000000c3c70000 - 00000000c3cf1000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000c3cf1000 - 00000000c3f0f000 (reserved)
[    0.000000]  BIOS-e820: 00000000c3f0f000 - 00000000c3f18000 (usable)
[    0.000000]  BIOS-e820: 00000000c3f18000 - 00000000c3f1f000 (reserved)
[    0.000000]  BIOS-e820: 00000000c3f1f000 - 00000000c3f81000 (usable)
[    0.000000]  BIOS-e820: 00000000c3f81000 - 00000000c3f9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000c3f9f000 - 00000000c3fe2000 (usable)
[    0.000000]  BIOS-e820: 00000000c3fe2000 - 00000000c3fff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000c3fff000 - 00000000c4000000 (usable)
[    0.000000]  BIOS-e820: 00000000c4000000 - 00000000c6000000 (reserved)
[    0.000000]  BIOS-e820: 00000000c7800000 - 00000000c8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0b04000 - 00000000f0b05000 (reserved)
[    0.000000]  BIOS-e820: 00000000feaff000 - 00000000feb00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 00000001b8000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x1b8000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DBFFF uncachable
[    0.000000]   DC000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFE00000 mask FFFE00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0C0000000 mask FF8000000 write-back
[    0.000000]   4 base 100000000 mask F80000000 write-back
[    0.000000]   5 base 180000000 mask FE0000000 write-back
[    0.000000]   6 base 1A0000000 mask FF0000000 write-back
[    0.000000]   7 base 1B0000000 mask FF8000000 write-back
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xc4000 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] found SMP MP-table at [ffff8800000f7050] f7050
[    0.000000] init_memory_mapping: 0000000000000000-00000000c4000000
[    0.000000]  0000000000 - 00c4000000 page 2M
[    0.000000] kernel direct mapping tables up to c4000000 @ 8000-d000
[    0.000000] init_memory_mapping: 0000000100000000-00000001b8000000
[    0.000000]  0100000000 - 01b8000000 page 2M
[    0.000000] kernel direct mapping tables up to 1b8000000 @ b000-13000
[    0.000000] RAMDISK: 37c6d000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000f6f70 00024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 00000000c3ff4006 00074 (v01 DELL    QA09    06040000  LTP 00000000)
[    0.000000] ACPI: FACP 00000000c3fe4000 000F4 (v03 INTEL  CRESTLNE 06040000 ALAN 00000001)
[    0.000000] ACPI: DSDT 00000000c3fe5000 0A9B8 (v02 Intel  CALPELLA 06040000 INTL 20060912)
[    0.000000] ACPI: FACS 00000000c3f9bfc0 00040
[    0.000000] ACPI: HPET 00000000c3ffebd2 00038 (v01 INTEL  CRESTLNE 06040000 LOHR 0000005A)
[    0.000000] ACPI: MCFG 00000000c3ffec0a 0003C (v01 INTEL  CRESTLNE 06040000 LOHR 0000005A)
[    0.000000] ACPI: APIC 00000000c3ffec46 000BC (v01 PTLTD  ? APIC   06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 00000000c3ffed02 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
[    0.000000] ACPI: SPCR 00000000c3ffed2a 00050 (v01 PTLTD  $UCRTBL$ 06040000 PTL  00000001)
[    0.000000] ACPI: SLIC 00000000c3ffed7a 00176 (v01 DELL    QA09    06040000  LTP 00000000)
[    0.000000] ACPI: OSFR 00000000c3ffeef0 00070 (v01 DELL   DELL     06040000 ASL  00000061)
[    0.000000] ACPI: ASF! 00000000c3ffef60 000A0 (v16   CETP     CETP 06040000 PTL  00000001)
[    0.000000] ACPI: SSDT 00000000c3fe3000 009F1 (v01  PmRef    CpuPm 00003000 INTL 20060912)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-00000001b8000000
[    0.000000] Initmem setup node 0 0000000000000000-00000001b8000000
[    0.000000]   NODE_DATA [0000000100000000 - 0000000100004fff]
[    0.000000]  [ffffea0000000000-ffffea00061fffff] PMD -> [ffff880100200000-ffff8801057fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000001 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x001b8000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[9] active PFN ranges
[    0.000000]     0: 0x00000001 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x000c3a7c
[    0.000000]     0: 0x000c3a82 -> 0x000c3be5
[    0.000000]     0: 0x000c3c0f -> 0x000c3c6f
[    0.000000]     0: 0x000c3f0f -> 0x000c3f18
[    0.000000]     0: 0x000c3f1f -> 0x000c3f81
[    0.000000]     0: 0x000c3f9f -> 0x000c3fe2
[    0.000000]     0: 0x000c3fff -> 0x000c4000
[    0.000000]     0: 0x00100000 -> 0x001b8000
[    0.000000] On node 0 totalpages: 1555593
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3939 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 783654 pages, LIFO batch:31
[    0.000000]   Normal zone: 10304 pages used for memmap
[    0.000000]   Normal zone: 743360 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] early_res array is doubled to 64 at [7000 - 77ff]
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] early_res array is doubled to 128 at [e000 - efff]
[    0.000000] PM: Registered nosave memory: 00000000c3a7c000 - 00000000c3a82000
[    0.000000] PM: Registered nosave memory: 00000000c3be5000 - 00000000c3c0f000
[    0.000000] PM: Registered nosave memory: 00000000c3c6f000 - 00000000c3c70000
[    0.000000] PM: Registered nosave memory: 00000000c3c70000 - 00000000c3cf1000
[    0.000000] PM: Registered nosave memory: 00000000c3cf1000 - 00000000c3f0f000
[    0.000000] PM: Registered nosave memory: 00000000c3f18000 - 00000000c3f1f000
[    0.000000] PM: Registered nosave memory: 00000000c3f81000 - 00000000c3f9f000
[    0.000000] PM: Registered nosave memory: 00000000c3fe2000 - 00000000c3fff000
[    0.000000] PM: Registered nosave memory: 00000000c4000000 - 00000000c6000000
[    0.000000] PM: Registered nosave memory: 00000000c6000000 - 00000000c7800000
[    0.000000] PM: Registered nosave memory: 00000000c7800000 - 00000000c8000000
[    0.000000] PM: Registered nosave memory: 00000000c8000000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000f0b04000
[    0.000000] PM: Registered nosave memory: 00000000f0b04000 - 00000000f0b05000
[    0.000000] PM: Registered nosave memory: 00000000f0b05000 - 00000000feaff000
[    0.000000] PM: Registered nosave memory: 00000000feaff000 - 00000000feb00000
[    0.000000] PM: Registered nosave memory: 00000000feb00000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c8000000 (gap: c8000000:18000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff880001e00000 s86720 r8192 d23872 u262144
[    0.000000] pcpu-alloc: s86720 r8192 d23872 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1530953
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.36-rc3-dave root=UUID=11178110-bf06-441d-ba14-61f55d6abe1f ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Subtract (85 early reservations)
[    0.000000]   #1 [0001000000 - 0001c58db0]   TEXT DATA BSS
[    0.000000]   #2 [0037c6d000 - 0037ff0000]         RAMDISK
[    0.000000]   #3 [0001c59000 - 0001c591cc]             BRK
[    0.000000]   #4 [00000f7060 - 0000100000]   BIOS reserved
[    0.000000]   #5 [00000f7050 - 00000f7060]    MP-table mpf
[    0.000000]   #6 [000009c400 - 000009c971]   BIOS reserved
[    0.000000]   #7 [000009cb45 - 00000f7050]   BIOS reserved
[    0.000000]   #8 [000009c971 - 000009cb45]    MP-table mpc
[    0.000000]   #9 [0000001000 - 0000003000]      TRAMPOLINE
[    0.000000]   #10 [0000003000 - 0000007000]     ACPI WAKEUP
[    0.000000]   #11 [0000008000 - 000000b000]         PGTABLE
[    0.000000]   #12 [000000b000 - 000000e000]         PGTABLE
[    0.000000]   #13 [0100000000 - 0100005000]       NODE_DATA
[    0.000000]   #14 [0001c59200 - 0001c5a200]         BOOTMEM
[    0.000000]   #15 [0100005000 - 0100005480]         BOOTMEM
[    0.000000]   #16 [0100006000 - 0100007000]         BOOTMEM
[    0.000000]   #17 [0100007000 - 0100008000]         BOOTMEM
[    0.000000]   #18 [0100200000 - 0105800000]        MEMMAP 0
[    0.000000]   #19 [0001c5a200 - 0001c72200]         BOOTMEM
[    0.000000]   #20 [0001c72200 - 0001c8a200]         BOOTMEM
[    0.000000]   #21 [0001c8a200 - 0001ca2200]         BOOTMEM
[    0.000000]   #22 [0001ca3000 - 0001ca4000]         BOOTMEM
[    0.000000]   #23 [0001c58dc0 - 0001c58e01]         BOOTMEM
[    0.000000]   #24 [0001c58e40 - 0001c58e83]         BOOTMEM
[    0.000000]   #25 [0001ca2200 - 0001ca2890]         BOOTMEM
[    0.000000]   #26 [0001c58ec0 - 0001c58f28]         BOOTMEM
[    0.000000]   #27 [0001c58f40 - 0001c58fa8]         BOOTMEM
[    0.000000]   #28 [0001ca28c0 - 0001ca2928]         BOOTMEM
[    0.000000]   #29 [0001ca2940 - 0001ca29a8]         BOOTMEM
[    0.000000]   #30 [0001ca29c0 - 0001ca2a28]         BOOTMEM
[    0.000000]   #31 [0001ca2a40 - 0001ca2aa8]         BOOTMEM
[    0.000000]   #32 [0001ca2ac0 - 0001ca2b28]         BOOTMEM
[    0.000000]   #33 [0001ca2b40 - 0001ca2ba8]         BOOTMEM
[    0.000000]   #34 [0001ca2bc0 - 0001ca2c28]         BOOTMEM
[    0.000000]   #35 [0001ca2c40 - 0001ca2ca8]         BOOTMEM
[    0.000000]   #36 [0001ca2cc0 - 0001ca2d28]         BOOTMEM
[    0.000000]   #37 [0001ca2d40 - 0001ca2da8]         BOOTMEM
[    0.000000]   #38 [0001ca2dc0 - 0001ca2e28]         BOOTMEM
[    0.000000]   #39 [0001ca2e40 - 0001ca2ea8]         BOOTMEM
[    0.000000]   #40 [0001ca2ec0 - 0001ca2f28]         BOOTMEM
[    0.000000]   #41 [0001ca2f40 - 0001ca2fa8]         BOOTMEM
[    0.000000]   #42 [0001ca4000 - 0001ca4068]         BOOTMEM
[    0.000000]   #43 [0001ca4080 - 0001ca40e8]         BOOTMEM
[    0.000000]   #44 [0001ca4100 - 0001ca4168]         BOOTMEM
[    0.000000]   #45 [0001ca4180 - 0001ca41e8]         BOOTMEM
[    0.000000]   #46 [0001ca4200 - 0001ca4268]         BOOTMEM
[    0.000000]   #47 [0001ca4280 - 0001ca42e8]         BOOTMEM
[    0.000000]   #48 [0001ca4300 - 0001ca4368]         BOOTMEM
[    0.000000]   #49 [0001ca4380 - 0001ca43e8]         BOOTMEM
[    0.000000]   #50 [0001ca4400 - 0001ca4468]         BOOTMEM
[    0.000000]   #51 [0001ca4480 - 0001ca44e8]         BOOTMEM
[    0.000000]   #52 [0001ca4500 - 0001ca4568]         BOOTMEM
[    0.000000]   #53 [0001ca4580 - 0001ca45e8]         BOOTMEM
[    0.000000]   #54 [0001ca4600 - 0001ca4668]         BOOTMEM
[    0.000000]   #55 [0001c58fc0 - 0001c58fe0]         BOOTMEM
[    0.000000]   #56 [0001ca2fc0 - 0001ca2fe0]         BOOTMEM
[    0.000000]   #57 [0001ca4680 - 0001ca46a0]         BOOTMEM
[    0.000000]   #58 [0001ca46c0 - 0001ca46e0]         BOOTMEM
[    0.000000]   #59 [0001ca4700 - 0001ca4720]         BOOTMEM
[    0.000000]   #60 [0001ca4740 - 0001ca4760]         BOOTMEM
[    0.000000]   #61 [0001ca4780 - 0001ca47a0]         BOOTMEM
[    0.000000]   #62 [0001ca47c0 - 0001ca47e0]         BOOTMEM
[    0.000000]   #63 [0001ca4800 - 0001ca4861]         BOOTMEM
[    0.000000]   #64 [0001ca4880 - 0001ca48e1]         BOOTMEM
[    0.000000]   #65 [0001e00000 - 0001e1d000]         BOOTMEM
[    0.000000]   #66 [0001e40000 - 0001e5d000]         BOOTMEM
[    0.000000]   #67 [0001e80000 - 0001e9d000]         BOOTMEM
[    0.000000]   #68 [0001ec0000 - 0001edd000]         BOOTMEM
[    0.000000]   #69 [0001f00000 - 0001f1d000]         BOOTMEM
[    0.000000]   #70 [0001f40000 - 0001f5d000]         BOOTMEM
[    0.000000]   #71 [0001f80000 - 0001f9d000]         BOOTMEM
[    0.000000]   #72 [0001fc0000 - 0001fdd000]         BOOTMEM
[    0.000000]   #73 [0001ca6900 - 0001ca6908]         BOOTMEM
[    0.000000]   #74 [0001ca6940 - 0001ca6948]         BOOTMEM
[    0.000000]   #75 [0001ca6980 - 0001ca69a0]         BOOTMEM
[    0.000000]   #76 [0001ca69c0 - 0001ca6a00]         BOOTMEM
[    0.000000]   #77 [0001ca6a00 - 0001ca6b20]         BOOTMEM
[    0.000000]   #78 [0001ca6b40 - 0001ca6b88]         BOOTMEM
[    0.000000]   #79 [0001ca6bc0 - 0001ca6c08]         BOOTMEM
[    0.000000]   #80 [0001ca6c40 - 0001caec40]         BOOTMEM
[    0.000000]   #81 [0001fdd000 - 0005fdd000]         BOOTMEM
[    0.000000]   #82 [0001caec40 - 0001ccec40]         BOOTMEM
[    0.000000]   #83 [0001ccec40 - 0001d0ec40]         BOOTMEM
[    0.000000]   #84 [000000f000 - 0000017000]         BOOTMEM
[    0.000000] Memory: 6050768k/7208960k available (4478k kernel code, 986588k absent, 171604k reserved, 6543k data, 544k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:4352 nr_irqs:744
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 62914560 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.003333] Detected 1728.938 MHz processor.
[    0.000009] Calibrating delay loop (skipped), value calculated using timer frequency.. 3459.95 BogoMIPS (lpj=5763126)
[    0.000013] pid_max: default: 32768 minimum: 301
[    0.000034] Security Framework initialized
[    0.000046] AppArmor: AppArmor initialized
[    0.000885] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.003238] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.004169] Mount-cache hash table entries: 256
[    0.004289] Initializing cgroup subsys ns
[    0.004292] Initializing cgroup subsys cpuacct
[    0.004297] Initializing cgroup subsys memory
[    0.004305] Initializing cgroup subsys devices
[    0.004307] Initializing cgroup subsys freezer
[    0.004309] Initializing cgroup subsys net_cls
[    0.004311] Initializing cgroup subsys blkio
[    0.004332] CPU: Physical Processor ID: 0
[    0.004333] CPU: Processor Core ID: 0
[    0.004339] mce: CPU supports 9 MCE banks
[    0.004348] CPU0: Thermal monitoring handled by SMI
[    0.004355] using mwait in idle threads.
[    0.004357] Performance Events: PEBS fmt1+, Nehalem events, Intel PMU driver.
[    0.004363] ... version:                3
[    0.004364] ... bit width:              48
[    0.004366] ... generic registers:      4
[    0.004368] ... value mask:             0000ffffffffffff
[    0.004369] ... max period:             000000007fffffff
[    0.004371] ... fixed-purpose events:   3
[    0.004373] ... event mask:             000000070000000f
[    0.005427] ACPI: Core revision 20100702
[    0.024404] Setting APIC routing to flat
[    0.024787] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.057776] CPU0: Intel(R) Core(TM) i7 CPU       Q 740  @ 1.73GHz stepping 05
[    0.161565] Booting Node   0, Processors  #1
[    0.254732] CPU1: Thermal monitoring handled by SMI
[    0.274889]  #2
[    0.368012] CPU2: Thermal monitoring handled by SMI
[    0.388105]  #3
[    0.481292] CPU3: Thermal monitoring handled by SMI
[    0.501425]  #4
[    0.594574] CPU4: Thermal monitoring handled by SMI
[    0.614736]  #5
[    0.707851] CPU5: Thermal monitoring handled by SMI
[    0.727954]  #6
[    0.821132] CPU6: Thermal monitoring handled by SMI
[    0.841279]  #7 Ok.
[    0.934412] CPU7: Thermal monitoring handled by SMI
[    0.954438] Brought up 8 CPUs
[    0.954441] Total of 8 processors activated (27674.56 BogoMIPS).
[    0.957886] devtmpfs: initialized
[    0.962607] regulator: core version 0.5
[    0.962648] NET: Registered protocol family 16
[    0.962758] ACPI: bus type pci registered
[    0.962844] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.962848] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    1.024889] PCI: Using configuration type 1 for base access
[    1.026113] bio: create slab <bio-0> at 0
[    1.027617] ACPI: EC: Look up EC in DSDT
[    1.035703] ACPI: BIOS _OSI(Linux) query ignored
[    1.037086] ACPI: SSDT 00000000c3f1aa98 0032A (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
[    1.037471] ACPI: Dynamic OEM Table Load:
[    1.037475] ACPI: SSDT (null) 0032A (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
[    1.037837] ACPI: SSDT 00000000c3f19018 008B0 (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
[    1.038166] ACPI: Dynamic OEM Table Load:
[    1.038170] ACPI: SSDT (null) 008B0 (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
[    1.038673] ACPI: SSDT 00000000c3f1a718 00303 (v01  PmRef    ApIst 00003000 INTL 20060912)
[    1.039094] ACPI: Dynamic OEM Table Load:
[    1.039098] ACPI: SSDT (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20060912)
[    1.039288] ACPI: SSDT 00000000c3f18d98 00119 (v01  PmRef    ApCst 00003000 INTL 20060912)
[    1.039647] ACPI: Dynamic OEM Table Load:
[    1.039650] ACPI: SSDT (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20060912)
[    1.041574] ACPI: Interpreter enabled
[    1.041577] ACPI: (supports S0 S3 S4 S5)
[    1.041602] ACPI: Using IOAPIC for interrupt routing
[    1.042123] [Firmware Bug]: ACPI: ACPI brightness control misses _BQC function
[    1.042286] [Firmware Bug]: ACPI: ACPI brightness control misses _BQC function
[    1.049152] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    1.049199] ACPI: Power Resource [FN00] (off)
[    1.049220] ACPI: Power Resource [FN01] (off)
[    1.049448] ACPI: No dock devices found.
[    1.049451] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.050201] \_SB_.PCI0:_OSC invalid UUID
[    1.050203] _OSC request data:1 8 1f 
[    1.050208] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    1.051499] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.051502] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.051505] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.051508] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000d3fff]
[    1.051511] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff]
[    1.051514] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff]
[    1.051517] pci_root PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff]
[    1.051521] pci_root PNP0A08:00: host bridge window [mem 0xc8000000-0xdfffffff]
[    1.051524] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfebfffff]
[    1.051629] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.051633] pci 0000:00:03.0: PME# disabled
[    1.052029] pci 0000:00:16.0: reg 10: [mem 0xf0b05800-0xf0b0580f 64bit]
[    1.052106] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.052115] pci 0000:00:16.0: PME# disabled
[    1.052184] pci 0000:00:1a.0: reg 10: [mem 0xf0b06000-0xf0b063ff]
[    1.052263] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.052272] pci 0000:00:1a.0: PME# disabled
[    1.052317] pci 0000:00:1b.0: reg 10: [mem 0xf0b00000-0xf0b03fff 64bit]
[    1.052378] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.052386] pci 0000:00:1b.0: PME# disabled
[    1.052472] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.052481] pci 0000:00:1c.0: PME# disabled
[    1.052573] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.052582] pci 0000:00:1c.1: PME# disabled
[    1.052675] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.052683] pci 0000:00:1c.3: PME# disabled
[    1.052775] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.052784] pci 0000:00:1c.4: PME# disabled
[    1.052875] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.052884] pci 0000:00:1c.5: PME# disabled
[    1.052947] pci 0000:00:1d.0: reg 10: [mem 0xf0b06400-0xf0b067ff]
[    1.053025] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.053034] pci 0000:00:1d.0: PME# disabled
[    1.053285] pci 0000:00:1f.2: reg 10: [io  0x1830-0x1837]
[    1.053298] pci 0000:00:1f.2: reg 14: [io  0x1824-0x1827]
[    1.053311] pci 0000:00:1f.2: reg 18: [io  0x1828-0x182f]
[    1.053324] pci 0000:00:1f.2: reg 1c: [io  0x1820-0x1823]
[    1.053337] pci 0000:00:1f.2: reg 20: [io  0x1800-0x181f]
[    1.053350] pci 0000:00:1f.2: reg 24: [mem 0xf0b05000-0xf0b057ff]
[    1.053393] pci 0000:00:1f.2: PME# supported from D3hot
[    1.053402] pci 0000:00:1f.2: PME# disabled
[    1.053450] pci 0000:00:1f.3: reg 10: [mem 0xf0b06800-0xf0b068ff 64bit]
[    1.053476] pci 0000:00:1f.3: reg 20: [io  0x1840-0x185f]
[    1.053559] pci 0000:02:00.0: reg 10: [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.053571] pci 0000:02:00.0: reg 18: [mem 0xcfee0000-0xcfefffff 64bit]
[    1.053580] pci 0000:02:00.0: reg 20: [io  0x2000-0x20ff]
[    1.053594] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    1.053613] pci 0000:02:00.0: supports D1 D2
[    1.053644] pci 0000:02:00.1: reg 10: [mem 0xcfedc000-0xcfedffff 64bit]
[    1.053692] pci 0000:02:00.1: supports D1 D2
[    1.057806] pci 0000:00:03.0: PCI bridge to [bus 02-02]
[    1.057810] pci 0000:00:03.0:   bridge window [io  0x2000-0x2fff]
[    1.057814] pci 0000:00:03.0:   bridge window [mem 0xcfe00000-0xcfefffff]
[    1.057819] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.057870] pci 0000:00:1c.0: PCI bridge to [bus 03-03]
[    1.057879] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.057888] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.057899] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.058169] pci 0000:04:00.0: reg 10: [mem 0xf0500000-0xf0503fff 64bit]
[    1.058592] pci 0000:04:00.0: supports D1 D2
[    1.058595] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.058609] pci 0000:04:00.0: PME# disabled
[    1.058827] pci 0000:00:1c.1: PCI bridge to [bus 04-04]
[    1.058836] pci 0000:00:1c.1:   bridge window [io  0xf000-0x0000] (disabled)
[    1.058845] pci 0000:00:1c.1:   bridge window [mem 0xf0500000-0xf05fffff]
[    1.058856] pci 0000:00:1c.1:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.058907] pci 0000:00:1c.3: PCI bridge to [bus 05-06]
[    1.058916] pci 0000:00:1c.3:   bridge window [io  0x3000-0x3fff]
[    1.058925] pci 0000:00:1c.3:   bridge window [mem 0xf0600000-0xf06fffff]
[    1.058936] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf01fffff 64bit pref]
[    1.059030] pci 0000:07:00.0: reg 10: [mem 0xf0700000-0xf07000ff]
[    1.059146] pci 0000:07:00.0: supports D1 D2
[    1.059148] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.059158] pci 0000:07:00.0: PME# disabled
[    1.059223] pci 0000:07:00.1: reg 10: [mem 0xf0800800-0xf08008ff]
[    1.059339] pci 0000:07:00.1: supports D1 D2
[    1.059341] pci 0000:07:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    1.059351] pci 0000:07:00.1: PME# disabled
[    1.059414] pci 0000:07:00.2: reg 10: [mem 0xf0800c00-0xf0800cff]
[    1.059531] pci 0000:07:00.2: supports D1 D2
[    1.059533] pci 0000:07:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    1.059542] pci 0000:07:00.2: PME# disabled
[    1.064492] pci 0000:00:1c.4: PCI bridge to [bus 07-08]
[    1.064501] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    1.064510] pci 0000:00:1c.4:   bridge window [mem 0xf0700000-0xf08fffff]
[    1.064521] pci 0000:00:1c.4:   bridge window [mem 0xf0200000-0xf03fffff 64bit pref]
[    1.064607] pci 0000:09:00.0: reg 10: [io  0x5000-0x50ff]
[    1.064640] pci 0000:09:00.0: reg 18: [mem 0xf0404000-0xf0404fff 64bit pref]
[    1.064664] pci 0000:09:00.0: reg 20: [mem 0xf0400000-0xf0403fff 64bit pref]
[    1.064681] pci 0000:09:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    1.064729] pci 0000:09:00.0: supports D1 D2
[    1.064731] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.064741] pci 0000:09:00.0: PME# disabled
[    1.071178] pci 0000:00:1c.5: PCI bridge to [bus 09-09]
[    1.071187] pci 0000:00:1c.5:   bridge window [io  0x5000-0x5fff]
[    1.071196] pci 0000:00:1c.5:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.071207] pci 0000:00:1c.5:   bridge window [mem 0xf0400000-0xf04fffff 64bit pref]
[    1.071279] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a] (subtractive decode)
[    1.071288] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.071297] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.071308] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.071311] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    1.071314] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    1.071317] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.071320] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000d3fff] (subtractive decode)
[    1.071323] pci 0000:00:1e.0:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    1.071326] pci 0000:00:1e.0:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    1.071329] pci 0000:00:1e.0:   bridge window [mem 0x000dc000-0x000dffff] (subtractive decode)
[    1.071332] pci 0000:00:1e.0:   bridge window [mem 0xc8000000-0xdfffffff] (subtractive decode)
[    1.071335] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfebfffff] (subtractive decode)
[    1.071374] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.071701] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    1.071788] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    1.071948] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.072029] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.072111] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    1.072195] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    1.072276] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    1.072391] \_SB_.PCI0:_OSC invalid UUID
[    1.072392] _OSC request data:1 1f 1f 
[    1.072449] \_SB_.PCI0:_OSC invalid UUID
[    1.072451] _OSC request data:1 0 1f 
[    1.072454] Unable to assume PCIe control: Disabling ASPM
[    1.078277] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus ff])
[    1.078655] Unable to assume PCIe control: Disabling ASPM
[    1.079231] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    1.079308] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *7 11 12 14 15)
[    1.079383] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.079457] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    1.079531] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    1.079606] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.079682] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.079756] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    1.079795] HEST: Table is not found!
[    1.079857] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.079868] vgaarb: loaded
[    1.079944] SCSI subsystem initialized
[    1.079946] libata version 3.00 loaded.
[    1.080006] PCI: Using ACPI for IRQ routing
[    1.080008] PCI: pci_cache_line_size set to 64 bytes
[    1.080307] reserve RAM buffer: 000000000009c400 - 000000000009ffff 
[    1.080310] reserve RAM buffer: 00000000c3a7c000 - 00000000c3ffffff 
[    1.080315] reserve RAM buffer: 00000000c3be5000 - 00000000c3ffffff 
[    1.080319] reserve RAM buffer: 00000000c3c6f000 - 00000000c3ffffff 
[    1.080323] reserve RAM buffer: 00000000c3f18000 - 00000000c3ffffff 
[    1.080327] reserve RAM buffer: 00000000c3f81000 - 00000000c3ffffff 
[    1.080330] reserve RAM buffer: 00000000c3fe2000 - 00000000c3ffffff 
[    1.080425]   alloc irq_desc for 40 on node 0
[    1.080427]   alloc kstat_irqs on node 0
[    1.080438]   alloc irq_desc for 41 on node 0
[    1.080439]   alloc kstat_irqs on node 0
[    1.080447]   alloc irq_desc for 42 on node 0
[    1.080449]   alloc kstat_irqs on node 0
[    1.080458]   alloc irq_desc for 43 on node 0
[    1.080459]   alloc kstat_irqs on node 0
[    1.080467]   alloc irq_desc for 44 on node 0
[    1.080469]   alloc kstat_irqs on node 0
[    1.080472] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    1.080482] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 40, 41, 42, 43, 44, 0
[    1.080488] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.084442] hpet: hpet2 irq 40 for MSI
[    1.084558] hpet: hpet3 irq 41 for MSI
[    1.087846] hpet: hpet4 irq 42 for MSI
[    1.091201] hpet: hpet5 irq 43 for MSI
[    1.094553] hpet: hpet6 irq 44 for MSI
[    1.104535] Switching to clocksource tsc
[    1.106558] FS-Cache: Loaded
[    1.106595] CacheFiles: Loaded
[    1.106613] AppArmor: AppArmor Filesystem Enabled
[    1.106621] pnp: PnP ACPI init
[    1.106632] ACPI: bus type pnp registered
[    1.108637]   alloc irq_desc for 20 on node 0
[    1.108639]   alloc kstat_irqs on node 0
[    1.109519] pnp: PnP ACPI: found 12 devices
[    1.109521] ACPI: ACPI bus type pnp unregistered
[    1.109532] system 00:05: [io  0x0680-0x069f] has been reserved
[    1.109535] system 00:05: [io  0x0500-0x050f] has been reserved
[    1.109538] system 00:05: [io  0x0600-0x0603] has been reserved
[    1.109541] system 00:05: [io  0xffff] has been reserved
[    1.109544] system 00:05: [io  0x0400-0x047f] has been reserved
[    1.109547] system 00:05: [io  0x1180-0x11ff] has been reserved
[    1.109550] system 00:05: [io  0x164e-0x164f] has been reserved
[    1.109553] system 00:05: [io  0xfe00] has been reserved
[    1.109560] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.109564] system 00:09: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    1.109567] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
[    1.109570] system 00:09: [mem 0xf0b04000-0xf0b04fff] has been reserved
[    1.109573] system 00:09: [mem 0xc8000000-0xc8000fff] has been reserved
[    1.109576] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.109580] system 00:09: [mem 0xfed40000-0xfed44fff] has been reserved
[    1.109583] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.109586] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    1.109589] system 00:09: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.115860] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc8100000-0xc82fffff]
[    1.115865] pci 0000:00:1c.0: BAR 15: assigned [mem 0xc8300000-0xc84fffff 64bit pref]
[    1.115869] pci 0000:00:1c.1: BAR 15: assigned [mem 0xc8500000-0xc86fffff 64bit pref]
[    1.115872] pci 0000:00:1c.5: BAR 14: assigned [mem 0xc8700000-0xc8afffff]
[    1.115876] pci 0000:00:1c.0: BAR 13: assigned [io  0x6000-0x6fff]
[    1.115879] pci 0000:00:1c.1: BAR 13: assigned [io  0x7000-0x7fff]
[    1.115883] pci 0000:02:00.0: BAR 6: assigned [mem 0xcfe00000-0xcfe1ffff pref]
[    1.115886] pci 0000:00:03.0: PCI bridge to [bus 02-02]
[    1.115889] pci 0000:00:03.0:   bridge window [io  0x2000-0x2fff]
[    1.115894] pci 0000:00:03.0:   bridge window [mem 0xcfe00000-0xcfefffff]
[    1.115898] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.115903] pci 0000:00:1c.0: PCI bridge to [bus 03-03]
[    1.115911] pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
[    1.115920] pci 0000:00:1c.0:   bridge window [mem 0xc8100000-0xc82fffff]
[    1.115930] pci 0000:00:1c.0:   bridge window [mem 0xc8300000-0xc84fffff 64bit pref]
[    1.115941] pci 0000:00:1c.1: PCI bridge to [bus 04-04]
[    1.115948] pci 0000:00:1c.1:   bridge window [io  0x7000-0x7fff]
[    1.115958] pci 0000:00:1c.1:   bridge window [mem 0xf0500000-0xf05fffff]
[    1.115967] pci 0000:00:1c.1:   bridge window [mem 0xc8500000-0xc86fffff 64bit pref]
[    1.115978] pci 0000:00:1c.3: PCI bridge to [bus 05-06]
[    1.115986] pci 0000:00:1c.3:   bridge window [io  0x3000-0x3fff]
[    1.115996] pci 0000:00:1c.3:   bridge window [mem 0xf0600000-0xf06fffff]
[    1.116005] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf01fffff 64bit pref]
[    1.116016] pci 0000:00:1c.4: PCI bridge to [bus 07-08]
[    1.116024] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    1.116034] pci 0000:00:1c.4:   bridge window [mem 0xf0700000-0xf08fffff]
[    1.116043] pci 0000:00:1c.4:   bridge window [mem 0xf0200000-0xf03fffff 64bit pref]
[    1.116055] pci 0000:09:00.0: BAR 6: assigned [mem 0xf0420000-0xf043ffff pref]
[    1.116057] pci 0000:00:1c.5: PCI bridge to [bus 09-09]
[    1.116065] pci 0000:00:1c.5:   bridge window [io  0x5000-0x5fff]
[    1.116075] pci 0000:00:1c.5:   bridge window [mem 0xc8700000-0xc8afffff]
[    1.116084] pci 0000:00:1c.5:   bridge window [mem 0xf0400000-0xf04fffff 64bit pref]
[    1.116095] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a]
[    1.116097] pci 0000:00:1e.0:   bridge window [io  disabled]
[    1.116106] pci 0000:00:1e.0:   bridge window [mem disabled]
[    1.116114] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    1.116130]   alloc irq_desc for 16 on node -1
[    1.116132]   alloc kstat_irqs on node -1
[    1.116138] pci 0000:00:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.116142] pci 0000:00:03.0: setting latency timer to 64
[    1.116155] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.116164] pci 0000:00:1c.0: setting latency timer to 64
[    1.116176]   alloc irq_desc for 17 on node -1
[    1.116178]   alloc kstat_irqs on node -1
[    1.116182] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.116187] pci 0000:00:1c.1: setting latency timer to 64
[    1.116203]   alloc irq_desc for 19 on node -1
[    1.116205]   alloc kstat_irqs on node -1
[    1.116209] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    1.116214] pci 0000:00:1c.3: setting latency timer to 64
[    1.116227] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.116236] pci 0000:00:1c.4: setting latency timer to 64
[    1.116248] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.116257] pci 0000:00:1c.5: setting latency timer to 64
[    1.116273] pci 0000:00:1e.0: setting latency timer to 64
[    1.116282] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.116284] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.116287] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.116289] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    1.116292] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    1.116294] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    1.116297] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff]
[    1.116299] pci_bus 0000:00: resource 11 [mem 0xc8000000-0xdfffffff]
[    1.116302] pci_bus 0000:00: resource 12 [mem 0xf0000000-0xfebfffff]
[    1.116304] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    1.116307] pci_bus 0000:02: resource 1 [mem 0xcfe00000-0xcfefffff]
[    1.116310] pci_bus 0000:02: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.116312] pci_bus 0000:03: resource 0 [io  0x6000-0x6fff]
[    1.116315] pci_bus 0000:03: resource 1 [mem 0xc8100000-0xc82fffff]
[    1.116317] pci_bus 0000:03: resource 2 [mem 0xc8300000-0xc84fffff 64bit pref]
[    1.116320] pci_bus 0000:04: resource 0 [io  0x7000-0x7fff]
[    1.116322] pci_bus 0000:04: resource 1 [mem 0xf0500000-0xf05fffff]
[    1.116325] pci_bus 0000:04: resource 2 [mem 0xc8500000-0xc86fffff 64bit pref]
[    1.116328] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    1.116330] pci_bus 0000:05: resource 1 [mem 0xf0600000-0xf06fffff]
[    1.116333] pci_bus 0000:05: resource 2 [mem 0xf0000000-0xf01fffff 64bit pref]
[    1.116335] pci_bus 0000:07: resource 0 [io  0x4000-0x4fff]
[    1.116338] pci_bus 0000:07: resource 1 [mem 0xf0700000-0xf08fffff]
[    1.116340] pci_bus 0000:07: resource 2 [mem 0xf0200000-0xf03fffff 64bit pref]
[    1.116343] pci_bus 0000:09: resource 0 [io  0x5000-0x5fff]
[    1.116345] pci_bus 0000:09: resource 1 [mem 0xc8700000-0xc8afffff]
[    1.116348] pci_bus 0000:09: resource 2 [mem 0xf0400000-0xf04fffff 64bit pref]
[    1.116351] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7]
[    1.116353] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff]
[    1.116356] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff]
[    1.116358] pci_bus 0000:0a: resource 7 [mem 0x000d0000-0x000d3fff]
[    1.116361] pci_bus 0000:0a: resource 8 [mem 0x000d4000-0x000d7fff]
[    1.116363] pci_bus 0000:0a: resource 9 [mem 0x000d8000-0x000dbfff]
[    1.116366] pci_bus 0000:0a: resource 10 [mem 0x000dc000-0x000dffff]
[    1.116368] pci_bus 0000:0a: resource 11 [mem 0xc8000000-0xdfffffff]
[    1.116371] pci_bus 0000:0a: resource 12 [mem 0xf0000000-0xfebfffff]
[    1.116401] NET: Registered protocol family 2
[    1.116646] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.117802] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.121109] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.121524] TCP: Hash tables configured (established 524288 bind 65536)
[    1.121527] TCP reno registered
[    1.121545] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.121632] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.121807] NET: Registered protocol family 1
[    1.121983] pci 0000:02:00.0: Boot video device
[    1.122076] PCI: CLS 64 bytes, default 64
[    1.122119] Unpacking initramfs...
[    1.213841] Freeing initrd memory: 3596k freed
[    1.214367] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.214370] Placing 64MB software IO TLB between ffff880001fdd000 - ffff880005fdd000
[    1.214373] software IO TLB at phys 0x1fdd000 - 0x5fdd000
[    1.214615] Simple Boot Flag at 0x36 set to 0x1
[    1.215117] microcode: CPU0 sig=0x106e5, pf=0x10, revision=0x3
[    1.215124] microcode: CPU1 sig=0x106e5, pf=0x10, revision=0x3
[    1.215131] microcode: CPU2 sig=0x106e5, pf=0x10, revision=0x3
[    1.215137] microcode: CPU3 sig=0x106e5, pf=0x10, revision=0x3
[    1.215143] microcode: CPU4 sig=0x106e5, pf=0x10, revision=0x3
[    1.215149] microcode: CPU5 sig=0x106e5, pf=0x10, revision=0x3
[    1.215156] microcode: CPU6 sig=0x106e5, pf=0x10, revision=0x3
[    1.215163] microcode: CPU7 sig=0x106e5, pf=0x10, revision=0x3
[    1.215192] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.215294] audit: initializing netlink socket (disabled)
[    1.215304] type=2000 audit(1283728850.996:1): initialized
[    1.240697] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.242243] VFS: Disk quotas dquot_6.5.2
[    1.242295] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.242626] ROMFS MTD (C) 2007 Red Hat, Inc.
[    1.242656] msgmni has been set to 11824
[    1.242768] alg: No test for cipher_null (cipher_null-generic)
[    1.242791] alg: No test for ecb(cipher_null) (ecb-cipher_null)
[    1.242814] alg: No test for digest_null (digest_null-generic)
[    1.242836] alg: No test for compress_null (compress_null-generic)
[    1.243474] alg: No test for stdrng (krng)
[    1.243553] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.243556] io scheduler noop registered
[    1.243558] io scheduler deadline registered
[    1.243594] io scheduler cfq registered (default)
[    1.243698] pcieport 0000:00:03.0: setting latency timer to 64
[    1.243725]   alloc irq_desc for 45 on node -1
[    1.243727]   alloc kstat_irqs on node -1
[    1.243736] pcieport 0000:00:03.0: irq 45 for MSI/MSI-X
[    1.243809] pcieport 0000:00:1c.0: setting latency timer to 64
[    1.243844]   alloc irq_desc for 46 on node -1
[    1.243845]   alloc kstat_irqs on node -1
[    1.243857] pcieport 0000:00:1c.0: irq 46 for MSI/MSI-X
[    1.243942] pcieport 0000:00:1c.1: setting latency timer to 64
[    1.243977]   alloc irq_desc for 47 on node -1
[    1.243979]   alloc kstat_irqs on node -1
[    1.243990] pcieport 0000:00:1c.1: irq 47 for MSI/MSI-X
[    1.244077] pcieport 0000:00:1c.3: setting latency timer to 64
[    1.244112]   alloc irq_desc for 48 on node -1
[    1.244114]   alloc kstat_irqs on node -1
[    1.244125] pcieport 0000:00:1c.3: irq 48 for MSI/MSI-X
[    1.244213] pcieport 0000:00:1c.4: setting latency timer to 64
[    1.244249]   alloc irq_desc for 49 on node -1
[    1.244250]   alloc kstat_irqs on node -1
[    1.244262] pcieport 0000:00:1c.4: irq 49 for MSI/MSI-X
[    1.244348] pcieport 0000:00:1c.5: setting latency timer to 64
[    1.244383]   alloc irq_desc for 50 on node -1
[    1.244384]   alloc kstat_irqs on node -1
[    1.244395] pcieport 0000:00:1c.5: irq 50 for MSI/MSI-X
[    1.244572] \_SB_.PCI0:_OSC invalid UUID
[    1.244574] _OSC request data:1 0 1f 
[    1.244578] aer 0000:00:03.0:pcie02: AER service couldn't init device: _OSC failed
[    1.244676] intel_idle: MWAIT substates: 0x1120
[    1.244678] intel_idle: v0.4 model 0x1E
[    1.244679] intel_idle: lapic_timer_reliable_states 0x2
[    1.244797] ACPI: AC Adapter [ADP1] (on-line)
[    1.244867] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.244871] ACPI: Power Button [PWRB]
[    1.244915] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    1.244919] ACPI: Sleep Button [SLPB]
[    1.244963] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    1.245791] ACPI: Lid Switch [LID0]
[    1.245838] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.245842] ACPI: Power Button [PWRF]
[    1.245928] ACPI: Fan [FAN0] (off)
[    1.245981] ACPI: Fan [FAN1] (off)
[    1.246115] [Firmware Bug]: ACPI: ACPI brightness control misses _BQC function
[    1.254186] acpi device:02: registered as cooling_device2
[    1.254269] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00/input/input4
[    1.254275] ACPI: Video Device [M86] (multi-head: yes  rom: no  post: no)
[    1.254551] ACPI: acpi_idle yielding to intel_idle
[    1.257332] thermal LNXTHERM:01: registered as thermal_zone0
[    1.257339] ACPI: Thermal Zone [TZ00] (27 C)
[    1.257761] thermal LNXTHERM:02: registered as thermal_zone1
[    1.257772] ACPI: Thermal Zone [TZ01] (0 C)
[    1.257798] ERST: Table is not found!
[    1.258785] Non-volatile memory driver v1.3
[    1.258787] Linux agpgart interface v0.103
[    1.258838] [drm] Initialized drm 1.1.0 20060810
[    1.258854] [drm] radeon defaulting to kernel modesetting.
[    1.258856] [drm] radeon kernel modesetting enabled.
[    1.258899] radeon 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.258904] radeon 0000:02:00.0: setting latency timer to 64
[    1.261478] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68E0).
[    1.261573] [drm] register mmio base: 0xCFEE0000
[    1.261575] [drm] register mmio size: 131072
[    1.261856] ATOM BIOS: Dell
[    1.261915] [drm] Clocks initialized !
[    1.261930] radeon 0000:02:00.0: VRAM: 1024M 0x00000000 - 0x3FFFFFFF (1024M used)
[    1.261936] radeon 0000:02:00.0: GTT: 512M 0x40000000 - 0x5FFFFFFF
[    1.261960] mtrr: no more MTRRs available
[    1.261962] [drm] Detected VRAM RAM=1024M, BAR=256M
[    1.261964] [drm] RAM width 64bits DDR
[    1.261992] [TTM] Zone  kernel: Available graphics memory: 3027182 kiB.
[    1.261995] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
[    1.261996] [TTM] Initializing pool allocator.
[    1.262011] [drm] radeon: 1024M of VRAM memory ready
[    1.262013] [drm] radeon: 512M of GTT memory ready.
[    1.262047]   alloc irq_desc for 51 on node -1
[    1.262049]   alloc kstat_irqs on node -1
[    1.262059] radeon 0000:02:00.0: irq 51 for MSI/MSI-X
[    1.262065] radeon 0000:02:00.0: radeon: using MSI.
[    1.262098] [drm] radeon: irq initialized.
[    1.262100] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    1.262876] [drm] Loading CEDAR Microcode
[    1.272540] ACPI: Battery Slot [BAT0] (battery present)
[    1.282496] [drm] ring test succeeded in 1 usecs
[    1.282627] [drm] radeon: ib pool ready.
[    1.282703] [drm] ib test succeeded in 0 usecs
[    1.283144] [drm] Radeon Display Connectors
[    1.283146] [drm] Connector 0:
[    1.283147] [drm]   LVDS
[    1.283149] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    1.283151] [drm]   Encoders:
[    1.283153] [drm]     LCD1: INTERNAL_UNIPHY
[    1.283154] [drm] Connector 1:
[    1.283156] [drm]   HDMI-A
[    1.283157] [drm]   HPD1
[    1.283159] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    1.283161] [drm]   Encoders:
[    1.283162] [drm]     DFP1: INTERNAL_UNIPHY1
[    1.283164] [drm] Connector 2:
[    1.283165] [drm]   VGA
[    1.283167] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    1.283169] [drm]   Encoders:
[    1.283170] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    1.351442] [drm] Internal thermal controller with fan control
[    1.351477] [drm] radeon: power management initialized
[    1.800100] [drm] fb mappable at 0xD0140000
[    1.800102] [drm] vram apper at 0xD0000000
[    1.800103] [drm] size 8294400
[    1.800105] [drm] fb depth is 24
[    1.800106] [drm]    pitch is 7680
[    2.776724] ACPI: resource 0000:00:1f.3 [io  0x1840-0x185f] conflicts with ACPI region SMBI [bus 1840-184f pref window disabled]
[    2.776727] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    4.145141] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    7.294793] ACPI: WMI: Mapper loaded
[   14.379461] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input18
[47984.081747] ACPI handle has no context!
[47985.101449] r8169 0000:09:00.0: wake-up capability enabled by ACPI
[47985.141546] ACPI: Preparing to enter system sleep state S3
[47993.481094] [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs aborting
[47993.481097] [drm:atom_execute_table_locked] *ERROR* atombios stuck executing CA04 (len 62, WS 0, PS 0) @ 0xCA20
[47998.488800] [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs aborting
[47998.488803] [drm:atom_execute_table_locked] *ERROR* atombios stuck executing CA04 (len 62, WS 0, PS 0) @ 0xCA20
[47998.488806] [drm:atom_execute_table_locked] *ERROR* atombios stuck executing C0DE (len 861, WS 0, PS 0) @ 0xC13B
[47998.512698] ACPI: Waking up from system sleep state S3
[47998.531161] r8169 0000:09:00.0: wake-up capability disabled by ACPI
[48003.756388] [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs aborting
[48003.756390] [drm:atom_execute_table_locked] *ERROR* atombios stuck executing CDD4 (len 72, WS 0, PS 0) @ 0xCE03
[48008.794080] [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs aborting
[48008.794083] [drm:atom_execute_table_locked] *ERROR* atombios stuck executing C9C0 (len 67, WS 0, PS 0) @ 0xC9EF


-- 
------------------------------------------------------------------------
andrew (AT) morphoss (DOT) com                            +64(272)DEBIAN
   Let us not seek to satisfy our thirst for freedom by drinking from
      the cup of bitterness and hatred. -- Martin luther King Jr.

------------------------------------------------------------------------


