From: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI problems, Dell XPS 15z laptop
Date: Mon, 26 Dec 2011 22:42:06 -0300
Message-ID: <4EF9226E.1050209@opensuse.org>
References: <4EF79074.90605@opensuse.org> <4EF7BDBC.9000406@opensuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <opensuse-kernel+bounces-3316-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Sender: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cr-PbW9x2wNDCQv87aORUpqLDJOH4l1HDhQ@public.gmane.org>
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
In-Reply-To: <4EF7BDBC.9000406-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 25/12/11 21:20, Cristian Rodr=EDguez wrote:

> It is random, let's say, the USB port works twice every three boots.

Ok, now back to home after xmas, I have managed to boot the machine with=20
an external USB keyboard attached here is dmesg


problems booting:

Neither touchpad or keyboard works unless I boot with pci=3Dnoapci


     0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000b5a28000 (usable)
[    0.000000]  BIOS-e820: 00000000b5a28000 - 00000000b6e29000 (reserved)
[    0.000000]  BIOS-e820: 00000000b6e29000 - 00000000b886a000 (usable)
[    0.000000]  BIOS-e820: 00000000b886a000 - 00000000b8ab3000 (reserved)
[    0.000000]  BIOS-e820: 00000000b8ab3000 - 00000000bac8f000 (usable)
[    0.000000]  BIOS-e820: 00000000bac8f000 - 00000000bad2e000 (reserved)
[    0.000000]  BIOS-e820: 00000000bad2e000 - 00000000bad3d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bad3d000 - 00000000badfb000 (reserved)
[    0.000000]  BIOS-e820: 00000000badfb000 - 00000000badfd000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000badfd000 - 00000000badff000 (reserved)
[    0.000000]  BIOS-e820: 00000000badff000 - 00000000bae02000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bae02000 - 00000000bae0a000 (reserved)
[    0.000000]  BIOS-e820: 00000000bae0a000 - 00000000bae1b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bae1b000 - 00000000baf18000 (reserved)
[    0.000000]  BIOS-e820: 00000000baf18000 - 00000000baf1c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000baf1c000 - 00000000baf1f000 (reserved)
[    0.000000]  BIOS-e820: 00000000baf1f000 - 00000000baf9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000baf9f000 - 00000000bafff000 (ACPI data=
)
[    0.000000]  BIOS-e820: 00000000bafff000 - 00000000bb000000 (usable)
[    0.000000]  BIOS-e820: 00000000bb000000 - 00000000bfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed08000 - 00000000fed09000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000023fe00000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Dell Inc.          Dell System XPS 15Z/00WW5M, BIOS=20
A08 12/13/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000=20
(usable) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000=20
(usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x23fe00 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0BB000000 mask FFF000000 uncachable
[    0.000000]   5 base 100000000 mask F00000000 write-back
[    0.000000]   6 base 200000000 mask FC0000000 write-back
[    0.000000]   7 base 23FE00000 mask FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new=20
0x7010600070106
[    0.000000] last_pfn =3D 0xbb000 max_arch_pfn =3D 0x400000000
[    0.000000] Scan SMP from ffff880000000000 for 1024 bytes.
[    0.000000] Scan SMP from ffff88000009fc00 for 1024 bytes.
[    0.000000] Scan SMP from ffff8800000f0000 for 65536 bytes.
[    0.000000] Scan SMP from ffff88000009d800 for 1024 bytes.
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20=
480
[    0.000000] init_memory_mapping: 0000000000000000-00000000bb000000
[    0.000000]  0000000000 - 00bb000000 page 2M
[    0.000000] kernel direct mapping tables up to bb000000 @=20
1fffc000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-000000023fe00000
[    0.000000]  0100000000 - 023fe00000 page 2M
[    0.000000] kernel direct mapping tables up to 23fe00000 @=20
bac85000-bac8f000
[    0.000000] RAMDISK: 373d9000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000f00e0 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000baffe120 00094 (v01 DELL    QA09=20
00000002 LOHR 00000002)
[    0.000000] ACPI: FACP 00000000baff0000 000F4 (v03 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: DSDT 00000000baff3000 08A57 (v02 DELL    SNB-CPT=20
00000000 INTL 20061109)
[    0.000000] ACPI: FACS 00000000baf40000 00040
[    0.000000] ACPI: SLIC 00000000baffd000 00176 (v01 DELL    QA09=20
00000002 LOHR 00000001)
[    0.000000] ACPI: SSDT 00000000baffc000 00166 (v01 DELL   PtidDevc=20
00001000 INTL 20061109)
[    0.000000] ACPI: ASF! 00000000baff2000 000A5 (v32 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: HPET 00000000bafef000 00038 (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: APIC 00000000bafee000 00098 (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: MCFG 00000000bafed000 0003C (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: SSDT 00000000bafec000 00B3B (v01 NvORef NvOptTbl=20
00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafeb000 00846 (v01  PmRef  Cpu0Ist=20
00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafea000 00996 (v01  PmRef    CpuPm=20
00003000 INTL 20061109)
[    0.000000] ACPI: UEFI 00000000bafe9000 0003E (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: UEFI 00000000bafe8000 00042 (v01 PTL      COMBUF=20
00000001 PTL  00000001)
[    0.000000] ACPI: DMAR 00000000bafe7000 000E8 (v01 INTEL      SNB=20
00000001 INTL 00000001)
[    0.000000] ACPI: UEFI 00000000bafe6000 0022E (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fa000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000023fe00000
[    0.000000] Initmem setup node 0 0000000000000000-000000023fe00000
[    0.000000]   NODE_DATA [000000023fdec000 - 000000023fdfffff]
[    0.000000]  [ffffea0000000000-ffffea0007dfffff] PMD ->=20
[ffff880237400000-ffff88023e3fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0023fe00
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000b5a28
[    0.000000]     0: 0x000b6e29 -> 0x000b886a
[    0.000000]     0: 0x000b8ab3 -> 0x000bac8f
[    0.000000]     0: 0x000bafff -> 0x000bb000
[    0.000000]     0: 0x00100000 -> 0x0023fe00
[    0.000000] On node 0 totalpages: 2069459
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 740990 pages, LIFO batch:31
[    0.000000]   Normal zone: 17913 pages used for memmap
[    0.000000]   Normal zone: 1292295 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fa000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI=20
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2,=20
APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2,=20
APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2,=20
APIC INT 01
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2,=20
APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2,=20
APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2,=20
APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2,=20
APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2,=20
APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2,=20
APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2,=20
APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2,=20
APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2,=20
APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2,=20
APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2,=20
APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2,=20
APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5f9000 (fec00000)
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 -=20
000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 -=20
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -=20
00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 -=20
0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000b5a28000 -=20
00000000b6e29000
[    0.000000] PM: Registered nosave memory: 00000000b886a000 -=20
00000000b8ab3000
[    0.000000] PM: Registered nosave memory: 00000000bac8f000 -=20
00000000bad2e000
[    0.000000] PM: Registered nosave memory: 00000000bad2e000 -=20
00000000bad3d000
[    0.000000] PM: Registered nosave memory: 00000000bad3d000 -=20
00000000badfb000
[    0.000000] PM: Registered nosave memory: 00000000badfb000 -=20
00000000badfd000
[    0.000000] PM: Registered nosave memory: 00000000badfd000 -=20
00000000badff000
[    0.000000] PM: Registered nosave memory: 00000000badff000 -=20
00000000bae02000
[    0.000000] PM: Registered nosave memory: 00000000bae02000 -=20
00000000bae0a000
[    0.000000] PM: Registered nosave memory: 00000000bae0a000 -=20
00000000bae1b000
[    0.000000] PM: Registered nosave memory: 00000000bae1b000 -=20
00000000baf18000
[    0.000000] PM: Registered nosave memory: 00000000baf18000 -=20
00000000baf1c000
[    0.000000] PM: Registered nosave memory: 00000000baf1c000 -=20
00000000baf1f000
[    0.000000] PM: Registered nosave memory: 00000000baf1f000 -=20
00000000baf9f000
[    0.000000] PM: Registered nosave memory: 00000000baf9f000 -=20
00000000bafff000
[    0.000000] PM: Registered nosave memory: 00000000bb000000 -=20
00000000bfa00000
[    0.000000] PM: Registered nosave memory: 00000000bfa00000 -=20
00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 -=20
00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 -=20
00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 -=20
00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 -=20
00000000fed08000
[    0.000000] PM: Registered nosave memory: 00000000fed08000 -=20
00000000fed09000
[    0.000000] PM: Registered nosave memory: 00000000fed09000 -=20
00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 -=20
00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 -=20
00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 -=20
00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 -=20
00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 -=20
00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 -=20
00000000ffd80000
[    0.000000] PM: Registered nosave memory: 00000000ffd80000 -=20
0000000100000000
[    0.000000] Allocating PCI resources starting at bfa00000 (gap:=20
bfa00000:38600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512=20
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88023fa00000 s79744=20
r8192 d22656 u262144
[    0.000000] pcpu-alloc: s79744 r8192 d22656 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.=20
Total pages: 2037205
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:=20
root=3D/dev/disk/by-uuid/ca00ffff-8c21-4750-b25c-3cf321a07dd9=20
resume=3D/dev/system/swap splash=3Dverbose clocksource=3Dhpet hpet64=20
ipv6.disable=3D1 elevator=3Dnoop acpi.debug_layer=3D0x400000 apic=3Ddebug=
=20
i8042.debug vga=3D0x31b
[    0.000000] bootsplash: verbose mode.
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 8067344k/9435136k available (5935k kernel code,=20
1157300k absent, 210492k reserved, 7648k data, 944k init)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 67108864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't=20
want memory cgroups
[    0.000000] hpet timer0 configured in 64-bit mode
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 2793.229 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using=20
timer frequency.. 5586.45 BogoMIPS (lpj=3D2793229)
[    0.000007] pid_max: default: 32768 minimum: 301
[    0.000037] Security Framework initialized
[    0.000049] AppArmor: AppArmor initialized
[    0.000647] Dentry cache hash table entries: 1048576 (order: 11,=20
8388608 bytes)
[    0.002144] Inode-cache hash table entries: 524288 (order: 10,=20
4194304 bytes)
[    0.002776] Mount-cache hash table entries: 256
[    0.002859] Initializing cgroup subsys cpuacct
[    0.002863] Initializing cgroup subsys memory
[    0.002877] Initializing cgroup subsys devices
[    0.002880] Initializing cgroup subsys freezer
[    0.002882] Initializing cgroup subsys net_cls
[    0.002884] Initializing cgroup subsys blkio
[    0.002890] Initializing cgroup subsys perf_event
[    0.002912] Disabled fast string operations
[    0.002915] CPU: Physical Processor ID: 0
[    0.002917] CPU: Processor Core ID: 0
[    0.002921] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.002922] ENERGY_PERF_BIAS: View and update with=20
x86_energy_perf_policy(8)
[    0.002927] mce: CPU supports 7 MCE banks
[    0.002936] CPU0: Thermal monitoring handled by SMI
[    0.002941] using mwait in idle threads.
[    0.003584] ACPI: Core revision 20110623
[    0.059768] Getting VERSION: 1060015
[    0.059771] Getting VERSION: 1060015
[    0.059773] Getting ID: 0
[    0.059774] Getting ID: 0
[    0.059783] DMAR: Host address width 36
[    0.059786] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.059792] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap=20
c0000020e60262 ecap f0101a
[    0.059796] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.059801] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap=20
c9008020660262 ecap f0105a
[    0.059804] DMAR: RMRR base: 0x000000bae1d000 end: 0x000000bae33fff
[    0.059807] DMAR: RMRR base: 0x000000bb800000 end: 0x000000bf9fffff
[    0.059879] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.059881] HPET id 0 under DRHD base 0xfed91000
[    0.059884] HPET id 0 under DRHD base 0xfed91000
[    0.059886] HPET id 0 under DRHD base 0xfed91000
[    0.059888] HPET id 0 under DRHD base 0xfed91000
[    0.059890] HPET id 0 under DRHD base 0xfed91000
[    0.059892] HPET id 0 under DRHD base 0xfed91000
[    0.059894] HPET id 0 under DRHD base 0xfed91000
[    0.059896] HPET id 0 under DRHD base 0xfed91000
[    0.060143] Enabled IRQ remapping in x2apic mode
[    0.060146] Enabling x2apic
[    0.060148] Enabled x2apic
[    0.060153] Switched APIC routing to cluster x2apic.
[    0.060158] enabled ExtINT on CPU#0
[    0.060404] ESR value before enabling vector: 0x00000080  after:=20
0x00000000
[    0.060421] ENABLING IO-APIC IRQs
[    0.060423] init IO_APIC IRQs
[    0.060424]  apic 2 pin 0 not connected
[    0.060427] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0=20
Active:0 Dest:1)
[    0.060431] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060436] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0=20
Active:0 Dest:1)
[    0.060439] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:30 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060443] IOAPIC[0]: Set routing entry (2-3 -> 0x33 -> IRQ 3 Mode:0=20
Active:0 Dest:1)
[    0.060446] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:33 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060450] IOAPIC[0]: Set routing entry (2-4 -> 0x34 -> IRQ 4 Mode:0=20
Active:0 Dest:1)
[    0.060453] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:34 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060457] IOAPIC[0]: Set routing entry (2-5 -> 0x35 -> IRQ 5 Mode:0=20
Active:0 Dest:1)
[    0.060460] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:35 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060465] IOAPIC[0]: Set routing entry (2-6 -> 0x36 -> IRQ 6 Mode:0=20
Active:0 Dest:1)
[    0.060467] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:36 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060472] IOAPIC[0]: Set routing entry (2-7 -> 0x37 -> IRQ 7 Mode:0=20
Active:0 Dest:1)
[    0.060475] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:37 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060479] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0=20
Active:0 Dest:1)
[    0.060482] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060486] IOAPIC[0]: Set routing entry (2-9 -> 0x39 -> IRQ 9 Mode:1=20
Active:0 Dest:1)
[    0.060489] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:39 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060493] IOAPIC[0]: Set routing entry (2-10 -> 0x3a -> IRQ 10=20
Mode:0 Active:0 Dest:1)
[    0.060496] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3A Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060500] IOAPIC[0]: Set routing entry (2-11 -> 0x3b -> IRQ 11=20
Mode:0 Active:0 Dest:1)
[    0.060503] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3B Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060507] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12=20
Mode:0 Active:0 Dest:1)
[    0.060510] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060514] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13=20
Mode:0 Active:0 Dest:1)
[    0.060517] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060521] IOAPIC[0]: Set routing entry (2-14 -> 0x3e -> IRQ 14=20
Mode:0 Active:0 Dest:1)
[    0.060524] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3E Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060528] IOAPIC[0]: Set routing entry (2-15 -> 0x3f -> IRQ 15=20
Mode:0 Active:0 Dest:1)
[    0.060531] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3F Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060535]  apic 2 pin 16 not connected
[    0.060536]  apic 2 pin 17 not connected
[    0.060537]  apic 2 pin 18 not connected
[    0.060538]  apic 2 pin 19 not connected
[    0.060538]  apic 2 pin 20 not connected
[    0.060539]  apic 2 pin 21 not connected
[    0.060540]  apic 2 pin 22 not connected
[    0.060541]  apic 2 pin 23 not connected
[    0.060679] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.070666] CPU0: Intel(R) Core(TM) i7-2640M CPU @ 2.80GHz stepping 07
[    0.070671] Using local APIC timer interrupts.
[    0.070671] calibrating APIC timer ...
[    0.172123] ... lapic delta =3D 623574
[    0.172125] ... PM-Timer delta =3D 357949
[    0.172126] ... PM-Timer result ok
[    0.172128] ..... delta 623574
[    0.172130] ..... mult: 26786370
[    0.172132] ..... calibration result: 99771
[    0.172134] ..... CPU clock speed is 2793.0611 MHz.
[    0.172136] ..... host bus clock speed is 99.0771 MHz.
[    0.172144] Performance Events: PEBS fmt1+, SandyBridge events, Intel=20
PMU driver.
[    0.172150] PEBS disabled due to CPU errata.
[    0.172154] ... version:                3
[    0.172155] ... bit width:              48
[    0.172157] ... generic registers:      4
[    0.172159] ... value mask:             0000ffffffffffff
[    0.172162] ... max period:             000000007fffffff
[    0.172164] ... fixed-purpose events:   3
[    0.172166] ... event mask:             000000070000000f
[    0.180330] NMI watchdog enabled, takes one hw-pmu counter.
[    0.188150] Booting Node   0, Processors  #1
[    0.188160] smpboot cpu 1: start_ip =3D 98000
[    0.199162] masked ExtINT on CPU#1
[    0.259011] Disabled fast string operations
[    0.259023] CPU1: Thermal monitoring handled by SMI
[    0.279047] NMI watchdog enabled, takes one hw-pmu counter.
[    0.285004]  #2
[    0.285010] smpboot cpu 2: start_ip =3D 98000
[    0.296013] masked ExtINT on CPU#2
[    0.355853] Disabled fast string operations
[    0.355864] CPU2: Thermal monitoring handled by SMI
[    0.375921] NMI watchdog enabled, takes one hw-pmu counter.
[    0.381847]  #3
[    0.381852] smpboot cpu 3: start_ip =3D 98000
[    0.392852] masked ExtINT on CPU#3
[    0.452696] Disabled fast string operations
[    0.452707] CPU3: Thermal monitoring handled by SMI
[    0.472765] NMI watchdog enabled, takes one hw-pmu counter.
[    0.474664] Brought up 4 CPUs
[    0.474673] Total of 4 processors activated (22346.24 BogoMIPS).
[    0.478171] devtmpfs: initialized
[    0.478919] PM: Registering ACPI NVS region at bad2e000 (61440 bytes)
[    0.478924] PM: Registering ACPI NVS region at badfb000 (8192 bytes)
[    0.478927] PM: Registering ACPI NVS region at badff000 (12288 bytes)
[    0.478930] PM: Registering ACPI NVS region at bae0a000 (69632 bytes)
[    0.478934] PM: Registering ACPI NVS region at baf18000 (16384 bytes)
[    0.478938] PM: Registering ACPI NVS region at baf1f000 (524288 bytes)
[    0.479061] print_constraints: dummy:
[    0.479091] RTC time:  1:23:20, date: 12/27/11
[    0.479128] NET: Registered protocol family 16
[    0.479269] ACPI: bus type pci registered
[    0.479329] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem=20
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.479334] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E=
820
[    0.489012] PCI: Using configuration type 1 for base access
[    0.489769] bio: create slab <bio-0> at 0
[    0.489840] ACPI: Added _OSI(Module Device)
[    0.489843] ACPI: Added _OSI(Processor Device)
[    0.489846] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.489848] ACPI: Added _OSI(Processor Aggregator Device)
[    0.491351] ACPI: EC: Look up EC in DSDT
[    0.492860] ACPI: Executed 1 blocks of module-level executable AML cod=
e
[    0.499730] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.500574] ACPI: SSDT 00000000bae06718 0067C (v01  PmRef  Cpu0Cst=20
00003001 INTL 20061109)
[    0.500979] ACPI: Dynamic OEM Table Load:
[    0.500982] ACPI: SSDT           (null) 0067C (v01  PmRef  Cpu0Cst=20
00003001 INTL 20061109)
[    0.506049] ACPI: SSDT 00000000bae07a98 00303 (v01  PmRef    ApIst=20
00003000 INTL 20061109)
[    0.506495] ACPI: Dynamic OEM Table Load:
[    0.506498] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst=20
00003000 INTL 20061109)
[    0.508778] ACPI: SSDT 00000000bae05d98 00119 (v01  PmRef    ApCst=20
00003000 INTL 20061109)
[    0.509171] ACPI: Dynamic OEM Table Load:
[    0.509173] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst=20
00003000 INTL 20061109)
[    0.514717] ACPI: Interpreter enabled
[    0.514722] ACPI: (supports S0 S3 S4 S5)
[    0.514744] ACPI: Using IOAPIC for interrupt routing
[    0.520280] ACPI: EC: GPE =3D 0x17, I/O: command/status =3D 0x66, data=
 =3D 0x62
[    0.520446] ACPI: No dock devices found.
[    0.520448] HEST: Table not found.
[    0.520451] PCI: Using host bridge windows from ACPI; if necessary,=20
use "pci=3Dnocrs" and report a bug
[    0.520852] \_SB_.PCI0:_OSC invalid UUID
[    0.520853] _OSC request data:1 8 1f
[    0.520856] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.521533] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7=
]
[    0.521537] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff=
]
[    0.521540] pci_root PNP0A08:00: host bridge window [mem=20
0x000a0000-0x000bffff]
[    0.521544] pci_root PNP0A08:00: host bridge window [mem=20
0xbfa00000-0xfeafffff]
[    0.521548] pci_root PNP0A08:00: host bridge window [mem=20
0xfed40000-0xfed44fff]
[    0.521559] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    0.521591] pci 0000:00:01.0: [8086:0101] type 1 class 0x000604
[    0.521611] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.521613] pci 0000:00:01.0: PME# disabled
[    0.521630] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    0.521639] pci 0000:00:02.0: reg 10: [mem 0xf1400000-0xf17fffff 64bit=
]
[    0.521644] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff=20
64bit pref]
[    0.521648] pci 0000:00:02.0: reg 20: [io  0x4000-0x403f]
[    0.521692] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    0.521714] pci 0000:00:16.0: reg 10: [mem 0xf1c05000-0xf1c0500f 64bit=
]
[    0.521774] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.521778] pci 0000:00:16.0: PME# disabled
[    0.521808] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    0.521828] pci 0000:00:1a.0: reg 10: [mem 0xf1c0a000-0xf1c0a3ff]
[    0.521898] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.521902] pci 0000:00:1a.0: PME# disabled
[    0.521925] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    0.521939] pci 0000:00:1b.0: reg 10: [mem 0xf1c00000-0xf1c03fff 64bit=
]
[    0.521991] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.521994] pci 0000:00:1b.0: PME# disabled
[    0.522016] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    0.522075] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.522079] pci 0000:00:1c.0: PME# disabled
[    0.522103] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    0.522162] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.522166] pci 0000:00:1c.1: PME# disabled
[    0.522190] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
[    0.522249] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.522253] pci 0000:00:1c.3: PME# disabled
[    0.522277] pci 0000:00:1c.4: [8086:1c18] type 1 class 0x000604
[    0.522335] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.522339] pci 0000:00:1c.4: PME# disabled
[    0.522363] pci 0000:00:1c.5: [8086:1c1a] type 1 class 0x000604
[    0.522422] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.522426] pci 0000:00:1c.5: PME# disabled
[    0.522455] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    0.522475] pci 0000:00:1d.0: reg 10: [mem 0xf1c09000-0xf1c093ff]
[    0.522544] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.522548] pci 0000:00:1d.0: PME# disabled
[    0.522571] pci 0000:00:1f.0: [8086:1c4b] type 0 class 0x000601
[    0.522685] pci 0000:00:1f.2: [8086:1c03] type 0 class 0x000106
[    0.522702] pci 0000:00:1f.2: reg 10: [io  0x4088-0x408f]
[    0.522710] pci 0000:00:1f.2: reg 14: [io  0x4094-0x4097]
[    0.522717] pci 0000:00:1f.2: reg 18: [io  0x4080-0x4087]
[    0.522725] pci 0000:00:1f.2: reg 1c: [io  0x4090-0x4093]
[    0.522732] pci 0000:00:1f.2: reg 20: [io  0x4060-0x407f]
[    0.522740] pci 0000:00:1f.2: reg 24: [mem 0xf1c08000-0xf1c087ff]
[    0.522770] pci 0000:00:1f.2: PME# supported from D3hot
[    0.522774] pci 0000:00:1f.2: PME# disabled
[    0.522791] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    0.522805] pci 0000:00:1f.3: reg 10: [mem 0xf1c04000-0xf1c040ff 64bit=
]
[    0.522826] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
[    0.522875] pci 0000:01:00.0: [10de:0df5] type 0 class 0x000300
[    0.522882] pci 0000:01:00.0: reg 10: [mem 0xf0000000-0xf0ffffff]
[    0.522890] pci 0000:01:00.0: reg 14: [mem 0xc0000000-0xcfffffff=20
64bit pref]
[    0.522898] pci 0000:01:00.0: reg 1c: [mem 0xd0000000-0xd1ffffff=20
64bit pref]
[    0.522903] pci 0000:01:00.0: reg 24: [io  0x3000-0x307f]
[    0.522909] pci 0000:01:00.0: reg 30: [mem 0xfff80000-0xffffffff pref]
[    0.524596] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.524609] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.524616] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fff=
ff]
[    0.524626] pci 0000:00:01.0:   bridge window [mem=20
0xc0000000-0xd1ffffff 64bit pref]
[    0.524698] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.524908] pci 0000:03:00.0: [8086:0091] type 0 class 0x000280
[    0.525049] pci 0000:03:00.0: reg 10: [mem 0xf1b00000-0xf1b01fff 64bit=
]
[    0.525618] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.525652] pci 0000:03:00.0: PME# disabled
[    0.527703] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.527711] pci 0000:00:1c.1:   bridge window [mem 0xf1b00000-0xf1bfff=
ff]
[    0.527783] pci 0000:04:00.0: [1033:0194] type 0 class 0x000c03
[    0.527808] pci 0000:04:00.0: reg 10: [mem 0xf1a00000-0xf1a01fff 64bit=
]
[    0.527912] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.527917] pci 0000:04:00.0: PME# disabled
[    0.529595] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.529614] pci 0000:00:1c.3:   bridge window [mem 0xf1a00000-0xf1afff=
ff]
[    0.529692] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.529700] pci 0000:00:1c.4:   bridge window [mem 0xf1900000-0xf19fff=
ff]
[    0.529769] pci 0000:06:00.0: [1969:1083] type 0 class 0x000200
[    0.529796] pci 0000:06:00.0: reg 10: [mem 0xf1800000-0xf183ffff 64bit=
]
[    0.529810] pci 0000:06:00.0: reg 18: [io  0x2000-0x207f]
[    0.529905] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.529910] pci 0000:06:00.0: PME# disabled
[    0.531592] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
[    0.531606] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.531617] pci 0000:00:1c.5:   bridge window [mem 0xf1800000-0xf18fff=
ff]
[    0.531674] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.531763]       0000:00:1f[A] -> [21]
[    0.531766]       0000:00:1f[B] -> [19]
[    0.531769]       0000:00:1f[C] -> [18]
[    0.531771]       0000:00:1f[D] -> [16]
[    0.531773]       0000:00:1d[A] -> [23]
[    0.531776]       0000:00:1a[A] -> [16]
[    0.531778]       0000:00:1b[A] -> [22]
[    0.531781]       0000:00:16[A] -> [16]
[    0.531783]       0000:00:16[B] -> [19]
[    0.531785]       0000:00:16[C] -> [18]
[    0.531788]       0000:00:16[D] -> [17]
[    0.531790]       0000:00:1c[A] -> [16]
[    0.531792]       0000:00:1c[B] -> [17]
[    0.531795]       0000:00:1c[C] -> [18]
[    0.531797]       0000:00:1c[D] -> [19]
[    0.531799]       0000:00:01[A] -> [16]
[    0.531802]       0000:00:01[B] -> [17]
[    0.531804]       0000:00:01[C] -> [18]
[    0.531806]       0000:00:01[D] -> [19]
[    0.531809]       0000:00:02[A] -> [16]
[    0.531811]       0000:00:04[A] -> [16]
[    0.531813]       0000:00:04[B] -> [17]
[    0.531816]       0000:00:04[C] -> [18]
[    0.531818]       0000:00:04[D] -> [19]
[    0.531840] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.0 is a PCI bridge
[    0.531846] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.531874]       0000:02:00[A] -> [16]
[    0.531877]       0000:02:00[B] -> [17]
[    0.531879]       0000:02:00[C] -> [18]
[    0.531882]       0000:02:00[D] -> [19]
[    0.531890] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.1 is a PCI bridge
[    0.531896] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.531923]       0000:03:00[A] -> [17]
[    0.531925]       0000:03:00[B] -> [18]
[    0.531928]       0000:03:00[C] -> [19]
[    0.531930]       0000:03:00[D] -> [16]
[    0.531940] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.3 is a PCI bridge
[    0.531945] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.531972]       0000:04:00[A] -> [19]
[    0.531974]       0000:04:00[B] -> [16]
[    0.531977]       0000:04:00[C] -> [17]
[    0.531979]       0000:04:00[D] -> [18]
[    0.531988] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.4 is a PCI bridge
[    0.531994] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.532020]       0000:05:00[A] -> [16]
[    0.532023]       0000:05:00[B] -> [17]
[    0.532025]       0000:05:00[C] -> [18]
[    0.532028]       0000:05:00[D] -> [19]
[    0.532053] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.5 is a PCI bridge
[    0.532058] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.532085]       0000:06:00[A] -> [17]
[    0.532087]       0000:06:00[B] -> [18]
[    0.532090]       0000:06:00[C] -> [19]
[    0.532092]       0000:06:00[D] -> [16]
[    0.532109] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:01.0 is a PCI bridge
[    0.532114] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG0._PRT]
[    0.532141]       0000:01:00[A] -> [16]
[    0.532143]       0000:01:00[B] -> [17]
[    0.532146]       0000:01:00[C] -> [18]
[    0.532148]       0000:01:00[D] -> [19]
[    0.532198] \_SB_.PCI0:_OSC invalid UUID
[    0.532198] _OSC request data:1 1f 1f
[    0.532201]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.532239] \_SB_.PCI0:_OSC invalid UUID
[    0.532240] _OSC request data:1 0 1d
[    0.532242]  pci0000:00: ACPI _OSC request failed (AE_ERROR),=20
returned control mask: 0x1d
[    0.532246] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.535536] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535572] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 11
[    0.535577] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12=20
14 15)
[    0.535607] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535638] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 9
[    0.535642] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *9
[    0.535671] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535699] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 9
[    0.535703] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *9
[    0.535731] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535759] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 10
[    0.535763] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12=20
14 15)
[    0.535790] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535818] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 0
[    0.535822] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *0, disabled.
[    0.535850] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535878] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 0
[    0.535882] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *0, disabled.
[    0.535911] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535939] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 10
[    0.535942] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12=20
14 15)
[    0.535970] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535998] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 11
[    0.536002] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 12=20
14 15)
[    0.536069] vgaarb: device added:=20
PCI:0000:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.536078] vgaarb: device added:=20
PCI:0000:01:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.536083] vgaarb: loaded
[    0.536085] vgaarb: bridge control possible 0000:01:00.0
[    0.536087] vgaarb: no bridge control possible 0000:00:02.0
[    0.536179] SCSI subsystem initialized
[    0.536213] libata version 3.00 loaded.
[    0.536245] usbcore: registered new interface driver usbfs
[    0.536257] usbcore: registered new interface driver hub
[    0.536277] usbcore: registered new device driver usb
[    0.536324] PCI: Using ACPI for IRQ routing
[    0.537738] PCI: pci_cache_line_size set to 64 bytes
[    0.537863] reserve RAM buffer: 000000000009d800 - 000000000009ffff
[    0.537865] reserve RAM buffer: 00000000b5a28000 - 00000000b7ffffff
[    0.537867] reserve RAM buffer: 00000000b886a000 - 00000000bbffffff
[    0.537871] reserve RAM buffer: 00000000bac8f000 - 00000000bbffffff
[    0.537874] reserve RAM buffer: 00000000bb000000 - 00000000bbffffff
[    0.537876] reserve RAM buffer: 000000023fe00000 - 000000023fffffff
[    0.537947] NetLabel: Initializing
[    0.537950] NetLabel:  domain hash size =3D 128
[    0.537952] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.537961] NetLabel:  unlabeled traffic allowed by default
[    0.537971] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.537977] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.539993] Switching to clocksource hpet
[    0.541903] AppArmor: AppArmor Filesystem Enabled
[    0.541922] pnp: PnP ACPI init
[    0.541934] ACPI: bus type pnp registered
[    0.542307] pnp 00:00: [bus 00-3e]
[    0.542310] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.542311] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.542313] pnp 00:00: [io  0x0d00-0xffff window]
[    0.542314] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.542316] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.542317] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.542318] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.542320] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.542321] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.542322] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.542324] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.542325] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.542326] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.542328] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.542329] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.542331] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.542332] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.542333] pnp 00:00: [mem 0xbfa00000-0xfeafffff window]
[    0.542335] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.542374] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03=20
(active)
[    0.542387] pnp 00:01: [io  0x0000-0x001f]
[    0.542389] pnp 00:01: [io  0x0081-0x0091]
[    0.542390] pnp 00:01: [io  0x0093-0x009f]
[    0.542391] pnp 00:01: [io  0x00c0-0x00df]
[    0.542392] pnp 00:01: [dma 4]
[    0.542409] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.542484] pnp 00:02: [mem 0xfed00000-0xfed003ff]
[    0.542501] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.542511] pnp 00:03: [io  0x00f0]
[    0.542515] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13=20
Mode:0 Active:0 Dest:1)
[    0.542519] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542525] pnp 00:03: [irq 13]
[    0.542541] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.542550] pnp 00:04: [io  0x002e-0x002f]
[    0.542551] pnp 00:04: [io  0x004e-0x004f]
[    0.542553] pnp 00:04: [io  0x0061]
[    0.542555] pnp 00:04: [io  0x0063]
[    0.542556] pnp 00:04: [io  0x0065]
[    0.542557] pnp 00:04: [io  0x0067]
[    0.542558] pnp 00:04: [io  0x0068]
[    0.542559] pnp 00:04: [io  0x006c]
[    0.542560] pnp 00:04: [io  0x0070]
[    0.542561] pnp 00:04: [io  0x0080]
[    0.542562] pnp 00:04: [io  0x0092]
[    0.542563] pnp 00:04: [io  0x00b2-0x00b3]
[    0.542564] pnp 00:04: [io  0x0680-0x069f]
[    0.542566] pnp 00:04: [io  0x1000-0x1003]
[    0.542567] pnp 00:04: [io  0x1004-0x1013]
[    0.542568] pnp 00:04: [io  0xffff]
[    0.542569] pnp 00:04: [io  0x0400-0x0453]
[    0.542570] pnp 00:04: [io  0x0458-0x047f]
[    0.542571] pnp 00:04: [io  0x0500-0x057f]
[    0.542573] pnp 00:04: [io  0x164e-0x164f]
[    0.542606] system 00:04: [io  0x0680-0x069f] has been reserved
[    0.542610] system 00:04: [io  0x1000-0x1003] has been reserved
[    0.542613] system 00:04: [io  0x1004-0x1013] has been reserved
[    0.542616] system 00:04: [io  0xffff] has been reserved
[    0.542619] system 00:04: [io  0x0400-0x0453] has been reserved
[    0.542622] system 00:04: [io  0x0458-0x047f] has been reserved
[    0.542625] system 00:04: [io  0x0500-0x057f] has been reserved
[    0.542628] system 00:04: [io  0x164e-0x164f] has been reserved
[    0.542631] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.542639] pnp 00:05: [io  0x0070-0x0077]
[    0.542641] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0=20
Active:0 Dest:1)
[    0.542644] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542649] pnp 00:05: [irq 8]
[    0.542666] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.542692] pnp 00:06: [io  0x0454-0x0457]
[    0.542721] system 00:06: [io  0x0454-0x0457] has been reserved
[    0.542724] system 00:06: Plug and Play ACPI device, IDs INT3f0d=20
PNP0c02 (active)
[    0.542760] pnp 00:07: [io  0x0060]
[    0.542761] pnp 00:07: [io  0x0064]
[    0.542763] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0=20
Active:0 Dest:1)
[    0.542766] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542770] pnp 00:07: [irq 1]
[    0.542788] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.542817] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12=20
Mode:0 Active:0 Dest:1)
[    0.542820] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542824] pnp 00:08: [irq 12]
[    0.542842] pnp 00:08: Plug and Play ACPI device, IDs DLL0446 PNP0f13=20
(active)
[    0.542954] pnp 00:09: [mem 0xfed1c000-0xfed1ffff]
[    0.542955] pnp 00:09: [mem 0xfed10000-0xfed17fff]
[    0.542957] pnp 00:09: [mem 0xfed18000-0xfed18fff]
[    0.542958] pnp 00:09: [mem 0xfed19000-0xfed19fff]
[    0.542959] pnp 00:09: [mem 0xf8000000-0xfbffffff]
[    0.542960] pnp 00:09: [mem 0xfed20000-0xfed3ffff]
[    0.542962] pnp 00:09: [mem 0xfed90000-0xfed93fff]
[    0.542964] pnp 00:09: [mem 0xfed45000-0xfed8ffff]
[    0.542965] pnp 00:09: [mem 0xff000000-0xffffffff]
[    0.542966] pnp 00:09: [mem 0xfee00000-0xfeefffff]
[    0.542968] pnp 00:09: [mem 0xfffff000-0xffffffff]
[    0.542980] pnp 00:09: disabling [mem 0xfffff000-0xffffffff] because=20
it overlaps 0000:01:00.0 BAR 6 [mem 0xfff80000-0xffffffff pref]
[    0.543006] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserve=
d
[    0.543010] system 00:09: [mem 0xfed10000-0xfed17fff] has been reserve=
d
[    0.543013] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserve=
d
[    0.543017] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserve=
d
[    0.543020] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserve=
d
[    0.543023] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserve=
d
[    0.543027] system 00:09: [mem 0xfed90000-0xfed93fff] has been reserve=
d
[    0.543030] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserve=
d
[    0.543033] system 00:09: [mem 0xff000000-0xffffffff] could not be=20
reserved
[    0.543037] system 00:09: [mem 0xfee00000-0xfeefffff] could not be=20
reserved
[    0.543047] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.543171] IOAPIC[0]: Set routing entry (2-20 -> 0x49 -> IRQ 20=20
Mode:0 Active:0 Dest:1)
[    0.543174] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:49 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.543177] pnp 00:0a: [irq 20]
[    0.543206] pnp 00:0a: Plug and Play ACPI device, IDs SMO8800 (active)
[    0.543336] pnp: PnP ACPI: found 11 devices
[    0.543338] ACPI: ACPI bus type pnp unregistered
[    0.549778] pci 0000:01:00.0: no compatible bridge window for [mem=20
0xfff80000-0xffffffff pref]
[    0.549785] PCI: max bus depth: 1 pci_try_num: 2
[    0.549827] pci 0000:01:00.0: BAR 6: assigned [mem=20
0xf1000000-0xf107ffff pref]
[    0.549831] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.549834] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.549838] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fff=
ff]
[    0.549842] pci 0000:00:01.0:   bridge window [mem=20
0xc0000000-0xd1ffffff 64bit pref]
[    0.549847] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.549859] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.549865] pci 0000:00:1c.1:   bridge window [mem 0xf1b00000-0xf1bfff=
ff]
[    0.549874] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.549880] pci 0000:00:1c.3:   bridge window [mem 0xf1a00000-0xf1afff=
ff]
[    0.549890] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.549896] pci 0000:00:1c.4:   bridge window [mem 0xf1900000-0xf19fff=
ff]
[    0.549905] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
[    0.549909] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.549915] pci 0000:00:1c.5:   bridge window [mem 0xf1800000-0xf18fff=
ff]
[    0.549928]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:01.0[A] _PRT entry
[    0.549937] IOAPIC[0]: Set routing entry (2-16 -> 0x51 -> IRQ 16=20
Mode:1 Active:1 Dest:1)
[    0.549941] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:51 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.549944] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.549948] pci 0000:00:01.0: setting latency timer to 64
[    0.549954]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.0[A] _PRT entry
[    0.549959] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.549965] pci 0000:00:1c.0: setting latency timer to 64
[    0.549971]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.1[B] _PRT entry
[    0.549977] IOAPIC[0]: Set routing entry (2-17 -> 0x59 -> IRQ 17=20
Mode:1 Active:1 Dest:1)
[    0.549980] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:59 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.549983] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    0.549988] pci 0000:00:1c.1: setting latency timer to 64
[    0.549994]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.3[D] _PRT entry
[    0.550001] IOAPIC[0]: Set routing entry (2-19 -> 0x61 -> IRQ 19=20
Mode:1 Active:1 Dest:1)
[    0.550004] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:61 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.550006] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ =
19
[    0.550011] pci 0000:00:1c.3: setting latency timer to 64
[    0.550017]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.4[A] _PRT entry
[    0.550022] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.550027] pci 0000:00:1c.4: setting latency timer to 64
[    0.550039]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.5[B] _PRT entry
[    0.550044] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    0.550050] pci 0000:00:1c.5: setting latency timer to 64
[    0.550053] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.550054] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.550056] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.550057] pci_bus 0000:00: resource 7 [mem 0xbfa00000-0xfeafffff]
[    0.550059] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.550060] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    0.550061] pci_bus 0000:01: resource 1 [mem 0xf0000000-0xf10fffff]
[    0.550063] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff=20
64bit pref]
[    0.550064] pci_bus 0000:03: resource 1 [mem 0xf1b00000-0xf1bfffff]
[    0.550066] pci_bus 0000:04: resource 1 [mem 0xf1a00000-0xf1afffff]
[    0.550067] pci_bus 0000:05: resource 1 [mem 0xf1900000-0xf19fffff]
[    0.550069] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.550070] pci_bus 0000:06: resource 1 [mem 0xf1800000-0xf18fffff]
[    0.550125] NET: Registered protocol family 2
[    0.550318] IP route cache hash table entries: 262144 (order: 9,=20
2097152 bytes)
[    0.551888] TCP established hash table entries: 524288 (order: 11,=20
8388608 bytes)
[    0.553016] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    0.553157] TCP: Hash tables configured (established 524288 bind 65536=
)
[    0.553161] TCP reno registered
[    0.553175] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.553205] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.553308] NET: Registered protocol family 1
[    0.553322] pci 0000:00:02.0: Boot video device
[    0.553459] PCI: CLS 64 bytes, default 64
[    0.553496] Unpacking initramfs...
[    0.723042] Freeing initrd memory: 12380k freed
[    0.724650] DMAR: No ATSR found
[    0.724686] IOMMU 0 0xfed90000: using Queued invalidation
[    0.724688] IOMMU 1 0xfed91000: using Queued invalidation
[    0.724692] IOMMU: Setting RMRR:
[    0.724704] IOMMU: Setting identity map for device 0000:00:02.0=20
[0xbb800000 - 0xbf9fffff]
[    0.725062] IOMMU: Setting identity map for device 0000:00:1d.0=20
[0xbae1d000 - 0xbae33fff]
[    0.725085] IOMMU: Setting identity map for device 0000:00:1a.0=20
[0xbae1d000 - 0xbae33fff]
[    0.725099] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    0.725108] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0=20
- 0xffffff]
[    0.725335] PCI-DMA: Intel(R) Virtualization Technology for Directed I=
/O
[    0.727095] audit: initializing netlink socket (disabled)
[    0.727106] type=3D2000 audit(1324949000.518:1): initialized
[    0.749859] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.765057] VFS: Disk quotas dquot_6.5.2
[    0.765086] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.765302] msgmni has been set to 15909
[    0.765461] Block layer SCSI generic (bsg) driver version 0.4 loaded=20
(major 253)
[    0.765486] io scheduler noop registered (default)
[    0.765491] io scheduler deadline registered
[    0.765508] io scheduler cfq registered
[    0.765594] pcieport 0000:00:01.0: setting latency timer to 64
[    0.765617] pcieport 0000:00:01.0: irq 42 for MSI/MSI-X
[    0.765914] vesafb: mode is 1280x1024x32, linelength=3D5120, pages=3D1=
1
[    0.765917] vesafb: scrolling: redraw
[    0.765920] vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.767586] vesafb: framebuffer at 0xe0000000, mapped to=20
0xffffc90005800000, using 10240k, total 65472k
[    0.767738] bootsplash 3.2.0-2010/03/31: looking for picture...
[    0.767739] bootsplash: silentjpeg size 109002 bytes
[    0.777989] bootsplash: ...found (1280x1024, 40442 bytes, v3).
[    0.778101] bootsplash: silentjpeg size 126037 bytes
[    0.882677] Console: switching to colour frame buffer device 156x60
[    0.962069] fb0: VESA VGA frame buffer device
[    0.962474] intel_idle: MWAIT substates: 0x21120
[    0.962475] intel_idle: v0.4 model 0x2A
[    0.962476] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.962518] ERST: Table is not found!
[    0.962842] GHES: HEST is not enabled!
[    0.963242] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.084566] Non-volatile memory driver v1.3
[    1.084937] Linux agpgart interface v0.103
[    1.085368] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.086005] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K=20
total, 262144K mappable
[    1.087854] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.088547] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000=
000
[    1.089240] ahci 0000:00:1f.2: version 3.0
[    1.089249]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1f.2[B] _PRT entry
[    1.089987] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ=
 19
[    1.090633] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    1.090657] ahci: SSS flag set, parallel bus scan disabled
[    1.101254] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps=20
0x13 impl SATA mode
[    1.102014] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo=20
pio slum part ems sxs apst
[    1.102794] ahci 0000:00:1f.2: setting latency timer to 64
[    1.106635] scsi0 : ahci
[    1.106935] scsi1 : ahci
[    1.107220] scsi2 : ahci
[    1.107497] scsi3 : ahci
[    1.107773] scsi4 : ahci
[    1.108048] scsi5 : ahci
[    1.108376] ata1: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08100 irq 43
[    1.109028] ata2: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08180 irq 43
[    1.109687] ata3: DUMMY
[    1.109906] ata4: DUMMY
[    1.110126] ata5: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08300 irq 43
[    1.110785] ata6: DUMMY
[    1.111067] Fixed MDIO Bus: probed
[    1.111378] arcnet loaded.
[    1.111620] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.112214]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1a.0[A] _PRT entry
[    1.112956] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low)=20
-> IRQ 16
[    1.113604] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.113607] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.114089] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned=20
bus number 1
[    1.114781] ehci_hcd 0000:00:1a.0: debug port 2
[    1.141311] ehci_hcd 0000:00:1a.0: cache line size of 64 is not suppor=
ted
[    1.141329] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf1c0a000
[    1.173136] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.195461] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.217783] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.240042] usb usb1: Product: EHCI Host Controller
[    1.262192] usb usb1: Manufacturer: Linux 3.2.0-rc6-3-desktop ehci_hcd
[    1.284442] usb usb1: SerialNumber: 0000:00:1a.0
[    1.306584] hub 1-0:1.0: USB hub found
[    1.328442] hub 1-0:1.0: 2 ports detected
[    1.350123]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1d.0[A] _PRT entry
[    1.372171] IOAPIC[0]: Set routing entry (2-23 -> 0x79 -> IRQ 23=20
Mode:1 Active:1 Dest:1)
[    1.372176] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:79 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    1.372180] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low)=20
-> IRQ 23
[    1.394153] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.394156] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.414770] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.437965] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned=20
bus number 2
[    1.460503] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by=20
device (Stat=3D0x51 Err=3D0x04)
[    1.460548] ehci_hcd 0000:00:1d.0: debug port 2
[    1.464440] ehci_hcd 0000:00:1d.0: cache line size of 64 is not suppor=
ted
[    1.464459] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf1c09000
[    1.473673] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.473717] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.473718] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.473720] usb usb2: Product: EHCI Host Controller
[    1.473721] usb usb2: Manufacturer: Linux 3.2.0-rc6-3-desktop ehci_hcd
[    1.473722] usb usb2: SerialNumber: 0000:00:1d.0
[    1.473841] hub 2-0:1.0: USB hub found
[    1.473845] hub 2-0:1.0: 2 ports detected
[    1.473918] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.473931] uhci_hcd: USB Universal Host Controller Interface driver
[    1.753069] Initializing USB Mass Storage driver...
[    1.753071] Refined TSC clocksource calibration: 2793.653 MHz.
[    1.755293] ata1.00: ATA-8: SAMSUNG SSD PM810 2.5" 7mm 256GB,=20
AXM08D1Q, max UDMA/133
[    1.755295] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth=20
31/32), AA
[    1.755611] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by=20
device (Stat=3D0x51 Err=3D0x04)
[    1.757928] ata1.00: configured for UDMA/133
[    1.854112] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    1.912671] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM81=20
AXM0 PQ: 0 ANSI: 5
[    1.912674] usbcore: registered new interface driver usb-storage
[    1.912675] USB Mass Storage support registered.
[    1.912682] usbcore: registered new interface driver ums-alauda
[    1.912688] usbcore: registered new interface driver ums-cypress
[    1.912694] usbcore: registered new interface driver ums-datafab
[    1.912701] usbcore: registered new interface driver ums-freecom
[    1.912707] usbcore: registered new interface driver ums-isd200
[    1.912713] usbcore: registered new interface driver ums-jumpshot
[    1.912718] usbcore: registered new interface driver ums-karma
[    1.912724] usbcore: registered new interface driver ums-onetouch
[    1.912730] usbcore: registered new interface driver ums-sddr09
[    1.912736] usbcore: registered new interface driver ums-sddr55
[    1.912741] usbcore: registered new interface driver ums-usbat
[    1.912768] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]=20
at 0x60,0x64 irq 1,12
[    1.912807] i8042: [0] 20 -> i8042 (command)
[    1.913286] i8042: [0] 67 <- i8042 (return)
[    1.913347] i8042: [1] 20 -> i8042 (command)
[    1.913721] i8042: [1] 67 <- i8042 (return)
[    1.913726] i8042: [1] 60 -> i8042 (command)
[    1.913889] i8042: [1] 76 -> i8042 (parameter)
[    1.914109] i8042: [1] d3 -> i8042 (command)
[    1.914325] i8042: [1] 5a -> i8042 (parameter)
[    1.914544] i8042: [1] 5a <- i8042 (return)
[    1.914553] i8042: [2] a7 -> i8042 (command)
[    1.914661] i8042: [2] 20 -> i8042 (command)
[    1.914931] i8042: [2] 76 <- i8042 (return)
[    1.914935] i8042: [2] a8 -> i8042 (command)
[    1.915095] i8042: [2] 20 -> i8042 (command)
[    1.915364] i8042: [2] 56 <- i8042 (return)
[    1.915373] i8042: [3] 60 -> i8042 (command)
[    1.915536] i8042: [3] 74 -> i8042 (parameter)
[    1.915763] i8042: [3] d3 -> i8042 (command)
[    1.915978] i8042: [3] f0 -> i8042 (parameter)
[    1.916198] i8042: [3] f0 <- i8042 (return)
[    1.916222] i8042: [4] d3 -> i8042 (command)
[    1.916282] i8042: [4] 56 -> i8042 (parameter)
[    1.916555] i8042: [4] 56 <- i8042 (return)
[    1.916567] i8042: [4] d3 -> i8042 (command)
[    1.916783] i8042: [4] a4 -> i8042 (parameter)
[    1.917002] i8042: [4] a4 <- i8042 (return)
[    1.917027] i8042: [5] 60 -> i8042 (command)
[    1.917137] i8042: [5] 56 -> i8042 (parameter)
[    1.917309] i8042: [5] 60 -> i8042 (command)
[    1.917525] i8042: [5] 47 -> i8042 (parameter)
[    1.917528] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.917552] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.917632] mousedev: PS/2 mouse device common for all mice
[    1.917760] i8042: [5] f2 -> i8042 (kbd-data)
[    1.917804] rtc_cmos 00:05: RTC can wake from S4
[    1.917906] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.917932] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet i=
rqs
[    1.918037] cpuidle: using governor ladder
[    2.402856] i8042: [491] ed -> i8042 (kbd-data)
[    2.402866] i8042: [491] fa <- i8042 (interrupt, 0, 12)
[    2.402926] hpet1: lost 30 rtc interrupts
[    2.403065] cpuidle: using governor menu
[    2.403067] EFI Variables Facility v0.08 2004-May-17
[    2.403295] usbcore: registered new interface driver usbhid
[    2.403297] usbhid: USB HID core driver
[    2.404035] i8042: [492] 00 -> i8042 (kbd-data)
[    2.510920] i8042: [599] fa <- i8042 (interrupt, 0, 1)
[    2.510940] i8042: [599] ed -> i8042 (kbd-data)
[    2.511103] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256=20
GB/238 GiB)
[    2.511126] TCP cubic registered
[    2.511128] IPv6: Loaded, but administratively disabled, reboot=20
required to enable
[    2.511144] lib80211: common routines for IEEE802.11 drivers
[    2.511145] lib80211_crypt: registered algorithm 'NULL'
[    2.511147] Registering the dns_resolver key type
[    2.511162] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[    2.511169]
[    2.511169] printing PIC contents
[    2.511173] ... PIC  IMR: ffff
[    2.511177] ... PIC  IRR: 0c01
[    2.511184] ... PIC  ISR: 0000
[    2.511187] ... PIC ELCR: 0e00
[    2.643783] printing local APIC contents on CPU#0/0:
[    2.643784] ... APIC ID:      00000000 (0)
[    2.666176] ... APIC VERSION: 01060015
[    2.688175] ... APIC TASKPRI: 00000000 (00)
[    2.688176] ... APIC PROCPRI: 00000000
[    2.688177] ... APIC LDR: 00000001
[    2.688178] ... APIC SPIV: 000001ff
[    2.688179] ... APIC ISR field:
[    2.688180]=20
0000000000000000000000000000000000000000000000000000000000000000
[    2.709866] i8042: [799] f4 -> i8042 (kbd-data)
[    2.710552] ... APIC TMR field:
[    2.710553]=20
0000000000000000000000000000000000000000000000000000000000000000
[    2.732661] ... APIC IRR field:
[    2.732662]=20
0000000002020000000200000000000000000000000000000000000000008000
[    2.754421] ... APIC ESR: 00000000
[    2.754422] ... APIC ICR: 000008fd
[    2.754422] ... APIC ICR2: 00000040
[    2.754423] ... APIC LVTT: 000000ef
[    2.754424] ... APIC LVTPC: 00000400
[    2.754425] ... APIC LVT0: 00010700
[    2.754426] ... APIC LVT1: 00000400
[    2.754427] ... APIC LVTERR: 000000fe
[    2.754428] ... APIC TMICT: 000004c0
[    2.754428] ... APIC TMCCT: 00000000
[    2.754429] ... APIC TDCR: 00000003
[    2.754430]
[    2.775580] number of MP IRQ sources: 15.
[    2.775582] number of IO-APIC #2 registers: 24.
[    2.775583] testing the IO APIC.......................
[    2.775623] i8042: [864] fa <- i8042 (interrupt, 0, 1)
[    2.775695] input: AT Translated Set 2 keyboard as=20
/devices/platform/i8042/serio0/input/input0
[    2.775800] sd 0:0:0:0: [sda] Write Protect is off
[    2.775802] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.775812] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[    2.786128] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    2.786130] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    2.815686] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.820070] ata2.00: ATAPI: HL-DT-ST DVD+/-RW GS30N, A101, max UDMA/13=
3
[    2.825187] ata2.00: configured for UDMA/133
[    2.830643] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GS30N=20
  A101 PQ: 0 ANSI: 5
[    2.995778]
[    2.995813] i8042: [1085] d4 -> i8042 (command)
[    2.995924] i8042: [1085] f2 -> i8042 (parameter)
[    2.995926] hub 1-1:1.0: USB hub found
[    2.996023] hub 1-1:1.0: 6 ports detected
[    2.997464]  sda: sda1 sda2
[    2.999069] i8042: [1087] fa <- i8042 (interrupt, 1, 12)
[    2.999923] i8042: [1088] 00 <- i8042 (interrupt, 1, 12)
[    2.999939] i8042: [1089] 60 -> i8042 (command)
[    3.000102] i8042: [1089] 45 -> i8042 (parameter)
[    3.000317] i8042: [1089] 60 -> i8042 (command)
[    3.000531] i8042: [1089] 47 -> i8042 (parameter)
[    3.000767] i8042: [1089] d4 -> i8042 (command)
[    3.000930] i8042: [1089] f2 -> i8042 (parameter)
[    3.004925] i8042: [1089] fa <- i8042 (interrupt, 1, 12)
[    3.005855] i8042: [1094] 00 <- i8042 (interrupt, 1, 12)
[    3.005871] i8042: [1095] d4 -> i8042 (command)
[    3.006034] i8042: [1095] f6 -> i8042 (parameter)
[    3.009373] i8042: [1095] fa <- i8042 (interrupt, 1, 12)
[    3.009391] i8042: [1099] d4 -> i8042 (command)
[    3.009609] i8042: [1099] f3 -> i8042 (parameter)
[    3.012027] i8042: [1099] fa <- i8042 (interrupt, 1, 12)
[    3.012042] i8042: [1101] d4 -> i8042 (command)
[    3.012206] i8042: [1101] 0a -> i8042 (parameter)
[    3.015493] i8042: [1101] fa <- i8042 (interrupt, 1, 12)
[    3.015508] i8042: [1105] d4 -> i8042 (command)
[    3.015725] i8042: [1105] e8 -> i8042 (parameter)
[    3.018010] i8042: [1105] fa <- i8042 (interrupt, 1, 12)
[    3.018029] i8042: [1107] d4 -> i8042 (command)
[    3.018192] i8042: [1107] 00 -> i8042 (parameter)
[    3.020628] i8042: [1107] fa <- i8042 (interrupt, 1, 12)
[    3.020643] i8042: [1110] d4 -> i8042 (command)
[    3.020807] i8042: [1110] f3 -> i8042 (parameter)
[    3.023287] i8042: [1110] fa <- i8042 (interrupt, 1, 12)
[    3.023302] i8042: [1112] d4 -> i8042 (command)
[    3.023465] i8042: [1112] 14 -> i8042 (parameter)
[    3.026067] i8042: [1113] fa <- i8042 (interrupt, 1, 12)
[    3.026083] i8042: [1115] d4 -> i8042 (command)
[    3.026247] i8042: [1115] f3 -> i8042 (parameter)
[    3.029425] i8042: [1115] fa <- i8042 (interrupt, 1, 12)
[    3.029440] i8042: [1119] d4 -> i8042 (command)
[    3.029708] i8042: [1119] 3c -> i8042 (parameter)
[    3.031965] i8042: [1119] fa <- i8042 (interrupt, 1, 12)
[    3.031981] i8042: [1121] d4 -> i8042 (command)
[    3.032144] i8042: [1121] f3 -> i8042 (parameter)
[    3.034971] i8042: [1121] fa <- i8042 (interrupt, 1, 12)
[    3.034987] i8042: [1124] d4 -> i8042 (command)
[    3.035149] i8042: [1124] 28 -> i8042 (parameter)
[    3.037422] i8042: [1124] fa <- i8042 (interrupt, 1, 12)
[    3.037436] i8042: [1127] d4 -> i8042 (command)
[    3.037600] i8042: [1127] f3 -> i8042 (parameter)
[    3.040473] i8042: [1127] fa <- i8042 (interrupt, 1, 12)
[    3.040490] i8042: [1130] d4 -> i8042 (command)
[    3.040757] i8042: [1130] 14 -> i8042 (parameter)
[    3.043019] i8042: [1130] fa <- i8042 (interrupt, 1, 12)
[    3.043034] i8042: [1132] d4 -> i8042 (command)
[    3.043198] i8042: [1132] f3 -> i8042 (parameter)
[    3.046227] i8042: [1132] fa <- i8042 (interrupt, 1, 12)
[    3.046243] i8042: [1135] d4 -> i8042 (command)
[    3.046408] i8042: [1135] 14 -> i8042 (parameter)
[    3.048701] i8042: [1135] fa <- i8042 (interrupt, 1, 12)
[    3.048718] i8042: [1138] d4 -> i8042 (command)
[    3.048882] i8042: [1138] f3 -> i8042 (parameter)
[    3.051911] i8042: [1138] fa <- i8042 (interrupt, 1, 12)
[    3.051926] i8042: [1141] d4 -> i8042 (command)
[    3.052194] i8042: [1141] 3c -> i8042 (parameter)
[    3.054453] i8042: [1141] fa <- i8042 (interrupt, 1, 12)
[    3.054467] i8042: [1144] d4 -> i8042 (command)
[    3.054630] i8042: [1144] f3 -> i8042 (parameter)
[    3.060839] i8042: [1144] fa <- i8042 (interrupt, 1, 12)
[    3.060853] i8042: [1150] d4 -> i8042 (command)
[    3.061069] i8042: [1150] 28 -> i8042 (parameter)
[    3.063300] i8042: [1150] fa <- i8042 (interrupt, 1, 12)
[    3.063316] i8042: [1153] d4 -> i8042 (command)
[    3.063479] i8042: [1153] f3 -> i8042 (parameter)
[    3.066150] i8042: [1153] fa <- i8042 (interrupt, 1, 12)
[    3.066166] i8042: [1155] d4 -> i8042 (command)
[    3.066329] i8042: [1155] 14 -> i8042 (parameter)
[    3.068591] i8042: [1156] fa <- i8042 (interrupt, 1, 12)
[    3.068608] i8042: [1158] d4 -> i8042 (command)
[    3.068772] i8042: [1158] f3 -> i8042 (parameter)
[    3.071764] i8042: [1158] fa <- i8042 (interrupt, 1, 12)
[    3.071780] i8042: [1161] d4 -> i8042 (command)
[    3.071943] i8042: [1161] 14 -> i8042 (parameter)
[    3.074268] i8042: [1161] fa <- i8042 (interrupt, 1, 12)
[    3.074285] i8042: [1164] d4 -> i8042 (command)
[    3.074448] i8042: [1164] f2 -> i8042 (parameter)
[    3.077037] i8042: [1164] fa <- i8042 (interrupt, 1, 12)
[    3.077906] i8042: [1166] 00 <- i8042 (interrupt, 1, 12)
[    3.077922] i8042: [1167] d4 -> i8042 (command)
[    3.078085] i8042: [1167] e8 -> i8042 (parameter)
[    3.080814] i8042: [1167] fa <- i8042 (interrupt, 1, 12)
[    3.080830] i8042: [1170] d4 -> i8042 (command)
[    3.081046] i8042: [1170] 00 -> i8042 (parameter)
[    3.083272] i8042: [1170] fa <- i8042 (interrupt, 1, 12)
[    3.083288] i8042: [1173] d4 -> i8042 (command)
[    3.083555] i8042: [1173] e8 -> i8042 (parameter)
[    3.085294] IO APIC #2......
[    3.085295] .... register #00: 02000000
[    3.085296] .......    : physical APIC id: 02
[    3.085297] .......    : Delivery Type: 0
[    3.085298] .......    : LTS          : 0
[    3.085299] .... register #01: 00170020
[    3.085300] .......     : max redirection entries: 17
[    3.085301] .......     : PRQ implemented: 0
[    3.085302] .......     : IO APIC version: 20
[    3.085302] .... IRQ redirection table:
[    3.085303]  NR Indx Fmt Mask Trig IRR Pol Stat Indx2 Zero Vect:
[    3.085308]  00 0000 0   1    0    0   0   0    0     0    00
[    3.085313]  01 0011 1   0    0    0   0   0    0     0    01
[    3.085318]  02 0001 1   0    0    0   0   0    0     0    02
[    3.085323]  03 0002 1   0    0    0   0   0    0     0    03
[    3.085328]  04 0003 1   0    0    0   0   0    0     0    04
[    3.085333]  05 0004 1   0    0    0   0   0    0     0    05
[    3.085342]  06 0005 1   0    0    0   0   0    0     0    06
[    3.085347]  07 0006 1   0    0    0   0   0    0     0    07
[    3.085352]  08 0010 1   0    0    0   0   0    0     0    08
[    3.085356]  09 0008 1   0    1    0   0   0    0     0    09
[    3.085363]  0a 0009 1   0    0    0   0   0    0     0    0A
[    3.085368]  0b 000A 1   0    0    0   0   0    0     0    0B
[    3.085373]  0c 0012 1   0    0    0   0   0    0     0    0C
[    3.085378]  0d 000F 1   0    0    0   0   0    0     0    0D
[    3.085383]  0e 000D 1   0    0    0   0   0    0     0    0E
[    3.085388]  0f 000E 1   0    0    0   0   0    0     0    0F
[    3.085393]  10 0014 1   0    1    0   1   0    0     0    10
[    3.085398]  11 0015 1   1    1    0   1   0    0     0    11
[    3.085402]  12 0000 0   1    0    0   0   0    0     0    00
[    3.085407]  13 0016 1   1    1    0   1   0    0     0    13
[    3.085412]  14 0013 1   0    0    0   0   0    0     0    14
[    3.085417]  15 0000 0   1    0    0   0   0    0     0    00
[    3.085421]  16 0000 0   1    0    0   0   0    0     0    00
[    3.085426]  17 0019 1   0    1    0   1   0    0     0    17
[    3.085428] IRQ to pin mappings:
[    3.085429] IRQ0 -> 0:2
[    3.085431] IRQ1 -> 0:1
[    3.085432] IRQ3 -> 0:3
[    3.085433] IRQ4 -> 0:4
[    3.085435] IRQ5 -> 0:5
[    3.085436] IRQ6 -> 0:6
[    3.085437] IRQ7 -> 0:7
[    3.085438] IRQ8 -> 0:8
[    3.085440] IRQ9 -> 0:9
[    3.085441] IRQ10 -> 0:10
[    3.085443] IRQ11 -> 0:11
[    3.085444] IRQ12 -> 0:12
[    3.085445] IRQ13 -> 0:13
[    3.085446] IRQ14 -> 0:14
[    3.085448] IRQ15 -> 0:15
[    3.085449] IRQ16 -> 0:16
[    3.085450] IRQ17 -> 0:17
[    3.085451] IRQ19 -> 0:19
[    3.085453] IRQ20 -> 0:20
[    3.085454] IRQ23 -> 0:23
[    3.085455] .................................... done.
[    3.085478] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.086479] i8042: [1175] fa <- i8042 (interrupt, 1, 12)
[    3.086492] i8042: [1176] d4 -> i8042 (command)
[    3.086656] i8042: [1176] 00 -> i8042 (parameter)
[    3.089087] i8042: [1176] fa <- i8042 (interrupt, 1, 12)
[    3.089102] i8042: [1178] d4 -> i8042 (command)
[    3.089370] i8042: [1178] e8 -> i8042 (parameter)
[    3.091996] i8042: [1178] fa <- i8042 (interrupt, 1, 12)
[    3.092012] i8042: [1181] d4 -> i8042 (command)
[    3.092227] i8042: [1181] 00 -> i8042 (parameter)
[    3.094467] i8042: [1181] fa <- i8042 (interrupt, 1, 12)
[    3.094483] i8042: [1184] d4 -> i8042 (command)
[    3.094648] i8042: [1184] e8 -> i8042 (parameter)
[    3.097145] i8042: [1184] fa <- i8042 (interrupt, 1, 12)
[    3.097161] i8042: [1186] d4 -> i8042 (command)
[    3.097427] i8042: [1186] 00 -> i8042 (parameter)
[    3.099660] i8042: [1187] fa <- i8042 (interrupt, 1, 12)
[    3.099675] i8042: [1189] d4 -> i8042 (command)
[    3.099838] i8042: [1189] e9 -> i8042 (parameter)
[    3.100250] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    3.102322] i8042: [1189] fa <- i8042 (interrupt, 1, 12)
[    3.103328] i8042: [1192] 33 <- i8042 (interrupt, 1, 12)
[    3.104331] i8042: [1193] cc <- i8042 (interrupt, 1, 12)
[    3.105784] i8042: [1193] a3 <- i8042 (interrupt, 1, 12)
[    3.105799] i8042: [1195] d4 -> i8042 (command)
[    3.106067] i8042: [1195] f6 -> i8042 (parameter)
[    3.108584] i8042: [1195] fa <- i8042 (interrupt, 1, 12)
[    3.108600] i8042: [1198] d4 -> i8042 (command)
[    3.108762] i8042: [1198] e8 -> i8042 (parameter)
[    3.111662] i8042: [1198] fa <- i8042 (interrupt, 1, 12)
[    3.111677] i8042: [1201] d4 -> i8042 (command)
[    3.111945] i8042: [1201] 00 -> i8042 (parameter)
[    3.114237] i8042: [1201] fa <- i8042 (interrupt, 1, 12)
[    3.114254] i8042: [1204] d4 -> i8042 (command)
[    3.114522] i8042: [1204] e6 -> i8042 (parameter)
[    3.117199] i8042: [1204] fa <- i8042 (interrupt, 1, 12)
[    3.117214] i8042: [1207] d4 -> i8042 (command)
[    3.117378] i8042: [1207] e6 -> i8042 (parameter)
[    3.119700] i8042: [1207] fa <- i8042 (interrupt, 1, 12)
[    3.119715] i8042: [1209] d4 -> i8042 (command)
[    3.119880] i8042: [1209] e6 -> i8042 (parameter)
[    3.123090] i8042: [1209] fa <- i8042 (interrupt, 1, 12)
[    3.123105] i8042: [1212] d4 -> i8042 (command)
[    3.123320] i8042: [1212] e9 -> i8042 (parameter)
[    3.125623] i8042: [1212] fa <- i8042 (interrupt, 1, 12)
[    3.126956] i8042: [1215] 05 <- i8042 (interrupt, 1, 12)
[    3.127832] i8042: [1216] 00 <- i8042 (interrupt, 1, 12)
[    3.128715] i8042: [1216] 64 <- i8042 (interrupt, 1, 12)
[    3.128731] i8042: [1218] d4 -> i8042 (command)
[    3.128894] i8042: [1218] f6 -> i8042 (parameter)
[    3.132087] i8042: [1218] fa <- i8042 (interrupt, 1, 12)
[    3.132101] i8042: [1221] d4 -> i8042 (command)
[    3.132265] i8042: [1221] f5 -> i8042 (parameter)
[    3.134770] i8042: [1222] fa <- i8042 (interrupt, 1, 12)
[    3.134786] i8042: [1224] d4 -> i8042 (command)
[    3.134949] i8042: [1224] e6 -> i8042 (parameter)
[    3.137759] i8042: [1224] fa <- i8042 (interrupt, 1, 12)
[    3.137773] i8042: [1227] d4 -> i8042 (command)
[    3.137935] i8042: [1227] e6 -> i8042 (parameter)
[    3.140370] i8042: [1227] fa <- i8042 (interrupt, 1, 12)
[    3.140385] i8042: [1230] d4 -> i8042 (command)
[    3.140654] i8042: [1230] e6 -> i8042 (parameter)
[    3.143061] i8042: [1230] fa <- i8042 (interrupt, 1, 12)
[    3.143076] i8042: [1232] d4 -> i8042 (command)
[    3.143291] i8042: [1232] e9 -> i8042 (parameter)
[    3.145630] i8042: [1232] fa <- i8042 (interrupt, 1, 12)
[    3.147022] i8042: [1235] 05 <- i8042 (interrupt, 1, 12)
[    3.147898] i8042: [1236] 02 <- i8042 (interrupt, 1, 12)
[    3.148782] i8042: [1236] 64 <- i8042 (interrupt, 1, 12)
[    3.148796] i8042: [1238] d4 -> i8042 (command)
[    3.148959] i8042: [1238] e8 -> i8042 (parameter)
[    3.151988] PM: Checking hibernation image partition /dev/system/swap
[    3.152061] i8042: [1241] fa <- i8042 (interrupt, 1, 12)
[    3.152134] i8042: [1241] d4 -> i8042 (command)
[    3.152298] i8042: [1242] 03 -> i8042 (parameter)
[    3.154621] i8042: [1244] fa <- i8042 (interrupt, 1, 12)
[    3.154707] i8042: [1244] d4 -> i8042 (command)
[    3.154818] i8042: [1244] e6 -> i8042 (parameter)
[    3.157874] i8042: [1247] fa <- i8042 (interrupt, 1, 12)
[    3.157971] i8042: [1247] d4 -> i8042 (command)
[    3.158134] i8042: [1247] e6 -> i8042 (parameter)
[    3.160475] i8042: [1250] fa <- i8042 (interrupt, 1, 12)
[    3.160558] i8042: [1250] d4 -> i8042 (command)
[    3.160669] i8042: [1250] e6 -> i8042 (parameter)
[    3.163664] i8042: [1253] fa <- i8042 (interrupt, 1, 12)
[    3.163788] i8042: [1253] d4 -> i8042 (command)
[    3.163900] i8042: [1253] e9 -> i8042 (parameter)
[    3.167138] i8042: [1256] fa <- i8042 (interrupt, 1, 12)
[    3.168005] i8042: [1257] 05 <- i8042 (interrupt, 1, 12)
[    3.168892] i8042: [1258] 03 <- i8042 (interrupt, 1, 12)
[    3.169776] i8042: [1259] 64 <- i8042 (interrupt, 1, 12)
[    3.169856] i8042: [1259] d4 -> i8042 (command)
[    3.169966] i8042: [1259] e8 -> i8042 (parameter)
[    3.173330] i8042: [1263] fa <- i8042 (interrupt, 1, 12)
[    3.173421] i8042: [1263] d4 -> i8042 (command)
[    3.173639] i8042: [1263] 00 -> i8042 (parameter)
[    3.175962] i8042: [1265] fa <- i8042 (interrupt, 1, 12)
[    3.176044] i8042: [1265] d4 -> i8042 (command)
[    3.176209] i8042: [1265] e6 -> i8042 (parameter)
[    3.178726] i8042: [1268] fa <- i8042 (interrupt, 1, 12)
[    3.178820] i8042: [1268] d4 -> i8042 (command)
[    3.178931] i8042: [1268] e6 -> i8042 (parameter)
[    3.181375] i8042: [1271] fa <- i8042 (interrupt, 1, 12)
[    3.181499] i8042: [1271] d4 -> i8042 (command)
[    3.182240] i8042: [1271] e6 -> i8042 (parameter)
[    3.184747] i8042: [1274] fa <- i8042 (interrupt, 1, 12)
[    3.184842] i8042: [1274] d4 -> i8042 (command)
[    3.184954] i8042: [1274] e9 -> i8042 (parameter)
[    3.187999] i8042: [1277] fa <- i8042 (interrupt, 1, 12)
[    3.188866] i8042: [1278] 05 <- i8042 (interrupt, 1, 12)
[    3.189767] i8042: [1279] 00 <- i8042 (interrupt, 1, 12)
[    3.190756] i8042: [1280] 64 <- i8042 (interrupt, 1, 12)
[    3.190841] i8042: [1280] d4 -> i8042 (command)
[    3.190953] i8042: [1280] e1 -> i8042 (parameter)
[    3.215928] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    3.237807] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    3.259900] hub 2-1:1.0: USB hub found
[    3.281547] hub 2-1:1.0: 8 ports detected
[    3.299961] ata5: SATA link down (SStatus 0 SControl 300)
[    3.389927] i8042: [1480] d4 -> i8042 (command)
[    3.390091] i8042: [1480] 0a -> i8042 (parameter)
[    3.398162] usb 1-1.4: new high-speed USB device number 3 using ehci_h=
cd
[    3.561936] usb 1-1.4: New USB device found, idVendor=3D0c45,=20
idProduct=3D642a
[    3.583110] usb 1-1.4: New USB device strings: Mfr=3D2, Product=3D1,=20
SerialNumber=3D0
[    3.589561] i8042: [1680] d4 -> i8042 (command)
[    3.589671] i8042: [1680] f5 -> i8042 (parameter)
[    3.604568] i8042: [1695] fa <- i8042 (interrupt, 1, 12)
[    3.604573] usb 1-1.4: Product: Laptop_Integrated_Webcam_2HDM
[    3.604613] i8042: [1695] d4 -> i8042 (command)
[    3.604725] i8042: [1695] f3 -> i8042 (parameter)
[    3.626275] i8042: [1716] fa <- i8042 (interrupt, 1, 12)
[    3.626278] usb 1-1.4: Manufacturer: CN0XRCWG724871ANS3CZA00
[    3.626320] i8042: [1716] d4 -> i8042 (command)
[    3.626484] i8042: [1716] 66 -> i8042 (parameter)
[    3.648215] i8042: [1738] fe <- i8042 (interrupt, 1, 12)
[    3.648259] i8042: [1738] d4 -> i8042 (command)
[    3.648424] i8042: [1738] 88 -> i8042 (parameter)
[    3.678465] i8042: [1769] d4 -> i8042 (command)
[    3.678643] i8042: [1769] f3 -> i8042 (parameter)
[    3.681134] i8042: [1771] fc <- i8042 (interrupt, 1, 12)
[    3.681225] i8042: [1771] d4 -> i8042 (command)
[    3.681336] i8042: [1771] f4 -> i8042 (parameter)
[    3.684450] i8042: [1775] fa <- i8042 (interrupt, 1, 12)
[    3.684574] i8042: [1775] d4 -> i8042 (command)
[    3.684791] i8042: [1775] f6 -> i8042 (parameter)
[    3.688413] i8042: [1779] fa <- i8042 (interrupt, 1, 12)
[    3.688507] i8042: [1779] d4 -> i8042 (command)
[    3.689512] i8042: [1779] ff -> i8042 (parameter)
[    3.692089] i8042: [1782] fa <- i8042 (interrupt, 1, 12)
[    3.726675] usb 2-1.5: new full-speed USB device number 3 using ehci_h=
cd
[    3.838521] usb 2-1.5: New USB device found, idVendor=3D8086,=20
idProduct=3D0189
[    3.861231] usb 2-1.5: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    3.892268] i8042: [1983] aa <- i8042 (interrupt, 1, 12)
[    3.893135] i8042: [1984] 00 <- i8042 (interrupt, 1, 12)
[    3.893215] i8042: [1984] d4 -> i8042 (command)
[    3.893483] i8042: [1984] f3 -> i8042 (parameter)
[    3.896588] i8042: [1987] fa <- i8042 (interrupt, 1, 12)
[    3.896676] i8042: [1987] d4 -> i8042 (command)
[    3.896787] i8042: [1987] c8 -> i8042 (parameter)
[    3.899159] i8042: [1990] fa <- i8042 (interrupt, 1, 12)
[    3.899238] i8042: [1990] d4 -> i8042 (command)
[    3.899454] i8042: [1990] f3 -> i8042 (parameter)
[    3.902540] i8042: [1993] fa <- i8042 (interrupt, 1, 12)
[    3.902664] i8042: [1993] d4 -> i8042 (command)
[    3.902775] i8042: [1993] 64 -> i8042 (parameter)
[    3.905189] i8042: [1996] fa <- i8042 (interrupt, 1, 12)
[    3.905283] i8042: [1996] d4 -> i8042 (command)
[    3.905973] i8042: [1996] f3 -> i8042 (parameter)
[    3.908560] i8042: [1999] fa <- i8042 (interrupt, 1, 12)
[    3.908653] i8042: [1999] d4 -> i8042 (command)
[    3.908765] i8042: [1999] 50 -> i8042 (parameter)
[    3.911650] i8042: [2002] fa <- i8042 (interrupt, 1, 12)
[    3.911743] i8042: [2002] d4 -> i8042 (command)
[    3.911855] i8042: [2002] f2 -> i8042 (parameter)
[    3.914438] i8042: [2005] fa <- i8042 (interrupt, 1, 12)
[    3.915312] i8042: [2006] 03 <- i8042 (interrupt, 1, 12)
[    3.915406] i8042: [2006] d4 -> i8042 (command)
[    3.916096] i8042: [2006] f3 -> i8042 (parameter)
[    3.918631] i8042: [2009] fa <- i8042 (interrupt, 1, 12)
[    3.918752] i8042: [2009] d4 -> i8042 (command)
[    3.918864] i8042: [2009] c8 -> i8042 (parameter)
[    3.921832] i8042: [2012] fa <- i8042 (interrupt, 1, 12)
[    3.921958] i8042: [2012] d4 -> i8042 (command)
[    3.922122] i8042: [2012] f3 -> i8042 (parameter)
[    3.924645] i8042: [2015] fa <- i8042 (interrupt, 1, 12)
[    3.924738] i8042: [2015] d4 -> i8042 (command)
[    3.924850] i8042: [2015] c8 -> i8042 (parameter)
[    3.927376] i8042: [2018] fa <- i8042 (interrupt, 1, 12)
[    3.927502] i8042: [2018] d4 -> i8042 (command)
[    3.927667] i8042: [2018] f3 -> i8042 (parameter)
[    3.930190] i8042: [2021] fa <- i8042 (interrupt, 1, 12)
[    3.930313] i8042: [2021] d4 -> i8042 (command)
[    3.931428] i8042: [2021] 50 -> i8042 (parameter)
[    3.933733] i8042: [2024] fa <- i8042 (interrupt, 1, 12)
[    3.933824] i8042: [2024] d4 -> i8042 (command)
[    3.933936] i8042: [2024] f2 -> i8042 (parameter)
[    3.936990] i8042: [2027] fa <- i8042 (interrupt, 1, 12)
[    3.937836] i8042: [2028] 03 <- i8042 (interrupt, 1, 12)
[    3.937931] i8042: [2028] d4 -> i8042 (command)
[    3.938042] i8042: [2028] f3 -> i8042 (parameter)
[    3.941461] i8042: [2032] fa <- i8042 (interrupt, 1, 12)
[    3.941554] i8042: [2032] d4 -> i8042 (command)
[    3.941770] i8042: [2032] c8 -> i8042 (parameter)
[    3.944095] i8042: [2035] fa <- i8042 (interrupt, 1, 12)
[    3.944219] i8042: [2035] d4 -> i8042 (command)
[    3.944330] i8042: [2035] f3 -> i8042 (parameter)
[    3.947216] i8042: [2038] fa <- i8042 (interrupt, 1, 12)
[    3.947324] i8042: [2038] d4 -> i8042 (command)
[    3.947488] i8042: [2038] 64 -> i8042 (parameter)
[    3.949809] i8042: [2040] fa <- i8042 (interrupt, 1, 12)
[    3.949903] i8042: [2040] d4 -> i8042 (command)
[    3.950015] i8042: [2040] f3 -> i8042 (parameter)
[    3.952817] i8042: [2043] fa <- i8042 (interrupt, 1, 12)
[    3.952941] i8042: [2043] d4 -> i8042 (command)
[    3.953053] i8042: [2043] 50 -> i8042 (parameter)
[    3.955464] i8042: [2046] fa <- i8042 (interrupt, 1, 12)
[    3.955589] i8042: [2046] d4 -> i8042 (command)
[    3.955753] i8042: [2046] f2 -> i8042 (parameter)
[    3.958834] i8042: [2049] fa <- i8042 (interrupt, 1, 12)
[    3.959841] i8042: [2050] 03 <- i8042 (interrupt, 1, 12)
[    3.959980] i8042: [2051] d4 -> i8042 (command)
[    3.960092] i8042: [2051] f3 -> i8042 (parameter)
[    3.963087] i8042: [2054] fa <- i8042 (interrupt, 1, 12)
[    3.963213] i8042: [2054] d4 -> i8042 (command)
[    3.963378] i8042: [2054] 64 -> i8042 (parameter)
[    3.965850] i8042: [2056] fa <- i8042 (interrupt, 1, 12)
[    3.965945] i8042: [2056] d4 -> i8042 (command)
[    3.966056] i8042: [2056] e8 -> i8042 (parameter)
[    3.968700] i8042: [2059] fa <- i8042 (interrupt, 1, 12)
[    3.968794] i8042: [2059] d4 -> i8042 (command)
[    3.968959] i8042: [2059] 03 -> i8042 (parameter)
[    3.971304] i8042: [2062] fa <- i8042 (interrupt, 1, 12)
[    3.971398] i8042: [2062] d4 -> i8042 (command)
[    3.974350] i8042: [2062] e6 -> i8042 (parameter)
[    3.976879] i8042: [2067] fa <- i8042 (interrupt, 1, 12)
[    3.977018] input: ImPS/2 Generic Wheel Mouse as=20
/devices/platform/i8042/serio1/input/input1
[    4.000810] i8042: [2091] d4 -> i8042 (command)
[    4.000921] i8042: [2091] f4 -> i8042 (parameter)
[    4.003458] i8042: [2094] fa <- i8042 (interrupt, 1, 12)
[    4.003598] PM: Hibernation image not present or could not be loaded.
[    4.003620] registered taskstats version 1
[    4.035412]   Magic number: 7:990:357
[    4.059596] rtc_cmos 00:05: setting system clock to 2011-12-27=20
01:23:24 UTC (1324949004)
[    4.085662] Freeing unused kernel memory: 944k freed
[    4.110469] Write protecting the kernel read-only data: 12288k
[    4.135741] Freeing unused kernel memory: 192k freed
[    4.164739] Freeing unused kernel memory: 1944k freed
[    4.241203] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.266531] shpchp: shpcd_init: pci_register_driver =3D 0
[    4.266533] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
[    4.322294] udevd[131]: starting version 173
[    4.356829] input: Power Button as=20
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    4.393554] ACPI: Power Button [PWRB]
[    4.393740] thermal LNXTHERM:00: registered as thermal_zone0
[    4.393743] ACPI: Thermal Zone [TZ00] (54 C)
[    4.393978] thermal LNXTHERM:01: registered as thermal_zone1
[    4.393981] ACPI: Thermal Zone [TZ01] (54 C)
[    4.522579]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:04:00.0[A] _PRT entry
[    4.522586] xhci_hcd 0000:04:00.0: PCI INT A -> GSI 19 (level, low)=20
-> IRQ 19
[    4.522610] xhci_hcd 0000:04:00.0: setting latency timer to 64
[    4.522615] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    4.522627] xhci_hcd 0000:04:00.0: new USB bus registered, assigned=20
bus number 3
[    4.522834] xhci_hcd 0000:04:00.0: irq 19, io mem 0xf1a00000
[    4.522906] xhci_hcd 0000:04:00.0: irq 44 for MSI/MSI-X
[    4.522913] xhci_hcd 0000:04:00.0: irq 45 for MSI/MSI-X
[    4.522918] xhci_hcd 0000:04:00.0: irq 46 for MSI/MSI-X
[    4.522924] xhci_hcd 0000:04:00.0: irq 47 for MSI/MSI-X
[    4.522929] xhci_hcd 0000:04:00.0: irq 48 for MSI/MSI-X
[    4.523002] input: Sleep Button as=20
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[    4.523043] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    4.523045] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    4.523047] usb usb3: Product: xHCI Host Controller
[    4.523049] usb usb3: Manufacturer: Linux 3.2.0-rc6-3-desktop xhci_hcd
[    4.523050] usb usb3: SerialNumber: 0000:04:00.0
[    4.523265] xHCI xhci_add_endpoint called for root hub
[    4.523267] xHCI xhci_check_bandwidth called for root hub
[    4.523328] hub 3-0:1.0: USB hub found
[    4.523339] hub 3-0:1.0: 2 ports detected
[    4.523379] ACPI: Sleep Button [SLPB]
[    4.523426] input: Lid Switch as=20
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input4
[    4.523478] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    4.523488] xhci_hcd 0000:04:00.0: new USB bus registered, assigned=20
bus number 4
[    4.524286] ACPI: Lid Switch [LID0]
[    4.524340] input: Power Button as=20
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    4.524373] ACPI: Power Button [PWRF]
[    4.526215] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    4.526218] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    4.526220] usb usb4: Product: xHCI Host Controller
[    4.526222] usb usb4: Manufacturer: Linux 3.2.0-rc6-3-desktop xhci_hcd
[    4.526223] usb usb4: SerialNumber: 0000:04:00.0
[    4.526375] xHCI xhci_add_endpoint called for root hub
[    4.526377] xHCI xhci_check_bandwidth called for root hub
[    4.526439] hub 4-0:1.0: USB hub found
[    4.526448] hub 4-0:1.0: 2 ports detected
[    4.526942] [drm] Initialized drm 1.1.0 20060810
[    4.531282]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:02.0[A] _PRT entry
[    4.531289] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ=
 16
[    4.531292] i915 0000:00:02.0: setting latency timer to 64
[    5.368663] i915 0000:00:02.0: irq 49 for MSI/MSI-X
[    5.368666] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010)=
.
[    5.368667] [drm] Driver supports precise vblank timestamp query.
[    5.378777] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call=20
failed
[    5.378819] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call=20
failed
[    5.378837] vgaarb: device changed decodes:=20
PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[    5.378839] vgaarb: transferring owner from PCI:0000:00:02.0 to=20
PCI:0000:01:00.0
[    5.569660] usb 3-1: new low-speed USB device number 2 using xhci_hcd
[    5.609793] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.621761] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.633738] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.638365] usb 3-1: New USB device found, idVendor=3D04ca, idProduct=3D=
0027
[    5.642881] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[    5.647346] usb 3-1: Product: USB Multimedia Keyboard
[    5.651787] usb 3-1: Manufacturer: Lite-On Technology Corp.
[    5.656387] usb 3-1: ep 0x81 - rounding interval to 128 microframes,=20
ep desc says 192 microframes
[    5.660984] usb 3-1: ep 0x82 - rounding interval to 64 microframes,=20
ep desc says 80 microframes
[    5.680911] input: Lite-On Technology Corp. USB Multimedia Keyboard=20
as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1/3-1:1.0/input/inpu=
t6
[    5.685919] generic-usb 0003:04CA:0027.0001: input,hidraw0: USB HID=20
v1.10 Keyboard [Lite-On Technology Corp. USB Multimedia Keyboard] on=20
usb-0000:04:00.0-1/input0
[    5.721562] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.728628] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.735543] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.740403] input: Lite-On Technology Corp. USB Multimedia Keyboard=20
as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1/3-1:1.1/input/inpu=
t7
[    5.745533] generic-usb 0003:04CA:0027.0002: input,hiddev0,hidraw1:=20
USB HID v1.10 Device [Lite-On Technology Corp. USB Multimedia Keyboard]=20
on usb-0000:04:00.0-1/input1
[    5.857203] usb 3-2: new high-speed USB device number 3 using xhci_hcd
[    5.876155] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.881610] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.886481] usb 3-2: New USB device found, idVendor=3D05e3, idProduct=3D=
0608
[    5.891212] usb 3-2: New USB device strings: Mfr=3D0, Product=3D1,=20
SerialNumber=3D0
[    5.895947] usb 3-2: Product: USB2.0 Hub
[    5.901665] hub 3-2:1.0: USB hub found
[    5.906793] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.911512] hub 3-2:1.0: 4 ports detected
[    5.945622] checking generic (e0000000 3ff0000) vs hw (e0000000 100000=
00)
[    5.945624] fb: conflicting fb hw usage inteldrmfb vs VESA VGA -=20
removing generic driver
[    5.950427] Console: switching to colour dummy device 80x25
[    5.951515] fbcon: inteldrmfb (fb0) is primary device
[    6.186212] usb 3-2.4: new high-speed USB device number 4 using xhci_h=
cd
[    6.200498] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.201158] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.201314] usb 3-2.4: New USB device found, idVendor=3D05e3,=20
idProduct=3D0608
[    6.201321] usb 3-2.4: New USB device strings: Mfr=3D0, Product=3D1,=20
SerialNumber=3D0
[    6.201327] usb 3-2.4: Product: USB2.0 Hub
[    6.202290] hub 3-2.4:1.0: USB hub found
[    6.202750] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.202925] hub 3-2.4:1.0: 4 ports detected
[    6.313235] Console: switching to colour frame buffer device 236x63
[    6.334979] fb0: inteldrmfb frame buffer device
[    6.335054] drm: registered panic notifier
[    6.335313] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    6.338677] acpi device:2e: registered as cooling_device4
[    6.338816] input: Video Bus as=20
/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:2d/LNXVIDEO:00/input/inp=
ut8
[    6.339007] ACPI: Video Device [PEGP] (multi-head: yes  rom: yes=20
post: no)
[    6.343258] acpi device:32: registered as cooling_device5
[    6.343536] input: Video Bus as=20
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input9
[    6.343717] ACPI: Video Device [GFX0] (multi-head: yes  rom: no=20
post: no)
[    6.343857] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on=20
minor 0
[    6.402163] Btrfs loaded
[    6.443076] md: linear personality registered for level -1
[    6.478910] device-mapper: uevent: version 1.0.3
[    6.479053] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19)=20
initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    6.482774] usb 3-2.4.4: new low-speed USB device number 5 using xhci_=
hcd
[    6.501092] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.503088] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.504086] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.504375] usb 3-2.4.4: New USB device found, idVendor=3D046d,=20
idProduct=3Dc063
[    6.509607] usb 3-2.4.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D0
[    6.514763] usb 3-2.4.4: Product: DELL USB Laser Mouse
[    6.519906] usb 3-2.4.4: Manufacturer: DELL
[    6.525207] usb 3-2.4.4: ep 0x81 - rounding interval to 64=20
microframes, ep desc says 80 microframes
[    6.536487] input: DELL DELL USB Laser Mouse as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-2/3-2.4/3-2.4.4/3-2.=
4.4:1.0/input/input10
[    6.542117] generic-usb 0003:046D:C063.0003: input,hidraw2: USB HID=20
v1.10 Mouse [DELL DELL USB Laser Mouse] on usb-0000:04:00.0-2.4.4/input0
[   39.516864] PM: Marking nosave pages: 000000000009d000 - 0000000000100=
000
[   39.516868] PM: Marking nosave pages: 00000000b5a28000 - 00000000b6e29=
000
[   39.516926] PM: Marking nosave pages: 00000000b886a000 - 00000000b8ab3=
000
[   39.516934] PM: Marking nosave pages: 00000000bac8f000 - 00000000bafff=
000
[   39.516945] PM: Marking nosave pages: 00000000bb000000 - 0000000100000=
000
[   39.517655] PM: Basic memory bitmaps created
[   39.540690] PM: Basic memory bitmaps freed
[   39.540694] video LNXVIDEO:00: Restoring backlight state
[   39.540695] video LNXVIDEO:01: Restoring backlight state
[   39.590164] PM: Starting manual resume from disk
[   39.595666] PM: Hibernation image partition 253:3 present
[   39.595669] PM: Looking for hibernation image.
[   39.597171] PM: Image not found (code -22)
[   39.597173] PM: Hibernation image not present or could not be loaded.
[   39.615833] device fsid ca00ffff-8c21-4750-b25c-3cf321a07dd9 devid 1=20
transid 21081 /dev/mapper/system-root
[   39.616353] btrfs: turning off barriers
[   39.616356] btrfs: enabling auto defrag
[   39.616357] btrfs: use lzo compression
[   39.616358] btrfs: disk space caching is enabled
[   39.661102] Btrfs detected SSD devices, enabling SSD mode
[   40.401467] btrfs: turning off barriers
[   40.407291] btrfs: enabling auto defrag
[   40.407352] btrfs: use lzo compression
[   40.418719] btrfs: disk space caching is enabled
[   40.683437] systemd[1]: systemd 37 running in system mode. (+PAM=20
+LIBWRAP +AUDIT +SELINUX +SYSVINIT +LIBCRYPTSETUP; suse)
[   40.731811] systemd[1]: Set hostname to <xps15z.cristianrodriguez.net>=
.
[   41.272117] udevd[606]: starting version 173
[   41.435290] mei: module is from the staging directory, the quality is=20
unknown, you have been warned.
[   41.435823]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:16.0[A] _PRT entry
[   41.435829] mei 0000:00:16.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[   41.435834] mei 0000:00:16.0: setting latency timer to 64
[   41.435901] mei 0000:00:16.0: irq 50 for MSI/MSI-X
[   41.473031] iTCO_vendor_support: vendor-support=3D0
[   41.477614]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:06:00.0[A] _PRT entry
[   41.477622] atl1c 0000:06:00.0: PCI INT A -> GSI 17 (level, low) ->=20
IRQ 17
[   41.477633] atl1c 0000:06:00.0: setting latency timer to 64
[   41.487779] mtp-probe[752]: checking bus 3, device 2:=20
"/sys/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1"
[   41.497929]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1f.3[C] _PRT entry
[   41.497940] IOAPIC[0]: Set routing entry (2-18 -> 0xb9 -> IRQ 18=20
Mode:1 Active:1 Dest:1)
[   41.497946] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:B9 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[   41.497951] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low)=20
-> IRQ 18
[   41.503468] mtp-probe[752]: bus: 3, device: 2 was not an MTP device
[   41.508295] ACPI: Deprecated procfs I/F for AC is loaded, please=20
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   41.508873] input: PC Speaker as /devices/platform/pcspkr/input/input1=
1
[   41.528598] mtp-probe[776]: checking bus 3, device 5:=20
"/sys/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-2/3-2.4/3-2.4.4=
"
[   41.533704] mtp-probe[776]: bus: 3, device: 5 was not an MTP device
[   41.538647] btrfs: turning off barriers
[   41.538650] btrfs: enabling auto defrag
[   41.538653] btrfs: use lzo compression
[   41.538653] btrfs: disk space caching is enabled
[   41.559847] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   41.568681] mtp-probe[794]: checking bus 1, device 3:=20
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4"
[   41.570805] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   41.578853] mtp-probe[794]: bus: 1, device: 3 was not an MTP device
[   41.587647] atl1c 0000:06:00.0: version 1.0.1.0-NAPI
[   41.593026] microcode: CPU0 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.597648] Bluetooth: Core ver 2.16
[   41.603983] NET: Registered protocol family 31
[   41.608008] ACPI: AC Adapter [ADP0] (on-line)
[   41.614610] Bluetooth: HCI device and connection manager initialized
[   41.614613] Bluetooth: HCI socket layer initialized
[   41.614615] Bluetooth: L2CAP socket layer initialized
[   41.614622] Bluetooth: SCO socket layer initialized
[   41.640484] microcode: CPU1 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.643741] microcode: CPU2 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.646724] microcode: CPU3 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.654637] microcode: Microcode Update Driver: v2.00=20
<tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[   41.676921] ACPI: Deprecated procfs I/F for battery is loaded, please=20
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   41.681836] ACPI: Battery Slot [BAT0] (battery present)
[   41.687239] wmi: Mapper loaded
[   41.693494] Linux video capture interface: v2.00
[   41.701454] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   41.701861] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[   41.701932] iTCO_wdt: Found a Cougar Point TCO device (Version=3D2,=20
TCOBASE=3D0x0460)
[   41.702023] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   41.702161] usbcore: registered new interface driver btusb
[   41.731287] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw=20
xa/form2 cdda caddy
[   41.731291] cdrom: Uniform CD-ROM driver Revision: 3.20
[   41.733075] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   41.742658] cfg80211: Calling CRDA to update world regulatory domain
[   41.755562] dcdbas dcdbas: Dell Systems Management Base Driver=20
(version 5.6.0-3.2)
[   41.766095] uvcvideo: Found UVC 1.00 device=20
Laptop_Integrated_Webcam_2HDM (0c45:642a)
[   41.772757] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:=
d
[   41.778771] Copyright(c) 2003-2011 Intel Corporation
[   41.778833] input: Laptop_Integrated_Webcam_2HDM as=20
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/input/input12
[   41.778960] usbcore: registered new interface driver uvcvideo
[   41.778962] USB Video Class driver (1.1.1)
[   41.802479]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1b.0[A] _PRT entry
[   41.807306]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:03:00.0[A] _PRT entry
[   41.807313] iwlwifi 0000:03:00.0: PCI INT A -> GSI 17 (level, low) ->=20
IRQ 17
[   41.807344] iwlwifi 0000:03:00.0: setting latency timer to 64
[   41.807397] iwlwifi 0000:03:00.0: pci_resource_len =3D 0x00002000
[   41.807399] iwlwifi 0000:03:00.0: pci_resource_base =3D ffffc900057fc0=
00
[   41.807401] iwlwifi 0000:03:00.0: HW Revision ID =3D 0x34
[   41.807630] iwlwifi 0000:03:00.0: irq 51 for MSI/MSI-X
[   41.807715] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R)=20
Advanced-N 6230 AGN, REV=3D0xB0
[   41.807861] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   41.823275] iwlwifi 0000:03:00.0: device EEPROM VER=3D0x716, CALIB=3D0=
x6
[   41.823278] iwlwifi 0000:03:00.0: Device SKU: 0X1f0
[   41.823280] iwlwifi 0000:03:00.0: Valid Tx ant: 0X3, Valid Rx ant: 0X3
[   41.823300] iwlwifi 0000:03:00.0: Tunable channels: 13 802.11bg, 24=20
802.11a channels
[   41.829386] ifup[893]: Service network not started and mode 'auto' ->=20
skipping
[   41.852847] cfg80211: World regulatory domain updated:
[   41.852849] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[   41.852850] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852852] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852853] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852854] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852855] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.920210] IOAPIC[0]: Set routing entry (2-22 -> 0xc9 -> IRQ 22=20
Mode:1 Active:1 Dest:1)
[   41.920216] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:C9 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[   41.920221] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,=20
low) -> IRQ 22
[   41.920290] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[   41.920313] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   41.920845] input: Dell WMI hotkeys as /devices/virtual/input/input13
[   41.940703] iwlwifi 0000:03:00.0: loaded firmware version 17.168.5.1=20
build 33993
[   41.940849] Registered led device: phy0-led
[   41.964426] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-r=
s'
[   42.010557] ifup[964]: Service network not started and mode 'auto' ->=20
skipping
[   42.174781] Adding 2097148k swap on /dev/mapper/system-swap.=20
Priority:0 extents:1 across:2097148k SS
[   44.925951] ALSA hda_intel.c:812 azx_get_response timeout, switching=20
to polling mode: last cmd=3D0x000f0000
[   45.437474] ALSA patch_realtek.c:1261 SKU: Nid=3D0x1d sku_cfg=3D0x4017=
9a2d
[   45.437477] ALSA patch_realtek.c:1263 SKU: port_connectivity=3D0x1
[   45.437478] ALSA patch_realtek.c:1264 SKU: enable_pcbeep=3D0x1
[   45.437480] ALSA patch_realtek.c:1265 SKU: check_sum=3D0x00000007
[   45.437481] ALSA patch_realtek.c:1266 SKU: customization=3D0x0000009a
[   45.437482] ALSA patch_realtek.c:1267 SKU: external_amp=3D0x5
[   45.437483] ALSA patch_realtek.c:1268 SKU: platform_type=3D0x1
[   45.437485] ALSA patch_realtek.c:1269 SKU: swap=3D0x0
[   45.437486] ALSA patch_realtek.c:1270 SKU: override=3D0x1
[   45.437895] ALSA hda_codec.c:4951 autoconfig: line_outs=3D1=20
(0x14/0x0/0x0/0x0/0x0) type:speaker
[   45.437897] ALSA hda_codec.c:4955    speaker_outs=3D0 (0x0/0x0/0x0/0x0=
/0x0)
[   45.437899] ALSA hda_codec.c:4959    hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0=
)
[   45.437900] ALSA hda_codec.c:4960    mono: mono_out=3D0x0
[   45.437901] ALSA hda_codec.c:4964    inputs:
[   45.437903] ALSA hda_codec.c:4968  Internal Mic=3D0x12
[   45.437904] ALSA hda_codec.c:4968  Mic=3D0x18
[   45.437905] ALSA hda_codec.c:4970
[   45.439163] ALSA patch_realtek.c:1324 realtek: No valid SSID,=20
checking pincfg 0x40179a2d for NID 0x1d
[   45.439165] ALSA patch_realtek.c:1340 realtek: Enabling init=20
ASM_ID=3D0x9a2d CODEC_ID=3D10ec0269
[   45.443482] HDMI status: Codec=3D3 Pin=3D6 Presence_Detect=3D0 ELD_Val=
id=3D0
[   45.448591] input: HDA Intel PCH HDMI/DP,pcm=3D3 as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   45.453689] input: HDA Intel PCH Mic as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   45.458609] input: HDA Intel PCH Headphone as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   45.710010] systemd-cryptsetup[1010]: Volume cr_sda2 already active.
[   45.787497] systemd-fsck[1005]: /dev/sda1: limpio, 63/40000 ficheros,=20
137097/159744 bloques
[   45.824455] device fsid 403609d3-a44c-4bb6-99c4-8be5430433e7 devid 1=20
transid 22126 /dev/mapper/system-home
[   45.829949] btrfs: turning off barriers
[   45.834896] btrfs: enabling auto defrag
[   45.834957] btrfs: use lzo compression
[   45.840735] EXT4-fs (sda1): barriers disabled
[   45.849518] btrfs: disk space caching is enabled
[   45.854628] EXT4-fs (sda1): mounted filesystem with writeback data=20
mode. Opts: acl,barrier=3D0,data=3Dwriteback,user_xattr
[   45.869431] Btrfs detected SSD devices, enabling SSD mode
[   47.174579] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   47.174581] Bluetooth: BNEP filters: protocol multicast
[   47.205249] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   47.215832] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   47.337233] Bluetooth: RFCOMM TTY layer initialized
[   47.337238] Bluetooth: RFCOMM socket layer initialized
[   47.337239] Bluetooth: RFCOMM ver 1.11
[   47.505097] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   47.511590] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   47.635461] atl1c 0000:06:00.0: irq 53 for MSI/MSI-X
[   47.635523] atl1c 0000:06:00.0: atl1c: eth0 NIC Link is Up<1000 Mbps=20
Full Duplex>
[   47.648775] NET: Registered protocol family 17
[   48.961311] EXT4-fs (sda1): re-mounted. Opts:=20
acl,barrier=3D0,data=3Dwriteback,user_xattr,commit=3D0
[   96.852567] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[   96.855107] wlan0: authenticated
[   96.896863] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[   96.903865] wlan0: RX AssocResp from 06:1c:f0:60:61:11 (capab=3D0x431=20
status=3D0 aid=3D1)
[   96.903869] wlan0: associated
[  106.895705] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  106.909897] cfg80211: Calling CRDA to update world regulatory domain
[  106.912356] cfg80211: World regulatory domain updated:
[  106.912359] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  106.912361] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912363] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912365] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912366] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912367] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  110.146828] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  110.149314] wlan0: authenticated
[  110.154157] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  110.159155] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  110.159157] wlan0: associated
[  120.042706] wlan0: deauthenticating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  120.054236] cfg80211: Calling CRDA to update world regulatory domain
[  120.056757] cfg80211: World regulatory domain updated:
[  120.056761] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  120.056763] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056764] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056766] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056767] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056769] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  138.190818] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  138.193402] wlan0: authenticated
[  138.196754] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  138.201826] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  138.201840] wlan0: associated
[  148.192646] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  148.206339] cfg80211: Calling CRDA to update world regulatory domain
[  148.208741] cfg80211: World regulatory domain updated:
[  148.208744] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  148.208746] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208748] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208749] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208751] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208752] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  151.443088] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  151.445498] wlan0: authenticated
[  151.446657] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  151.451688] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  151.451691] wlan0: associated
[  159.980012] wlan0: deauthenticating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  159.992768] cfg80211: Calling CRDA to update world regulatory domain
[  159.995101] cfg80211: World regulatory domain updated:
[  159.995104] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  159.995106] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995108] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995109] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995111] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995112] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  172.519660] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  172.522038] wlan0: authenticated
[  172.525229] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  172.530226] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  172.530229] wlan0: associated
root@xps15z:/home/crrodriguez # systemctl restart NetworkManager.service
root@xps15z:/home/crrodriguez # dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-rc6-3-desktop (geeko@buildhost) (gcc=20
version 4.6.2 (SUSE Linux) ) #1 SMP PREEMPT Thu Dec 22 15:05:54 UTC 2011=20
(c4246bf)
[    0.000000] Command line:=20
root=3D/dev/disk/by-uuid/ca00ffff-8c21-4750-b25c-3cf321a07dd9=20
resume=3D/dev/system/swap splash=3Dverbose clocksource=3Dhpet hpet64=20
ipv6.disable=3D1 elevator=3Dnoop acpi.debug_layer=3D0x400000 apic=3Ddebug=
=20
i8042.debug vga=3D0x31b
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000b5a28000 (usable)
[    0.000000]  BIOS-e820: 00000000b5a28000 - 00000000b6e29000 (reserved)
[    0.000000]  BIOS-e820: 00000000b6e29000 - 00000000b886a000 (usable)
[    0.000000]  BIOS-e820: 00000000b886a000 - 00000000b8ab3000 (reserved)
[    0.000000]  BIOS-e820: 00000000b8ab3000 - 00000000bac8f000 (usable)
[    0.000000]  BIOS-e820: 00000000bac8f000 - 00000000bad2e000 (reserved)
[    0.000000]  BIOS-e820: 00000000bad2e000 - 00000000bad3d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bad3d000 - 00000000badfb000 (reserved)
[    0.000000]  BIOS-e820: 00000000badfb000 - 00000000badfd000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000badfd000 - 00000000badff000 (reserved)
[    0.000000]  BIOS-e820: 00000000badff000 - 00000000bae02000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bae02000 - 00000000bae0a000 (reserved)
[    0.000000]  BIOS-e820: 00000000bae0a000 - 00000000bae1b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bae1b000 - 00000000baf18000 (reserved)
[    0.000000]  BIOS-e820: 00000000baf18000 - 00000000baf1c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000baf1c000 - 00000000baf1f000 (reserved)
[    0.000000]  BIOS-e820: 00000000baf1f000 - 00000000baf9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000baf9f000 - 00000000bafff000 (ACPI data=
)
[    0.000000]  BIOS-e820: 00000000bafff000 - 00000000bb000000 (usable)
[    0.000000]  BIOS-e820: 00000000bb000000 - 00000000bfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed08000 - 00000000fed09000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000023fe00000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Dell Inc.          Dell System XPS 15Z/00WW5M, BIOS=20
A08 12/13/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000=20
(usable) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000=20
(usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x23fe00 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0BB000000 mask FFF000000 uncachable
[    0.000000]   5 base 100000000 mask F00000000 write-back
[    0.000000]   6 base 200000000 mask FC0000000 write-back
[    0.000000]   7 base 23FE00000 mask FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new=20
0x7010600070106
[    0.000000] last_pfn =3D 0xbb000 max_arch_pfn =3D 0x400000000
[    0.000000] Scan SMP from ffff880000000000 for 1024 bytes.
[    0.000000] Scan SMP from ffff88000009fc00 for 1024 bytes.
[    0.000000] Scan SMP from ffff8800000f0000 for 65536 bytes.
[    0.000000] Scan SMP from ffff88000009d800 for 1024 bytes.
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20=
480
[    0.000000] init_memory_mapping: 0000000000000000-00000000bb000000
[    0.000000]  0000000000 - 00bb000000 page 2M
[    0.000000] kernel direct mapping tables up to bb000000 @=20
1fffc000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-000000023fe00000
[    0.000000]  0100000000 - 023fe00000 page 2M
[    0.000000] kernel direct mapping tables up to 23fe00000 @=20
bac85000-bac8f000
[    0.000000] RAMDISK: 373d9000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000f00e0 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000baffe120 00094 (v01 DELL    QA09=20
00000002 LOHR 00000002)
[    0.000000] ACPI: FACP 00000000baff0000 000F4 (v03 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: DSDT 00000000baff3000 08A57 (v02 DELL    SNB-CPT=20
00000000 INTL 20061109)
[    0.000000] ACPI: FACS 00000000baf40000 00040
[    0.000000] ACPI: SLIC 00000000baffd000 00176 (v01 DELL    QA09=20
00000002 LOHR 00000001)
[    0.000000] ACPI: SSDT 00000000baffc000 00166 (v01 DELL   PtidDevc=20
00001000 INTL 20061109)
[    0.000000] ACPI: ASF! 00000000baff2000 000A5 (v32 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: HPET 00000000bafef000 00038 (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: APIC 00000000bafee000 00098 (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: MCFG 00000000bafed000 0003C (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: SSDT 00000000bafec000 00B3B (v01 NvORef NvOptTbl=20
00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafeb000 00846 (v01  PmRef  Cpu0Ist=20
00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafea000 00996 (v01  PmRef    CpuPm=20
00003000 INTL 20061109)
[    0.000000] ACPI: UEFI 00000000bafe9000 0003E (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: UEFI 00000000bafe8000 00042 (v01 PTL      COMBUF=20
00000001 PTL  00000001)
[    0.000000] ACPI: DMAR 00000000bafe7000 000E8 (v01 INTEL      SNB=20
00000001 INTL 00000001)
[    0.000000] ACPI: UEFI 00000000bafe6000 0022E (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fa000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000023fe00000
[    0.000000] Initmem setup node 0 0000000000000000-000000023fe00000
[    0.000000]   NODE_DATA [000000023fdec000 - 000000023fdfffff]
[    0.000000]  [ffffea0000000000-ffffea0007dfffff] PMD ->=20
[ffff880237400000-ffff88023e3fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0023fe00
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000b5a28
[    0.000000]     0: 0x000b6e29 -> 0x000b886a
[    0.000000]     0: 0x000b8ab3 -> 0x000bac8f
[    0.000000]     0: 0x000bafff -> 0x000bb000
[    0.000000]     0: 0x00100000 -> 0x0023fe00
[    0.000000] On node 0 totalpages: 2069459
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 740990 pages, LIFO batch:31
[    0.000000]   Normal zone: 17913 pages used for memmap
[    0.000000]   Normal zone: 1292295 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fa000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI=20
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2,=20
APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2,=20
APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2,=20
APIC INT 01
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2,=20
APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2,=20
APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2,=20
APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2,=20
APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2,=20
APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2,=20
APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2,=20
APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2,=20
APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2,=20
APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2,=20
APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2,=20
APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2,=20
APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5f9000 (fec00000)
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 -=20
000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 -=20
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -=20
00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 -=20
0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000b5a28000 -=20
00000000b6e29000
[    0.000000] PM: Registered nosave memory: 00000000b886a000 -=20
00000000b8ab3000
[    0.000000] PM: Registered nosave memory: 00000000bac8f000 -=20
00000000bad2e000
[    0.000000] PM: Registered nosave memory: 00000000bad2e000 -=20
00000000bad3d000
[    0.000000] PM: Registered nosave memory: 00000000bad3d000 -=20
00000000badfb000
[    0.000000] PM: Registered nosave memory: 00000000badfb000 -=20
00000000badfd000
[    0.000000] PM: Registered nosave memory: 00000000badfd000 -=20
00000000badff000
[    0.000000] PM: Registered nosave memory: 00000000badff000 -=20
00000000bae02000
[    0.000000] PM: Registered nosave memory: 00000000bae02000 -=20
00000000bae0a000
[    0.000000] PM: Registered nosave memory: 00000000bae0a000 -=20
00000000bae1b000
[    0.000000] PM: Registered nosave memory: 00000000bae1b000 -=20
00000000baf18000
[    0.000000] PM: Registered nosave memory: 00000000baf18000 -=20
00000000baf1c000
[    0.000000] PM: Registered nosave memory: 00000000baf1c000 -=20
00000000baf1f000
[    0.000000] PM: Registered nosave memory: 00000000baf1f000 -=20
00000000baf9f000
[    0.000000] PM: Registered nosave memory: 00000000baf9f000 -=20
00000000bafff000
[    0.000000] PM: Registered nosave memory: 00000000bb000000 -=20
00000000bfa00000
[    0.000000] PM: Registered nosave memory: 00000000bfa00000 -=20
00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 -=20
00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 -=20
00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 -=20
00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 -=20
00000000fed08000
[    0.000000] PM: Registered nosave memory: 00000000fed08000 -=20
00000000fed09000
[    0.000000] PM: Registered nosave memory: 00000000fed09000 -=20
00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 -=20
00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 -=20
00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 -=20
00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 -=20
00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 -=20
00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 -=20
00000000ffd80000
[    0.000000] PM: Registered nosave memory: 00000000ffd80000 -=20
0000000100000000
[    0.000000] Allocating PCI resources starting at bfa00000 (gap:=20
bfa00000:38600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512=20
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88023fa00000 s79744=20
r8192 d22656 u262144
[    0.000000] pcpu-alloc: s79744 r8192 d22656 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.=20
Total pages: 2037205
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:=20
root=3D/dev/disk/by-uuid/ca00ffff-8c21-4750-b25c-3cf321a07dd9=20
resume=3D/dev/system/swap splash=3Dverbose clocksource=3Dhpet hpet64=20
ipv6.disable=3D1 elevator=3Dnoop acpi.debug_layer=3D0x400000 apic=3Ddebug=
=20
i8042.debug vga=3D0x31b
[    0.000000] bootsplash: verbose mode.
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 8067344k/9435136k available (5935k kernel code,=20
1157300k absent, 210492k reserved, 7648k data, 944k init)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 67108864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't=20
want memory cgroups
[    0.000000] hpet timer0 configured in 64-bit mode
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 2793.229 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using=20
timer frequency.. 5586.45 BogoMIPS (lpj=3D2793229)
[    0.000007] pid_max: default: 32768 minimum: 301
[    0.000037] Security Framework initialized
[    0.000049] AppArmor: AppArmor initialized
[    0.000647] Dentry cache hash table entries: 1048576 (order: 11,=20
8388608 bytes)
[    0.002144] Inode-cache hash table entries: 524288 (order: 10,=20
4194304 bytes)
[    0.002776] Mount-cache hash table entries: 256
[    0.002859] Initializing cgroup subsys cpuacct
[    0.002863] Initializing cgroup subsys memory
[    0.002877] Initializing cgroup subsys devices
[    0.002880] Initializing cgroup subsys freezer
[    0.002882] Initializing cgroup subsys net_cls
[    0.002884] Initializing cgroup subsys blkio
[    0.002890] Initializing cgroup subsys perf_event
[    0.002912] Disabled fast string operations
[    0.002915] CPU: Physical Processor ID: 0
[    0.002917] CPU: Processor Core ID: 0
[    0.002921] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.002922] ENERGY_PERF_BIAS: View and update with=20
x86_energy_perf_policy(8)
[    0.002927] mce: CPU supports 7 MCE banks
[    0.002936] CPU0: Thermal monitoring handled by SMI
[    0.002941] using mwait in idle threads.
[    0.003584] ACPI: Core revision 20110623
[    0.059768] Getting VERSION: 1060015
[    0.059771] Getting VERSION: 1060015
[    0.059773] Getting ID: 0
[    0.059774] Getting ID: 0
[    0.059783] DMAR: Host address width 36
[    0.059786] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.059792] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap=20
c0000020e60262 ecap f0101a
[    0.059796] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.059801] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap=20
c9008020660262 ecap f0105a
[    0.059804] DMAR: RMRR base: 0x000000bae1d000 end: 0x000000bae33fff
[    0.059807] DMAR: RMRR base: 0x000000bb800000 end: 0x000000bf9fffff
[    0.059879] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.059881] HPET id 0 under DRHD base 0xfed91000
[    0.059884] HPET id 0 under DRHD base 0xfed91000
[    0.059886] HPET id 0 under DRHD base 0xfed91000
[    0.059888] HPET id 0 under DRHD base 0xfed91000
[    0.059890] HPET id 0 under DRHD base 0xfed91000
[    0.059892] HPET id 0 under DRHD base 0xfed91000
[    0.059894] HPET id 0 under DRHD base 0xfed91000
[    0.059896] HPET id 0 under DRHD base 0xfed91000
[    0.060143] Enabled IRQ remapping in x2apic mode
[    0.060146] Enabling x2apic
[    0.060148] Enabled x2apic
[    0.060153] Switched APIC routing to cluster x2apic.
[    0.060158] enabled ExtINT on CPU#0
[    0.060404] ESR value before enabling vector: 0x00000080  after:=20
0x00000000
[    0.060421] ENABLING IO-APIC IRQs
[    0.060423] init IO_APIC IRQs
[    0.060424]  apic 2 pin 0 not connected
[    0.060427] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0=20
Active:0 Dest:1)
[    0.060431] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060436] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0=20
Active:0 Dest:1)
[    0.060439] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:30 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060443] IOAPIC[0]: Set routing entry (2-3 -> 0x33 -> IRQ 3 Mode:0=20
Active:0 Dest:1)
[    0.060446] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:33 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060450] IOAPIC[0]: Set routing entry (2-4 -> 0x34 -> IRQ 4 Mode:0=20
Active:0 Dest:1)
[    0.060453] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:34 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060457] IOAPIC[0]: Set routing entry (2-5 -> 0x35 -> IRQ 5 Mode:0=20
Active:0 Dest:1)
[    0.060460] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:35 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060465] IOAPIC[0]: Set routing entry (2-6 -> 0x36 -> IRQ 6 Mode:0=20
Active:0 Dest:1)
[    0.060467] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:36 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060472] IOAPIC[0]: Set routing entry (2-7 -> 0x37 -> IRQ 7 Mode:0=20
Active:0 Dest:1)
[    0.060475] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:37 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060479] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0=20
Active:0 Dest:1)
[    0.060482] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060486] IOAPIC[0]: Set routing entry (2-9 -> 0x39 -> IRQ 9 Mode:1=20
Active:0 Dest:1)
[    0.060489] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:39 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060493] IOAPIC[0]: Set routing entry (2-10 -> 0x3a -> IRQ 10=20
Mode:0 Active:0 Dest:1)
[    0.060496] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3A Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060500] IOAPIC[0]: Set routing entry (2-11 -> 0x3b -> IRQ 11=20
Mode:0 Active:0 Dest:1)
[    0.060503] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3B Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060507] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12=20
Mode:0 Active:0 Dest:1)
[    0.060510] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060514] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13=20
Mode:0 Active:0 Dest:1)
[    0.060517] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060521] IOAPIC[0]: Set routing entry (2-14 -> 0x3e -> IRQ 14=20
Mode:0 Active:0 Dest:1)
[    0.060524] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3E Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060528] IOAPIC[0]: Set routing entry (2-15 -> 0x3f -> IRQ 15=20
Mode:0 Active:0 Dest:1)
[    0.060531] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3F Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060535]  apic 2 pin 16 not connected
[    0.060536]  apic 2 pin 17 not connected
[    0.060537]  apic 2 pin 18 not connected
[    0.060538]  apic 2 pin 19 not connected
[    0.060538]  apic 2 pin 20 not connected
[    0.060539]  apic 2 pin 21 not connected
[    0.060540]  apic 2 pin 22 not connected
[    0.060541]  apic 2 pin 23 not connected
[    0.060679] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.070666] CPU0: Intel(R) Core(TM) i7-2640M CPU @ 2.80GHz stepping 07
[    0.070671] Using local APIC timer interrupts.
[    0.070671] calibrating APIC timer ...
[    0.172123] ... lapic delta =3D 623574
[    0.172125] ... PM-Timer delta =3D 357949
[    0.172126] ... PM-Timer result ok
[    0.172128] ..... delta 623574
[    0.172130] ..... mult: 26786370
[    0.172132] ..... calibration result: 99771
[    0.172134] ..... CPU clock speed is 2793.0611 MHz.
[    0.172136] ..... host bus clock speed is 99.0771 MHz.
[    0.172144] Performance Events: PEBS fmt1+, SandyBridge events, Intel=20
PMU driver.
[    0.172150] PEBS disabled due to CPU errata.
[    0.172154] ... version:                3
[    0.172155] ... bit width:              48
[    0.172157] ... generic registers:      4
[    0.172159] ... value mask:             0000ffffffffffff
[    0.172162] ... max period:             000000007fffffff
[    0.172164] ... fixed-purpose events:   3
[    0.172166] ... event mask:             000000070000000f
[    0.180330] NMI watchdog enabled, takes one hw-pmu counter.
[    0.188150] Booting Node   0, Processors  #1
[    0.188160] smpboot cpu 1: start_ip =3D 98000
[    0.199162] masked ExtINT on CPU#1
[    0.259011] Disabled fast string operations
[    0.259023] CPU1: Thermal monitoring handled by SMI
[    0.279047] NMI watchdog enabled, takes one hw-pmu counter.
[    0.285004]  #2
[    0.285010] smpboot cpu 2: start_ip =3D 98000
[    0.296013] masked ExtINT on CPU#2
[    0.355853] Disabled fast string operations
[    0.355864] CPU2: Thermal monitoring handled by SMI
[    0.375921] NMI watchdog enabled, takes one hw-pmu counter.
[    0.381847]  #3
[    0.381852] smpboot cpu 3: start_ip =3D 98000
[    0.392852] masked ExtINT on CPU#3
[    0.452696] Disabled fast string operations
[    0.452707] CPU3: Thermal monitoring handled by SMI
[    0.472765] NMI watchdog enabled, takes one hw-pmu counter.
[    0.474664] Brought up 4 CPUs
[    0.474673] Total of 4 processors activated (22346.24 BogoMIPS).
[    0.478171] devtmpfs: initialized
[    0.478919] PM: Registering ACPI NVS region at bad2e000 (61440 bytes)
[    0.478924] PM: Registering ACPI NVS region at badfb000 (8192 bytes)
[    0.478927] PM: Registering ACPI NVS region at badff000 (12288 bytes)
[    0.478930] PM: Registering ACPI NVS region at bae0a000 (69632 bytes)
[    0.478934] PM: Registering ACPI NVS region at baf18000 (16384 bytes)
[    0.478938] PM: Registering ACPI NVS region at baf1f000 (524288 bytes)
[    0.479061] print_constraints: dummy:
[    0.479091] RTC time:  1:23:20, date: 12/27/11
[    0.479128] NET: Registered protocol family 16
[    0.479269] ACPI: bus type pci registered
[    0.479329] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem=20
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.479334] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E=
820
[    0.489012] PCI: Using configuration type 1 for base access
[    0.489769] bio: create slab <bio-0> at 0
[    0.489840] ACPI: Added _OSI(Module Device)
[    0.489843] ACPI: Added _OSI(Processor Device)
[    0.489846] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.489848] ACPI: Added _OSI(Processor Aggregator Device)
[    0.491351] ACPI: EC: Look up EC in DSDT
[    0.492860] ACPI: Executed 1 blocks of module-level executable AML cod=
e
[    0.499730] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.500574] ACPI: SSDT 00000000bae06718 0067C (v01  PmRef  Cpu0Cst=20
00003001 INTL 20061109)
[    0.500979] ACPI: Dynamic OEM Table Load:
[    0.500982] ACPI: SSDT           (null) 0067C (v01  PmRef  Cpu0Cst=20
00003001 INTL 20061109)
[    0.506049] ACPI: SSDT 00000000bae07a98 00303 (v01  PmRef    ApIst=20
00003000 INTL 20061109)
[    0.506495] ACPI: Dynamic OEM Table Load:
[    0.506498] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst=20
00003000 INTL 20061109)
[    0.508778] ACPI: SSDT 00000000bae05d98 00119 (v01  PmRef    ApCst=20
00003000 INTL 20061109)
[    0.509171] ACPI: Dynamic OEM Table Load:
[    0.509173] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst=20
00003000 INTL 20061109)
[    0.514717] ACPI: Interpreter enabled
[    0.514722] ACPI: (supports S0 S3 S4 S5)
[    0.514744] ACPI: Using IOAPIC for interrupt routing
[    0.520280] ACPI: EC: GPE =3D 0x17, I/O: command/status =3D 0x66, data=
 =3D 0x62
[    0.520446] ACPI: No dock devices found.
[    0.520448] HEST: Table not found.
[    0.520451] PCI: Using host bridge windows from ACPI; if necessary,=20
use "pci=3Dnocrs" and report a bug
[    0.520852] \_SB_.PCI0:_OSC invalid UUID
[    0.520853] _OSC request data:1 8 1f
[    0.520856] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.521533] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7=
]
[    0.521537] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff=
]
[    0.521540] pci_root PNP0A08:00: host bridge window [mem=20
0x000a0000-0x000bffff]
[    0.521544] pci_root PNP0A08:00: host bridge window [mem=20
0xbfa00000-0xfeafffff]
[    0.521548] pci_root PNP0A08:00: host bridge window [mem=20
0xfed40000-0xfed44fff]
[    0.521559] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    0.521591] pci 0000:00:01.0: [8086:0101] type 1 class 0x000604
[    0.521611] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.521613] pci 0000:00:01.0: PME# disabled
[    0.521630] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    0.521639] pci 0000:00:02.0: reg 10: [mem 0xf1400000-0xf17fffff 64bit=
]
[    0.521644] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff=20
64bit pref]
[    0.521648] pci 0000:00:02.0: reg 20: [io  0x4000-0x403f]
[    0.521692] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    0.521714] pci 0000:00:16.0: reg 10: [mem 0xf1c05000-0xf1c0500f 64bit=
]
[    0.521774] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.521778] pci 0000:00:16.0: PME# disabled
[    0.521808] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    0.521828] pci 0000:00:1a.0: reg 10: [mem 0xf1c0a000-0xf1c0a3ff]
[    0.521898] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.521902] pci 0000:00:1a.0: PME# disabled
[    0.521925] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    0.521939] pci 0000:00:1b.0: reg 10: [mem 0xf1c00000-0xf1c03fff 64bit=
]
[    0.521991] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.521994] pci 0000:00:1b.0: PME# disabled
[    0.522016] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    0.522075] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.522079] pci 0000:00:1c.0: PME# disabled
[    0.522103] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    0.522162] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.522166] pci 0000:00:1c.1: PME# disabled
[    0.522190] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
[    0.522249] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.522253] pci 0000:00:1c.3: PME# disabled
[    0.522277] pci 0000:00:1c.4: [8086:1c18] type 1 class 0x000604
[    0.522335] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.522339] pci 0000:00:1c.4: PME# disabled
[    0.522363] pci 0000:00:1c.5: [8086:1c1a] type 1 class 0x000604
[    0.522422] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.522426] pci 0000:00:1c.5: PME# disabled
[    0.522455] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    0.522475] pci 0000:00:1d.0: reg 10: [mem 0xf1c09000-0xf1c093ff]
[    0.522544] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.522548] pci 0000:00:1d.0: PME# disabled
[    0.522571] pci 0000:00:1f.0: [8086:1c4b] type 0 class 0x000601
[    0.522685] pci 0000:00:1f.2: [8086:1c03] type 0 class 0x000106
[    0.522702] pci 0000:00:1f.2: reg 10: [io  0x4088-0x408f]
[    0.522710] pci 0000:00:1f.2: reg 14: [io  0x4094-0x4097]
[    0.522717] pci 0000:00:1f.2: reg 18: [io  0x4080-0x4087]
[    0.522725] pci 0000:00:1f.2: reg 1c: [io  0x4090-0x4093]
[    0.522732] pci 0000:00:1f.2: reg 20: [io  0x4060-0x407f]
[    0.522740] pci 0000:00:1f.2: reg 24: [mem 0xf1c08000-0xf1c087ff]
[    0.522770] pci 0000:00:1f.2: PME# supported from D3hot
[    0.522774] pci 0000:00:1f.2: PME# disabled
[    0.522791] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    0.522805] pci 0000:00:1f.3: reg 10: [mem 0xf1c04000-0xf1c040ff 64bit=
]
[    0.522826] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
[    0.522875] pci 0000:01:00.0: [10de:0df5] type 0 class 0x000300
[    0.522882] pci 0000:01:00.0: reg 10: [mem 0xf0000000-0xf0ffffff]
[    0.522890] pci 0000:01:00.0: reg 14: [mem 0xc0000000-0xcfffffff=20
64bit pref]
[    0.522898] pci 0000:01:00.0: reg 1c: [mem 0xd0000000-0xd1ffffff=20
64bit pref]
[    0.522903] pci 0000:01:00.0: reg 24: [io  0x3000-0x307f]
[    0.522909] pci 0000:01:00.0: reg 30: [mem 0xfff80000-0xffffffff pref]
[    0.524596] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.524609] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.524616] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fff=
ff]
[    0.524626] pci 0000:00:01.0:   bridge window [mem=20
0xc0000000-0xd1ffffff 64bit pref]
[    0.524698] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.524908] pci 0000:03:00.0: [8086:0091] type 0 class 0x000280
[    0.525049] pci 0000:03:00.0: reg 10: [mem 0xf1b00000-0xf1b01fff 64bit=
]
[    0.525618] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.525652] pci 0000:03:00.0: PME# disabled
[    0.527703] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.527711] pci 0000:00:1c.1:   bridge window [mem 0xf1b00000-0xf1bfff=
ff]
[    0.527783] pci 0000:04:00.0: [1033:0194] type 0 class 0x000c03
[    0.527808] pci 0000:04:00.0: reg 10: [mem 0xf1a00000-0xf1a01fff 64bit=
]
[    0.527912] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.527917] pci 0000:04:00.0: PME# disabled
[    0.529595] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.529614] pci 0000:00:1c.3:   bridge window [mem 0xf1a00000-0xf1afff=
ff]
[    0.529692] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.529700] pci 0000:00:1c.4:   bridge window [mem 0xf1900000-0xf19fff=
ff]
[    0.529769] pci 0000:06:00.0: [1969:1083] type 0 class 0x000200
[    0.529796] pci 0000:06:00.0: reg 10: [mem 0xf1800000-0xf183ffff 64bit=
]
[    0.529810] pci 0000:06:00.0: reg 18: [io  0x2000-0x207f]
[    0.529905] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.529910] pci 0000:06:00.0: PME# disabled
[    0.531592] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
[    0.531606] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.531617] pci 0000:00:1c.5:   bridge window [mem 0xf1800000-0xf18fff=
ff]
[    0.531674] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.531763]       0000:00:1f[A] -> [21]
[    0.531766]       0000:00:1f[B] -> [19]
[    0.531769]       0000:00:1f[C] -> [18]
[    0.531771]       0000:00:1f[D] -> [16]
[    0.531773]       0000:00:1d[A] -> [23]
[    0.531776]       0000:00:1a[A] -> [16]
[    0.531778]       0000:00:1b[A] -> [22]
[    0.531781]       0000:00:16[A] -> [16]
[    0.531783]       0000:00:16[B] -> [19]
[    0.531785]       0000:00:16[C] -> [18]
[    0.531788]       0000:00:16[D] -> [17]
[    0.531790]       0000:00:1c[A] -> [16]
[    0.531792]       0000:00:1c[B] -> [17]
[    0.531795]       0000:00:1c[C] -> [18]
[    0.531797]       0000:00:1c[D] -> [19]
[    0.531799]       0000:00:01[A] -> [16]
[    0.531802]       0000:00:01[B] -> [17]
[    0.531804]       0000:00:01[C] -> [18]
[    0.531806]       0000:00:01[D] -> [19]
[    0.531809]       0000:00:02[A] -> [16]
[    0.531811]       0000:00:04[A] -> [16]
[    0.531813]       0000:00:04[B] -> [17]
[    0.531816]       0000:00:04[C] -> [18]
[    0.531818]       0000:00:04[D] -> [19]
[    0.531840] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.0 is a PCI bridge
[    0.531846] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.531874]       0000:02:00[A] -> [16]
[    0.531877]       0000:02:00[B] -> [17]
[    0.531879]       0000:02:00[C] -> [18]
[    0.531882]       0000:02:00[D] -> [19]
[    0.531890] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.1 is a PCI bridge
[    0.531896] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.531923]       0000:03:00[A] -> [17]
[    0.531925]       0000:03:00[B] -> [18]
[    0.531928]       0000:03:00[C] -> [19]
[    0.531930]       0000:03:00[D] -> [16]
[    0.531940] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.3 is a PCI bridge
[    0.531945] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.531972]       0000:04:00[A] -> [19]
[    0.531974]       0000:04:00[B] -> [16]
[    0.531977]       0000:04:00[C] -> [17]
[    0.531979]       0000:04:00[D] -> [18]
[    0.531988] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.4 is a PCI bridge
[    0.531994] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.532020]       0000:05:00[A] -> [16]
[    0.532023]       0000:05:00[B] -> [17]
[    0.532025]       0000:05:00[C] -> [18]
[    0.532028]       0000:05:00[D] -> [19]
[    0.532053] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.5 is a PCI bridge
[    0.532058] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.532085]       0000:06:00[A] -> [17]
[    0.532087]       0000:06:00[B] -> [18]
[    0.532090]       0000:06:00[C] -> [19]
[    0.532092]       0000:06:00[D] -> [16]
[    0.532109] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:01.0 is a PCI bridge
[    0.532114] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG0._PRT]
[    0.532141]       0000:01:00[A] -> [16]
[    0.532143]       0000:01:00[B] -> [17]
[    0.532146]       0000:01:00[C] -> [18]
[    0.532148]       0000:01:00[D] -> [19]
[    0.532198] \_SB_.PCI0:_OSC invalid UUID
[    0.532198] _OSC request data:1 1f 1f
[    0.532201]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.532239] \_SB_.PCI0:_OSC invalid UUID
[    0.532240] _OSC request data:1 0 1d
[    0.532242]  pci0000:00: ACPI _OSC request failed (AE_ERROR),=20
returned control mask: 0x1d
[    0.532246] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.535536] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535572] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 11
[    0.535577] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12=20
14 15)
[    0.535607] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535638] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 9
[    0.535642] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *9
[    0.535671] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535699] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 9
[    0.535703] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *9
[    0.535731] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535759] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 10
[    0.535763] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12=20
14 15)
[    0.535790] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535818] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 0
[    0.535822] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *0, disabled.
[    0.535850] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535878] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 0
[    0.535882] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *0, disabled.
[    0.535911] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535939] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 10
[    0.535942] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12=20
14 15)
[    0.535970] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535998] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 11
[    0.536002] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 12=20
14 15)
[    0.536069] vgaarb: device added:=20
PCI:0000:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.536078] vgaarb: device added:=20
PCI:0000:01:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.536083] vgaarb: loaded
[    0.536085] vgaarb: bridge control possible 0000:01:00.0
[    0.536087] vgaarb: no bridge control possible 0000:00:02.0
[    0.536179] SCSI subsystem initialized
[    0.536213] libata version 3.00 loaded.
[    0.536245] usbcore: registered new interface driver usbfs
[    0.536257] usbcore: registered new interface driver hub
[    0.536277] usbcore: registered new device driver usb
[    0.536324] PCI: Using ACPI for IRQ routing
[    0.537738] PCI: pci_cache_line_size set to 64 bytes
[    0.537863] reserve RAM buffer: 000000000009d800 - 000000000009ffff
[    0.537865] reserve RAM buffer: 00000000b5a28000 - 00000000b7ffffff
[    0.537867] reserve RAM buffer: 00000000b886a000 - 00000000bbffffff
[    0.537871] reserve RAM buffer: 00000000bac8f000 - 00000000bbffffff
[    0.537874] reserve RAM buffer: 00000000bb000000 - 00000000bbffffff
[    0.537876] reserve RAM buffer: 000000023fe00000 - 000000023fffffff
[    0.537947] NetLabel: Initializing
[    0.537950] NetLabel:  domain hash size =3D 128
[    0.537952] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.537961] NetLabel:  unlabeled traffic allowed by default
[    0.537971] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.537977] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.539993] Switching to clocksource hpet
[    0.541903] AppArmor: AppArmor Filesystem Enabled
[    0.541922] pnp: PnP ACPI init
[    0.541934] ACPI: bus type pnp registered
[    0.542307] pnp 00:00: [bus 00-3e]
[    0.542310] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.542311] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.542313] pnp 00:00: [io  0x0d00-0xffff window]
[    0.542314] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.542316] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.542317] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.542318] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.542320] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.542321] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.542322] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.542324] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.542325] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.542326] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.542328] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.542329] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.542331] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.542332] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.542333] pnp 00:00: [mem 0xbfa00000-0xfeafffff window]
[    0.542335] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.542374] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03=20
(active)
[    0.542387] pnp 00:01: [io  0x0000-0x001f]
[    0.542389] pnp 00:01: [io  0x0081-0x0091]
[    0.542390] pnp 00:01: [io  0x0093-0x009f]
[    0.542391] pnp 00:01: [io  0x00c0-0x00df]
[    0.542392] pnp 00:01: [dma 4]
[    0.542409] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.542484] pnp 00:02: [mem 0xfed00000-0xfed003ff]
[    0.542501] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.542511] pnp 00:03: [io  0x00f0]
[    0.542515] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13=20
Mode:0 Active:0 Dest:1)
[    0.542519] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542525] pnp 00:03: [irq 13]
[    0.542541] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.542550] pnp 00:04: [io  0x002e-0x002f]
[    0.542551] pnp 00:04: [io  0x004e-0x004f]
[    0.542553] pnp 00:04: [io  0x0061]
[    0.542555] pnp 00:04: [io  0x0063]
[    0.542556] pnp 00:04: [io  0x0065]
[    0.542557] pnp 00:04: [io  0x0067]
[    0.542558] pnp 00:04: [io  0x0068]
[    0.542559] pnp 00:04: [io  0x006c]
[    0.542560] pnp 00:04: [io  0x0070]
[    0.542561] pnp 00:04: [io  0x0080]
[    0.542562] pnp 00:04: [io  0x0092]
[    0.542563] pnp 00:04: [io  0x00b2-0x00b3]
[    0.542564] pnp 00:04: [io  0x0680-0x069f]
[    0.542566] pnp 00:04: [io  0x1000-0x1003]
[    0.542567] pnp 00:04: [io  0x1004-0x1013]
[    0.542568] pnp 00:04: [io  0xffff]
[    0.542569] pnp 00:04: [io  0x0400-0x0453]
[    0.542570] pnp 00:04: [io  0x0458-0x047f]
[    0.542571] pnp 00:04: [io  0x0500-0x057f]
[    0.542573] pnp 00:04: [io  0x164e-0x164f]
[    0.542606] system 00:04: [io  0x0680-0x069f] has been reserved
[    0.542610] system 00:04: [io  0x1000-0x1003] has been reserved
[    0.542613] system 00:04: [io  0x1004-0x1013] has been reserved
[    0.542616] system 00:04: [io  0xffff] has been reserved
[    0.542619] system 00:04: [io  0x0400-0x0453] has been reserved
[    0.542622] system 00:04: [io  0x0458-0x047f] has been reserved
[    0.542625] system 00:04: [io  0x0500-0x057f] has been reserved
[    0.542628] system 00:04: [io  0x164e-0x164f] has been reserved
[    0.542631] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.542639] pnp 00:05: [io  0x0070-0x0077]
[    0.542641] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0=20
Active:0 Dest:1)
[    0.542644] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542649] pnp 00:05: [irq 8]
[    0.542666] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.542692] pnp 00:06: [io  0x0454-0x0457]
[    0.542721] system 00:06: [io  0x0454-0x0457] has been reserved
[    0.542724] system 00:06: Plug and Play ACPI device, IDs INT3f0d=20
PNP0c02 (active)
[    0.542760] pnp 00:07: [io  0x0060]
[    0.542761] pnp 00:07: [io  0x0064]
[    0.542763] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0=20
Active:0 Dest:1)
[    0.542766] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542770] pnp 00:07: [irq 1]
[    0.542788] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.542817] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12=20
Mode:0 Active:0 Dest:1)
[    0.542820] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542824] pnp 00:08: [irq 12]
[    0.542842] pnp 00:08: Plug and Play ACPI device, IDs DLL0446 PNP0f13=20
(active)
[    0.542954] pnp 00:09: [mem 0xfed1c000-0xfed1ffff]
[    0.542955] pnp 00:09: [mem 0xfed10000-0xfed17fff]
[    0.542957] pnp 00:09: [mem 0xfed18000-0xfed18fff]
[    0.542958] pnp 00:09: [mem 0xfed19000-0xfed19fff]
[    0.542959] pnp 00:09: [mem 0xf8000000-0xfbffffff]
[    0.542960] pnp 00:09: [mem 0xfed20000-0xfed3ffff]
[    0.542962] pnp 00:09: [mem 0xfed90000-0xfed93fff]
[    0.542964] pnp 00:09: [mem 0xfed45000-0xfed8ffff]
[    0.542965] pnp 00:09: [mem 0xff000000-0xffffffff]
[    0.542966] pnp 00:09: [mem 0xfee00000-0xfeefffff]
[    0.542968] pnp 00:09: [mem 0xfffff000-0xffffffff]
[    0.542980] pnp 00:09: disabling [mem 0xfffff000-0xffffffff] because=20
it overlaps 0000:01:00.0 BAR 6 [mem 0xfff80000-0xffffffff pref]
[    0.543006] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserve=
d
[    0.543010] system 00:09: [mem 0xfed10000-0xfed17fff] has been reserve=
d
[    0.543013] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserve=
d
[    0.543017] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserve=
d
[    0.543020] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserve=
d
[    0.543023] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserve=
d
[    0.543027] system 00:09: [mem 0xfed90000-0xfed93fff] has been reserve=
d
[    0.543030] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserve=
d
[    0.543033] system 00:09: [mem 0xff000000-0xffffffff] could not be=20
reserved
[    0.543037] system 00:09: [mem 0xfee00000-0xfeefffff] could not be=20
reserved
[    0.543047] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.543171] IOAPIC[0]: Set routing entry (2-20 -> 0x49 -> IRQ 20=20
Mode:0 Active:0 Dest:1)
[    0.543174] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:49 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.543177] pnp 00:0a: [irq 20]
[    0.543206] pnp 00:0a: Plug and Play ACPI device, IDs SMO8800 (active)
[    0.543336] pnp: PnP ACPI: found 11 devices
[    0.543338] ACPI: ACPI bus type pnp unregistered
[    0.549778] pci 0000:01:00.0: no compatible bridge window for [mem=20
0xfff80000-0xffffffff pref]
[    0.549785] PCI: max bus depth: 1 pci_try_num: 2
[    0.549827] pci 0000:01:00.0: BAR 6: assigned [mem=20
0xf1000000-0xf107ffff pref]
[    0.549831] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.549834] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.549838] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fff=
ff]
[    0.549842] pci 0000:00:01.0:   bridge window [mem=20
0xc0000000-0xd1ffffff 64bit pref]
[    0.549847] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.549859] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.549865] pci 0000:00:1c.1:   bridge window [mem 0xf1b00000-0xf1bfff=
ff]
[    0.549874] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.549880] pci 0000:00:1c.3:   bridge window [mem 0xf1a00000-0xf1afff=
ff]
[    0.549890] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.549896] pci 0000:00:1c.4:   bridge window [mem 0xf1900000-0xf19fff=
ff]
[    0.549905] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
[    0.549909] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.549915] pci 0000:00:1c.5:   bridge window [mem 0xf1800000-0xf18fff=
ff]
[    0.549928]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:01.0[A] _PRT entry
[    0.549937] IOAPIC[0]: Set routing entry (2-16 -> 0x51 -> IRQ 16=20
Mode:1 Active:1 Dest:1)
[    0.549941] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:51 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.549944] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.549948] pci 0000:00:01.0: setting latency timer to 64
[    0.549954]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.0[A] _PRT entry
[    0.549959] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.549965] pci 0000:00:1c.0: setting latency timer to 64
[    0.549971]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.1[B] _PRT entry
[    0.549977] IOAPIC[0]: Set routing entry (2-17 -> 0x59 -> IRQ 17=20
Mode:1 Active:1 Dest:1)
[    0.549980] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:59 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.549983] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    0.549988] pci 0000:00:1c.1: setting latency timer to 64
[    0.549994]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.3[D] _PRT entry
[    0.550001] IOAPIC[0]: Set routing entry (2-19 -> 0x61 -> IRQ 19=20
Mode:1 Active:1 Dest:1)
[    0.550004] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:61 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.550006] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ =
19
[    0.550011] pci 0000:00:1c.3: setting latency timer to 64
[    0.550017]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.4[A] _PRT entry
[    0.550022] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.550027] pci 0000:00:1c.4: setting latency timer to 64
[    0.550039]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.5[B] _PRT entry
[    0.550044] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    0.550050] pci 0000:00:1c.5: setting latency timer to 64
[    0.550053] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.550054] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.550056] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.550057] pci_bus 0000:00: resource 7 [mem 0xbfa00000-0xfeafffff]
[    0.550059] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.550060] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    0.550061] pci_bus 0000:01: resource 1 [mem 0xf0000000-0xf10fffff]
[    0.550063] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff=20
64bit pref]
[    0.550064] pci_bus 0000:03: resource 1 [mem 0xf1b00000-0xf1bfffff]
[    0.550066] pci_bus 0000:04: resource 1 [mem 0xf1a00000-0xf1afffff]
[    0.550067] pci_bus 0000:05: resource 1 [mem 0xf1900000-0xf19fffff]
[    0.550069] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.550070] pci_bus 0000:06: resource 1 [mem 0xf1800000-0xf18fffff]
[    0.550125] NET: Registered protocol family 2
[    0.550318] IP route cache hash table entries: 262144 (order: 9,=20
2097152 bytes)
[    0.551888] TCP established hash table entries: 524288 (order: 11,=20
8388608 bytes)
[    0.553016] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    0.553157] TCP: Hash tables configured (established 524288 bind 65536=
)
[    0.553161] TCP reno registered
[    0.553175] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.553205] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.553308] NET: Registered protocol family 1
[    0.553322] pci 0000:00:02.0: Boot video device
[    0.553459] PCI: CLS 64 bytes, default 64
[    0.553496] Unpacking initramfs...
[    0.723042] Freeing initrd memory: 12380k freed
[    0.724650] DMAR: No ATSR found
[    0.724686] IOMMU 0 0xfed90000: using Queued invalidation
[    0.724688] IOMMU 1 0xfed91000: using Queued invalidation
[    0.724692] IOMMU: Setting RMRR:
[    0.724704] IOMMU: Setting identity map for device 0000:00:02.0=20
[0xbb800000 - 0xbf9fffff]
[    0.725062] IOMMU: Setting identity map for device 0000:00:1d.0=20
[0xbae1d000 - 0xbae33fff]
[    0.725085] IOMMU: Setting identity map for device 0000:00:1a.0=20
[0xbae1d000 - 0xbae33fff]
[    0.725099] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    0.725108] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0=20
- 0xffffff]
[    0.725335] PCI-DMA: Intel(R) Virtualization Technology for Directed I=
/O
[    0.727095] audit: initializing netlink socket (disabled)
[    0.727106] type=3D2000 audit(1324949000.518:1): initialized
[    0.749859] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.765057] VFS: Disk quotas dquot_6.5.2
[    0.765086] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.765302] msgmni has been set to 15909
[    0.765461] Block layer SCSI generic (bsg) driver version 0.4 loaded=20
(major 253)
[    0.765486] io scheduler noop registered (default)
[    0.765491] io scheduler deadline registered
[    0.765508] io scheduler cfq registered
[    0.765594] pcieport 0000:00:01.0: setting latency timer to 64
[    0.765617] pcieport 0000:00:01.0: irq 42 for MSI/MSI-X
[    0.765914] vesafb: mode is 1280x1024x32, linelength=3D5120, pages=3D1=
1
[    0.765917] vesafb: scrolling: redraw
[    0.765920] vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.767586] vesafb: framebuffer at 0xe0000000, mapped to=20
0xffffc90005800000, using 10240k, total 65472k
[    0.767738] bootsplash 3.2.0-2010/03/31: looking for picture...
[    0.767739] bootsplash: silentjpeg size 109002 bytes
[    0.777989] bootsplash: ...found (1280x1024, 40442 bytes, v3).
[    0.778101] bootsplash: silentjpeg size 126037 bytes
[    0.882677] Console: switching to colour frame buffer device 156x60
[    0.962069] fb0: VESA VGA frame buffer device
[    0.962474] intel_idle: MWAIT substates: 0x21120
[    0.962475] intel_idle: v0.4 model 0x2A
[    0.962476] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.962518] ERST: Table is not found!
[    0.962842] GHES: HEST is not enabled!
[    0.963242] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.084566] Non-volatile memory driver v1.3
[    1.084937] Linux agpgart interface v0.103
[    1.085368] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.086005] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K=20
total, 262144K mappable
[    1.087854] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.088547] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000=
000
[    1.089240] ahci 0000:00:1f.2: version 3.0
[    1.089249]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1f.2[B] _PRT entry
[    1.089987] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ=
 19
[    1.090633] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    1.090657] ahci: SSS flag set, parallel bus scan disabled
[    1.101254] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps=20
0x13 impl SATA mode
[    1.102014] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo=20
pio slum part ems sxs apst
[    1.102794] ahci 0000:00:1f.2: setting latency timer to 64
[    1.106635] scsi0 : ahci
[    1.106935] scsi1 : ahci
[    1.107220] scsi2 : ahci
[    1.107497] scsi3 : ahci
[    1.107773] scsi4 : ahci
[    1.108048] scsi5 : ahci
[    1.108376] ata1: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08100 irq 43
[    1.109028] ata2: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08180 irq 43
[    1.109687] ata3: DUMMY
[    1.109906] ata4: DUMMY
[    1.110126] ata5: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08300 irq 43
[    1.110785] ata6: DUMMY
[    1.111067] Fixed MDIO Bus: probed
[    1.111378] arcnet loaded.
[    1.111620] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.112214]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1a.0[A] _PRT entry
[    1.112956] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low)=20
-> IRQ 16
[    1.113604] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.113607] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.114089] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned=20
bus number 1
[    1.114781] ehci_hcd 0000:00:1a.0: debug port 2
[    1.141311] ehci_hcd 0000:00:1a.0: cache line size of 64 is not suppor=
ted
[    1.141329] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf1c0a000
[    1.173136] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.195461] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.217783] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.240042] usb usb1: Product: EHCI Host Controller
[    1.262192] usb usb1: Manufacturer: Linux 3.2.0-rc6-3-desktop ehci_hcd
[    1.284442] usb usb1: SerialNumber: 0000:00:1a.0
[    1.306584] hub 1-0:1.0: USB hub found
[    1.328442] hub 1-0:1.0: 2 ports detected
[    1.350123]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1d.0[A] _PRT entry
[    1.372171] IOAPIC[0]: Set routing entry (2-23 -> 0x79 -> IRQ 23=20
Mode:1 Active:1 Dest:1)
[    1.372176] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:79 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    1.372180] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low)=20
-> IRQ 23
[    1.394153] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.394156] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.414770] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.437965] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned=20
bus number 2
[    1.460503] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by=20
device (Stat=3D0x51 Err=3D0x04)
[    1.460548] ehci_hcd 0000:00:1d.0: debug port 2
[    1.464440] ehci_hcd 0000:00:1d.0: cache line size of 64 is not suppor=
ted
[    1.464459] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf1c09000
[    1.473673] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.473717] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.473718] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.473720] usb usb2: Product: EHCI Host Controller
[    1.473721] usb usb2: Manufacturer: Linux 3.2.0-rc6-3-desktop ehci_hcd
[    1.473722] usb usb2: SerialNumber: 0000:00:1d.0
[    1.473841] hub 2-0:1.0: USB hub found
[    1.473845] hub 2-0:1.0: 2 ports detected
[    1.473918] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.473931] uhci_hcd: USB Universal Host Controller Interface driver
[    1.753069] Initializing USB Mass Storage driver...
[    1.753071] Refined TSC clocksource calibration: 2793.653 MHz.
[    1.755293] ata1.00: ATA-8: SAMSUNG SSD PM810 2.5" 7mm 256GB,=20
AXM08D1Q, max UDMA/133
[    1.755295] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth=20
31/32), AA
[    1.755611] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by=20
device (Stat=3D0x51 Err=3D0x04)
[    1.757928] ata1.00: configured for UDMA/133
[    1.854112] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    1.912671] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM81=20
AXM0 PQ: 0 ANSI: 5
[    1.912674] usbcore: registered new interface driver usb-storage
[    1.912675] USB Mass Storage support registered.
[    1.912682] usbcore: registered new interface driver ums-alauda
[    1.912688] usbcore: registered new interface driver ums-cypress
[    1.912694] usbcore: registered new interface driver ums-datafab
[    1.912701] usbcore: registered new interface driver ums-freecom
[    1.912707] usbcore: registered new interface driver ums-isd200
[    1.912713] usbcore: registered new interface driver ums-jumpshot
[    1.912718] usbcore: registered new interface driver ums-karma
[    1.912724] usbcore: registered new interface driver ums-onetouch
[    1.912730] usbcore: registered new interface driver ums-sddr09
[    1.912736] usbcore: registered new interface driver ums-sddr55
[    1.912741] usbcore: registered new interface driver ums-usbat
[    1.912768] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]=20
at 0x60,0x64 irq 1,12
[    1.912807] i8042: [0] 20 -> i8042 (command)
[    1.913286] i8042: [0] 67 <- i8042 (return)
[    1.913347] i8042: [1] 20 -> i8042 (command)
[    1.913721] i8042: [1] 67 <- i8042 (return)
[    1.913726] i8042: [1] 60 -> i8042 (command)
[    1.913889] i8042: [1] 76 -> i8042 (parameter)
[    1.914109] i8042: [1] d3 -> i8042 (command)
[    1.914325] i8042: [1] 5a -> i8042 (parameter)
[    1.914544] i8042: [1] 5a <- i8042 (return)
[    1.914553] i8042: [2] a7 -> i8042 (command)
[    1.914661] i8042: [2] 20 -> i8042 (command)
[    1.914931] i8042: [2] 76 <- i8042 (return)
[    1.914935] i8042: [2] a8 -> i8042 (command)
[    1.915095] i8042: [2] 20 -> i8042 (command)
[    1.915364] i8042: [2] 56 <- i8042 (return)
[    1.915373] i8042: [3] 60 -> i8042 (command)
[    1.915536] i8042: [3] 74 -> i8042 (parameter)
[    1.915763] i8042: [3] d3 -> i8042 (command)
[    1.915978] i8042: [3] f0 -> i8042 (parameter)
[    1.916198] i8042: [3] f0 <- i8042 (return)
[    1.916222] i8042: [4] d3 -> i8042 (command)
[    1.916282] i8042: [4] 56 -> i8042 (parameter)
[    1.916555] i8042: [4] 56 <- i8042 (return)
[    1.916567] i8042: [4] d3 -> i8042 (command)
[    1.916783] i8042: [4] a4 -> i8042 (parameter)
[    1.917002] i8042: [4] a4 <- i8042 (return)
[    1.917027] i8042: [5] 60 -> i8042 (command)
[    1.917137] i8042: [5] 56 -> i8042 (parameter)
[    1.917309] i8042: [5] 60 -> i8042 (command)
[    1.917525] i8042: [5] 47 -> i8042 (parameter)
[    1.917528] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.917552] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.917632] mousedev: PS/2 mouse device common for all mice
[    1.917760] i8042: [5] f2 -> i8042 (kbd-data)
[    1.917804] rtc_cmos 00:05: RTC can wake from S4
[    1.917906] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.917932] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet i=
rqs
[    1.918037] cpuidle: using governor ladder
[    2.402856] i8042: [491] ed -> i8042 (kbd-data)
[    2.402866] i8042: [491] fa <- i8042 (interrupt, 0, 12)
[    2.402926] hpet1: lost 30 rtc interrupts
[    2.403065] cpuidle: using governor menu
[    2.403067] EFI Variables Facility v0.08 2004-May-17
[    2.403295] usbcore: registered new interface driver usbhid
[    2.403297] usbhid: USB HID core driver
[    2.404035] i8042: [492] 00 -> i8042 (kbd-data)
[    2.510920] i8042: [599] fa <- i8042 (interrupt, 0, 1)
[    2.510940] i8042: [599] ed -> i8042 (kbd-data)
[    2.511103] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256=20
GB/238 GiB)
[    2.511126] TCP cubic registered
[    2.511128] IPv6: Loaded, but administratively disabled, reboot=20
required to enable
[    2.511144] lib80211: common routines for IEEE802.11 drivers
[    2.511145] lib80211_crypt: registered algorithm 'NULL'
[    2.511147] Registering the dns_resolver key type
[    2.511162] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[    2.511169]
[    2.511169] printing PIC contents
[    2.511173] ... PIC  IMR: ffff
[    2.511177] ... PIC  IRR: 0c01
[    2.511184] ... PIC  ISR: 0000
[    2.511187] ... PIC ELCR: 0e00
[    2.643783] printing local APIC contents on CPU#0/0:
[    2.643784] ... APIC ID:      00000000 (0)
[    2.666176] ... APIC VERSION: 01060015
[    2.688175] ... APIC TASKPRI: 00000000 (00)
[    2.688176] ... APIC PROCPRI: 00000000
[    2.688177] ... APIC LDR: 00000001
[    2.688178] ... APIC SPIV: 000001ff
[    2.688179] ... APIC ISR field:
[    2.688180]=20
0000000000000000000000000000000000000000000000000000000000000000
[    2.709866] i8042: [799] f4 -> i8042 (kbd-data)
[    2.710552] ... APIC TMR field:
[    2.710553]=20
0000000000000000000000000000000000000000000000000000000000000000
[    2.732661] ... APIC IRR field:
[    2.732662]=20
0000000002020000000200000000000000000000000000000000000000008000
[    2.754421] ... APIC ESR: 00000000
[    2.754422] ... APIC ICR: 000008fd
[    2.754422] ... APIC ICR2: 00000040
[    2.754423] ... APIC LVTT: 000000ef
[    2.754424] ... APIC LVTPC: 00000400
[    2.754425] ... APIC LVT0: 00010700
[    2.754426] ... APIC LVT1: 00000400
[    2.754427] ... APIC LVTERR: 000000fe
[    2.754428] ... APIC TMICT: 000004c0
[    2.754428] ... APIC TMCCT: 00000000
[    2.754429] ... APIC TDCR: 00000003
[    2.754430]
[    2.775580] number of MP IRQ sources: 15.
[    2.775582] number of IO-APIC #2 registers: 24.
[    2.775583] testing the IO APIC.......................
[    2.775623] i8042: [864] fa <- i8042 (interrupt, 0, 1)
[    2.775695] input: AT Translated Set 2 keyboard as=20
/devices/platform/i8042/serio0/input/input0
[    2.775800] sd 0:0:0:0: [sda] Write Protect is off
[    2.775802] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.775812] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[    2.786128] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    2.786130] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    2.815686] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.820070] ata2.00: ATAPI: HL-DT-ST DVD+/-RW GS30N, A101, max UDMA/13=
3
[    2.825187] ata2.00: configured for UDMA/133
[    2.830643] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GS30N=20
  A101 PQ: 0 ANSI: 5
[    2.995778]
[    2.995813] i8042: [1085] d4 -> i8042 (command)
[    2.995924] i8042: [1085] f2 -> i8042 (parameter)
[    2.995926] hub 1-1:1.0: USB hub found
[    2.996023] hub 1-1:1.0: 6 ports detected
[    2.997464]  sda: sda1 sda2
[    2.999069] i8042: [1087] fa <- i8042 (interrupt, 1, 12)
[    2.999923] i8042: [1088] 00 <- i8042 (interrupt, 1, 12)
[    2.999939] i8042: [1089] 60 -> i8042 (command)
[    3.000102] i8042: [1089] 45 -> i8042 (parameter)
[    3.000317] i8042: [1089] 60 -> i8042 (command)
[    3.000531] i8042: [1089] 47 -> i8042 (parameter)
[    3.000767] i8042: [1089] d4 -> i8042 (command)
[    3.000930] i8042: [1089] f2 -> i8042 (parameter)
[    3.004925] i8042: [1089] fa <- i8042 (interrupt, 1, 12)
[    3.005855] i8042: [1094] 00 <- i8042 (interrupt, 1, 12)
[    3.005871] i8042: [1095] d4 -> i8042 (command)
[    3.006034] i8042: [1095] f6 -> i8042 (parameter)
[    3.009373] i8042: [1095] fa <- i8042 (interrupt, 1, 12)
[    3.009391] i8042: [1099] d4 -> i8042 (command)
[    3.009609] i8042: [1099] f3 -> i8042 (parameter)
[    3.012027] i8042: [1099] fa <- i8042 (interrupt, 1, 12)
[    3.012042] i8042: [1101] d4 -> i8042 (command)
[    3.012206] i8042: [1101] 0a -> i8042 (parameter)
[    3.015493] i8042: [1101] fa <- i8042 (interrupt, 1, 12)
[    3.015508] i8042: [1105] d4 -> i8042 (command)
[    3.015725] i8042: [1105] e8 -> i8042 (parameter)
[    3.018010] i8042: [1105] fa <- i8042 (interrupt, 1, 12)
[    3.018029] i8042: [1107] d4 -> i8042 (command)
[    3.018192] i8042: [1107] 00 -> i8042 (parameter)
[    3.020628] i8042: [1107] fa <- i8042 (interrupt, 1, 12)
[    3.020643] i8042: [1110] d4 -> i8042 (command)
[    3.020807] i8042: [1110] f3 -> i8042 (parameter)
[    3.023287] i8042: [1110] fa <- i8042 (interrupt, 1, 12)
[    3.023302] i8042: [1112] d4 -> i8042 (command)
[    3.023465] i8042: [1112] 14 -> i8042 (parameter)
[    3.026067] i8042: [1113] fa <- i8042 (interrupt, 1, 12)
[    3.026083] i8042: [1115] d4 -> i8042 (command)
[    3.026247] i8042: [1115] f3 -> i8042 (parameter)
[    3.029425] i8042: [1115] fa <- i8042 (interrupt, 1, 12)
[    3.029440] i8042: [1119] d4 -> i8042 (command)
[    3.029708] i8042: [1119] 3c -> i8042 (parameter)
[    3.031965] i8042: [1119] fa <- i8042 (interrupt, 1, 12)
[    3.031981] i8042: [1121] d4 -> i8042 (command)
[    3.032144] i8042: [1121] f3 -> i8042 (parameter)
[    3.034971] i8042: [1121] fa <- i8042 (interrupt, 1, 12)
[    3.034987] i8042: [1124] d4 -> i8042 (command)
[    3.035149] i8042: [1124] 28 -> i8042 (parameter)
[    3.037422] i8042: [1124] fa <- i8042 (interrupt, 1, 12)
[    3.037436] i8042: [1127] d4 -> i8042 (command)
[    3.037600] i8042: [1127] f3 -> i8042 (parameter)
[    3.040473] i8042: [1127] fa <- i8042 (interrupt, 1, 12)
[    3.040490] i8042: [1130] d4 -> i8042 (command)
[    3.040757] i8042: [1130] 14 -> i8042 (parameter)
[    3.043019] i8042: [1130] fa <- i8042 (interrupt, 1, 12)
[    3.043034] i8042: [1132] d4 -> i8042 (command)
[    3.043198] i8042: [1132] f3 -> i8042 (parameter)
[    3.046227] i8042: [1132] fa <- i8042 (interrupt, 1, 12)
[    3.046243] i8042: [1135] d4 -> i8042 (command)
[    3.046408] i8042: [1135] 14 -> i8042 (parameter)
[    3.048701] i8042: [1135] fa <- i8042 (interrupt, 1, 12)
[    3.048718] i8042: [1138] d4 -> i8042 (command)
[    3.048882] i8042: [1138] f3 -> i8042 (parameter)
[    3.051911] i8042: [1138] fa <- i8042 (interrupt, 1, 12)
[    3.051926] i8042: [1141] d4 -> i8042 (command)
[    3.052194] i8042: [1141] 3c -> i8042 (parameter)
[    3.054453] i8042: [1141] fa <- i8042 (interrupt, 1, 12)
[    3.054467] i8042: [1144] d4 -> i8042 (command)
[    3.054630] i8042: [1144] f3 -> i8042 (parameter)
[    3.060839] i8042: [1144] fa <- i8042 (interrupt, 1, 12)
[    3.060853] i8042: [1150] d4 -> i8042 (command)
[    3.061069] i8042: [1150] 28 -> i8042 (parameter)
[    3.063300] i8042: [1150] fa <- i8042 (interrupt, 1, 12)
[    3.063316] i8042: [1153] d4 -> i8042 (command)
[    3.063479] i8042: [1153] f3 -> i8042 (parameter)
[    3.066150] i8042: [1153] fa <- i8042 (interrupt, 1, 12)
[    3.066166] i8042: [1155] d4 -> i8042 (command)
[    3.066329] i8042: [1155] 14 -> i8042 (parameter)
[    3.068591] i8042: [1156] fa <- i8042 (interrupt, 1, 12)
[    3.068608] i8042: [1158] d4 -> i8042 (command)
[    3.068772] i8042: [1158] f3 -> i8042 (parameter)
[    3.071764] i8042: [1158] fa <- i8042 (interrupt, 1, 12)
[    3.071780] i8042: [1161] d4 -> i8042 (command)
[    3.071943] i8042: [1161] 14 -> i8042 (parameter)
[    3.074268] i8042: [1161] fa <- i8042 (interrupt, 1, 12)
[    3.074285] i8042: [1164] d4 -> i8042 (command)
[    3.074448] i8042: [1164] f2 -> i8042 (parameter)
[    3.077037] i8042: [1164] fa <- i8042 (interrupt, 1, 12)
[    3.077906] i8042: [1166] 00 <- i8042 (interrupt, 1, 12)
[    3.077922] i8042: [1167] d4 -> i8042 (command)
[    3.078085] i8042: [1167] e8 -> i8042 (parameter)
[    3.080814] i8042: [1167] fa <- i8042 (interrupt, 1, 12)
[    3.080830] i8042: [1170] d4 -> i8042 (command)
[    3.081046] i8042: [1170] 00 -> i8042 (parameter)
[    3.083272] i8042: [1170] fa <- i8042 (interrupt, 1, 12)
[    3.083288] i8042: [1173] d4 -> i8042 (command)
[    3.083555] i8042: [1173] e8 -> i8042 (parameter)
[    3.085294] IO APIC #2......
[    3.085295] .... register #00: 02000000
[    3.085296] .......    : physical APIC id: 02
[    3.085297] .......    : Delivery Type: 0
[    3.085298] .......    : LTS          : 0
[    3.085299] .... register #01: 00170020
[    3.085300] .......     : max redirection entries: 17
[    3.085301] .......     : PRQ implemented: 0
[    3.085302] .......     : IO APIC version: 20
[    3.085302] .... IRQ redirection table:
[    3.085303]  NR Indx Fmt Mask Trig IRR Pol Stat Indx2 Zero Vect:
[    3.085308]  00 0000 0   1    0    0   0   0    0     0    00
[    3.085313]  01 0011 1   0    0    0   0   0    0     0    01
[    3.085318]  02 0001 1   0    0    0   0   0    0     0    02
[    3.085323]  03 0002 1   0    0    0   0   0    0     0    03
[    3.085328]  04 0003 1   0    0    0   0   0    0     0    04
[    3.085333]  05 0004 1   0    0    0   0   0    0     0    05
[    3.085342]  06 0005 1   0    0    0   0   0    0     0    06
[    3.085347]  07 0006 1   0    0    0   0   0    0     0    07
[    3.085352]  08 0010 1   0    0    0   0   0    0     0    08
[    3.085356]  09 0008 1   0    1    0   0   0    0     0    09
[    3.085363]  0a 0009 1   0    0    0   0   0    0     0    0A
[    3.085368]  0b 000A 1   0    0    0   0   0    0     0    0B
[    3.085373]  0c 0012 1   0    0    0   0   0    0     0    0C
[    3.085378]  0d 000F 1   0    0    0   0   0    0     0    0D
[    3.085383]  0e 000D 1   0    0    0   0   0    0     0    0E
[    3.085388]  0f 000E 1   0    0    0   0   0    0     0    0F
[    3.085393]  10 0014 1   0    1    0   1   0    0     0    10
[    3.085398]  11 0015 1   1    1    0   1   0    0     0    11
[    3.085402]  12 0000 0   1    0    0   0   0    0     0    00
[    3.085407]  13 0016 1   1    1    0   1   0    0     0    13
[    3.085412]  14 0013 1   0    0    0   0   0    0     0    14
[    3.085417]  15 0000 0   1    0    0   0   0    0     0    00
[    3.085421]  16 0000 0   1    0    0   0   0    0     0    00
[    3.085426]  17 0019 1   0    1    0   1   0    0     0    17
[    3.085428] IRQ to pin mappings:
[    3.085429] IRQ0 -> 0:2
[    3.085431] IRQ1 -> 0:1
[    3.085432] IRQ3 -> 0:3
[    3.085433] IRQ4 -> 0:4
[    3.085435] IRQ5 -> 0:5
[    3.085436] IRQ6 -> 0:6
[    3.085437] IRQ7 -> 0:7
[    3.085438] IRQ8 -> 0:8
[    3.085440] IRQ9 -> 0:9
[    3.085441] IRQ10 -> 0:10
[    3.085443] IRQ11 -> 0:11
[    3.085444] IRQ12 -> 0:12
[    3.085445] IRQ13 -> 0:13
[    3.085446] IRQ14 -> 0:14
[    3.085448] IRQ15 -> 0:15
[    3.085449] IRQ16 -> 0:16
[    3.085450] IRQ17 -> 0:17
[    3.085451] IRQ19 -> 0:19
[    3.085453] IRQ20 -> 0:20
[    3.085454] IRQ23 -> 0:23
[    3.085455] .................................... done.
[    3.085478] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.086479] i8042: [1175] fa <- i8042 (interrupt, 1, 12)
[    3.086492] i8042: [1176] d4 -> i8042 (command)
[    3.086656] i8042: [1176] 00 -> i8042 (parameter)
[    3.089087] i8042: [1176] fa <- i8042 (interrupt, 1, 12)
[    3.089102] i8042: [1178] d4 -> i8042 (command)
[    3.089370] i8042: [1178] e8 -> i8042 (parameter)
[    3.091996] i8042: [1178] fa <- i8042 (interrupt, 1, 12)
[    3.092012] i8042: [1181] d4 -> i8042 (command)
[    3.092227] i8042: [1181] 00 -> i8042 (parameter)
[    3.094467] i8042: [1181] fa <- i8042 (interrupt, 1, 12)
[    3.094483] i8042: [1184] d4 -> i8042 (command)
[    3.094648] i8042: [1184] e8 -> i8042 (parameter)
[    3.097145] i8042: [1184] fa <- i8042 (interrupt, 1, 12)
[    3.097161] i8042: [1186] d4 -> i8042 (command)
[    3.097427] i8042: [1186] 00 -> i8042 (parameter)
[    3.099660] i8042: [1187] fa <- i8042 (interrupt, 1, 12)
[    3.099675] i8042: [1189] d4 -> i8042 (command)
[    3.099838] i8042: [1189] e9 -> i8042 (parameter)
[    3.100250] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    3.102322] i8042: [1189] fa <- i8042 (interrupt, 1, 12)
[    3.103328] i8042: [1192] 33 <- i8042 (interrupt, 1, 12)
[    3.104331] i8042: [1193] cc <- i8042 (interrupt, 1, 12)
[    3.105784] i8042: [1193] a3 <- i8042 (interrupt, 1, 12)
[    3.105799] i8042: [1195] d4 -> i8042 (command)
[    3.106067] i8042: [1195] f6 -> i8042 (parameter)
[    3.108584] i8042: [1195] fa <- i8042 (interrupt, 1, 12)
[    3.108600] i8042: [1198] d4 -> i8042 (command)
[    3.108762] i8042: [1198] e8 -> i8042 (parameter)
[    3.111662] i8042: [1198] fa <- i8042 (interrupt, 1, 12)
[    3.111677] i8042: [1201] d4 -> i8042 (command)
[    3.111945] i8042: [1201] 00 -> i8042 (parameter)
[    3.114237] i8042: [1201] fa <- i8042 (interrupt, 1, 12)
[    3.114254] i8042: [1204] d4 -> i8042 (command)
[    3.114522] i8042: [1204] e6 -> i8042 (parameter)
[    3.117199] i8042: [1204] fa <- i8042 (interrupt, 1, 12)
[    3.117214] i8042: [1207] d4 -> i8042 (command)
[    3.117378] i8042: [1207] e6 -> i8042 (parameter)
[    3.119700] i8042: [1207] fa <- i8042 (interrupt, 1, 12)
[    3.119715] i8042: [1209] d4 -> i8042 (command)
[    3.119880] i8042: [1209] e6 -> i8042 (parameter)
[    3.123090] i8042: [1209] fa <- i8042 (interrupt, 1, 12)
[    3.123105] i8042: [1212] d4 -> i8042 (command)
[    3.123320] i8042: [1212] e9 -> i8042 (parameter)
[    3.125623] i8042: [1212] fa <- i8042 (interrupt, 1, 12)
[    3.126956] i8042: [1215] 05 <- i8042 (interrupt, 1, 12)
[    3.127832] i8042: [1216] 00 <- i8042 (interrupt, 1, 12)
[    3.128715] i8042: [1216] 64 <- i8042 (interrupt, 1, 12)
[    3.128731] i8042: [1218] d4 -> i8042 (command)
[    3.128894] i8042: [1218] f6 -> i8042 (parameter)
[    3.132087] i8042: [1218] fa <- i8042 (interrupt, 1, 12)
[    3.132101] i8042: [1221] d4 -> i8042 (command)
[    3.132265] i8042: [1221] f5 -> i8042 (parameter)
[    3.134770] i8042: [1222] fa <- i8042 (interrupt, 1, 12)
[    3.134786] i8042: [1224] d4 -> i8042 (command)
[    3.134949] i8042: [1224] e6 -> i8042 (parameter)
[    3.137759] i8042: [1224] fa <- i8042 (interrupt, 1, 12)
[    3.137773] i8042: [1227] d4 -> i8042 (command)
[    3.137935] i8042: [1227] e6 -> i8042 (parameter)
[    3.140370] i8042: [1227] fa <- i8042 (interrupt, 1, 12)
[    3.140385] i8042: [1230] d4 -> i8042 (command)
[    3.140654] i8042: [1230] e6 -> i8042 (parameter)
[    3.143061] i8042: [1230] fa <- i8042 (interrupt, 1, 12)
[    3.143076] i8042: [1232] d4 -> i8042 (command)
[    3.143291] i8042: [1232] e9 -> i8042 (parameter)
[    3.145630] i8042: [1232] fa <- i8042 (interrupt, 1, 12)
[    3.147022] i8042: [1235] 05 <- i8042 (interrupt, 1, 12)
[    3.147898] i8042: [1236] 02 <- i8042 (interrupt, 1, 12)
[    3.148782] i8042: [1236] 64 <- i8042 (interrupt, 1, 12)
[    3.148796] i8042: [1238] d4 -> i8042 (command)
[    3.148959] i8042: [1238] e8 -> i8042 (parameter)
[    3.151988] PM: Checking hibernation image partition /dev/system/swap
[    3.152061] i8042: [1241] fa <- i8042 (interrupt, 1, 12)
[    3.152134] i8042: [1241] d4 -> i8042 (command)
[    3.152298] i8042: [1242] 03 -> i8042 (parameter)
[    3.154621] i8042: [1244] fa <- i8042 (interrupt, 1, 12)
[    3.154707] i8042: [1244] d4 -> i8042 (command)
[    3.154818] i8042: [1244] e6 -> i8042 (parameter)
[    3.157874] i8042: [1247] fa <- i8042 (interrupt, 1, 12)
[    3.157971] i8042: [1247] d4 -> i8042 (command)
[    3.158134] i8042: [1247] e6 -> i8042 (parameter)
[    3.160475] i8042: [1250] fa <- i8042 (interrupt, 1, 12)
[    3.160558] i8042: [1250] d4 -> i8042 (command)
[    3.160669] i8042: [1250] e6 -> i8042 (parameter)
[    3.163664] i8042: [1253] fa <- i8042 (interrupt, 1, 12)
[    3.163788] i8042: [1253] d4 -> i8042 (command)
[    3.163900] i8042: [1253] e9 -> i8042 (parameter)
[    3.167138] i8042: [1256] fa <- i8042 (interrupt, 1, 12)
[    3.168005] i8042: [1257] 05 <- i8042 (interrupt, 1, 12)
[    3.168892] i8042: [1258] 03 <- i8042 (interrupt, 1, 12)
[    3.169776] i8042: [1259] 64 <- i8042 (interrupt, 1, 12)
[    3.169856] i8042: [1259] d4 -> i8042 (command)
[    3.169966] i8042: [1259] e8 -> i8042 (parameter)
[    3.173330] i8042: [1263] fa <- i8042 (interrupt, 1, 12)
[    3.173421] i8042: [1263] d4 -> i8042 (command)
[    3.173639] i8042: [1263] 00 -> i8042 (parameter)
[    3.175962] i8042: [1265] fa <- i8042 (interrupt, 1, 12)
[    3.176044] i8042: [1265] d4 -> i8042 (command)
[    3.176209] i8042: [1265] e6 -> i8042 (parameter)
[    3.178726] i8042: [1268] fa <- i8042 (interrupt, 1, 12)
[    3.178820] i8042: [1268] d4 -> i8042 (command)
[    3.178931] i8042: [1268] e6 -> i8042 (parameter)
[    3.181375] i8042: [1271] fa <- i8042 (interrupt, 1, 12)
[    3.181499] i8042: [1271] d4 -> i8042 (command)
[    3.182240] i8042: [1271] e6 -> i8042 (parameter)
[    3.184747] i8042: [1274] fa <- i8042 (interrupt, 1, 12)
[    3.184842] i8042: [1274] d4 -> i8042 (command)
[    3.184954] i8042: [1274] e9 -> i8042 (parameter)
[    3.187999] i8042: [1277] fa <- i8042 (interrupt, 1, 12)
[    3.188866] i8042: [1278] 05 <- i8042 (interrupt, 1, 12)
[    3.189767] i8042: [1279] 00 <- i8042 (interrupt, 1, 12)
[    3.190756] i8042: [1280] 64 <- i8042 (interrupt, 1, 12)
[    3.190841] i8042: [1280] d4 -> i8042 (command)
[    3.190953] i8042: [1280] e1 -> i8042 (parameter)
[    3.215928] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    3.237807] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    3.259900] hub 2-1:1.0: USB hub found
[    3.281547] hub 2-1:1.0: 8 ports detected
[    3.299961] ata5: SATA link down (SStatus 0 SControl 300)
[    3.389927] i8042: [1480] d4 -> i8042 (command)
[    3.390091] i8042: [1480] 0a -> i8042 (parameter)
[    3.398162] usb 1-1.4: new high-speed USB device number 3 using ehci_h=
cd
[    3.561936] usb 1-1.4: New USB device found, idVendor=3D0c45,=20
idProduct=3D642a
[    3.583110] usb 1-1.4: New USB device strings: Mfr=3D2, Product=3D1,=20
SerialNumber=3D0
[    3.589561] i8042: [1680] d4 -> i8042 (command)
[    3.589671] i8042: [1680] f5 -> i8042 (parameter)
[    3.604568] i8042: [1695] fa <- i8042 (interrupt, 1, 12)
[    3.604573] usb 1-1.4: Product: Laptop_Integrated_Webcam_2HDM
[    3.604613] i8042: [1695] d4 -> i8042 (command)
[    3.604725] i8042: [1695] f3 -> i8042 (parameter)
[    3.626275] i8042: [1716] fa <- i8042 (interrupt, 1, 12)
[    3.626278] usb 1-1.4: Manufacturer: CN0XRCWG724871ANS3CZA00
[    3.626320] i8042: [1716] d4 -> i8042 (command)
[    3.626484] i8042: [1716] 66 -> i8042 (parameter)
[    3.648215] i8042: [1738] fe <- i8042 (interrupt, 1, 12)
[    3.648259] i8042: [1738] d4 -> i8042 (command)
[    3.648424] i8042: [1738] 88 -> i8042 (parameter)
[    3.678465] i8042: [1769] d4 -> i8042 (command)
[    3.678643] i8042: [1769] f3 -> i8042 (parameter)
[    3.681134] i8042: [1771] fc <- i8042 (interrupt, 1, 12)
[    3.681225] i8042: [1771] d4 -> i8042 (command)
[    3.681336] i8042: [1771] f4 -> i8042 (parameter)
[    3.684450] i8042: [1775] fa <- i8042 (interrupt, 1, 12)
[    3.684574] i8042: [1775] d4 -> i8042 (command)
[    3.684791] i8042: [1775] f6 -> i8042 (parameter)
[    3.688413] i8042: [1779] fa <- i8042 (interrupt, 1, 12)
[    3.688507] i8042: [1779] d4 -> i8042 (command)
[    3.689512] i8042: [1779] ff -> i8042 (parameter)
[    3.692089] i8042: [1782] fa <- i8042 (interrupt, 1, 12)
[    3.726675] usb 2-1.5: new full-speed USB device number 3 using ehci_h=
cd
[    3.838521] usb 2-1.5: New USB device found, idVendor=3D8086,=20
idProduct=3D0189
[    3.861231] usb 2-1.5: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    3.892268] i8042: [1983] aa <- i8042 (interrupt, 1, 12)
[    3.893135] i8042: [1984] 00 <- i8042 (interrupt, 1, 12)
[    3.893215] i8042: [1984] d4 -> i8042 (command)
[    3.893483] i8042: [1984] f3 -> i8042 (parameter)
[    3.896588] i8042: [1987] fa <- i8042 (interrupt, 1, 12)
[    3.896676] i8042: [1987] d4 -> i8042 (command)
[    3.896787] i8042: [1987] c8 -> i8042 (parameter)
[    3.899159] i8042: [1990] fa <- i8042 (interrupt, 1, 12)
[    3.899238] i8042: [1990] d4 -> i8042 (command)
[    3.899454] i8042: [1990] f3 -> i8042 (parameter)
[    3.902540] i8042: [1993] fa <- i8042 (interrupt, 1, 12)
[    3.902664] i8042: [1993] d4 -> i8042 (command)
[    3.902775] i8042: [1993] 64 -> i8042 (parameter)
[    3.905189] i8042: [1996] fa <- i8042 (interrupt, 1, 12)
[    3.905283] i8042: [1996] d4 -> i8042 (command)
[    3.905973] i8042: [1996] f3 -> i8042 (parameter)
[    3.908560] i8042: [1999] fa <- i8042 (interrupt, 1, 12)
[    3.908653] i8042: [1999] d4 -> i8042 (command)
[    3.908765] i8042: [1999] 50 -> i8042 (parameter)
[    3.911650] i8042: [2002] fa <- i8042 (interrupt, 1, 12)
[    3.911743] i8042: [2002] d4 -> i8042 (command)
[    3.911855] i8042: [2002] f2 -> i8042 (parameter)
[    3.914438] i8042: [2005] fa <- i8042 (interrupt, 1, 12)
[    3.915312] i8042: [2006] 03 <- i8042 (interrupt, 1, 12)
[    3.915406] i8042: [2006] d4 -> i8042 (command)
[    3.916096] i8042: [2006] f3 -> i8042 (parameter)
[    3.918631] i8042: [2009] fa <- i8042 (interrupt, 1, 12)
[    3.918752] i8042: [2009] d4 -> i8042 (command)
[    3.918864] i8042: [2009] c8 -> i8042 (parameter)
[    3.921832] i8042: [2012] fa <- i8042 (interrupt, 1, 12)
[    3.921958] i8042: [2012] d4 -> i8042 (command)
[    3.922122] i8042: [2012] f3 -> i8042 (parameter)
[    3.924645] i8042: [2015] fa <- i8042 (interrupt, 1, 12)
[    3.924738] i8042: [2015] d4 -> i8042 (command)
[    3.924850] i8042: [2015] c8 -> i8042 (parameter)
[    3.927376] i8042: [2018] fa <- i8042 (interrupt, 1, 12)
[    3.927502] i8042: [2018] d4 -> i8042 (command)
[    3.927667] i8042: [2018] f3 -> i8042 (parameter)
[    3.930190] i8042: [2021] fa <- i8042 (interrupt, 1, 12)
[    3.930313] i8042: [2021] d4 -> i8042 (command)
[    3.931428] i8042: [2021] 50 -> i8042 (parameter)
[    3.933733] i8042: [2024] fa <- i8042 (interrupt, 1, 12)
[    3.933824] i8042: [2024] d4 -> i8042 (command)
[    3.933936] i8042: [2024] f2 -> i8042 (parameter)
[    3.936990] i8042: [2027] fa <- i8042 (interrupt, 1, 12)
[    3.937836] i8042: [2028] 03 <- i8042 (interrupt, 1, 12)
[    3.937931] i8042: [2028] d4 -> i8042 (command)
[    3.938042] i8042: [2028] f3 -> i8042 (parameter)
[    3.941461] i8042: [2032] fa <- i8042 (interrupt, 1, 12)
[    3.941554] i8042: [2032] d4 -> i8042 (command)
[    3.941770] i8042: [2032] c8 -> i8042 (parameter)
[    3.944095] i8042: [2035] fa <- i8042 (interrupt, 1, 12)
[    3.944219] i8042: [2035] d4 -> i8042 (command)
[    3.944330] i8042: [2035] f3 -> i8042 (parameter)
[    3.947216] i8042: [2038] fa <- i8042 (interrupt, 1, 12)
[    3.947324] i8042: [2038] d4 -> i8042 (command)
[    3.947488] i8042: [2038] 64 -> i8042 (parameter)
[    3.949809] i8042: [2040] fa <- i8042 (interrupt, 1, 12)
[    3.949903] i8042: [2040] d4 -> i8042 (command)
[    3.950015] i8042: [2040] f3 -> i8042 (parameter)
[    3.952817] i8042: [2043] fa <- i8042 (interrupt, 1, 12)
[    3.952941] i8042: [2043] d4 -> i8042 (command)
[    3.953053] i8042: [2043] 50 -> i8042 (parameter)
[    3.955464] i8042: [2046] fa <- i8042 (interrupt, 1, 12)
[    3.955589] i8042: [2046] d4 -> i8042 (command)
[    3.955753] i8042: [2046] f2 -> i8042 (parameter)
[    3.958834] i8042: [2049] fa <- i8042 (interrupt, 1, 12)
[    3.959841] i8042: [2050] 03 <- i8042 (interrupt, 1, 12)
[    3.959980] i8042: [2051] d4 -> i8042 (command)
[    3.960092] i8042: [2051] f3 -> i8042 (parameter)
[    3.963087] i8042: [2054] fa <- i8042 (interrupt, 1, 12)
[    3.963213] i8042: [2054] d4 -> i8042 (command)
[    3.963378] i8042: [2054] 64 -> i8042 (parameter)
[    3.965850] i8042: [2056] fa <- i8042 (interrupt, 1, 12)
[    3.965945] i8042: [2056] d4 -> i8042 (command)
[    3.966056] i8042: [2056] e8 -> i8042 (parameter)
[    3.968700] i8042: [2059] fa <- i8042 (interrupt, 1, 12)
[    3.968794] i8042: [2059] d4 -> i8042 (command)
[    3.968959] i8042: [2059] 03 -> i8042 (parameter)
[    3.971304] i8042: [2062] fa <- i8042 (interrupt, 1, 12)
[    3.971398] i8042: [2062] d4 -> i8042 (command)
[    3.974350] i8042: [2062] e6 -> i8042 (parameter)
[    3.976879] i8042: [2067] fa <- i8042 (interrupt, 1, 12)
[    3.977018] input: ImPS/2 Generic Wheel Mouse as=20
/devices/platform/i8042/serio1/input/input1
[    4.000810] i8042: [2091] d4 -> i8042 (command)
[    4.000921] i8042: [2091] f4 -> i8042 (parameter)
[    4.003458] i8042: [2094] fa <- i8042 (interrupt, 1, 12)
[    4.003598] PM: Hibernation image not present or could not be loaded.
[    4.003620] registered taskstats version 1
[    4.035412]   Magic number: 7:990:357
[    4.059596] rtc_cmos 00:05: setting system clock to 2011-12-27=20
01:23:24 UTC (1324949004)
[    4.085662] Freeing unused kernel memory: 944k freed
[    4.110469] Write protecting the kernel read-only data: 12288k
[    4.135741] Freeing unused kernel memory: 192k freed
[    4.164739] Freeing unused kernel memory: 1944k freed
[    4.241203] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.266531] shpchp: shpcd_init: pci_register_driver =3D 0
[    4.266533] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
[    4.322294] udevd[131]: starting version 173
[    4.356829] input: Power Button as=20
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    4.393554] ACPI: Power Button [PWRB]
[    4.393740] thermal LNXTHERM:00: registered as thermal_zone0
[    4.393743] ACPI: Thermal Zone [TZ00] (54 C)
[    4.393978] thermal LNXTHERM:01: registered as thermal_zone1
[    4.393981] ACPI: Thermal Zone [TZ01] (54 C)
[    4.522579]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:04:00.0[A] _PRT entry
[    4.522586] xhci_hcd 0000:04:00.0: PCI INT A -> GSI 19 (level, low)=20
-> IRQ 19
[    4.522610] xhci_hcd 0000:04:00.0: setting latency timer to 64
[    4.522615] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    4.522627] xhci_hcd 0000:04:00.0: new USB bus registered, assigned=20
bus number 3
[    4.522834] xhci_hcd 0000:04:00.0: irq 19, io mem 0xf1a00000
[    4.522906] xhci_hcd 0000:04:00.0: irq 44 for MSI/MSI-X
[    4.522913] xhci_hcd 0000:04:00.0: irq 45 for MSI/MSI-X
[    4.522918] xhci_hcd 0000:04:00.0: irq 46 for MSI/MSI-X
[    4.522924] xhci_hcd 0000:04:00.0: irq 47 for MSI/MSI-X
[    4.522929] xhci_hcd 0000:04:00.0: irq 48 for MSI/MSI-X
[    4.523002] input: Sleep Button as=20
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[    4.523043] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    4.523045] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    4.523047] usb usb3: Product: xHCI Host Controller
[    4.523049] usb usb3: Manufacturer: Linux 3.2.0-rc6-3-desktop xhci_hcd
[    4.523050] usb usb3: SerialNumber: 0000:04:00.0
[    4.523265] xHCI xhci_add_endpoint called for root hub
[    4.523267] xHCI xhci_check_bandwidth called for root hub
[    4.523328] hub 3-0:1.0: USB hub found
[    4.523339] hub 3-0:1.0: 2 ports detected
[    4.523379] ACPI: Sleep Button [SLPB]
[    4.523426] input: Lid Switch as=20
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input4
[    4.523478] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    4.523488] xhci_hcd 0000:04:00.0: new USB bus registered, assigned=20
bus number 4
[    4.524286] ACPI: Lid Switch [LID0]
[    4.524340] input: Power Button as=20
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    4.524373] ACPI: Power Button [PWRF]
[    4.526215] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    4.526218] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    4.526220] usb usb4: Product: xHCI Host Controller
[    4.526222] usb usb4: Manufacturer: Linux 3.2.0-rc6-3-desktop xhci_hcd
[    4.526223] usb usb4: SerialNumber: 0000:04:00.0
[    4.526375] xHCI xhci_add_endpoint called for root hub
[    4.526377] xHCI xhci_check_bandwidth called for root hub
[    4.526439] hub 4-0:1.0: USB hub found
[    4.526448] hub 4-0:1.0: 2 ports detected
[    4.526942] [drm] Initialized drm 1.1.0 20060810
[    4.531282]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:02.0[A] _PRT entry
[    4.531289] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ=
 16
[    4.531292] i915 0000:00:02.0: setting latency timer to 64
[    5.368663] i915 0000:00:02.0: irq 49 for MSI/MSI-X
[    5.368666] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010)=
.
[    5.368667] [drm] Driver supports precise vblank timestamp query.
[    5.378777] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call=20
failed
[    5.378819] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call=20
failed
[    5.378837] vgaarb: device changed decodes:=20
PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[    5.378839] vgaarb: transferring owner from PCI:0000:00:02.0 to=20
PCI:0000:01:00.0
[    5.569660] usb 3-1: new low-speed USB device number 2 using xhci_hcd
[    5.609793] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.621761] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.633738] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.638365] usb 3-1: New USB device found, idVendor=3D04ca, idProduct=3D=
0027
[    5.642881] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[    5.647346] usb 3-1: Product: USB Multimedia Keyboard
[    5.651787] usb 3-1: Manufacturer: Lite-On Technology Corp.
[    5.656387] usb 3-1: ep 0x81 - rounding interval to 128 microframes,=20
ep desc says 192 microframes
[    5.660984] usb 3-1: ep 0x82 - rounding interval to 64 microframes,=20
ep desc says 80 microframes
[    5.680911] input: Lite-On Technology Corp. USB Multimedia Keyboard=20
as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1/3-1:1.0/input/inpu=
t6
[    5.685919] generic-usb 0003:04CA:0027.0001: input,hidraw0: USB HID=20
v1.10 Keyboard [Lite-On Technology Corp. USB Multimedia Keyboard] on=20
usb-0000:04:00.0-1/input0
[    5.721562] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.728628] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.735543] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.740403] input: Lite-On Technology Corp. USB Multimedia Keyboard=20
as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1/3-1:1.1/input/inpu=
t7
[    5.745533] generic-usb 0003:04CA:0027.0002: input,hiddev0,hidraw1:=20
USB HID v1.10 Device [Lite-On Technology Corp. USB Multimedia Keyboard]=20
on usb-0000:04:00.0-1/input1
[    5.857203] usb 3-2: new high-speed USB device number 3 using xhci_hcd
[    5.876155] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.881610] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.886481] usb 3-2: New USB device found, idVendor=3D05e3, idProduct=3D=
0608
[    5.891212] usb 3-2: New USB device strings: Mfr=3D0, Product=3D1,=20
SerialNumber=3D0
[    5.895947] usb 3-2: Product: USB2.0 Hub
[    5.901665] hub 3-2:1.0: USB hub found
[    5.906793] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.911512] hub 3-2:1.0: 4 ports detected
[    5.945622] checking generic (e0000000 3ff0000) vs hw (e0000000 100000=
00)
[    5.945624] fb: conflicting fb hw usage inteldrmfb vs VESA VGA -=20
removing generic driver
[    5.950427] Console: switching to colour dummy device 80x25
[    5.951515] fbcon: inteldrmfb (fb0) is primary device
[    6.186212] usb 3-2.4: new high-speed USB device number 4 using xhci_h=
cd
[    6.200498] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.201158] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.201314] usb 3-2.4: New USB device found, idVendor=3D05e3,=20
idProduct=3D0608
[    6.201321] usb 3-2.4: New USB device strings: Mfr=3D0, Product=3D1,=20
SerialNumber=3D0
[    6.201327] usb 3-2.4: Product: USB2.0 Hub
[    6.202290] hub 3-2.4:1.0: USB hub found
[    6.202750] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.202925] hub 3-2.4:1.0: 4 ports detected
[    6.313235] Console: switching to colour frame buffer device 236x63
[    6.334979] fb0: inteldrmfb frame buffer device
[    6.335054] drm: registered panic notifier
[    6.335313] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    6.338677] acpi device:2e: registered as cooling_device4
[    6.338816] input: Video Bus as=20
/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:2d/LNXVIDEO:00/input/inp=
ut8
[    6.339007] ACPI: Video Device [PEGP] (multi-head: yes  rom: yes=20
post: no)
[    6.343258] acpi device:32: registered as cooling_device5
[    6.343536] input: Video Bus as=20
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input9
[    6.343717] ACPI: Video Device [GFX0] (multi-head: yes  rom: no=20
post: no)
[    6.343857] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on=20
minor 0
[    6.402163] Btrfs loaded
[    6.443076] md: linear personality registered for level -1
[    6.478910] device-mapper: uevent: version 1.0.3
[    6.479053] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19)=20
initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    6.482774] usb 3-2.4.4: new low-speed USB device number 5 using xhci_=
hcd
[    6.501092] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.503088] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.504086] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.504375] usb 3-2.4.4: New USB device found, idVendor=3D046d,=20
idProduct=3Dc063
[    6.509607] usb 3-2.4.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D0
[    6.514763] usb 3-2.4.4: Product: DELL USB Laser Mouse
[    6.519906] usb 3-2.4.4: Manufacturer: DELL
[    6.525207] usb 3-2.4.4: ep 0x81 - rounding interval to 64=20
microframes, ep desc says 80 microframes
[    6.536487] input: DELL DELL USB Laser Mouse as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-2/3-2.4/3-2.4.4/3-2.=
4.4:1.0/input/input10
[    6.542117] generic-usb 0003:046D:C063.0003: input,hidraw2: USB HID=20
v1.10 Mouse [DELL DELL USB Laser Mouse] on usb-0000:04:00.0-2.4.4/input0
[   39.516864] PM: Marking nosave pages: 000000000009d000 - 0000000000100=
000
[   39.516868] PM: Marking nosave pages: 00000000b5a28000 - 00000000b6e29=
000
[   39.516926] PM: Marking nosave pages: 00000000b886a000 - 00000000b8ab3=
000
[   39.516934] PM: Marking nosave pages: 00000000bac8f000 - 00000000bafff=
000
[   39.516945] PM: Marking nosave pages: 00000000bb000000 - 0000000100000=
000
[   39.517655] PM: Basic memory bitmaps created
[   39.540690] PM: Basic memory bitmaps freed
[   39.540694] video LNXVIDEO:00: Restoring backlight state
[   39.540695] video LNXVIDEO:01: Restoring backlight state
[   39.590164] PM: Starting manual resume from disk
[   39.595666] PM: Hibernation image partition 253:3 present
[   39.595669] PM: Looking for hibernation image.
[   39.597171] PM: Image not found (code -22)
[   39.597173] PM: Hibernation image not present or could not be loaded.
[   39.615833] device fsid ca00ffff-8c21-4750-b25c-3cf321a07dd9 devid 1=20
transid 21081 /dev/mapper/system-root
[   39.616353] btrfs: turning off barriers
[   39.616356] btrfs: enabling auto defrag
[   39.616357] btrfs: use lzo compression
[   39.616358] btrfs: disk space caching is enabled
[   39.661102] Btrfs detected SSD devices, enabling SSD mode
[   40.401467] btrfs: turning off barriers
[   40.407291] btrfs: enabling auto defrag
[   40.407352] btrfs: use lzo compression
[   40.418719] btrfs: disk space caching is enabled
[   40.683437] systemd[1]: systemd 37 running in system mode. (+PAM=20
+LIBWRAP +AUDIT +SELINUX +SYSVINIT +LIBCRYPTSETUP; suse)
[   40.731811] systemd[1]: Set hostname to <xps15z.cristianrodriguez.net>=
.
[   41.272117] udevd[606]: starting version 173
[   41.435290] mei: module is from the staging directory, the quality is=20
unknown, you have been warned.
[   41.435823]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:16.0[A] _PRT entry
[   41.435829] mei 0000:00:16.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[   41.435834] mei 0000:00:16.0: setting latency timer to 64
[   41.435901] mei 0000:00:16.0: irq 50 for MSI/MSI-X
[   41.473031] iTCO_vendor_support: vendor-support=3D0
[   41.477614]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:06:00.0[A] _PRT entry
[   41.477622] atl1c 0000:06:00.0: PCI INT A -> GSI 17 (level, low) ->=20
IRQ 17
[   41.477633] atl1c 0000:06:00.0: setting latency timer to 64
[   41.487779] mtp-probe[752]: checking bus 3, device 2:=20
"/sys/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1"
[   41.497929]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1f.3[C] _PRT entry
[   41.497940] IOAPIC[0]: Set routing entry (2-18 -> 0xb9 -> IRQ 18=20
Mode:1 Active:1 Dest:1)
[   41.497946] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:B9 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[   41.497951] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low)=20
-> IRQ 18
[   41.503468] mtp-probe[752]: bus: 3, device: 2 was not an MTP device
[   41.508295] ACPI: Deprecated procfs I/F for AC is loaded, please=20
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   41.508873] input: PC Speaker as /devices/platform/pcspkr/input/input1=
1
[   41.528598] mtp-probe[776]: checking bus 3, device 5:=20
"/sys/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-2/3-2.4/3-2.4.4=
"
[   41.533704] mtp-probe[776]: bus: 3, device: 5 was not an MTP device
[   41.538647] btrfs: turning off barriers
[   41.538650] btrfs: enabling auto defrag
[   41.538653] btrfs: use lzo compression
[   41.538653] btrfs: disk space caching is enabled
[   41.559847] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   41.568681] mtp-probe[794]: checking bus 1, device 3:=20
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4"
[   41.570805] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   41.578853] mtp-probe[794]: bus: 1, device: 3 was not an MTP device
[   41.587647] atl1c 0000:06:00.0: version 1.0.1.0-NAPI
[   41.593026] microcode: CPU0 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.597648] Bluetooth: Core ver 2.16
[   41.603983] NET: Registered protocol family 31
[   41.608008] ACPI: AC Adapter [ADP0] (on-line)
[   41.614610] Bluetooth: HCI device and connection manager initialized
[   41.614613] Bluetooth: HCI socket layer initialized
[   41.614615] Bluetooth: L2CAP socket layer initialized
[   41.614622] Bluetooth: SCO socket layer initialized
[   41.640484] microcode: CPU1 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.643741] microcode: CPU2 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.646724] microcode: CPU3 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.654637] microcode: Microcode Update Driver: v2.00=20
<tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[   41.676921] ACPI: Deprecated procfs I/F for battery is loaded, please=20
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   41.681836] ACPI: Battery Slot [BAT0] (battery present)
[   41.687239] wmi: Mapper loaded
[   41.693494] Linux video capture interface: v2.00
[   41.701454] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   41.701861] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[   41.701932] iTCO_wdt: Found a Cougar Point TCO device (Version=3D2,=20
TCOBASE=3D0x0460)
[   41.702023] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   41.702161] usbcore: registered new interface driver btusb
[   41.731287] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw=20
xa/form2 cdda caddy
[   41.731291] cdrom: Uniform CD-ROM driver Revision: 3.20
[   41.733075] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   41.742658] cfg80211: Calling CRDA to update world regulatory domain
[   41.755562] dcdbas dcdbas: Dell Systems Management Base Driver=20
(version 5.6.0-3.2)
[   41.766095] uvcvideo: Found UVC 1.00 device=20
Laptop_Integrated_Webcam_2HDM (0c45:642a)
[   41.772757] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:=
d
[   41.778771] Copyright(c) 2003-2011 Intel Corporation
[   41.778833] input: Laptop_Integrated_Webcam_2HDM as=20
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/input/input12
[   41.778960] usbcore: registered new interface driver uvcvideo
[   41.778962] USB Video Class driver (1.1.1)
[   41.802479]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1b.0[A] _PRT entry
[   41.807306]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:03:00.0[A] _PRT entry
[   41.807313] iwlwifi 0000:03:00.0: PCI INT A -> GSI 17 (level, low) ->=20
IRQ 17
[   41.807344] iwlwifi 0000:03:00.0: setting latency timer to 64
[   41.807397] iwlwifi 0000:03:00.0: pci_resource_len =3D 0x00002000
[   41.807399] iwlwifi 0000:03:00.0: pci_resource_base =3D ffffc900057fc0=
00
[   41.807401] iwlwifi 0000:03:00.0: HW Revision ID =3D 0x34
[   41.807630] iwlwifi 0000:03:00.0: irq 51 for MSI/MSI-X
[   41.807715] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R)=20
Advanced-N 6230 AGN, REV=3D0xB0
[   41.807861] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   41.823275] iwlwifi 0000:03:00.0: device EEPROM VER=3D0x716, CALIB=3D0=
x6
[   41.823278] iwlwifi 0000:03:00.0: Device SKU: 0X1f0
[   41.823280] iwlwifi 0000:03:00.0: Valid Tx ant: 0X3, Valid Rx ant: 0X3
[   41.823300] iwlwifi 0000:03:00.0: Tunable channels: 13 802.11bg, 24=20
802.11a channels
[   41.829386] ifup[893]: Service network not started and mode 'auto' ->=20
skipping
[   41.852847] cfg80211: World regulatory domain updated:
[   41.852849] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[   41.852850] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852852] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852853] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852854] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852855] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.920210] IOAPIC[0]: Set routing entry (2-22 -> 0xc9 -> IRQ 22=20
Mode:1 Active:1 Dest:1)
[   41.920216] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:C9 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[   41.920221] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,=20
low) -> IRQ 22
[   41.920290] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[   41.920313] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   41.920845] input: Dell WMI hotkeys as /devices/virtual/input/input13
[   41.940703] iwlwifi 0000:03:00.0: loaded firmware version 17.168.5.1=20
build 33993
[   41.940849] Registered led device: phy0-led
[   41.964426] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-r=
s'
[   42.010557] ifup[964]: Service network not started and mode 'auto' ->=20
skipping
[   42.174781] Adding 2097148k swap on /dev/mapper/system-swap.=20
Priority:0 extents:1 across:2097148k SS
[   44.925951] ALSA hda_intel.c:812 azx_get_response timeout, switching=20
to polling mode: last cmd=3D0x000f0000
[   45.437474] ALSA patch_realtek.c:1261 SKU: Nid=3D0x1d sku_cfg=3D0x4017=
9a2d
[   45.437477] ALSA patch_realtek.c:1263 SKU: port_connectivity=3D0x1
[   45.437478] ALSA patch_realtek.c:1264 SKU: enable_pcbeep=3D0x1
[   45.437480] ALSA patch_realtek.c:1265 SKU: check_sum=3D0x00000007
[   45.437481] ALSA patch_realtek.c:1266 SKU: customization=3D0x0000009a
[   45.437482] ALSA patch_realtek.c:1267 SKU: external_amp=3D0x5
[   45.437483] ALSA patch_realtek.c:1268 SKU: platform_type=3D0x1
[   45.437485] ALSA patch_realtek.c:1269 SKU: swap=3D0x0
[   45.437486] ALSA patch_realtek.c:1270 SKU: override=3D0x1
[   45.437895] ALSA hda_codec.c:4951 autoconfig: line_outs=3D1=20
(0x14/0x0/0x0/0x0/0x0) type:speaker
[   45.437897] ALSA hda_codec.c:4955    speaker_outs=3D0 (0x0/0x0/0x0/0x0=
/0x0)
[   45.437899] ALSA hda_codec.c:4959    hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0=
)
[   45.437900] ALSA hda_codec.c:4960    mono: mono_out=3D0x0
[   45.437901] ALSA hda_codec.c:4964    inputs:
[   45.437903] ALSA hda_codec.c:4968  Internal Mic=3D0x12
[   45.437904] ALSA hda_codec.c:4968  Mic=3D0x18
[   45.437905] ALSA hda_codec.c:4970
[   45.439163] ALSA patch_realtek.c:1324 realtek: No valid SSID,=20
checking pincfg 0x40179a2d for NID 0x1d
[   45.439165] ALSA patch_realtek.c:1340 realtek: Enabling init=20
ASM_ID=3D0x9a2d CODEC_ID=3D10ec0269
[   45.443482] HDMI status: Codec=3D3 Pin=3D6 Presence_Detect=3D0 ELD_Val=
id=3D0
[   45.448591] input: HDA Intel PCH HDMI/DP,pcm=3D3 as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   45.453689] input: HDA Intel PCH Mic as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   45.458609] input: HDA Intel PCH Headphone as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   45.710010] systemd-cryptsetup[1010]: Volume cr_sda2 already active.
[   45.787497] systemd-fsck[1005]: /dev/sda1: limpio, 63/40000 ficheros,=20
137097/159744 bloques
[   45.824455] device fsid 403609d3-a44c-4bb6-99c4-8be5430433e7 devid 1=20
transid 22126 /dev/mapper/system-home
[   45.829949] btrfs: turning off barriers
[   45.834896] btrfs: enabling auto defrag
[   45.834957] btrfs: use lzo compression
[   45.840735] EXT4-fs (sda1): barriers disabled
[   45.849518] btrfs: disk space caching is enabled
[   45.854628] EXT4-fs (sda1): mounted filesystem with writeback data=20
mode. Opts: acl,barrier=3D0,data=3Dwriteback,user_xattr
[   45.869431] Btrfs detected SSD devices, enabling SSD mode
[   47.174579] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   47.174581] Bluetooth: BNEP filters: protocol multicast
[   47.205249] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   47.215832] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   47.337233] Bluetooth: RFCOMM TTY layer initialized
[   47.337238] Bluetooth: RFCOMM socket layer initialized
[   47.337239] Bluetooth: RFCOMM ver 1.11
[   47.505097] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   47.511590] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   47.635461] atl1c 0000:06:00.0: irq 53 for MSI/MSI-X
[   47.635523] atl1c 0000:06:00.0: atl1c: eth0 NIC Link is Up<1000 Mbps=20
Full Duplex>
[   47.648775] NET: Registered protocol family 17
[   48.961311] EXT4-fs (sda1): re-mounted. Opts:=20
acl,barrier=3D0,data=3Dwriteback,user_xattr,commit=3D0
[   96.852567] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[   96.855107] wlan0: authenticated
[   96.896863] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[   96.903865] wlan0: RX AssocResp from 06:1c:f0:60:61:11 (capab=3D0x431=20
status=3D0 aid=3D1)
[   96.903869] wlan0: associated
[  106.895705] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  106.909897] cfg80211: Calling CRDA to update world regulatory domain
[  106.912356] cfg80211: World regulatory domain updated:
[  106.912359] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  106.912361] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912363] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912365] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912366] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  106.912367] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  110.146828] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  110.149314] wlan0: authenticated
[  110.154157] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  110.159155] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  110.159157] wlan0: associated
[  120.042706] wlan0: deauthenticating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  120.054236] cfg80211: Calling CRDA to update world regulatory domain
[  120.056757] cfg80211: World regulatory domain updated:
[  120.056761] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  120.056763] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056764] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056766] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056767] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  120.056769] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  138.190818] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  138.193402] wlan0: authenticated
[  138.196754] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  138.201826] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  138.201840] wlan0: associated
[  148.192646] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  148.206339] cfg80211: Calling CRDA to update world regulatory domain
[  148.208741] cfg80211: World regulatory domain updated:
[  148.208744] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  148.208746] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208748] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208749] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208751] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  148.208752] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  151.443088] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  151.445498] wlan0: authenticated
[  151.446657] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  151.451688] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  151.451691] wlan0: associated
[  159.980012] wlan0: deauthenticating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  159.992768] cfg80211: Calling CRDA to update world regulatory domain
[  159.995101] cfg80211: World regulatory domain updated:
[  159.995104] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  159.995106] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995108] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995109] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995111] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  159.995112] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  172.519660] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  172.522038] wlan0: authenticated
[  172.525229] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  172.530226] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  172.530229] wlan0: associated
[  182.521101] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  182.535253] cfg80211: Calling CRDA to update world regulatory domain
[  182.537720] cfg80211: World regulatory domain updated:
[  182.537723] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  182.537725] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  182.537727] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  182.537728] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  182.537730] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  182.537731] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  185.803811] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  185.806245] wlan0: authenticated
[  185.807952] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  185.814223] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  185.814226] wlan0: associated
[  194.926199] wlan0: deauthenticating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  194.939848] cfg80211: Calling CRDA to update world regulatory domain
[  194.942320] cfg80211: World regulatory domain updated:
[  194.942323] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  194.942325] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  194.942326] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  194.942328] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  194.942329] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  194.942331] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  200.611067] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[  200.617743] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[  200.746343] atl1c 0000:06:00.0: irq 53 for MSI/MSI-X
[  200.746502] atl1c 0000:06:00.0: atl1c: eth0 NIC Link is Up<1000 Mbps=20
Full Duplex>
[  215.864303] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  215.867879] wlan0: authenticated
[  215.871819] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  215.878327] wlan0: RX AssocResp from 06:1c:f0:60:61:11 (capab=3D0x431=20
status=3D0 aid=3D1)
[  215.878330] wlan0: associated
[  225.870530] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  225.885706] cfg80211: Calling CRDA to update world regulatory domain
[  225.888475] cfg80211: World regulatory domain updated:
[  225.888479] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  225.888481] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  225.888483] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  225.888484] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  225.888486] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  225.888487] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  229.142454] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  229.145043] wlan0: authenticated
[  229.146399] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  229.151507] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  229.151510] wlan0: associated
[  237.860170] wlan0: deauthenticating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  237.878971] cfg80211: Calling CRDA to update world regulatory domain
[  237.881425] cfg80211: World regulatory domain updated:
[  237.881428] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  237.881430] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  237.881431] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  237.881433] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  237.881434] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  237.881436] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  253.367126] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  253.371335] wlan0: authenticated
[  253.372468] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  253.377431] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  253.377434] wlan0: associated
[  263.368490] wlan0: disassociating from 06:1c:f0:60:61:11 by local=20
choice (reason=3D3)
[  263.381771] cfg80211: Calling CRDA to update world regulatory domain
[  263.384197] cfg80211: World regulatory domain updated:
[  263.384200] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[  263.384202] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  263.384203] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  263.384205] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[  263.384206] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  263.384208] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[  266.659599] wlan0: authenticate with 06:1c:f0:60:61:11 (try 1)
[  266.662253] wlan0: authenticated
[  266.665307] wlan0: associate with 06:1c:f0:60:61:11 (try 1)
[  266.670391] wlan0: RX ReassocResp from 06:1c:f0:60:61:11 (capab=3D0x43=
1=20
status=3D0 aid=3D1)
[  266.670394] wlan0: associated
root@xps15z:/home/crrodriguez # ls
abuild         .cache      .emacs       .gconf=20
home:elvigia:nfs-systemd  .kchmviewer  .mozilla        .profile=20
  .qmmp          .skel         .vim         .xim.template=20
.zsh-update
.adobe         .config     esc.php      .gitconfig=20
.htoprc                   .kde4        M=FAsica          public_html=20
  .quiltrc       .ssh          .viminfo     .xinitrc.template
.aqemu         .dbus       Escritorio   .gnome2=20
Im=E1genes                  .kderc       .oh-my-zsh      P=FAblico=20
  .rcc           .subversion   .vim_local   .xsession-errors
attachments    Descargas   .esd_auth    .gstreamer-0.10=20
.inputrc                  .lastpass    .osc_cookiejar  .pulse=20
  rpmbuild       systemd.svg   .vimrc       yankring_history_v2.txt
.bash_history  .dmrc       .fontconfig  .gtkrc-2.0-kde4=20
isos                      .lesshst     .oscrc          .pulse-cookie=20
  .rpmmacros     .thumbnails   vms          .zcompdump
.bashrc        Documentos  .fonts       .gvfs=20
.java                     .local       .pki            pulseverbose.log=20
  .scanview.cfg  .thunderbird  .wine        .zsh_history
bin            dotvim      .fonts.conf  home:elvigia:branches:network=20
jdk-7u2-linux-x64.rpm     .macromedia  Plantillas      .pyhistory=20
  scm            V=EDdeos        .Xauthority  .zshrc
root@xps15z:/home/crrodriguez # ls
abuild         .cache      .emacs       .gconf=20
home:elvigia:nfs-systemd  .kchmviewer  .mozilla        .profile=20
  .qmmp          .skel         .vim         .xim.template=20
.zsh-update
.adobe         .config     esc.php      .gitconfig=20
.htoprc                   .kde4        M=FAsica          public_html=20
  .quiltrc       .ssh          .viminfo     .xinitrc.template
.aqemu         .dbus       Escritorio   .gnome2=20
Im=E1genes                  .kderc       .oh-my-zsh      P=FAblico=20
  .rcc           .subversion   .vim_local   .xsession-errors
attachments    Descargas   .esd_auth    .gstreamer-0.10=20
.inputrc                  .lastpass    .osc_cookiejar  .pulse=20
  rpmbuild       systemd.svg   .vimrc       yankring_history_v2.txt
.bash_history  .dmrc       .fontconfig  .gtkrc-2.0-kde4=20
isos                      .lesshst     .oscrc          .pulse-cookie=20
  .rpmmacros     .thumbnails   vms          .zcompdump
.bashrc        Documentos  .fonts       .gvfs=20
.java                     .local       .pki            pulseverbose.log=20
  .scanview.cfg  .thunderbird  .wine        .zsh_history
bin            dotvim      .fonts.conf  home:elvigia:branches:network=20
jdk-7u2-linux-x64.rpm     .macromedia  Plantillas      .pyhistory=20
  scm            V=EDdeos        .Xauthority  .zshrc
root@xps15z:/home/crrodriguez # dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-rc6-3-desktop (geeko@buildhost) (gcc=20
version 4.6.2 (SUSE Linux) ) #1 SMP PREEMPT Thu Dec 22 15:05:54 UTC 2011=20
(c4246bf)
[    0.000000] Command line:=20
root=3D/dev/disk/by-uuid/ca00ffff-8c21-4750-b25c-3cf321a07dd9=20
resume=3D/dev/system/swap splash=3Dverbose clocksource=3Dhpet hpet64=20
ipv6.disable=3D1 elevator=3Dnoop acpi.debug_layer=3D0x400000 apic=3Ddebug=
=20
i8042.debug vga=3D0x31b
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000b5a28000 (usable)
[    0.000000]  BIOS-e820: 00000000b5a28000 - 00000000b6e29000 (reserved)
[    0.000000]  BIOS-e820: 00000000b6e29000 - 00000000b886a000 (usable)
[    0.000000]  BIOS-e820: 00000000b886a000 - 00000000b8ab3000 (reserved)
[    0.000000]  BIOS-e820: 00000000b8ab3000 - 00000000bac8f000 (usable)
[    0.000000]  BIOS-e820: 00000000bac8f000 - 00000000bad2e000 (reserved)
[    0.000000]  BIOS-e820: 00000000bad2e000 - 00000000bad3d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bad3d000 - 00000000badfb000 (reserved)
[    0.000000]  BIOS-e820: 00000000badfb000 - 00000000badfd000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000badfd000 - 00000000badff000 (reserved)
[    0.000000]  BIOS-e820: 00000000badff000 - 00000000bae02000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bae02000 - 00000000bae0a000 (reserved)
[    0.000000]  BIOS-e820: 00000000bae0a000 - 00000000bae1b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bae1b000 - 00000000baf18000 (reserved)
[    0.000000]  BIOS-e820: 00000000baf18000 - 00000000baf1c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000baf1c000 - 00000000baf1f000 (reserved)
[    0.000000]  BIOS-e820: 00000000baf1f000 - 00000000baf9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000baf9f000 - 00000000bafff000 (ACPI data=
)
[    0.000000]  BIOS-e820: 00000000bafff000 - 00000000bb000000 (usable)
[    0.000000]  BIOS-e820: 00000000bb000000 - 00000000bfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed08000 - 00000000fed09000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000023fe00000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Dell Inc.          Dell System XPS 15Z/00WW5M, BIOS=20
A08 12/13/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000=20
(usable) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000=20
(usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x23fe00 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0BB000000 mask FFF000000 uncachable
[    0.000000]   5 base 100000000 mask F00000000 write-back
[    0.000000]   6 base 200000000 mask FC0000000 write-back
[    0.000000]   7 base 23FE00000 mask FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new=20
0x7010600070106
[    0.000000] last_pfn =3D 0xbb000 max_arch_pfn =3D 0x400000000
[    0.000000] Scan SMP from ffff880000000000 for 1024 bytes.
[    0.000000] Scan SMP from ffff88000009fc00 for 1024 bytes.
[    0.000000] Scan SMP from ffff8800000f0000 for 65536 bytes.
[    0.000000] Scan SMP from ffff88000009d800 for 1024 bytes.
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20=
480
[    0.000000] init_memory_mapping: 0000000000000000-00000000bb000000
[    0.000000]  0000000000 - 00bb000000 page 2M
[    0.000000] kernel direct mapping tables up to bb000000 @=20
1fffc000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-000000023fe00000
[    0.000000]  0100000000 - 023fe00000 page 2M
[    0.000000] kernel direct mapping tables up to 23fe00000 @=20
bac85000-bac8f000
[    0.000000] RAMDISK: 373d9000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000f00e0 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000baffe120 00094 (v01 DELL    QA09=20
00000002 LOHR 00000002)
[    0.000000] ACPI: FACP 00000000baff0000 000F4 (v03 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: DSDT 00000000baff3000 08A57 (v02 DELL    SNB-CPT=20
00000000 INTL 20061109)
[    0.000000] ACPI: FACS 00000000baf40000 00040
[    0.000000] ACPI: SLIC 00000000baffd000 00176 (v01 DELL    QA09=20
00000002 LOHR 00000001)
[    0.000000] ACPI: SSDT 00000000baffc000 00166 (v01 DELL   PtidDevc=20
00001000 INTL 20061109)
[    0.000000] ACPI: ASF! 00000000baff2000 000A5 (v32 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: HPET 00000000bafef000 00038 (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: APIC 00000000bafee000 00098 (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: MCFG 00000000bafed000 0003C (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: SSDT 00000000bafec000 00B3B (v01 NvORef NvOptTbl=20
00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafeb000 00846 (v01  PmRef  Cpu0Ist=20
00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafea000 00996 (v01  PmRef    CpuPm=20
00003000 INTL 20061109)
[    0.000000] ACPI: UEFI 00000000bafe9000 0003E (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: UEFI 00000000bafe8000 00042 (v01 PTL      COMBUF=20
00000001 PTL  00000001)
[    0.000000] ACPI: DMAR 00000000bafe7000 000E8 (v01 INTEL      SNB=20
00000001 INTL 00000001)
[    0.000000] ACPI: UEFI 00000000bafe6000 0022E (v01 DELL    QA09=20
00000002 PTL  00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fa000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000023fe00000
[    0.000000] Initmem setup node 0 0000000000000000-000000023fe00000
[    0.000000]   NODE_DATA [000000023fdec000 - 000000023fdfffff]
[    0.000000]  [ffffea0000000000-ffffea0007dfffff] PMD ->=20
[ffff880237400000-ffff88023e3fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0023fe00
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000b5a28
[    0.000000]     0: 0x000b6e29 -> 0x000b886a
[    0.000000]     0: 0x000b8ab3 -> 0x000bac8f
[    0.000000]     0: 0x000bafff -> 0x000bb000
[    0.000000]     0: 0x00100000 -> 0x0023fe00
[    0.000000] On node 0 totalpages: 2069459
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 740990 pages, LIFO batch:31
[    0.000000]   Normal zone: 17913 pages used for memmap
[    0.000000]   Normal zone: 1292295 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fa000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI=20
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2,=20
APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2,=20
APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2,=20
APIC INT 01
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2,=20
APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2,=20
APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2,=20
APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2,=20
APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2,=20
APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2,=20
APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2,=20
APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2,=20
APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2,=20
APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2,=20
APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2,=20
APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2,=20
APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5f9000 (fec00000)
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 -=20
000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 -=20
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -=20
00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 -=20
0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000b5a28000 -=20
00000000b6e29000
[    0.000000] PM: Registered nosave memory: 00000000b886a000 -=20
00000000b8ab3000
[    0.000000] PM: Registered nosave memory: 00000000bac8f000 -=20
00000000bad2e000
[    0.000000] PM: Registered nosave memory: 00000000bad2e000 -=20
00000000bad3d000
[    0.000000] PM: Registered nosave memory: 00000000bad3d000 -=20
00000000badfb000
[    0.000000] PM: Registered nosave memory: 00000000badfb000 -=20
00000000badfd000
[    0.000000] PM: Registered nosave memory: 00000000badfd000 -=20
00000000badff000
[    0.000000] PM: Registered nosave memory: 00000000badff000 -=20
00000000bae02000
[    0.000000] PM: Registered nosave memory: 00000000bae02000 -=20
00000000bae0a000
[    0.000000] PM: Registered nosave memory: 00000000bae0a000 -=20
00000000bae1b000
[    0.000000] PM: Registered nosave memory: 00000000bae1b000 -=20
00000000baf18000
[    0.000000] PM: Registered nosave memory: 00000000baf18000 -=20
00000000baf1c000
[    0.000000] PM: Registered nosave memory: 00000000baf1c000 -=20
00000000baf1f000
[    0.000000] PM: Registered nosave memory: 00000000baf1f000 -=20
00000000baf9f000
[    0.000000] PM: Registered nosave memory: 00000000baf9f000 -=20
00000000bafff000
[    0.000000] PM: Registered nosave memory: 00000000bb000000 -=20
00000000bfa00000
[    0.000000] PM: Registered nosave memory: 00000000bfa00000 -=20
00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 -=20
00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 -=20
00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 -=20
00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 -=20
00000000fed08000
[    0.000000] PM: Registered nosave memory: 00000000fed08000 -=20
00000000fed09000
[    0.000000] PM: Registered nosave memory: 00000000fed09000 -=20
00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 -=20
00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 -=20
00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 -=20
00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 -=20
00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 -=20
00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 -=20
00000000ffd80000
[    0.000000] PM: Registered nosave memory: 00000000ffd80000 -=20
0000000100000000
[    0.000000] Allocating PCI resources starting at bfa00000 (gap:=20
bfa00000:38600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512=20
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88023fa00000 s79744=20
r8192 d22656 u262144
[    0.000000] pcpu-alloc: s79744 r8192 d22656 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.=20
Total pages: 2037205
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:=20
root=3D/dev/disk/by-uuid/ca00ffff-8c21-4750-b25c-3cf321a07dd9=20
resume=3D/dev/system/swap splash=3Dverbose clocksource=3Dhpet hpet64=20
ipv6.disable=3D1 elevator=3Dnoop acpi.debug_layer=3D0x400000 apic=3Ddebug=
=20
i8042.debug vga=3D0x31b
[    0.000000] bootsplash: verbose mode.
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 8067344k/9435136k available (5935k kernel code,=20
1157300k absent, 210492k reserved, 7648k data, 944k init)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 67108864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't=20
want memory cgroups
[    0.000000] hpet timer0 configured in 64-bit mode
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 2793.229 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using=20
timer frequency.. 5586.45 BogoMIPS (lpj=3D2793229)
[    0.000007] pid_max: default: 32768 minimum: 301
[    0.000037] Security Framework initialized
[    0.000049] AppArmor: AppArmor initialized
[    0.000647] Dentry cache hash table entries: 1048576 (order: 11,=20
8388608 bytes)
[    0.002144] Inode-cache hash table entries: 524288 (order: 10,=20
4194304 bytes)
[    0.002776] Mount-cache hash table entries: 256
[    0.002859] Initializing cgroup subsys cpuacct
[    0.002863] Initializing cgroup subsys memory
[    0.002877] Initializing cgroup subsys devices
[    0.002880] Initializing cgroup subsys freezer
[    0.002882] Initializing cgroup subsys net_cls
[    0.002884] Initializing cgroup subsys blkio
[    0.002890] Initializing cgroup subsys perf_event
[    0.002912] Disabled fast string operations
[    0.002915] CPU: Physical Processor ID: 0
[    0.002917] CPU: Processor Core ID: 0
[    0.002921] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.002922] ENERGY_PERF_BIAS: View and update with=20
x86_energy_perf_policy(8)
[    0.002927] mce: CPU supports 7 MCE banks
[    0.002936] CPU0: Thermal monitoring handled by SMI
[    0.002941] using mwait in idle threads.
[    0.003584] ACPI: Core revision 20110623
[    0.059768] Getting VERSION: 1060015
[    0.059771] Getting VERSION: 1060015
[    0.059773] Getting ID: 0
[    0.059774] Getting ID: 0
[    0.059783] DMAR: Host address width 36
[    0.059786] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.059792] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap=20
c0000020e60262 ecap f0101a
[    0.059796] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.059801] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap=20
c9008020660262 ecap f0105a
[    0.059804] DMAR: RMRR base: 0x000000bae1d000 end: 0x000000bae33fff
[    0.059807] DMAR: RMRR base: 0x000000bb800000 end: 0x000000bf9fffff
[    0.059879] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.059881] HPET id 0 under DRHD base 0xfed91000
[    0.059884] HPET id 0 under DRHD base 0xfed91000
[    0.059886] HPET id 0 under DRHD base 0xfed91000
[    0.059888] HPET id 0 under DRHD base 0xfed91000
[    0.059890] HPET id 0 under DRHD base 0xfed91000
[    0.059892] HPET id 0 under DRHD base 0xfed91000
[    0.059894] HPET id 0 under DRHD base 0xfed91000
[    0.059896] HPET id 0 under DRHD base 0xfed91000
[    0.060143] Enabled IRQ remapping in x2apic mode
[    0.060146] Enabling x2apic
[    0.060148] Enabled x2apic
[    0.060153] Switched APIC routing to cluster x2apic.
[    0.060158] enabled ExtINT on CPU#0
[    0.060404] ESR value before enabling vector: 0x00000080  after:=20
0x00000000
[    0.060421] ENABLING IO-APIC IRQs
[    0.060423] init IO_APIC IRQs
[    0.060424]  apic 2 pin 0 not connected
[    0.060427] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0=20
Active:0 Dest:1)
[    0.060431] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060436] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0=20
Active:0 Dest:1)
[    0.060439] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:30 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060443] IOAPIC[0]: Set routing entry (2-3 -> 0x33 -> IRQ 3 Mode:0=20
Active:0 Dest:1)
[    0.060446] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:33 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060450] IOAPIC[0]: Set routing entry (2-4 -> 0x34 -> IRQ 4 Mode:0=20
Active:0 Dest:1)
[    0.060453] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:34 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060457] IOAPIC[0]: Set routing entry (2-5 -> 0x35 -> IRQ 5 Mode:0=20
Active:0 Dest:1)
[    0.060460] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:35 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060465] IOAPIC[0]: Set routing entry (2-6 -> 0x36 -> IRQ 6 Mode:0=20
Active:0 Dest:1)
[    0.060467] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:36 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060472] IOAPIC[0]: Set routing entry (2-7 -> 0x37 -> IRQ 7 Mode:0=20
Active:0 Dest:1)
[    0.060475] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:37 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060479] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0=20
Active:0 Dest:1)
[    0.060482] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060486] IOAPIC[0]: Set routing entry (2-9 -> 0x39 -> IRQ 9 Mode:1=20
Active:0 Dest:1)
[    0.060489] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:39 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060493] IOAPIC[0]: Set routing entry (2-10 -> 0x3a -> IRQ 10=20
Mode:0 Active:0 Dest:1)
[    0.060496] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3A Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060500] IOAPIC[0]: Set routing entry (2-11 -> 0x3b -> IRQ 11=20
Mode:0 Active:0 Dest:1)
[    0.060503] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3B Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060507] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12=20
Mode:0 Active:0 Dest:1)
[    0.060510] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060514] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13=20
Mode:0 Active:0 Dest:1)
[    0.060517] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060521] IOAPIC[0]: Set routing entry (2-14 -> 0x3e -> IRQ 14=20
Mode:0 Active:0 Dest:1)
[    0.060524] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3E Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060528] IOAPIC[0]: Set routing entry (2-15 -> 0x3f -> IRQ 15=20
Mode:0 Active:0 Dest:1)
[    0.060531] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3F Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.060535]  apic 2 pin 16 not connected
[    0.060536]  apic 2 pin 17 not connected
[    0.060537]  apic 2 pin 18 not connected
[    0.060538]  apic 2 pin 19 not connected
[    0.060538]  apic 2 pin 20 not connected
[    0.060539]  apic 2 pin 21 not connected
[    0.060540]  apic 2 pin 22 not connected
[    0.060541]  apic 2 pin 23 not connected
[    0.060679] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.070666] CPU0: Intel(R) Core(TM) i7-2640M CPU @ 2.80GHz stepping 07
[    0.070671] Using local APIC timer interrupts.
[    0.070671] calibrating APIC timer ...
[    0.172123] ... lapic delta =3D 623574
[    0.172125] ... PM-Timer delta =3D 357949
[    0.172126] ... PM-Timer result ok
[    0.172128] ..... delta 623574
[    0.172130] ..... mult: 26786370
[    0.172132] ..... calibration result: 99771
[    0.172134] ..... CPU clock speed is 2793.0611 MHz.
[    0.172136] ..... host bus clock speed is 99.0771 MHz.
[    0.172144] Performance Events: PEBS fmt1+, SandyBridge events, Intel=20
PMU driver.
[    0.172150] PEBS disabled due to CPU errata.
[    0.172154] ... version:                3
[    0.172155] ... bit width:              48
[    0.172157] ... generic registers:      4
[    0.172159] ... value mask:             0000ffffffffffff
[    0.172162] ... max period:             000000007fffffff
[    0.172164] ... fixed-purpose events:   3
[    0.172166] ... event mask:             000000070000000f
[    0.180330] NMI watchdog enabled, takes one hw-pmu counter.
[    0.188150] Booting Node   0, Processors  #1
[    0.188160] smpboot cpu 1: start_ip =3D 98000
[    0.199162] masked ExtINT on CPU#1
[    0.259011] Disabled fast string operations
[    0.259023] CPU1: Thermal monitoring handled by SMI
[    0.279047] NMI watchdog enabled, takes one hw-pmu counter.
[    0.285004]  #2
[    0.285010] smpboot cpu 2: start_ip =3D 98000
[    0.296013] masked ExtINT on CPU#2
[    0.355853] Disabled fast string operations
[    0.355864] CPU2: Thermal monitoring handled by SMI
[    0.375921] NMI watchdog enabled, takes one hw-pmu counter.
[    0.381847]  #3
[    0.381852] smpboot cpu 3: start_ip =3D 98000
[    0.392852] masked ExtINT on CPU#3
[    0.452696] Disabled fast string operations
[    0.452707] CPU3: Thermal monitoring handled by SMI
[    0.472765] NMI watchdog enabled, takes one hw-pmu counter.
[    0.474664] Brought up 4 CPUs
[    0.474673] Total of 4 processors activated (22346.24 BogoMIPS).
[    0.478171] devtmpfs: initialized
[    0.478919] PM: Registering ACPI NVS region at bad2e000 (61440 bytes)
[    0.478924] PM: Registering ACPI NVS region at badfb000 (8192 bytes)
[    0.478927] PM: Registering ACPI NVS region at badff000 (12288 bytes)
[    0.478930] PM: Registering ACPI NVS region at bae0a000 (69632 bytes)
[    0.478934] PM: Registering ACPI NVS region at baf18000 (16384 bytes)
[    0.478938] PM: Registering ACPI NVS region at baf1f000 (524288 bytes)
[    0.479061] print_constraints: dummy:
[    0.479091] RTC time:  1:23:20, date: 12/27/11
[    0.479128] NET: Registered protocol family 16
[    0.479269] ACPI: bus type pci registered
[    0.479329] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem=20
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.479334] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E=
820
[    0.489012] PCI: Using configuration type 1 for base access
[    0.489769] bio: create slab <bio-0> at 0
[    0.489840] ACPI: Added _OSI(Module Device)
[    0.489843] ACPI: Added _OSI(Processor Device)
[    0.489846] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.489848] ACPI: Added _OSI(Processor Aggregator Device)
[    0.491351] ACPI: EC: Look up EC in DSDT
[    0.492860] ACPI: Executed 1 blocks of module-level executable AML cod=
e
[    0.499730] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.500574] ACPI: SSDT 00000000bae06718 0067C (v01  PmRef  Cpu0Cst=20
00003001 INTL 20061109)
[    0.500979] ACPI: Dynamic OEM Table Load:
[    0.500982] ACPI: SSDT           (null) 0067C (v01  PmRef  Cpu0Cst=20
00003001 INTL 20061109)
[    0.506049] ACPI: SSDT 00000000bae07a98 00303 (v01  PmRef    ApIst=20
00003000 INTL 20061109)
[    0.506495] ACPI: Dynamic OEM Table Load:
[    0.506498] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst=20
00003000 INTL 20061109)
[    0.508778] ACPI: SSDT 00000000bae05d98 00119 (v01  PmRef    ApCst=20
00003000 INTL 20061109)
[    0.509171] ACPI: Dynamic OEM Table Load:
[    0.509173] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst=20
00003000 INTL 20061109)
[    0.514717] ACPI: Interpreter enabled
[    0.514722] ACPI: (supports S0 S3 S4 S5)
[    0.514744] ACPI: Using IOAPIC for interrupt routing
[    0.520280] ACPI: EC: GPE =3D 0x17, I/O: command/status =3D 0x66, data=
 =3D 0x62
[    0.520446] ACPI: No dock devices found.
[    0.520448] HEST: Table not found.
[    0.520451] PCI: Using host bridge windows from ACPI; if necessary,=20
use "pci=3Dnocrs" and report a bug
[    0.520852] \_SB_.PCI0:_OSC invalid UUID
[    0.520853] _OSC request data:1 8 1f
[    0.520856] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.521533] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7=
]
[    0.521537] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff=
]
[    0.521540] pci_root PNP0A08:00: host bridge window [mem=20
0x000a0000-0x000bffff]
[    0.521544] pci_root PNP0A08:00: host bridge window [mem=20
0xbfa00000-0xfeafffff]
[    0.521548] pci_root PNP0A08:00: host bridge window [mem=20
0xfed40000-0xfed44fff]
[    0.521559] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    0.521591] pci 0000:00:01.0: [8086:0101] type 1 class 0x000604
[    0.521611] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.521613] pci 0000:00:01.0: PME# disabled
[    0.521630] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    0.521639] pci 0000:00:02.0: reg 10: [mem 0xf1400000-0xf17fffff 64bit=
]
[    0.521644] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff=20
64bit pref]
[    0.521648] pci 0000:00:02.0: reg 20: [io  0x4000-0x403f]
[    0.521692] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    0.521714] pci 0000:00:16.0: reg 10: [mem 0xf1c05000-0xf1c0500f 64bit=
]
[    0.521774] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.521778] pci 0000:00:16.0: PME# disabled
[    0.521808] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    0.521828] pci 0000:00:1a.0: reg 10: [mem 0xf1c0a000-0xf1c0a3ff]
[    0.521898] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.521902] pci 0000:00:1a.0: PME# disabled
[    0.521925] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    0.521939] pci 0000:00:1b.0: reg 10: [mem 0xf1c00000-0xf1c03fff 64bit=
]
[    0.521991] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.521994] pci 0000:00:1b.0: PME# disabled
[    0.522016] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    0.522075] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.522079] pci 0000:00:1c.0: PME# disabled
[    0.522103] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    0.522162] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.522166] pci 0000:00:1c.1: PME# disabled
[    0.522190] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
[    0.522249] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.522253] pci 0000:00:1c.3: PME# disabled
[    0.522277] pci 0000:00:1c.4: [8086:1c18] type 1 class 0x000604
[    0.522335] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.522339] pci 0000:00:1c.4: PME# disabled
[    0.522363] pci 0000:00:1c.5: [8086:1c1a] type 1 class 0x000604
[    0.522422] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.522426] pci 0000:00:1c.5: PME# disabled
[    0.522455] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    0.522475] pci 0000:00:1d.0: reg 10: [mem 0xf1c09000-0xf1c093ff]
[    0.522544] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.522548] pci 0000:00:1d.0: PME# disabled
[    0.522571] pci 0000:00:1f.0: [8086:1c4b] type 0 class 0x000601
[    0.522685] pci 0000:00:1f.2: [8086:1c03] type 0 class 0x000106
[    0.522702] pci 0000:00:1f.2: reg 10: [io  0x4088-0x408f]
[    0.522710] pci 0000:00:1f.2: reg 14: [io  0x4094-0x4097]
[    0.522717] pci 0000:00:1f.2: reg 18: [io  0x4080-0x4087]
[    0.522725] pci 0000:00:1f.2: reg 1c: [io  0x4090-0x4093]
[    0.522732] pci 0000:00:1f.2: reg 20: [io  0x4060-0x407f]
[    0.522740] pci 0000:00:1f.2: reg 24: [mem 0xf1c08000-0xf1c087ff]
[    0.522770] pci 0000:00:1f.2: PME# supported from D3hot
[    0.522774] pci 0000:00:1f.2: PME# disabled
[    0.522791] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    0.522805] pci 0000:00:1f.3: reg 10: [mem 0xf1c04000-0xf1c040ff 64bit=
]
[    0.522826] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
[    0.522875] pci 0000:01:00.0: [10de:0df5] type 0 class 0x000300
[    0.522882] pci 0000:01:00.0: reg 10: [mem 0xf0000000-0xf0ffffff]
[    0.522890] pci 0000:01:00.0: reg 14: [mem 0xc0000000-0xcfffffff=20
64bit pref]
[    0.522898] pci 0000:01:00.0: reg 1c: [mem 0xd0000000-0xd1ffffff=20
64bit pref]
[    0.522903] pci 0000:01:00.0: reg 24: [io  0x3000-0x307f]
[    0.522909] pci 0000:01:00.0: reg 30: [mem 0xfff80000-0xffffffff pref]
[    0.524596] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.524609] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.524616] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fff=
ff]
[    0.524626] pci 0000:00:01.0:   bridge window [mem=20
0xc0000000-0xd1ffffff 64bit pref]
[    0.524698] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.524908] pci 0000:03:00.0: [8086:0091] type 0 class 0x000280
[    0.525049] pci 0000:03:00.0: reg 10: [mem 0xf1b00000-0xf1b01fff 64bit=
]
[    0.525618] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.525652] pci 0000:03:00.0: PME# disabled
[    0.527703] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.527711] pci 0000:00:1c.1:   bridge window [mem 0xf1b00000-0xf1bfff=
ff]
[    0.527783] pci 0000:04:00.0: [1033:0194] type 0 class 0x000c03
[    0.527808] pci 0000:04:00.0: reg 10: [mem 0xf1a00000-0xf1a01fff 64bit=
]
[    0.527912] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.527917] pci 0000:04:00.0: PME# disabled
[    0.529595] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.529614] pci 0000:00:1c.3:   bridge window [mem 0xf1a00000-0xf1afff=
ff]
[    0.529692] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.529700] pci 0000:00:1c.4:   bridge window [mem 0xf1900000-0xf19fff=
ff]
[    0.529769] pci 0000:06:00.0: [1969:1083] type 0 class 0x000200
[    0.529796] pci 0000:06:00.0: reg 10: [mem 0xf1800000-0xf183ffff 64bit=
]
[    0.529810] pci 0000:06:00.0: reg 18: [io  0x2000-0x207f]
[    0.529905] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.529910] pci 0000:06:00.0: PME# disabled
[    0.531592] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
[    0.531606] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.531617] pci 0000:00:1c.5:   bridge window [mem 0xf1800000-0xf18fff=
ff]
[    0.531674] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.531763]       0000:00:1f[A] -> [21]
[    0.531766]       0000:00:1f[B] -> [19]
[    0.531769]       0000:00:1f[C] -> [18]
[    0.531771]       0000:00:1f[D] -> [16]
[    0.531773]       0000:00:1d[A] -> [23]
[    0.531776]       0000:00:1a[A] -> [16]
[    0.531778]       0000:00:1b[A] -> [22]
[    0.531781]       0000:00:16[A] -> [16]
[    0.531783]       0000:00:16[B] -> [19]
[    0.531785]       0000:00:16[C] -> [18]
[    0.531788]       0000:00:16[D] -> [17]
[    0.531790]       0000:00:1c[A] -> [16]
[    0.531792]       0000:00:1c[B] -> [17]
[    0.531795]       0000:00:1c[C] -> [18]
[    0.531797]       0000:00:1c[D] -> [19]
[    0.531799]       0000:00:01[A] -> [16]
[    0.531802]       0000:00:01[B] -> [17]
[    0.531804]       0000:00:01[C] -> [18]
[    0.531806]       0000:00:01[D] -> [19]
[    0.531809]       0000:00:02[A] -> [16]
[    0.531811]       0000:00:04[A] -> [16]
[    0.531813]       0000:00:04[B] -> [17]
[    0.531816]       0000:00:04[C] -> [18]
[    0.531818]       0000:00:04[D] -> [19]
[    0.531840] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.0 is a PCI bridge
[    0.531846] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.531874]       0000:02:00[A] -> [16]
[    0.531877]       0000:02:00[B] -> [17]
[    0.531879]       0000:02:00[C] -> [18]
[    0.531882]       0000:02:00[D] -> [19]
[    0.531890] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.1 is a PCI bridge
[    0.531896] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.531923]       0000:03:00[A] -> [17]
[    0.531925]       0000:03:00[B] -> [18]
[    0.531928]       0000:03:00[C] -> [19]
[    0.531930]       0000:03:00[D] -> [16]
[    0.531940] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.3 is a PCI bridge
[    0.531945] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.531972]       0000:04:00[A] -> [19]
[    0.531974]       0000:04:00[B] -> [16]
[    0.531977]       0000:04:00[C] -> [17]
[    0.531979]       0000:04:00[D] -> [18]
[    0.531988] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.4 is a PCI bridge
[    0.531994] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.532020]       0000:05:00[A] -> [16]
[    0.532023]       0000:05:00[B] -> [17]
[    0.532025]       0000:05:00[C] -> [18]
[    0.532028]       0000:05:00[D] -> [19]
[    0.532053] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:1c.5 is a PCI bridge
[    0.532058] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.532085]       0000:06:00[A] -> [17]
[    0.532087]       0000:06:00[B] -> [18]
[    0.532090]       0000:06:00[C] -> [19]
[    0.532092]       0000:06:00[D] -> [16]
[    0.532109] pci_bind-0085 [00] pci_bind              : Device=20
0000:00:01.0 is a PCI bridge
[    0.532114] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG0._PRT]
[    0.532141]       0000:01:00[A] -> [16]
[    0.532143]       0000:01:00[B] -> [17]
[    0.532146]       0000:01:00[C] -> [18]
[    0.532148]       0000:01:00[D] -> [19]
[    0.532198] \_SB_.PCI0:_OSC invalid UUID
[    0.532198] _OSC request data:1 1f 1f
[    0.532201]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.532239] \_SB_.PCI0:_OSC invalid UUID
[    0.532240] _OSC request data:1 0 1d
[    0.532242]  pci0000:00: ACPI _OSC request failed (AE_ERROR),=20
returned control mask: 0x1d
[    0.532246] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.535536] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535572] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 11
[    0.535577] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12=20
14 15)
[    0.535607] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535638] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 9
[    0.535642] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *9
[    0.535671] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535699] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 9
[    0.535703] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *9
[    0.535731] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535759] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 10
[    0.535763] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12=20
14 15)
[    0.535790] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535818] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 0
[    0.535822] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *0, disabled.
[    0.535850] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535878] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 0
[    0.535882] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12=20
14 15) *0, disabled.
[    0.535911] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535939] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 10
[    0.535942] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12=20
14 15)
[    0.535970] pci_link-0190 [00] pci_link_get_possible : Found 10=20
possible IRQs
[    0.535998] pci_link-0294 [00] pci_link_get_current  : Link at IRQ 11
[    0.536002] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 12=20
14 15)
[    0.536069] vgaarb: device added:=20
PCI:0000:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.536078] vgaarb: device added:=20
PCI:0000:01:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.536083] vgaarb: loaded
[    0.536085] vgaarb: bridge control possible 0000:01:00.0
[    0.536087] vgaarb: no bridge control possible 0000:00:02.0
[    0.536179] SCSI subsystem initialized
[    0.536213] libata version 3.00 loaded.
[    0.536245] usbcore: registered new interface driver usbfs
[    0.536257] usbcore: registered new interface driver hub
[    0.536277] usbcore: registered new device driver usb
[    0.536324] PCI: Using ACPI for IRQ routing
[    0.537738] PCI: pci_cache_line_size set to 64 bytes
[    0.537863] reserve RAM buffer: 000000000009d800 - 000000000009ffff
[    0.537865] reserve RAM buffer: 00000000b5a28000 - 00000000b7ffffff
[    0.537867] reserve RAM buffer: 00000000b886a000 - 00000000bbffffff
[    0.537871] reserve RAM buffer: 00000000bac8f000 - 00000000bbffffff
[    0.537874] reserve RAM buffer: 00000000bb000000 - 00000000bbffffff
[    0.537876] reserve RAM buffer: 000000023fe00000 - 000000023fffffff
[    0.537947] NetLabel: Initializing
[    0.537950] NetLabel:  domain hash size =3D 128
[    0.537952] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.537961] NetLabel:  unlabeled traffic allowed by default
[    0.537971] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.537977] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.539993] Switching to clocksource hpet
[    0.541903] AppArmor: AppArmor Filesystem Enabled
[    0.541922] pnp: PnP ACPI init
[    0.541934] ACPI: bus type pnp registered
[    0.542307] pnp 00:00: [bus 00-3e]
[    0.542310] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.542311] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.542313] pnp 00:00: [io  0x0d00-0xffff window]
[    0.542314] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.542316] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.542317] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.542318] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.542320] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.542321] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.542322] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.542324] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.542325] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.542326] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.542328] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.542329] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.542331] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.542332] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.542333] pnp 00:00: [mem 0xbfa00000-0xfeafffff window]
[    0.542335] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.542374] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03=20
(active)
[    0.542387] pnp 00:01: [io  0x0000-0x001f]
[    0.542389] pnp 00:01: [io  0x0081-0x0091]
[    0.542390] pnp 00:01: [io  0x0093-0x009f]
[    0.542391] pnp 00:01: [io  0x00c0-0x00df]
[    0.542392] pnp 00:01: [dma 4]
[    0.542409] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.542484] pnp 00:02: [mem 0xfed00000-0xfed003ff]
[    0.542501] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.542511] pnp 00:03: [io  0x00f0]
[    0.542515] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13=20
Mode:0 Active:0 Dest:1)
[    0.542519] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542525] pnp 00:03: [irq 13]
[    0.542541] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.542550] pnp 00:04: [io  0x002e-0x002f]
[    0.542551] pnp 00:04: [io  0x004e-0x004f]
[    0.542553] pnp 00:04: [io  0x0061]
[    0.542555] pnp 00:04: [io  0x0063]
[    0.542556] pnp 00:04: [io  0x0065]
[    0.542557] pnp 00:04: [io  0x0067]
[    0.542558] pnp 00:04: [io  0x0068]
[    0.542559] pnp 00:04: [io  0x006c]
[    0.542560] pnp 00:04: [io  0x0070]
[    0.542561] pnp 00:04: [io  0x0080]
[    0.542562] pnp 00:04: [io  0x0092]
[    0.542563] pnp 00:04: [io  0x00b2-0x00b3]
[    0.542564] pnp 00:04: [io  0x0680-0x069f]
[    0.542566] pnp 00:04: [io  0x1000-0x1003]
[    0.542567] pnp 00:04: [io  0x1004-0x1013]
[    0.542568] pnp 00:04: [io  0xffff]
[    0.542569] pnp 00:04: [io  0x0400-0x0453]
[    0.542570] pnp 00:04: [io  0x0458-0x047f]
[    0.542571] pnp 00:04: [io  0x0500-0x057f]
[    0.542573] pnp 00:04: [io  0x164e-0x164f]
[    0.542606] system 00:04: [io  0x0680-0x069f] has been reserved
[    0.542610] system 00:04: [io  0x1000-0x1003] has been reserved
[    0.542613] system 00:04: [io  0x1004-0x1013] has been reserved
[    0.542616] system 00:04: [io  0xffff] has been reserved
[    0.542619] system 00:04: [io  0x0400-0x0453] has been reserved
[    0.542622] system 00:04: [io  0x0458-0x047f] has been reserved
[    0.542625] system 00:04: [io  0x0500-0x057f] has been reserved
[    0.542628] system 00:04: [io  0x164e-0x164f] has been reserved
[    0.542631] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.542639] pnp 00:05: [io  0x0070-0x0077]
[    0.542641] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0=20
Active:0 Dest:1)
[    0.542644] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542649] pnp 00:05: [irq 8]
[    0.542666] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.542692] pnp 00:06: [io  0x0454-0x0457]
[    0.542721] system 00:06: [io  0x0454-0x0457] has been reserved
[    0.542724] system 00:06: Plug and Play ACPI device, IDs INT3f0d=20
PNP0c02 (active)
[    0.542760] pnp 00:07: [io  0x0060]
[    0.542761] pnp 00:07: [io  0x0064]
[    0.542763] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0=20
Active:0 Dest:1)
[    0.542766] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542770] pnp 00:07: [irq 1]
[    0.542788] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.542817] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12=20
Mode:0 Active:0 Dest:1)
[    0.542820] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.542824] pnp 00:08: [irq 12]
[    0.542842] pnp 00:08: Plug and Play ACPI device, IDs DLL0446 PNP0f13=20
(active)
[    0.542954] pnp 00:09: [mem 0xfed1c000-0xfed1ffff]
[    0.542955] pnp 00:09: [mem 0xfed10000-0xfed17fff]
[    0.542957] pnp 00:09: [mem 0xfed18000-0xfed18fff]
[    0.542958] pnp 00:09: [mem 0xfed19000-0xfed19fff]
[    0.542959] pnp 00:09: [mem 0xf8000000-0xfbffffff]
[    0.542960] pnp 00:09: [mem 0xfed20000-0xfed3ffff]
[    0.542962] pnp 00:09: [mem 0xfed90000-0xfed93fff]
[    0.542964] pnp 00:09: [mem 0xfed45000-0xfed8ffff]
[    0.542965] pnp 00:09: [mem 0xff000000-0xffffffff]
[    0.542966] pnp 00:09: [mem 0xfee00000-0xfeefffff]
[    0.542968] pnp 00:09: [mem 0xfffff000-0xffffffff]
[    0.542980] pnp 00:09: disabling [mem 0xfffff000-0xffffffff] because=20
it overlaps 0000:01:00.0 BAR 6 [mem 0xfff80000-0xffffffff pref]
[    0.543006] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserve=
d
[    0.543010] system 00:09: [mem 0xfed10000-0xfed17fff] has been reserve=
d
[    0.543013] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserve=
d
[    0.543017] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserve=
d
[    0.543020] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserve=
d
[    0.543023] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserve=
d
[    0.543027] system 00:09: [mem 0xfed90000-0xfed93fff] has been reserve=
d
[    0.543030] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserve=
d
[    0.543033] system 00:09: [mem 0xff000000-0xffffffff] could not be=20
reserved
[    0.543037] system 00:09: [mem 0xfee00000-0xfeefffff] could not be=20
reserved
[    0.543047] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.543171] IOAPIC[0]: Set routing entry (2-20 -> 0x49 -> IRQ 20=20
Mode:0 Active:0 Dest:1)
[    0.543174] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:49 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.543177] pnp 00:0a: [irq 20]
[    0.543206] pnp 00:0a: Plug and Play ACPI device, IDs SMO8800 (active)
[    0.543336] pnp: PnP ACPI: found 11 devices
[    0.543338] ACPI: ACPI bus type pnp unregistered
[    0.549778] pci 0000:01:00.0: no compatible bridge window for [mem=20
0xfff80000-0xffffffff pref]
[    0.549785] PCI: max bus depth: 1 pci_try_num: 2
[    0.549827] pci 0000:01:00.0: BAR 6: assigned [mem=20
0xf1000000-0xf107ffff pref]
[    0.549831] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.549834] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.549838] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fff=
ff]
[    0.549842] pci 0000:00:01.0:   bridge window [mem=20
0xc0000000-0xd1ffffff 64bit pref]
[    0.549847] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.549859] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.549865] pci 0000:00:1c.1:   bridge window [mem 0xf1b00000-0xf1bfff=
ff]
[    0.549874] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.549880] pci 0000:00:1c.3:   bridge window [mem 0xf1a00000-0xf1afff=
ff]
[    0.549890] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.549896] pci 0000:00:1c.4:   bridge window [mem 0xf1900000-0xf19fff=
ff]
[    0.549905] pci 0000:00:1c.5: PCI bridge to [bus 06-06]
[    0.549909] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.549915] pci 0000:00:1c.5:   bridge window [mem 0xf1800000-0xf18fff=
ff]
[    0.549928]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:01.0[A] _PRT entry
[    0.549937] IOAPIC[0]: Set routing entry (2-16 -> 0x51 -> IRQ 16=20
Mode:1 Active:1 Dest:1)
[    0.549941] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:51 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.549944] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.549948] pci 0000:00:01.0: setting latency timer to 64
[    0.549954]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.0[A] _PRT entry
[    0.549959] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.549965] pci 0000:00:1c.0: setting latency timer to 64
[    0.549971]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.1[B] _PRT entry
[    0.549977] IOAPIC[0]: Set routing entry (2-17 -> 0x59 -> IRQ 17=20
Mode:1 Active:1 Dest:1)
[    0.549980] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:59 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.549983] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    0.549988] pci 0000:00:1c.1: setting latency timer to 64
[    0.549994]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.3[D] _PRT entry
[    0.550001] IOAPIC[0]: Set routing entry (2-19 -> 0x61 -> IRQ 19=20
Mode:1 Active:1 Dest:1)
[    0.550004] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:61 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    0.550006] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ =
19
[    0.550011] pci 0000:00:1c.3: setting latency timer to 64
[    0.550017]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.4[A] _PRT entry
[    0.550022] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    0.550027] pci 0000:00:1c.4: setting latency timer to 64
[    0.550039]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1c.5[B] _PRT entry
[    0.550044] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ =
17
[    0.550050] pci 0000:00:1c.5: setting latency timer to 64
[    0.550053] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.550054] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.550056] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.550057] pci_bus 0000:00: resource 7 [mem 0xbfa00000-0xfeafffff]
[    0.550059] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.550060] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    0.550061] pci_bus 0000:01: resource 1 [mem 0xf0000000-0xf10fffff]
[    0.550063] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff=20
64bit pref]
[    0.550064] pci_bus 0000:03: resource 1 [mem 0xf1b00000-0xf1bfffff]
[    0.550066] pci_bus 0000:04: resource 1 [mem 0xf1a00000-0xf1afffff]
[    0.550067] pci_bus 0000:05: resource 1 [mem 0xf1900000-0xf19fffff]
[    0.550069] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.550070] pci_bus 0000:06: resource 1 [mem 0xf1800000-0xf18fffff]
[    0.550125] NET: Registered protocol family 2
[    0.550318] IP route cache hash table entries: 262144 (order: 9,=20
2097152 bytes)
[    0.551888] TCP established hash table entries: 524288 (order: 11,=20
8388608 bytes)
[    0.553016] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    0.553157] TCP: Hash tables configured (established 524288 bind 65536=
)
[    0.553161] TCP reno registered
[    0.553175] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.553205] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.553308] NET: Registered protocol family 1
[    0.553322] pci 0000:00:02.0: Boot video device
[    0.553459] PCI: CLS 64 bytes, default 64
[    0.553496] Unpacking initramfs...
[    0.723042] Freeing initrd memory: 12380k freed
[    0.724650] DMAR: No ATSR found
[    0.724686] IOMMU 0 0xfed90000: using Queued invalidation
[    0.724688] IOMMU 1 0xfed91000: using Queued invalidation
[    0.724692] IOMMU: Setting RMRR:
[    0.724704] IOMMU: Setting identity map for device 0000:00:02.0=20
[0xbb800000 - 0xbf9fffff]
[    0.725062] IOMMU: Setting identity map for device 0000:00:1d.0=20
[0xbae1d000 - 0xbae33fff]
[    0.725085] IOMMU: Setting identity map for device 0000:00:1a.0=20
[0xbae1d000 - 0xbae33fff]
[    0.725099] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    0.725108] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0=20
- 0xffffff]
[    0.725335] PCI-DMA: Intel(R) Virtualization Technology for Directed I=
/O
[    0.727095] audit: initializing netlink socket (disabled)
[    0.727106] type=3D2000 audit(1324949000.518:1): initialized
[    0.749859] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.765057] VFS: Disk quotas dquot_6.5.2
[    0.765086] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.765302] msgmni has been set to 15909
[    0.765461] Block layer SCSI generic (bsg) driver version 0.4 loaded=20
(major 253)
[    0.765486] io scheduler noop registered (default)
[    0.765491] io scheduler deadline registered
[    0.765508] io scheduler cfq registered
[    0.765594] pcieport 0000:00:01.0: setting latency timer to 64
[    0.765617] pcieport 0000:00:01.0: irq 42 for MSI/MSI-X
[    0.765914] vesafb: mode is 1280x1024x32, linelength=3D5120, pages=3D1=
1
[    0.765917] vesafb: scrolling: redraw
[    0.765920] vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.767586] vesafb: framebuffer at 0xe0000000, mapped to=20
0xffffc90005800000, using 10240k, total 65472k
[    0.767738] bootsplash 3.2.0-2010/03/31: looking for picture...
[    0.767739] bootsplash: silentjpeg size 109002 bytes
[    0.777989] bootsplash: ...found (1280x1024, 40442 bytes, v3).
[    0.778101] bootsplash: silentjpeg size 126037 bytes
[    0.882677] Console: switching to colour frame buffer device 156x60
[    0.962069] fb0: VESA VGA frame buffer device
[    0.962474] intel_idle: MWAIT substates: 0x21120
[    0.962475] intel_idle: v0.4 model 0x2A
[    0.962476] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.962518] ERST: Table is not found!
[    0.962842] GHES: HEST is not enabled!
[    0.963242] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.084566] Non-volatile memory driver v1.3
[    1.084937] Linux agpgart interface v0.103
[    1.085368] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.086005] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K=20
total, 262144K mappable
[    1.087854] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.088547] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000=
000
[    1.089240] ahci 0000:00:1f.2: version 3.0
[    1.089249]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1f.2[B] _PRT entry
[    1.089987] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ=
 19
[    1.090633] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    1.090657] ahci: SSS flag set, parallel bus scan disabled
[    1.101254] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps=20
0x13 impl SATA mode
[    1.102014] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo=20
pio slum part ems sxs apst
[    1.102794] ahci 0000:00:1f.2: setting latency timer to 64
[    1.106635] scsi0 : ahci
[    1.106935] scsi1 : ahci
[    1.107220] scsi2 : ahci
[    1.107497] scsi3 : ahci
[    1.107773] scsi4 : ahci
[    1.108048] scsi5 : ahci
[    1.108376] ata1: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08100 irq 43
[    1.109028] ata2: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08180 irq 43
[    1.109687] ata3: DUMMY
[    1.109906] ata4: DUMMY
[    1.110126] ata5: SATA max UDMA/133 abar m2048@0xf1c08000 port=20
0xf1c08300 irq 43
[    1.110785] ata6: DUMMY
[    1.111067] Fixed MDIO Bus: probed
[    1.111378] arcnet loaded.
[    1.111620] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.112214]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1a.0[A] _PRT entry
[    1.112956] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low)=20
-> IRQ 16
[    1.113604] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.113607] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.114089] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned=20
bus number 1
[    1.114781] ehci_hcd 0000:00:1a.0: debug port 2
[    1.141311] ehci_hcd 0000:00:1a.0: cache line size of 64 is not suppor=
ted
[    1.141329] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf1c0a000
[    1.173136] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.195461] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.217783] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.240042] usb usb1: Product: EHCI Host Controller
[    1.262192] usb usb1: Manufacturer: Linux 3.2.0-rc6-3-desktop ehci_hcd
[    1.284442] usb usb1: SerialNumber: 0000:00:1a.0
[    1.306584] hub 1-0:1.0: USB hub found
[    1.328442] hub 1-0:1.0: 2 ports detected
[    1.350123]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1d.0[A] _PRT entry
[    1.372171] IOAPIC[0]: Set routing entry (2-23 -> 0x79 -> IRQ 23=20
Mode:1 Active:1 Dest:1)
[    1.372176] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:79 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[    1.372180] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low)=20
-> IRQ 23
[    1.394153] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.394156] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.414770] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.437965] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned=20
bus number 2
[    1.460503] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by=20
device (Stat=3D0x51 Err=3D0x04)
[    1.460548] ehci_hcd 0000:00:1d.0: debug port 2
[    1.464440] ehci_hcd 0000:00:1d.0: cache line size of 64 is not suppor=
ted
[    1.464459] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf1c09000
[    1.473673] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.473717] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.473718] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    1.473720] usb usb2: Product: EHCI Host Controller
[    1.473721] usb usb2: Manufacturer: Linux 3.2.0-rc6-3-desktop ehci_hcd
[    1.473722] usb usb2: SerialNumber: 0000:00:1d.0
[    1.473841] hub 2-0:1.0: USB hub found
[    1.473845] hub 2-0:1.0: 2 ports detected
[    1.473918] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.473931] uhci_hcd: USB Universal Host Controller Interface driver
[    1.753069] Initializing USB Mass Storage driver...
[    1.753071] Refined TSC clocksource calibration: 2793.653 MHz.
[    1.755293] ata1.00: ATA-8: SAMSUNG SSD PM810 2.5" 7mm 256GB,=20
AXM08D1Q, max UDMA/133
[    1.755295] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth=20
31/32), AA
[    1.755611] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by=20
device (Stat=3D0x51 Err=3D0x04)
[    1.757928] ata1.00: configured for UDMA/133
[    1.854112] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    1.912671] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM81=20
AXM0 PQ: 0 ANSI: 5
[    1.912674] usbcore: registered new interface driver usb-storage
[    1.912675] USB Mass Storage support registered.
[    1.912682] usbcore: registered new interface driver ums-alauda
[    1.912688] usbcore: registered new interface driver ums-cypress
[    1.912694] usbcore: registered new interface driver ums-datafab
[    1.912701] usbcore: registered new interface driver ums-freecom
[    1.912707] usbcore: registered new interface driver ums-isd200
[    1.912713] usbcore: registered new interface driver ums-jumpshot
[    1.912718] usbcore: registered new interface driver ums-karma
[    1.912724] usbcore: registered new interface driver ums-onetouch
[    1.912730] usbcore: registered new interface driver ums-sddr09
[    1.912736] usbcore: registered new interface driver ums-sddr55
[    1.912741] usbcore: registered new interface driver ums-usbat
[    1.912768] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]=20
at 0x60,0x64 irq 1,12
[    1.912807] i8042: [0] 20 -> i8042 (command)
[    1.913286] i8042: [0] 67 <- i8042 (return)
[    1.913347] i8042: [1] 20 -> i8042 (command)
[    1.913721] i8042: [1] 67 <- i8042 (return)
[    1.913726] i8042: [1] 60 -> i8042 (command)
[    1.913889] i8042: [1] 76 -> i8042 (parameter)
[    1.914109] i8042: [1] d3 -> i8042 (command)
[    1.914325] i8042: [1] 5a -> i8042 (parameter)
[    1.914544] i8042: [1] 5a <- i8042 (return)
[    1.914553] i8042: [2] a7 -> i8042 (command)
[    1.914661] i8042: [2] 20 -> i8042 (command)
[    1.914931] i8042: [2] 76 <- i8042 (return)
[    1.914935] i8042: [2] a8 -> i8042 (command)
[    1.915095] i8042: [2] 20 -> i8042 (command)
[    1.915364] i8042: [2] 56 <- i8042 (return)
[    1.915373] i8042: [3] 60 -> i8042 (command)
[    1.915536] i8042: [3] 74 -> i8042 (parameter)
[    1.915763] i8042: [3] d3 -> i8042 (command)
[    1.915978] i8042: [3] f0 -> i8042 (parameter)
[    1.916198] i8042: [3] f0 <- i8042 (return)
[    1.916222] i8042: [4] d3 -> i8042 (command)
[    1.916282] i8042: [4] 56 -> i8042 (parameter)
[    1.916555] i8042: [4] 56 <- i8042 (return)
[    1.916567] i8042: [4] d3 -> i8042 (command)
[    1.916783] i8042: [4] a4 -> i8042 (parameter)
[    1.917002] i8042: [4] a4 <- i8042 (return)
[    1.917027] i8042: [5] 60 -> i8042 (command)
[    1.917137] i8042: [5] 56 -> i8042 (parameter)
[    1.917309] i8042: [5] 60 -> i8042 (command)
[    1.917525] i8042: [5] 47 -> i8042 (parameter)
[    1.917528] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.917552] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.917632] mousedev: PS/2 mouse device common for all mice
[    1.917760] i8042: [5] f2 -> i8042 (kbd-data)
[    1.917804] rtc_cmos 00:05: RTC can wake from S4
[    1.917906] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.917932] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet i=
rqs
[    1.918037] cpuidle: using governor ladder
[    2.402856] i8042: [491] ed -> i8042 (kbd-data)
[    2.402866] i8042: [491] fa <- i8042 (interrupt, 0, 12)
[    2.402926] hpet1: lost 30 rtc interrupts
[    2.403065] cpuidle: using governor menu
[    2.403067] EFI Variables Facility v0.08 2004-May-17
[    2.403295] usbcore: registered new interface driver usbhid
[    2.403297] usbhid: USB HID core driver
[    2.404035] i8042: [492] 00 -> i8042 (kbd-data)
[    2.510920] i8042: [599] fa <- i8042 (interrupt, 0, 1)
[    2.510940] i8042: [599] ed -> i8042 (kbd-data)
[    2.511103] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256=20
GB/238 GiB)
[    2.511126] TCP cubic registered
[    2.511128] IPv6: Loaded, but administratively disabled, reboot=20
required to enable
[    2.511144] lib80211: common routines for IEEE802.11 drivers
[    2.511145] lib80211_crypt: registered algorithm 'NULL'
[    2.511147] Registering the dns_resolver key type
[    2.511162] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[    2.511169]
[    2.511169] printing PIC contents
[    2.511173] ... PIC  IMR: ffff
[    2.511177] ... PIC  IRR: 0c01
[    2.511184] ... PIC  ISR: 0000
[    2.511187] ... PIC ELCR: 0e00
[    2.643783] printing local APIC contents on CPU#0/0:
[    2.643784] ... APIC ID:      00000000 (0)
[    2.666176] ... APIC VERSION: 01060015
[    2.688175] ... APIC TASKPRI: 00000000 (00)
[    2.688176] ... APIC PROCPRI: 00000000
[    2.688177] ... APIC LDR: 00000001
[    2.688178] ... APIC SPIV: 000001ff
[    2.688179] ... APIC ISR field:
[    2.688180]=20
0000000000000000000000000000000000000000000000000000000000000000
[    2.709866] i8042: [799] f4 -> i8042 (kbd-data)
[    2.710552] ... APIC TMR field:
[    2.710553]=20
0000000000000000000000000000000000000000000000000000000000000000
[    2.732661] ... APIC IRR field:
[    2.732662]=20
0000000002020000000200000000000000000000000000000000000000008000
[    2.754421] ... APIC ESR: 00000000
[    2.754422] ... APIC ICR: 000008fd
[    2.754422] ... APIC ICR2: 00000040
[    2.754423] ... APIC LVTT: 000000ef
[    2.754424] ... APIC LVTPC: 00000400
[    2.754425] ... APIC LVT0: 00010700
[    2.754426] ... APIC LVT1: 00000400
[    2.754427] ... APIC LVTERR: 000000fe
[    2.754428] ... APIC TMICT: 000004c0
[    2.754428] ... APIC TMCCT: 00000000
[    2.754429] ... APIC TDCR: 00000003
[    2.754430]
[    2.775580] number of MP IRQ sources: 15.
[    2.775582] number of IO-APIC #2 registers: 24.
[    2.775583] testing the IO APIC.......................
[    2.775623] i8042: [864] fa <- i8042 (interrupt, 0, 1)
[    2.775695] input: AT Translated Set 2 keyboard as=20
/devices/platform/i8042/serio0/input/input0
[    2.775800] sd 0:0:0:0: [sda] Write Protect is off
[    2.775802] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.775812] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[    2.786128] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    2.786130] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    2.815686] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.820070] ata2.00: ATAPI: HL-DT-ST DVD+/-RW GS30N, A101, max UDMA/13=
3
[    2.825187] ata2.00: configured for UDMA/133
[    2.830643] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GS30N=20
  A101 PQ: 0 ANSI: 5
[    2.995778]
[    2.995813] i8042: [1085] d4 -> i8042 (command)
[    2.995924] i8042: [1085] f2 -> i8042 (parameter)
[    2.995926] hub 1-1:1.0: USB hub found
[    2.996023] hub 1-1:1.0: 6 ports detected
[    2.997464]  sda: sda1 sda2
[    2.999069] i8042: [1087] fa <- i8042 (interrupt, 1, 12)
[    2.999923] i8042: [1088] 00 <- i8042 (interrupt, 1, 12)
[    2.999939] i8042: [1089] 60 -> i8042 (command)
[    3.000102] i8042: [1089] 45 -> i8042 (parameter)
[    3.000317] i8042: [1089] 60 -> i8042 (command)
[    3.000531] i8042: [1089] 47 -> i8042 (parameter)
[    3.000767] i8042: [1089] d4 -> i8042 (command)
[    3.000930] i8042: [1089] f2 -> i8042 (parameter)
[    3.004925] i8042: [1089] fa <- i8042 (interrupt, 1, 12)
[    3.005855] i8042: [1094] 00 <- i8042 (interrupt, 1, 12)
[    3.005871] i8042: [1095] d4 -> i8042 (command)
[    3.006034] i8042: [1095] f6 -> i8042 (parameter)
[    3.009373] i8042: [1095] fa <- i8042 (interrupt, 1, 12)
[    3.009391] i8042: [1099] d4 -> i8042 (command)
[    3.009609] i8042: [1099] f3 -> i8042 (parameter)
[    3.012027] i8042: [1099] fa <- i8042 (interrupt, 1, 12)
[    3.012042] i8042: [1101] d4 -> i8042 (command)
[    3.012206] i8042: [1101] 0a -> i8042 (parameter)
[    3.015493] i8042: [1101] fa <- i8042 (interrupt, 1, 12)
[    3.015508] i8042: [1105] d4 -> i8042 (command)
[    3.015725] i8042: [1105] e8 -> i8042 (parameter)
[    3.018010] i8042: [1105] fa <- i8042 (interrupt, 1, 12)
[    3.018029] i8042: [1107] d4 -> i8042 (command)
[    3.018192] i8042: [1107] 00 -> i8042 (parameter)
[    3.020628] i8042: [1107] fa <- i8042 (interrupt, 1, 12)
[    3.020643] i8042: [1110] d4 -> i8042 (command)
[    3.020807] i8042: [1110] f3 -> i8042 (parameter)
[    3.023287] i8042: [1110] fa <- i8042 (interrupt, 1, 12)
[    3.023302] i8042: [1112] d4 -> i8042 (command)
[    3.023465] i8042: [1112] 14 -> i8042 (parameter)
[    3.026067] i8042: [1113] fa <- i8042 (interrupt, 1, 12)
[    3.026083] i8042: [1115] d4 -> i8042 (command)
[    3.026247] i8042: [1115] f3 -> i8042 (parameter)
[    3.029425] i8042: [1115] fa <- i8042 (interrupt, 1, 12)
[    3.029440] i8042: [1119] d4 -> i8042 (command)
[    3.029708] i8042: [1119] 3c -> i8042 (parameter)
[    3.031965] i8042: [1119] fa <- i8042 (interrupt, 1, 12)
[    3.031981] i8042: [1121] d4 -> i8042 (command)
[    3.032144] i8042: [1121] f3 -> i8042 (parameter)
[    3.034971] i8042: [1121] fa <- i8042 (interrupt, 1, 12)
[    3.034987] i8042: [1124] d4 -> i8042 (command)
[    3.035149] i8042: [1124] 28 -> i8042 (parameter)
[    3.037422] i8042: [1124] fa <- i8042 (interrupt, 1, 12)
[    3.037436] i8042: [1127] d4 -> i8042 (command)
[    3.037600] i8042: [1127] f3 -> i8042 (parameter)
[    3.040473] i8042: [1127] fa <- i8042 (interrupt, 1, 12)
[    3.040490] i8042: [1130] d4 -> i8042 (command)
[    3.040757] i8042: [1130] 14 -> i8042 (parameter)
[    3.043019] i8042: [1130] fa <- i8042 (interrupt, 1, 12)
[    3.043034] i8042: [1132] d4 -> i8042 (command)
[    3.043198] i8042: [1132] f3 -> i8042 (parameter)
[    3.046227] i8042: [1132] fa <- i8042 (interrupt, 1, 12)
[    3.046243] i8042: [1135] d4 -> i8042 (command)
[    3.046408] i8042: [1135] 14 -> i8042 (parameter)
[    3.048701] i8042: [1135] fa <- i8042 (interrupt, 1, 12)
[    3.048718] i8042: [1138] d4 -> i8042 (command)
[    3.048882] i8042: [1138] f3 -> i8042 (parameter)
[    3.051911] i8042: [1138] fa <- i8042 (interrupt, 1, 12)
[    3.051926] i8042: [1141] d4 -> i8042 (command)
[    3.052194] i8042: [1141] 3c -> i8042 (parameter)
[    3.054453] i8042: [1141] fa <- i8042 (interrupt, 1, 12)
[    3.054467] i8042: [1144] d4 -> i8042 (command)
[    3.054630] i8042: [1144] f3 -> i8042 (parameter)
[    3.060839] i8042: [1144] fa <- i8042 (interrupt, 1, 12)
[    3.060853] i8042: [1150] d4 -> i8042 (command)
[    3.061069] i8042: [1150] 28 -> i8042 (parameter)
[    3.063300] i8042: [1150] fa <- i8042 (interrupt, 1, 12)
[    3.063316] i8042: [1153] d4 -> i8042 (command)
[    3.063479] i8042: [1153] f3 -> i8042 (parameter)
[    3.066150] i8042: [1153] fa <- i8042 (interrupt, 1, 12)
[    3.066166] i8042: [1155] d4 -> i8042 (command)
[    3.066329] i8042: [1155] 14 -> i8042 (parameter)
[    3.068591] i8042: [1156] fa <- i8042 (interrupt, 1, 12)
[    3.068608] i8042: [1158] d4 -> i8042 (command)
[    3.068772] i8042: [1158] f3 -> i8042 (parameter)
[    3.071764] i8042: [1158] fa <- i8042 (interrupt, 1, 12)
[    3.071780] i8042: [1161] d4 -> i8042 (command)
[    3.071943] i8042: [1161] 14 -> i8042 (parameter)
[    3.074268] i8042: [1161] fa <- i8042 (interrupt, 1, 12)
[    3.074285] i8042: [1164] d4 -> i8042 (command)
[    3.074448] i8042: [1164] f2 -> i8042 (parameter)
[    3.077037] i8042: [1164] fa <- i8042 (interrupt, 1, 12)
[    3.077906] i8042: [1166] 00 <- i8042 (interrupt, 1, 12)
[    3.077922] i8042: [1167] d4 -> i8042 (command)
[    3.078085] i8042: [1167] e8 -> i8042 (parameter)
[    3.080814] i8042: [1167] fa <- i8042 (interrupt, 1, 12)
[    3.080830] i8042: [1170] d4 -> i8042 (command)
[    3.081046] i8042: [1170] 00 -> i8042 (parameter)
[    3.083272] i8042: [1170] fa <- i8042 (interrupt, 1, 12)
[    3.083288] i8042: [1173] d4 -> i8042 (command)
[    3.083555] i8042: [1173] e8 -> i8042 (parameter)
[    3.085294] IO APIC #2......
[    3.085295] .... register #00: 02000000
[    3.085296] .......    : physical APIC id: 02
[    3.085297] .......    : Delivery Type: 0
[    3.085298] .......    : LTS          : 0
[    3.085299] .... register #01: 00170020
[    3.085300] .......     : max redirection entries: 17
[    3.085301] .......     : PRQ implemented: 0
[    3.085302] .......     : IO APIC version: 20
[    3.085302] .... IRQ redirection table:
[    3.085303]  NR Indx Fmt Mask Trig IRR Pol Stat Indx2 Zero Vect:
[    3.085308]  00 0000 0   1    0    0   0   0    0     0    00
[    3.085313]  01 0011 1   0    0    0   0   0    0     0    01
[    3.085318]  02 0001 1   0    0    0   0   0    0     0    02
[    3.085323]  03 0002 1   0    0    0   0   0    0     0    03
[    3.085328]  04 0003 1   0    0    0   0   0    0     0    04
[    3.085333]  05 0004 1   0    0    0   0   0    0     0    05
[    3.085342]  06 0005 1   0    0    0   0   0    0     0    06
[    3.085347]  07 0006 1   0    0    0   0   0    0     0    07
[    3.085352]  08 0010 1   0    0    0   0   0    0     0    08
[    3.085356]  09 0008 1   0    1    0   0   0    0     0    09
[    3.085363]  0a 0009 1   0    0    0   0   0    0     0    0A
[    3.085368]  0b 000A 1   0    0    0   0   0    0     0    0B
[    3.085373]  0c 0012 1   0    0    0   0   0    0     0    0C
[    3.085378]  0d 000F 1   0    0    0   0   0    0     0    0D
[    3.085383]  0e 000D 1   0    0    0   0   0    0     0    0E
[    3.085388]  0f 000E 1   0    0    0   0   0    0     0    0F
[    3.085393]  10 0014 1   0    1    0   1   0    0     0    10
[    3.085398]  11 0015 1   1    1    0   1   0    0     0    11
[    3.085402]  12 0000 0   1    0    0   0   0    0     0    00
[    3.085407]  13 0016 1   1    1    0   1   0    0     0    13
[    3.085412]  14 0013 1   0    0    0   0   0    0     0    14
[    3.085417]  15 0000 0   1    0    0   0   0    0     0    00
[    3.085421]  16 0000 0   1    0    0   0   0    0     0    00
[    3.085426]  17 0019 1   0    1    0   1   0    0     0    17
[    3.085428] IRQ to pin mappings:
[    3.085429] IRQ0 -> 0:2
[    3.085431] IRQ1 -> 0:1
[    3.085432] IRQ3 -> 0:3
[    3.085433] IRQ4 -> 0:4
[    3.085435] IRQ5 -> 0:5
[    3.085436] IRQ6 -> 0:6
[    3.085437] IRQ7 -> 0:7
[    3.085438] IRQ8 -> 0:8
[    3.085440] IRQ9 -> 0:9
[    3.085441] IRQ10 -> 0:10
[    3.085443] IRQ11 -> 0:11
[    3.085444] IRQ12 -> 0:12
[    3.085445] IRQ13 -> 0:13
[    3.085446] IRQ14 -> 0:14
[    3.085448] IRQ15 -> 0:15
[    3.085449] IRQ16 -> 0:16
[    3.085450] IRQ17 -> 0:17
[    3.085451] IRQ19 -> 0:19
[    3.085453] IRQ20 -> 0:20
[    3.085454] IRQ23 -> 0:23
[    3.085455] .................................... done.
[    3.085478] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.086479] i8042: [1175] fa <- i8042 (interrupt, 1, 12)
[    3.086492] i8042: [1176] d4 -> i8042 (command)
[    3.086656] i8042: [1176] 00 -> i8042 (parameter)
[    3.089087] i8042: [1176] fa <- i8042 (interrupt, 1, 12)
[    3.089102] i8042: [1178] d4 -> i8042 (command)
[    3.089370] i8042: [1178] e8 -> i8042 (parameter)
[    3.091996] i8042: [1178] fa <- i8042 (interrupt, 1, 12)
[    3.092012] i8042: [1181] d4 -> i8042 (command)
[    3.092227] i8042: [1181] 00 -> i8042 (parameter)
[    3.094467] i8042: [1181] fa <- i8042 (interrupt, 1, 12)
[    3.094483] i8042: [1184] d4 -> i8042 (command)
[    3.094648] i8042: [1184] e8 -> i8042 (parameter)
[    3.097145] i8042: [1184] fa <- i8042 (interrupt, 1, 12)
[    3.097161] i8042: [1186] d4 -> i8042 (command)
[    3.097427] i8042: [1186] 00 -> i8042 (parameter)
[    3.099660] i8042: [1187] fa <- i8042 (interrupt, 1, 12)
[    3.099675] i8042: [1189] d4 -> i8042 (command)
[    3.099838] i8042: [1189] e9 -> i8042 (parameter)
[    3.100250] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    3.102322] i8042: [1189] fa <- i8042 (interrupt, 1, 12)
[    3.103328] i8042: [1192] 33 <- i8042 (interrupt, 1, 12)
[    3.104331] i8042: [1193] cc <- i8042 (interrupt, 1, 12)
[    3.105784] i8042: [1193] a3 <- i8042 (interrupt, 1, 12)
[    3.105799] i8042: [1195] d4 -> i8042 (command)
[    3.106067] i8042: [1195] f6 -> i8042 (parameter)
[    3.108584] i8042: [1195] fa <- i8042 (interrupt, 1, 12)
[    3.108600] i8042: [1198] d4 -> i8042 (command)
[    3.108762] i8042: [1198] e8 -> i8042 (parameter)
[    3.111662] i8042: [1198] fa <- i8042 (interrupt, 1, 12)
[    3.111677] i8042: [1201] d4 -> i8042 (command)
[    3.111945] i8042: [1201] 00 -> i8042 (parameter)
[    3.114237] i8042: [1201] fa <- i8042 (interrupt, 1, 12)
[    3.114254] i8042: [1204] d4 -> i8042 (command)
[    3.114522] i8042: [1204] e6 -> i8042 (parameter)
[    3.117199] i8042: [1204] fa <- i8042 (interrupt, 1, 12)
[    3.117214] i8042: [1207] d4 -> i8042 (command)
[    3.117378] i8042: [1207] e6 -> i8042 (parameter)
[    3.119700] i8042: [1207] fa <- i8042 (interrupt, 1, 12)
[    3.119715] i8042: [1209] d4 -> i8042 (command)
[    3.119880] i8042: [1209] e6 -> i8042 (parameter)
[    3.123090] i8042: [1209] fa <- i8042 (interrupt, 1, 12)
[    3.123105] i8042: [1212] d4 -> i8042 (command)
[    3.123320] i8042: [1212] e9 -> i8042 (parameter)
[    3.125623] i8042: [1212] fa <- i8042 (interrupt, 1, 12)
[    3.126956] i8042: [1215] 05 <- i8042 (interrupt, 1, 12)
[    3.127832] i8042: [1216] 00 <- i8042 (interrupt, 1, 12)
[    3.128715] i8042: [1216] 64 <- i8042 (interrupt, 1, 12)
[    3.128731] i8042: [1218] d4 -> i8042 (command)
[    3.128894] i8042: [1218] f6 -> i8042 (parameter)
[    3.132087] i8042: [1218] fa <- i8042 (interrupt, 1, 12)
[    3.132101] i8042: [1221] d4 -> i8042 (command)
[    3.132265] i8042: [1221] f5 -> i8042 (parameter)
[    3.134770] i8042: [1222] fa <- i8042 (interrupt, 1, 12)
[    3.134786] i8042: [1224] d4 -> i8042 (command)
[    3.134949] i8042: [1224] e6 -> i8042 (parameter)
[    3.137759] i8042: [1224] fa <- i8042 (interrupt, 1, 12)
[    3.137773] i8042: [1227] d4 -> i8042 (command)
[    3.137935] i8042: [1227] e6 -> i8042 (parameter)
[    3.140370] i8042: [1227] fa <- i8042 (interrupt, 1, 12)
[    3.140385] i8042: [1230] d4 -> i8042 (command)
[    3.140654] i8042: [1230] e6 -> i8042 (parameter)
[    3.143061] i8042: [1230] fa <- i8042 (interrupt, 1, 12)
[    3.143076] i8042: [1232] d4 -> i8042 (command)
[    3.143291] i8042: [1232] e9 -> i8042 (parameter)
[    3.145630] i8042: [1232] fa <- i8042 (interrupt, 1, 12)
[    3.147022] i8042: [1235] 05 <- i8042 (interrupt, 1, 12)
[    3.147898] i8042: [1236] 02 <- i8042 (interrupt, 1, 12)
[    3.148782] i8042: [1236] 64 <- i8042 (interrupt, 1, 12)
[    3.148796] i8042: [1238] d4 -> i8042 (command)
[    3.148959] i8042: [1238] e8 -> i8042 (parameter)
[    3.151988] PM: Checking hibernation image partition /dev/system/swap
[    3.152061] i8042: [1241] fa <- i8042 (interrupt, 1, 12)
[    3.152134] i8042: [1241] d4 -> i8042 (command)
[    3.152298] i8042: [1242] 03 -> i8042 (parameter)
[    3.154621] i8042: [1244] fa <- i8042 (interrupt, 1, 12)
[    3.154707] i8042: [1244] d4 -> i8042 (command)
[    3.154818] i8042: [1244] e6 -> i8042 (parameter)
[    3.157874] i8042: [1247] fa <- i8042 (interrupt, 1, 12)
[    3.157971] i8042: [1247] d4 -> i8042 (command)
[    3.158134] i8042: [1247] e6 -> i8042 (parameter)
[    3.160475] i8042: [1250] fa <- i8042 (interrupt, 1, 12)
[    3.160558] i8042: [1250] d4 -> i8042 (command)
[    3.160669] i8042: [1250] e6 -> i8042 (parameter)
[    3.163664] i8042: [1253] fa <- i8042 (interrupt, 1, 12)
[    3.163788] i8042: [1253] d4 -> i8042 (command)
[    3.163900] i8042: [1253] e9 -> i8042 (parameter)
[    3.167138] i8042: [1256] fa <- i8042 (interrupt, 1, 12)
[    3.168005] i8042: [1257] 05 <- i8042 (interrupt, 1, 12)
[    3.168892] i8042: [1258] 03 <- i8042 (interrupt, 1, 12)
[    3.169776] i8042: [1259] 64 <- i8042 (interrupt, 1, 12)
[    3.169856] i8042: [1259] d4 -> i8042 (command)
[    3.169966] i8042: [1259] e8 -> i8042 (parameter)
[    3.173330] i8042: [1263] fa <- i8042 (interrupt, 1, 12)
[    3.173421] i8042: [1263] d4 -> i8042 (command)
[    3.173639] i8042: [1263] 00 -> i8042 (parameter)
[    3.175962] i8042: [1265] fa <- i8042 (interrupt, 1, 12)
[    3.176044] i8042: [1265] d4 -> i8042 (command)
[    3.176209] i8042: [1265] e6 -> i8042 (parameter)
[    3.178726] i8042: [1268] fa <- i8042 (interrupt, 1, 12)
[    3.178820] i8042: [1268] d4 -> i8042 (command)
[    3.178931] i8042: [1268] e6 -> i8042 (parameter)
[    3.181375] i8042: [1271] fa <- i8042 (interrupt, 1, 12)
[    3.181499] i8042: [1271] d4 -> i8042 (command)
[    3.182240] i8042: [1271] e6 -> i8042 (parameter)
[    3.184747] i8042: [1274] fa <- i8042 (interrupt, 1, 12)
[    3.184842] i8042: [1274] d4 -> i8042 (command)
[    3.184954] i8042: [1274] e9 -> i8042 (parameter)
[    3.187999] i8042: [1277] fa <- i8042 (interrupt, 1, 12)
[    3.188866] i8042: [1278] 05 <- i8042 (interrupt, 1, 12)
[    3.189767] i8042: [1279] 00 <- i8042 (interrupt, 1, 12)
[    3.190756] i8042: [1280] 64 <- i8042 (interrupt, 1, 12)
[    3.190841] i8042: [1280] d4 -> i8042 (command)
[    3.190953] i8042: [1280] e1 -> i8042 (parameter)
[    3.215928] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    3.237807] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    3.259900] hub 2-1:1.0: USB hub found
[    3.281547] hub 2-1:1.0: 8 ports detected
[    3.299961] ata5: SATA link down (SStatus 0 SControl 300)
[    3.389927] i8042: [1480] d4 -> i8042 (command)
[    3.390091] i8042: [1480] 0a -> i8042 (parameter)
[    3.398162] usb 1-1.4: new high-speed USB device number 3 using ehci_h=
cd
[    3.561936] usb 1-1.4: New USB device found, idVendor=3D0c45,=20
idProduct=3D642a
[    3.583110] usb 1-1.4: New USB device strings: Mfr=3D2, Product=3D1,=20
SerialNumber=3D0
[    3.589561] i8042: [1680] d4 -> i8042 (command)
[    3.589671] i8042: [1680] f5 -> i8042 (parameter)
[    3.604568] i8042: [1695] fa <- i8042 (interrupt, 1, 12)
[    3.604573] usb 1-1.4: Product: Laptop_Integrated_Webcam_2HDM
[    3.604613] i8042: [1695] d4 -> i8042 (command)
[    3.604725] i8042: [1695] f3 -> i8042 (parameter)
[    3.626275] i8042: [1716] fa <- i8042 (interrupt, 1, 12)
[    3.626278] usb 1-1.4: Manufacturer: CN0XRCWG724871ANS3CZA00
[    3.626320] i8042: [1716] d4 -> i8042 (command)
[    3.626484] i8042: [1716] 66 -> i8042 (parameter)
[    3.648215] i8042: [1738] fe <- i8042 (interrupt, 1, 12)
[    3.648259] i8042: [1738] d4 -> i8042 (command)
[    3.648424] i8042: [1738] 88 -> i8042 (parameter)
[    3.678465] i8042: [1769] d4 -> i8042 (command)
[    3.678643] i8042: [1769] f3 -> i8042 (parameter)
[    3.681134] i8042: [1771] fc <- i8042 (interrupt, 1, 12)
[    3.681225] i8042: [1771] d4 -> i8042 (command)
[    3.681336] i8042: [1771] f4 -> i8042 (parameter)
[    3.684450] i8042: [1775] fa <- i8042 (interrupt, 1, 12)
[    3.684574] i8042: [1775] d4 -> i8042 (command)
[    3.684791] i8042: [1775] f6 -> i8042 (parameter)
[    3.688413] i8042: [1779] fa <- i8042 (interrupt, 1, 12)
[    3.688507] i8042: [1779] d4 -> i8042 (command)
[    3.689512] i8042: [1779] ff -> i8042 (parameter)
[    3.692089] i8042: [1782] fa <- i8042 (interrupt, 1, 12)
[    3.726675] usb 2-1.5: new full-speed USB device number 3 using ehci_h=
cd
[    3.838521] usb 2-1.5: New USB device found, idVendor=3D8086,=20
idProduct=3D0189
[    3.861231] usb 2-1.5: New USB device strings: Mfr=3D0, Product=3D0,=20
SerialNumber=3D0
[    3.892268] i8042: [1983] aa <- i8042 (interrupt, 1, 12)
[    3.893135] i8042: [1984] 00 <- i8042 (interrupt, 1, 12)
[    3.893215] i8042: [1984] d4 -> i8042 (command)
[    3.893483] i8042: [1984] f3 -> i8042 (parameter)
[    3.896588] i8042: [1987] fa <- i8042 (interrupt, 1, 12)
[    3.896676] i8042: [1987] d4 -> i8042 (command)
[    3.896787] i8042: [1987] c8 -> i8042 (parameter)
[    3.899159] i8042: [1990] fa <- i8042 (interrupt, 1, 12)
[    3.899238] i8042: [1990] d4 -> i8042 (command)
[    3.899454] i8042: [1990] f3 -> i8042 (parameter)
[    3.902540] i8042: [1993] fa <- i8042 (interrupt, 1, 12)
[    3.902664] i8042: [1993] d4 -> i8042 (command)
[    3.902775] i8042: [1993] 64 -> i8042 (parameter)
[    3.905189] i8042: [1996] fa <- i8042 (interrupt, 1, 12)
[    3.905283] i8042: [1996] d4 -> i8042 (command)
[    3.905973] i8042: [1996] f3 -> i8042 (parameter)
[    3.908560] i8042: [1999] fa <- i8042 (interrupt, 1, 12)
[    3.908653] i8042: [1999] d4 -> i8042 (command)
[    3.908765] i8042: [1999] 50 -> i8042 (parameter)
[    3.911650] i8042: [2002] fa <- i8042 (interrupt, 1, 12)
[    3.911743] i8042: [2002] d4 -> i8042 (command)
[    3.911855] i8042: [2002] f2 -> i8042 (parameter)
[    3.914438] i8042: [2005] fa <- i8042 (interrupt, 1, 12)
[    3.915312] i8042: [2006] 03 <- i8042 (interrupt, 1, 12)
[    3.915406] i8042: [2006] d4 -> i8042 (command)
[    3.916096] i8042: [2006] f3 -> i8042 (parameter)
[    3.918631] i8042: [2009] fa <- i8042 (interrupt, 1, 12)
[    3.918752] i8042: [2009] d4 -> i8042 (command)
[    3.918864] i8042: [2009] c8 -> i8042 (parameter)
[    3.921832] i8042: [2012] fa <- i8042 (interrupt, 1, 12)
[    3.921958] i8042: [2012] d4 -> i8042 (command)
[    3.922122] i8042: [2012] f3 -> i8042 (parameter)
[    3.924645] i8042: [2015] fa <- i8042 (interrupt, 1, 12)
[    3.924738] i8042: [2015] d4 -> i8042 (command)
[    3.924850] i8042: [2015] c8 -> i8042 (parameter)
[    3.927376] i8042: [2018] fa <- i8042 (interrupt, 1, 12)
[    3.927502] i8042: [2018] d4 -> i8042 (command)
[    3.927667] i8042: [2018] f3 -> i8042 (parameter)
[    3.930190] i8042: [2021] fa <- i8042 (interrupt, 1, 12)
[    3.930313] i8042: [2021] d4 -> i8042 (command)
[    3.931428] i8042: [2021] 50 -> i8042 (parameter)
[    3.933733] i8042: [2024] fa <- i8042 (interrupt, 1, 12)
[    3.933824] i8042: [2024] d4 -> i8042 (command)
[    3.933936] i8042: [2024] f2 -> i8042 (parameter)
[    3.936990] i8042: [2027] fa <- i8042 (interrupt, 1, 12)
[    3.937836] i8042: [2028] 03 <- i8042 (interrupt, 1, 12)
[    3.937931] i8042: [2028] d4 -> i8042 (command)
[    3.938042] i8042: [2028] f3 -> i8042 (parameter)
[    3.941461] i8042: [2032] fa <- i8042 (interrupt, 1, 12)
[    3.941554] i8042: [2032] d4 -> i8042 (command)
[    3.941770] i8042: [2032] c8 -> i8042 (parameter)
[    3.944095] i8042: [2035] fa <- i8042 (interrupt, 1, 12)
[    3.944219] i8042: [2035] d4 -> i8042 (command)
[    3.944330] i8042: [2035] f3 -> i8042 (parameter)
[    3.947216] i8042: [2038] fa <- i8042 (interrupt, 1, 12)
[    3.947324] i8042: [2038] d4 -> i8042 (command)
[    3.947488] i8042: [2038] 64 -> i8042 (parameter)
[    3.949809] i8042: [2040] fa <- i8042 (interrupt, 1, 12)
[    3.949903] i8042: [2040] d4 -> i8042 (command)
[    3.950015] i8042: [2040] f3 -> i8042 (parameter)
[    3.952817] i8042: [2043] fa <- i8042 (interrupt, 1, 12)
[    3.952941] i8042: [2043] d4 -> i8042 (command)
[    3.953053] i8042: [2043] 50 -> i8042 (parameter)
[    3.955464] i8042: [2046] fa <- i8042 (interrupt, 1, 12)
[    3.955589] i8042: [2046] d4 -> i8042 (command)
[    3.955753] i8042: [2046] f2 -> i8042 (parameter)
[    3.958834] i8042: [2049] fa <- i8042 (interrupt, 1, 12)
[    3.959841] i8042: [2050] 03 <- i8042 (interrupt, 1, 12)
[    3.959980] i8042: [2051] d4 -> i8042 (command)
[    3.960092] i8042: [2051] f3 -> i8042 (parameter)
[    3.963087] i8042: [2054] fa <- i8042 (interrupt, 1, 12)
[    3.963213] i8042: [2054] d4 -> i8042 (command)
[    3.963378] i8042: [2054] 64 -> i8042 (parameter)
[    3.965850] i8042: [2056] fa <- i8042 (interrupt, 1, 12)
[    3.965945] i8042: [2056] d4 -> i8042 (command)
[    3.966056] i8042: [2056] e8 -> i8042 (parameter)
[    3.968700] i8042: [2059] fa <- i8042 (interrupt, 1, 12)
[    3.968794] i8042: [2059] d4 -> i8042 (command)
[    3.968959] i8042: [2059] 03 -> i8042 (parameter)
[    3.971304] i8042: [2062] fa <- i8042 (interrupt, 1, 12)
[    3.971398] i8042: [2062] d4 -> i8042 (command)
[    3.974350] i8042: [2062] e6 -> i8042 (parameter)
[    3.976879] i8042: [2067] fa <- i8042 (interrupt, 1, 12)
[    3.977018] input: ImPS/2 Generic Wheel Mouse as=20
/devices/platform/i8042/serio1/input/input1
[    4.000810] i8042: [2091] d4 -> i8042 (command)
[    4.000921] i8042: [2091] f4 -> i8042 (parameter)
[    4.003458] i8042: [2094] fa <- i8042 (interrupt, 1, 12)
[    4.003598] PM: Hibernation image not present or could not be loaded.
[    4.003620] registered taskstats version 1
[    4.035412]   Magic number: 7:990:357
[    4.059596] rtc_cmos 00:05: setting system clock to 2011-12-27=20
01:23:24 UTC (1324949004)
[    4.085662] Freeing unused kernel memory: 944k freed
[    4.110469] Write protecting the kernel read-only data: 12288k
[    4.135741] Freeing unused kernel memory: 192k freed
[    4.164739] Freeing unused kernel memory: 1944k freed
[    4.241203] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.266531] shpchp: shpcd_init: pci_register_driver =3D 0
[    4.266533] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
[    4.322294] udevd[131]: starting version 173
[    4.356829] input: Power Button as=20
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    4.393554] ACPI: Power Button [PWRB]
[    4.393740] thermal LNXTHERM:00: registered as thermal_zone0
[    4.393743] ACPI: Thermal Zone [TZ00] (54 C)
[    4.393978] thermal LNXTHERM:01: registered as thermal_zone1
[    4.393981] ACPI: Thermal Zone [TZ01] (54 C)
[    4.522579]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:04:00.0[A] _PRT entry
[    4.522586] xhci_hcd 0000:04:00.0: PCI INT A -> GSI 19 (level, low)=20
-> IRQ 19
[    4.522610] xhci_hcd 0000:04:00.0: setting latency timer to 64
[    4.522615] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    4.522627] xhci_hcd 0000:04:00.0: new USB bus registered, assigned=20
bus number 3
[    4.522834] xhci_hcd 0000:04:00.0: irq 19, io mem 0xf1a00000
[    4.522906] xhci_hcd 0000:04:00.0: irq 44 for MSI/MSI-X
[    4.522913] xhci_hcd 0000:04:00.0: irq 45 for MSI/MSI-X
[    4.522918] xhci_hcd 0000:04:00.0: irq 46 for MSI/MSI-X
[    4.522924] xhci_hcd 0000:04:00.0: irq 47 for MSI/MSI-X
[    4.522929] xhci_hcd 0000:04:00.0: irq 48 for MSI/MSI-X
[    4.523002] input: Sleep Button as=20
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[    4.523043] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    4.523045] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    4.523047] usb usb3: Product: xHCI Host Controller
[    4.523049] usb usb3: Manufacturer: Linux 3.2.0-rc6-3-desktop xhci_hcd
[    4.523050] usb usb3: SerialNumber: 0000:04:00.0
[    4.523265] xHCI xhci_add_endpoint called for root hub
[    4.523267] xHCI xhci_check_bandwidth called for root hub
[    4.523328] hub 3-0:1.0: USB hub found
[    4.523339] hub 3-0:1.0: 2 ports detected
[    4.523379] ACPI: Sleep Button [SLPB]
[    4.523426] input: Lid Switch as=20
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input4
[    4.523478] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    4.523488] xhci_hcd 0000:04:00.0: new USB bus registered, assigned=20
bus number 4
[    4.524286] ACPI: Lid Switch [LID0]
[    4.524340] input: Power Button as=20
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    4.524373] ACPI: Power Button [PWRF]
[    4.526215] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    4.526218] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    4.526220] usb usb4: Product: xHCI Host Controller
[    4.526222] usb usb4: Manufacturer: Linux 3.2.0-rc6-3-desktop xhci_hcd
[    4.526223] usb usb4: SerialNumber: 0000:04:00.0
[    4.526375] xHCI xhci_add_endpoint called for root hub
[    4.526377] xHCI xhci_check_bandwidth called for root hub
[    4.526439] hub 4-0:1.0: USB hub found
[    4.526448] hub 4-0:1.0: 2 ports detected
[    4.526942] [drm] Initialized drm 1.1.0 20060810
[    4.531282]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:02.0[A] _PRT entry
[    4.531289] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ=
 16
[    4.531292] i915 0000:00:02.0: setting latency timer to 64
[    5.368663] i915 0000:00:02.0: irq 49 for MSI/MSI-X
[    5.368666] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010)=
.
[    5.368667] [drm] Driver supports precise vblank timestamp query.
[    5.378777] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call=20
failed
[    5.378819] [drm:intel_dsm_platform_mux_info] *ERROR* MUX INFO call=20
failed
[    5.378837] vgaarb: device changed decodes:=20
PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[    5.378839] vgaarb: transferring owner from PCI:0000:00:02.0 to=20
PCI:0000:01:00.0
[    5.569660] usb 3-1: new low-speed USB device number 2 using xhci_hcd
[    5.609793] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.621761] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.633738] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.638365] usb 3-1: New USB device found, idVendor=3D04ca, idProduct=3D=
0027
[    5.642881] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[    5.647346] usb 3-1: Product: USB Multimedia Keyboard
[    5.651787] usb 3-1: Manufacturer: Lite-On Technology Corp.
[    5.656387] usb 3-1: ep 0x81 - rounding interval to 128 microframes,=20
ep desc says 192 microframes
[    5.660984] usb 3-1: ep 0x82 - rounding interval to 64 microframes,=20
ep desc says 80 microframes
[    5.680911] input: Lite-On Technology Corp. USB Multimedia Keyboard=20
as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1/3-1:1.0/input/inpu=
t6
[    5.685919] generic-usb 0003:04CA:0027.0001: input,hidraw0: USB HID=20
v1.10 Keyboard [Lite-On Technology Corp. USB Multimedia Keyboard] on=20
usb-0000:04:00.0-1/input0
[    5.721562] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.728628] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.735543] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.740403] input: Lite-On Technology Corp. USB Multimedia Keyboard=20
as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1/3-1:1.1/input/inpu=
t7
[    5.745533] generic-usb 0003:04CA:0027.0002: input,hiddev0,hidraw1:=20
USB HID v1.10 Device [Lite-On Technology Corp. USB Multimedia Keyboard]=20
on usb-0000:04:00.0-1/input1
[    5.857203] usb 3-2: new high-speed USB device number 3 using xhci_hcd
[    5.876155] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.881610] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.886481] usb 3-2: New USB device found, idVendor=3D05e3, idProduct=3D=
0608
[    5.891212] usb 3-2: New USB device strings: Mfr=3D0, Product=3D1,=20
SerialNumber=3D0
[    5.895947] usb 3-2: Product: USB2.0 Hub
[    5.901665] hub 3-2:1.0: USB hub found
[    5.906793] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    5.911512] hub 3-2:1.0: 4 ports detected
[    5.945622] checking generic (e0000000 3ff0000) vs hw (e0000000 100000=
00)
[    5.945624] fb: conflicting fb hw usage inteldrmfb vs VESA VGA -=20
removing generic driver
[    5.950427] Console: switching to colour dummy device 80x25
[    5.951515] fbcon: inteldrmfb (fb0) is primary device
[    6.186212] usb 3-2.4: new high-speed USB device number 4 using xhci_h=
cd
[    6.200498] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.201158] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.201314] usb 3-2.4: New USB device found, idVendor=3D05e3,=20
idProduct=3D0608
[    6.201321] usb 3-2.4: New USB device strings: Mfr=3D0, Product=3D1,=20
SerialNumber=3D0
[    6.201327] usb 3-2.4: Product: USB2.0 Hub
[    6.202290] hub 3-2.4:1.0: USB hub found
[    6.202750] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.202925] hub 3-2.4:1.0: 4 ports detected
[    6.313235] Console: switching to colour frame buffer device 236x63
[    6.334979] fb0: inteldrmfb frame buffer device
[    6.335054] drm: registered panic notifier
[    6.335313] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    6.338677] acpi device:2e: registered as cooling_device4
[    6.338816] input: Video Bus as=20
/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:2d/LNXVIDEO:00/input/inp=
ut8
[    6.339007] ACPI: Video Device [PEGP] (multi-head: yes  rom: yes=20
post: no)
[    6.343258] acpi device:32: registered as cooling_device5
[    6.343536] input: Video Bus as=20
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input9
[    6.343717] ACPI: Video Device [GFX0] (multi-head: yes  rom: no=20
post: no)
[    6.343857] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on=20
minor 0
[    6.402163] Btrfs loaded
[    6.443076] md: linear personality registered for level -1
[    6.478910] device-mapper: uevent: version 1.0.3
[    6.479053] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19)=20
initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    6.482774] usb 3-2.4.4: new low-speed USB device number 5 using xhci_=
hcd
[    6.501092] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.503088] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.504086] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[    6.504375] usb 3-2.4.4: New USB device found, idVendor=3D046d,=20
idProduct=3Dc063
[    6.509607] usb 3-2.4.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D0
[    6.514763] usb 3-2.4.4: Product: DELL USB Laser Mouse
[    6.519906] usb 3-2.4.4: Manufacturer: DELL
[    6.525207] usb 3-2.4.4: ep 0x81 - rounding interval to 64=20
microframes, ep desc says 80 microframes
[    6.536487] input: DELL DELL USB Laser Mouse as=20
/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-2/3-2.4/3-2.4.4/3-2.=
4.4:1.0/input/input10
[    6.542117] generic-usb 0003:046D:C063.0003: input,hidraw2: USB HID=20
v1.10 Mouse [DELL DELL USB Laser Mouse] on usb-0000:04:00.0-2.4.4/input0
[   39.516864] PM: Marking nosave pages: 000000000009d000 - 0000000000100=
000
[   39.516868] PM: Marking nosave pages: 00000000b5a28000 - 00000000b6e29=
000
[   39.516926] PM: Marking nosave pages: 00000000b886a000 - 00000000b8ab3=
000
[   39.516934] PM: Marking nosave pages: 00000000bac8f000 - 00000000bafff=
000
[   39.516945] PM: Marking nosave pages: 00000000bb000000 - 0000000100000=
000
[   39.517655] PM: Basic memory bitmaps created
[   39.540690] PM: Basic memory bitmaps freed
[   39.540694] video LNXVIDEO:00: Restoring backlight state
[   39.540695] video LNXVIDEO:01: Restoring backlight state
[   39.590164] PM: Starting manual resume from disk
[   39.595666] PM: Hibernation image partition 253:3 present
[   39.595669] PM: Looking for hibernation image.
[   39.597171] PM: Image not found (code -22)
[   39.597173] PM: Hibernation image not present or could not be loaded.
[   39.615833] device fsid ca00ffff-8c21-4750-b25c-3cf321a07dd9 devid 1=20
transid 21081 /dev/mapper/system-root
[   39.616353] btrfs: turning off barriers
[   39.616356] btrfs: enabling auto defrag
[   39.616357] btrfs: use lzo compression
[   39.616358] btrfs: disk space caching is enabled
[   39.661102] Btrfs detected SSD devices, enabling SSD mode
[   40.401467] btrfs: turning off barriers
[   40.407291] btrfs: enabling auto defrag
[   40.407352] btrfs: use lzo compression
[   40.418719] btrfs: disk space caching is enabled
[   40.683437] systemd[1]: systemd 37 running in system mode. (+PAM=20
+LIBWRAP +AUDIT +SELINUX +SYSVINIT +LIBCRYPTSETUP; suse)
[   40.731811] systemd[1]: Set hostname to <xps15z.cristianrodriguez.net>=
.
[   41.272117] udevd[606]: starting version 173
[   41.435290] mei: module is from the staging directory, the quality is=20
unknown, you have been warned.
[   41.435823]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:16.0[A] _PRT entry
[   41.435829] mei 0000:00:16.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[   41.435834] mei 0000:00:16.0: setting latency timer to 64
[   41.435901] mei 0000:00:16.0: irq 50 for MSI/MSI-X
[   41.473031] iTCO_vendor_support: vendor-support=3D0
[   41.477614]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:06:00.0[A] _PRT entry
[   41.477622] atl1c 0000:06:00.0: PCI INT A -> GSI 17 (level, low) ->=20
IRQ 17
[   41.477633] atl1c 0000:06:00.0: setting latency timer to 64
[   41.487779] mtp-probe[752]: checking bus 3, device 2:=20
"/sys/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-1"
[   41.497929]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1f.3[C] _PRT entry
[   41.497940] IOAPIC[0]: Set routing entry (2-18 -> 0xb9 -> IRQ 18=20
Mode:1 Active:1 Dest:1)
[   41.497946] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:B9 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[   41.497951] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low)=20
-> IRQ 18
[   41.503468] mtp-probe[752]: bus: 3, device: 2 was not an MTP device
[   41.508295] ACPI: Deprecated procfs I/F for AC is loaded, please=20
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   41.508873] input: PC Speaker as /devices/platform/pcspkr/input/input1=
1
[   41.528598] mtp-probe[776]: checking bus 3, device 5:=20
"/sys/devices/pci0000:00/0000:00:1c.3/0000:04:00.0/usb3/3-2/3-2.4/3-2.4.4=
"
[   41.533704] mtp-probe[776]: bus: 3, device: 5 was not an MTP device
[   41.538647] btrfs: turning off barriers
[   41.538650] btrfs: enabling auto defrag
[   41.538653] btrfs: use lzo compression
[   41.538653] btrfs: disk space caching is enabled
[   41.559847] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   41.568681] mtp-probe[794]: checking bus 1, device 3:=20
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4"
[   41.570805] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   41.578853] mtp-probe[794]: bus: 1, device: 3 was not an MTP device
[   41.587647] atl1c 0000:06:00.0: version 1.0.1.0-NAPI
[   41.593026] microcode: CPU0 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.597648] Bluetooth: Core ver 2.16
[   41.603983] NET: Registered protocol family 31
[   41.608008] ACPI: AC Adapter [ADP0] (on-line)
[   41.614610] Bluetooth: HCI device and connection manager initialized
[   41.614613] Bluetooth: HCI socket layer initialized
[   41.614615] Bluetooth: L2CAP socket layer initialized
[   41.614622] Bluetooth: SCO socket layer initialized
[   41.640484] microcode: CPU1 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.643741] microcode: CPU2 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.646724] microcode: CPU3 sig=3D0x206a7, pf=3D0x10, revision=3D0x25
[   41.654637] microcode: Microcode Update Driver: v2.00=20
<tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[   41.676921] ACPI: Deprecated procfs I/F for battery is loaded, please=20
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   41.681836] ACPI: Battery Slot [BAT0] (battery present)
[   41.687239] wmi: Mapper loaded
[   41.693494] Linux video capture interface: v2.00
[   41.701454] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   41.701861] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[   41.701932] iTCO_wdt: Found a Cougar Point TCO device (Version=3D2,=20
TCOBASE=3D0x0460)
[   41.702023] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   41.702161] usbcore: registered new interface driver btusb
[   41.731287] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw=20
xa/form2 cdda caddy
[   41.731291] cdrom: Uniform CD-ROM driver Revision: 3.20
[   41.733075] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   41.742658] cfg80211: Calling CRDA to update world regulatory domain
[   41.755562] dcdbas dcdbas: Dell Systems Management Base Driver=20
(version 5.6.0-3.2)
[   41.766095] uvcvideo: Found UVC 1.00 device=20
Laptop_Integrated_Webcam_2HDM (0c45:642a)
[   41.772757] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:=
d
[   41.778771] Copyright(c) 2003-2011 Intel Corporation
[   41.778833] input: Laptop_Integrated_Webcam_2HDM as=20
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/input/input12
[   41.778960] usbcore: registered new interface driver uvcvideo
[   41.778962] USB Video Class driver (1.1.1)
[   41.802479]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:00:1b.0[A] _PRT entry
[   41.807306]  pci_irq-0373 [00] pci_irq_lookup        : Found=20
0000:03:00.0[A] _PRT entry
[   41.807313] iwlwifi 0000:03:00.0: PCI INT A -> GSI 17 (level, low) ->=20
IRQ 17
[   41.807344] iwlwifi 0000:03:00.0: setting latency timer to 64
[   41.807397] iwlwifi 0000:03:00.0: pci_resource_len =3D 0x00002000
[   41.807399] iwlwifi 0000:03:00.0: pci_resource_base =3D ffffc900057fc0=
00
[   41.807401] iwlwifi 0000:03:00.0: HW Revision ID =3D 0x34
[   41.807630] iwlwifi 0000:03:00.0: irq 51 for MSI/MSI-X
[   41.807715] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R)=20
Advanced-N 6230 AGN, REV=3D0xB0
[   41.807861] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   41.823275] iwlwifi 0000:03:00.0: device EEPROM VER=3D0x716, CALIB=3D0=
x6
[   41.823278] iwlwifi 0000:03:00.0: Device SKU: 0X1f0
[   41.823280] iwlwifi 0000:03:00.0: Valid Tx ant: 0X3, Valid Rx ant: 0X3
[   41.823300] iwlwifi 0000:03:00.0: Tunable channels: 13 802.11bg, 24=20
802.11a channels
[   41.829386] ifup[893]: Service network not started and mode 'auto' ->=20
skipping
[   41.852847] cfg80211: World regulatory domain updated:
[   41.852849] cfg80211:     (start_freq - end_freq @ bandwidth),=20
(max_antenna_gain, max_eirp)
[   41.852850] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852852] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852853] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852854] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.852855] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),=20
(300 mBi, 2000 mBm)
[   41.920210] IOAPIC[0]: Set routing entry (2-22 -> 0xc9 -> IRQ 22=20
Mode:1 Active:1 Dest:1)
[   41.920216] IOAPIC[0]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1=20
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:C9 Dest:00000001=20
SID:F0F8 SQ:0 SVT:1)
[   41.920221] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,=20
low) -> IRQ 22
[   41.920290] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[   41.920313] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   41.920845] input: Dell WMI hotkeys as /devices/virtual/input/input13
[   41.940703] iwlwifi 0000:03:00.0: loaded firmware version 17.168.5.1=20
build 33993
[   41.940849] Registered led device: phy0-led
[   41.964426] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-r=
s'
[   42.010557] ifup[964]: Service network not started and mode 'auto' ->=20
skipping
[   42.174781] Adding 2097148k swap on /dev/mapper/system-swap.=20
Priority:0 extents:1 across:2097148k SS
[   44.925951] ALSA hda_intel.c:812 azx_get_response timeout, switching=20
to polling mode: last cmd=3D0x000f0000
[   45.437474] ALSA patch_realtek.c:1261 SKU: Nid=3D0x1d sku_cfg=3D0x4017=
9a2d
[   45.437477] ALSA patch_realtek.c:1263 SKU: port_connectivity=3D0x1
[   45.437478] ALSA patch_realtek.c:1264 SKU: enable_pcbeep=3D0x1
[   45.437480] ALSA patch_realtek.c:1265 SKU: check_sum=3D0x00000007
[   45.437481] ALSA patch_realtek.c:1266 SKU: customization=3D0x0000009a
[   45.437482] ALSA patch_realtek.c:1267 SKU: external_amp=3D0x5
[   45.437483] ALSA patch_realtek.c:1268 SKU: platform_type=3D0x1
[   45.437485] ALSA patch_realtek.c:1269 SKU: swap=3D0x0
[   45.437486] ALSA patch_realtek.c:1270 SKU: override=3D0x1
[   45.437895] ALSA hda_codec.c:4951 autoconfig: line_outs=3D1=20
(0x14/0x0/0x0/0x0/0x0) type:speaker
[   45.437897] ALSA hda_codec.c:4955    speaker_outs=3D0 (0x0/0x0/0x0/0x0=
/0x0)
[   45.437899] ALSA hda_codec.c:4959    hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0=
)
[   45.437900] ALSA hda_codec.c:4960    mono: mono_out=3D0x0
[   45.437901] ALSA hda_codec.c:4964    inputs:
[   45.437903] ALSA hda_codec.c:4968  Internal Mic=3D0x12
[   45.437904] ALSA hda_codec.c:4968  Mic=3D0x18
[   45.437905] ALSA hda_codec.c:4970
[   45.439163] ALSA patch_realtek.c:1324 realtek: No valid SSID,=20
checking pincfg 0x40179a2d for NID 0x1d
[   45.439165] ALSA patch_realtek.c:1340 realtek: Enabling init=20
ASM_ID=3D0x9a2d CODEC_ID=3D10ec0269
[   45.443482] HDMI status: Codec=3D3 Pin=3D6 Presence_Detect=3D0 ELD_Val=
id=3D0
[   45.448591] input: HDA Intel PCH HDMI/DP,pcm=3D3 as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   45.453689] input: HDA Intel PCH Mic as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   45.458609] input: HDA Intel PCH Headphone as=20
/devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   45.710010] systemd-cryptsetup[1010]: Volume cr_sda2 already active.
[   45.787497] systemd-fsck[1005]: /dev/sda1: limpio, 63/40000 ficheros,=20
137097/159744 bloques
[   45.824455] device fsid 403609d3-a44c-4bb6-99c4-8be5430433e7 devid 1=20
transid 22126 /dev/mapper/system-home
[   45.829949] btrfs: turning off barriers
[   45.834896] btrfs: enabling auto defrag
[   45.834957] btrfs: use lzo compression
[   45.840735] EXT4-fs (sda1): barriers disabled
[   45.849518] btrfs: disk space caching is enabled
[   45.854628] EXT4-fs (sda1): mounted filesystem with writeback data=20
mode. Opts: acl,barrier=3D0,data=3Dwriteback,user_xattr
[   45.869431] Btrfs detected SSD devices, enabling SSD mode
[   47.174579] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   47.174581] Bluetooth: BNEP filters: protocol multicast
[   47.205249] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   47.215832] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   47.337233] Bluetooth: RFCOMM TTY layer initialized
[   47.337238] Bluetooth: RFCOMM socket layer initialized
[   47.337239] Bluetooth: RFCOMM ver 1.11
[   47.505097] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[   47.511590] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   47.635461] atl1c 0000:06:00.0: irq 53 for MSI/MSI-X
[   47.635523] atl1c 0000:06:00.0: atl1c: eth0 NIC Link is Up<1000 Mbps=20
Full Duplex>
[   47.648775] NET: Registered protocol family 17



--=20
To unsubscribe, e-mail: opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org
To contact the owner, e-mail: opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org
