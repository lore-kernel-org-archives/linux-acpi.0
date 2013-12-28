From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Atheros AR9285: enabling or disabling Wi-Fi freezes the system
Date: Sat, 28 Dec 2013 23:44:29 +0100
Message-ID: <1388270669.14575.11.camel@deadeye.wl.decadent.org.uk>
References: <111971357467708@web8e.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8OpOzLXZ9HJ0t3O51Sis"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54574 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037Ab3L1Wol (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Dec 2013 17:44:41 -0500
In-Reply-To: <111971357467708@web8e.yandex.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ath9k-devel@lists.ath9k.org, linux-acpi@vger.kernel.org
Cc: =?UTF-8?Q?=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B8=D1=81?= =?UTF-8?Q?=D1=82_?= =?UTF-8?Q?=D0=BD=D0=B5=D0=BA=D1=82=D0=BE?= <programmer11180@programist.ru>


--=-8OpOzLXZ9HJ0t3O51Sis
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2013-01-06 at 14:21 +0400, programmer11180@programist.ru wrote:
> Package: linux-image-3.2.0-4-686-pae
> Version: 3.2.35-2 =20
> Severity: Critical
>=20
>=20
> Hello, comrades.
> When I enable or disable wi-fi, system sometimes hangs. Also, Also, the s=
ystem sometimes hangs when booting.
> This bug is also present in other kernels (higher 3.2) and 64-bit system.
> After that I had to turn off the laptop by power button.

They also tested earlier and later versions, and found that this was a
regression in 2.6.39 and still occurs in 3.12.

What can be done to investigate this?

Ben.

> syslog
> Jan  6 17:47:08 gateway-lmde rsyslogd: [origin software=3D"rsyslogd" swVe=
rsion=3D"7.2.4" x-pid=3D"2443" x-info=3D"http://www.rsyslog.com"] start
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] Initializing cgroup s=
ubsys cpuset
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] Initializing cgroup s=
ubsys cpu
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] Linux version 3.2.0-4=
-686-pae (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-=
14) ) #1 SMP Debian 3.2.35-2
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] BIOS-provided physica=
l RAM map:
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
0000000 - 000000000009f800 (usable)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
009f800 - 00000000000a0000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
00ce000 - 0000000000100000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
0100000 - 000000006fed0000 (usable)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000006=
fed0000 - 000000006fee5000 (ACPI data)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000006=
fee5000 - 000000006fee7000 (ACPI NVS)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000006=
fee7000 - 0000000080000000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000e=
0000000 - 00000000f0000000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000f=
ec00000 - 00000000fec10000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000f=
ee00000 - 00000000fee01000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000f=
ff00000 - 0000000100000000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] NX (Execute Disable) =
protection: active
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] DMI present.
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] DMI: Gateway         =
 LT31            /SJM11-YK        , BIOS v1.3201  06/18/2009
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] e820 update range: 00=
00000000000000 - 0000000000010000 (usable) =3D=3D> (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] e820 remove range: 00=
000000000a0000 - 0000000000100000 (usable)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] last_pfn =3D 0x6fed0 =
max_arch_pfn =3D 0x1000000
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] MTRR default type: un=
cachable
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] MTRR fixed ranges ena=
bled:
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   00000-9FFFF write-b=
ack
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   A0000-BFFFF uncacha=
ble
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   C0000-CDFFF write-p=
rotect
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   CE000-CFFFF uncacha=
ble
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   D0000-D1FFF write-b=
ack
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   D2000-E3FFF uncacha=
ble
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   E4000-FFFFF write-p=
rotect
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] MTRR variable ranges =
enabled:
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   0 base 0000000000 m=
ask FF80000000 write-back
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   1 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   2 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   3 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   4 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   5 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   6 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]   7 disabled
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] x86 PAT enabled: cpu =
0, old 0x7040600070406, new 0x7010600070106
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] found SMP MP-table at=
 [c00f82e0] f82e0
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] initial memory mapped=
 : 0 - 01a00000
>=20
> Further entries in the log made =E2=80=8B=E2=80=8Bafter reboot.
>=20
> /var/messages
> Jan  6 17:47:08 gateway-lmde rsyslogd: [origin software=3D"rsyslogd" swVe=
rsion=3D"7.2.4" x-pid=3D"2443" x-info=3D"http://www.rsyslog.com"] start
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] Initializing cgroup s=
ubsys cpuset
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] Initializing cgroup s=
ubsys cpu
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] Linux version 3.2.0-4=
-686-pae (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-=
14) ) #1 SMP Debian 3.2.35-2
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] BIOS-provided physica=
l RAM map:
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
0000000 - 000000000009f800 (usable)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
009f800 - 00000000000a0000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
00ce000 - 0000000000100000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000000=
0100000 - 000000006fed0000 (usable)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000006=
fed0000 - 000000006fee5000 (ACPI data)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000006=
fee5000 - 000000006fee7000 (ACPI NVS)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 000000006=
fee7000 - 0000000080000000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000e=
0000000 - 00000000f0000000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000f=
ec00000 - 00000000fec10000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000f=
ee00000 - 00000000fee01000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000]  BIOS-e820: 00000000f=
ff00000 - 0000000100000000 (reserved)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] NX (Execute Disable) =
protection: active
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] DMI present.
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] last_pfn =3D 0x6fed0 =
max_arch_pfn =3D 0x1000000
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] x86 PAT enabled: cpu =
0, old 0x7040600070406, new 0x7010600070106
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] found SMP MP-table at=
 [c00f82e0] f82e0
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] init_memory_mapping: =
0000000000000000-00000000379fe000
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] RAMDISK: 36cac000 - 3=
764e000
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] ACPI: RSDP 000f82b0 0=
0024 (v02 PTLTD )
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] ACPI: XSDT 6fedc069 0=
005C (v01 ACRSYS ACRPRDCT 06040000  LTP 00000000)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] ACPI: FACP 6fee4b8e 0=
00F4 (v03 ATI    Herring  06040000 ATI  000F4240)
> Jan  6 17:47:08 gateway-lmde kernel: [    0.000000] ACPI: DSDT 6fedc0c5 0=
8AC9 (v01
>=20
> Further entries in the log made =E2=80=8B=E2=80=8Bafter reboot.
>=20
> /var/dmesg
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.2.0-4-686-pae (debian-kernel@lists.debian.=
org) (gcc version 4.6.3 (Debian 4.6.3-14) ) #1 SMP Debian 3.2.35-2
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 000000006fed0000 (usable)
> [    0.000000]  BIOS-e820: 000000006fed0000 - 000000006fee5000 (ACPI data=
)
> [    0.000000]  BIOS-e820: 000000006fee5000 - 000000006fee7000 (ACPI NVS)
> [    0.000000]  BIOS-e820: 000000006fee7000 - 0000000080000000 (reserved)
> [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] DMI present.
> [    0.000000] DMI: Gateway          LT31            /SJM11-YK        , B=
IOS v1.3201  06/18/2009
> [    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (us=
able) =3D=3D> (reserved)
> [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (us=
able)
> [    0.000000] last_pfn =3D 0x6fed0 max_arch_pfn =3D 0x1000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-CDFFF write-protect
> [    0.000000]   CE000-CFFFF uncachable
> [    0.000000]   D0000-D1FFF write-back
> [    0.000000]   D2000-E3FFF uncachable
> [    0.000000]   E4000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 0000000000 mask FF80000000 write-back
> [    0.000000]   1 disabled
> [    0.000000]   2 disabled
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600=
070106
> [    0.000000] found SMP MP-table at [c00f82e0] f82e0
> [    0.000000] initial memory mapped : 0 - 01a00000
> [    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
> [    0.000000] init_memory_mapping: 0000000000000000-00000000379fe000
> [    0.000000]  0000000000 - 0000200000 page 4k
> [    0.000000]  0000200000 - 0037800000 page 2M
> [    0.000000]  0037800000 - 00379fe000 page 4k
> [    0.000000] kernel direct mapping tables up to 379fe000 @ 19f9000-1a00=
000
> [    0.000000] RAMDISK: 36cac000 - 3764e000
> [    0.000000] ACPI: RSDP 000f82b0 00024 (v02 PTLTD )
> [    0.000000] ACPI: XSDT 6fedc069 0005C (v01 ACRSYS ACRPRDCT 06040000  L=
TP 00000000)
> [    0.000000] ACPI: FACP 6fee4b8e 000F4 (v03 ATI    Herring  06040000 AT=
I  000F4240)
> [    0.000000] ACPI: DSDT 6fedc0c5 08AC9 (v01    ATI    SB600 06040000 MS=
FT 03000001)
> [    0.000000] ACPI: FACS 6fee6fc0 00040
> [    0.000000] ACPI: SSDT 6fee4cf6 000B2 (v01 PTLTD  POWERNOW 06040000  L=
TP 00000001)
> [    0.000000] ACPI: APIC 6fee4da8 00046 (v01 PTLTD  ? APIC   06040000  L=
TP 00000000)
> [    0.000000] ACPI: MCFG 6fee4dee 0003C (v01 PTLTD    MCFG   06040000  L=
TP 00000000)
> [    0.000000] ACPI: HPET 6fee4e2a 00038 (v01 PTLTD  HPETTBL  06040000  L=
TP 00000001)
> [    0.000000] ACPI: BOOT 6fee4e62 00028 (v01 PTLTD  $SBFTBL$ 06040000  L=
TP 00000001)
> [    0.000000] ACPI: SLIC 6fee4e8a 00176 (v01 ACRSYS ACRPRDCT 06040000 ac=
er 00000000)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] 900MB HIGHMEM available.
> [    0.000000] 889MB LOWMEM available.
> [    0.000000]   mapped low ram: 0 - 379fe000
> [    0.000000]   low ram: 0 - 379fe000
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000010 -> 0x00001000
> [    0.000000]   Normal   0x00001000 -> 0x000379fe
> [    0.000000]   HighMem  0x000379fe -> 0x0006fed0
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[2] active PFN ranges
> [    0.000000]     0: 0x00000010 -> 0x0000009f
> [    0.000000]     0: 0x00000100 -> 0x0006fed0
> [    0.000000] On node 0 totalpages: 458335
> [    0.000000] free_area_init_node: node 0, pgdat c1412180, node_mem_map =
f5eac200
> [    0.000000]   DMA zone: 32 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 3951 pages, LIFO batch:0
> [    0.000000]   Normal zone: 1748 pages used for memmap
> [    0.000000]   Normal zone: 221994 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 1802 pages used for memmap
> [    0.000000]   HighMem zone: 228808 pages, LIFO batch:31
> [    0.000000] Using APIC driver default
> [    0.000000] Detected use of extended apic ids on hypertransport bus
> [    0.000000] ACPI: PM-Timer IO Port: 0x8008
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI =
0-23
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
> [    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
> [    0.000000] nr_irqs_gsi: 40
> [    0.000000] PM: Registered nosave memory: 000000000009f000 - 000000000=
00a0000
> [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 000000000=
00ce000
> [    0.000000] PM: Registered nosave memory: 00000000000ce000 - 000000000=
0100000
> [    0.000000] Allocating PCI resources starting at 80000000 (gap: 800000=
00:60000000)
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 n=
r_node_ids:1
> [    0.000000] PERCPU: Embedded 14 pages/cpu @f79e6000 s33280 r0 d24064 u=
57344
> [    0.000000] pcpu-alloc: s33280 r0 d24064 u57344 alloc=3D14*4096
> [    0.000000] pcpu-alloc: [0] 0=20
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 454753
> [    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.2.0-4-68=
6-pae root=3DUUID=3D13f3c2d1-c820-4b5d-89d9-62b8cdd3dd23 ro quiet acpi_back=
light=3Dvendor init=3D/sbin/e4rat-preload
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 =
bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 by=
tes)
> [    0.000000] Initializing CPU#0
> [    0.000000] Initializing HighMem for node 0 (000379fe:0006fed0)
> [    0.000000] Memory: 1803020k/1833792k available (2845k kernel code, 30=
320k reserved, 1353k data, 416k init, 922440k highmem)
> [    0.000000] virtual kernel memory layout:
> [    0.000000]     fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
> [    0.000000]     pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
> [    0.000000]     vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
> [    0.000000]       .init : 0xc141a000 - 0xc1482000   ( 416 kB)
> [    0.000000]       .data : 0xc12c7484 - 0xc1419a80   (1353 kB)
> [    0.000000]       .text : 0xc1000000 - 0xc12c7484   (2845 kB)
> [    0.000000] Checking if this processor honours the WP bit even in supe=
rvisor mode...Ok.
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] NR_IRQS:2304 nr_irqs:256 16
> [    0.000000] CPU 0 irqstacks, hard=3Df5806000 soft=3Df5808000
> [    0.000000] spurious 8259A interrupt: IRQ7.
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] hpet clockevent registered
> [    0.000000] Fast TSC calibration using PIT
> [    0.000000] Detected 1196.876 MHz processor.
> [    0.008003] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 2393.75 BogoMIPS (lpj=3D4787504)
> [    0.008013] pid_max: default: 32768 minimum: 301
> [    0.008091] Security Framework initialized
> [    0.008102] AppArmor: AppArmor disabled by boot time parameter
> [    0.008132] Mount-cache hash table entries: 512
> [    0.008400] Initializing cgroup subsys cpuacct
> [    0.008412] Initializing cgroup subsys memory
> [    0.008433] Initializing cgroup subsys devices
> [    0.008438] Initializing cgroup subsys freezer
> [    0.008443] Initializing cgroup subsys net_cls
> [    0.008448] Initializing cgroup subsys blkio
> [    0.008465] Initializing cgroup subsys perf_event
> [    0.008523] mce: CPU supports 5 MCE banks
> [    0.008542] using AMD E400 aware idle routine
> [    0.012068] SMP alternatives: switching to UP code
> [    0.015679] Freeing SMP alternatives: 8k freed
> [    0.015691] ACPI: Core revision 20110623
> [    0.024097] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> [    0.024499] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=
=3D-1
> [    0.028001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> [    0.028001] ...trying to set up timer (IRQ0) through the 8259A ...
> [    0.028001] ..... (found apic 0 pin 0) ...
> [    0.069097] ....... works.
> [    0.069100] CPU0: AMD Athlon(tm) Processor L110 stepping 02
> [    0.072003] Performance Events: AMD PMU driver.
> [    0.072003] ... version:                0
> [    0.072003] ... bit width:              48
> [    0.072003] ... generic registers:      4
> [    0.072003] ... value mask:             0000ffffffffffff
> [    0.072003] ... max period:             00007fffffffffff
> [    0.072003] ... fixed-purpose events:   0
> [    0.072003] ... event mask:             000000000000000f
> [    0.072003] NMI watchdog enabled, takes one hw-pmu counter.
> [    0.072003] Brought up 1 CPUs
> [    0.072003] Total of 1 processors activated (2393.75 BogoMIPS).
> [    0.072003] devtmpfs: initialized
> [    0.072003] PM: Registering ACPI NVS region at 6fee5000 (8192 bytes)
> [    0.072003] print_constraints: dummy:=20
> [    0.072003] NET: Registered protocol family 16
> [    0.072003] node 0 link 0: io port [1000, fffff]
> [    0.072003] TOM: 0000000080000000 aka 2048M
> [    0.072003] node 0 link 0: mmio [f0100000, ffffffff]
> [    0.072003] node 0 link 0: mmio [e0000000, dfffffff]
> [    0.072003] node 0 link 0: mmio [d0000000, dfffffff]
> [    0.072003] node 0 link 0: mmio [a0000, bffff]
> [    0.072003] node 0 link 0: mmio [f0000000, f00fffff]
> [    0.072003] node 0 link 0: mmio [e0000000, efffffff]
> [    0.072003] node 0 link 0: mmio [80000000, cfffffff]
> [    0.072003] bus: [00, ff] on node 0 link 0
> [    0.072003] bus: 00 index 0 [io  0x0000-0xffff]
> [    0.072003] bus: 00 index 1 [mem 0xe0000000-0xfcffffffff]
> [    0.072003] bus: 00 index 2 [mem 0x80000000-0xdfffffff]
> [    0.072003] bus: 00 index 3 [mem 0x000a0000-0x000bffff]
> [    0.072003] ACPI: bus type pci registered
> [    0.072003] PCI: MMCONFIG for domain 0000 [bus 00-08] at [mem 0xe00000=
00-0xe08fffff] (base 0xe0000000)
> [    0.072003] PCI: MMCONFIG at [mem 0xe0000000-0xe08fffff] reserved in E=
820
> [    0.072003] PCI: Using MMCONFIG for extended config space
> [    0.072003] PCI: Using configuration type 1 for base access
> [    0.072003] bio: create slab <bio-0> at 0
> [    0.072003] ACPI: Added _OSI(Module Device)
> [    0.072003] ACPI: Added _OSI(Processor Device)
> [    0.072003] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.072003] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.073143] ACPI: EC: Look up EC in DSDT
> [    0.078386] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> [    0.108141] ACPI: Interpreter enabled
> [    0.108155] ACPI: (supports S0 S3 S4 S5)
> [    0.108186] ACPI: Using IOAPIC for interrupt routing
> [    0.116289] ACPI: EC: GPE =3D 0x10, I/O: command/status =3D 0x66, data=
 =3D 0x62
> [    0.116525] ACPI: No dock devices found.
> [    0.116529] HEST: Table not found.
> [    0.116538] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
> [    0.117982] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.120583] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x=
000bffff]
> [    0.120590] pci_root PNP0A08:00: host bridge window [mem 0x000ce000-0x=
000cffff]
> [    0.120596] pci_root PNP0A08:00: host bridge window [mem 0x000d2000-0x=
000d3fff]
> [    0.120601] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x=
000d5fff]
> [    0.120607] pci_root PNP0A08:00: host bridge window [mem 0x000d6000-0x=
000d7fff]
> [    0.120612] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x=
000d9fff]
> [    0.120617] pci_root PNP0A08:00: host bridge window [mem 0x000da000-0x=
000dbfff]
> [    0.120623] pci_root PNP0A08:00: host bridge window [mem 0x000dc000-0x=
000ddfff]
> [    0.120628] pci_root PNP0A08:00: host bridge window [mem 0x000de000-0x=
000dffff]
> [    0.120633] pci_root PNP0A08:00: host bridge window [mem 0x000e0000-0x=
000e1fff]
> [    0.120639] pci_root PNP0A08:00: host bridge window [mem 0x000e2000-0x=
000e3fff]
> [    0.120645] pci_root PNP0A08:00: host bridge window [mem 0x80000000-0x=
dfffffff]
> [    0.120650] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0x=
ffffffff]
> [    0.120656] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7=
]
> [    0.120661] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff=
]
> [    0.120689] pci 0000:00:00.0: [1002:7910] type 0 class 0x000600
> [    0.120735] pci 0000:00:01.0: [1002:7912] type 1 class 0x000604
> [    0.120795] pci 0000:00:05.0: [1002:7915] type 1 class 0x000604
> [    0.120844] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [    0.120869] pci 0000:00:06.0: [1002:7916] type 1 class 0x000604
> [    0.120916] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
> [    0.120963] pci 0000:00:12.0: [1002:4380] type 0 class 0x000101
> [    0.120987] pci 0000:00:12.0: reg 10: [io  0x8440-0x8447]
> [    0.121001] pci 0000:00:12.0: reg 14: [io  0x8434-0x8437]
> [    0.121015] pci 0000:00:12.0: reg 18: [io  0x8438-0x843f]
> [    0.121030] pci 0000:00:12.0: reg 1c: [io  0x8430-0x8433]
> [    0.121044] pci 0000:00:12.0: reg 20: [io  0x8400-0x840f]
> [    0.121058] pci 0000:00:12.0: reg 24: [mem 0xf0508000-0xf05083ff]
> [    0.121086] pci 0000:00:12.0: set SATA to AHCI mode
> [    0.121137] pci 0000:00:13.0: [1002:4387] type 0 class 0x000c03
> [    0.121157] pci 0000:00:13.0: reg 10: [mem 0xf0504000-0xf0504fff]
> [    0.121243] pci 0000:00:13.1: [1002:4388] type 0 class 0x000c03
> [    0.121262] pci 0000:00:13.1: reg 10: [mem 0xf0505000-0xf0505fff]
> [    0.121350] pci 0000:00:13.3: [1002:438a] type 0 class 0x000c03
> [    0.121369] pci 0000:00:13.3: reg 10: [mem 0xf0506000-0xf0506fff]
> [    0.121455] pci 0000:00:13.4: [1002:438b] type 0 class 0x000c03
> [    0.121474] pci 0000:00:13.4: reg 10: [mem 0xf0507000-0xf0507fff]
> [    0.121568] pci 0000:00:13.5: [1002:4386] type 0 class 0x000c03
> [    0.121595] pci 0000:00:13.5: reg 10: [mem 0xf0508400-0xf05084ff]
> [    0.121698] pci 0000:00:13.5: supports D1 D2
> [    0.121703] pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
> [    0.121737] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
> [    0.121766] pci 0000:00:14.0: reg 10: [io  0x8410-0x841f]
> [    0.121874] pci 0000:00:14.1: [1002:438c] type 0 class 0x000101
> [    0.121893] pci 0000:00:14.1: reg 10: [io  0x01f0-0x01f7]
> [    0.121907] pci 0000:00:14.1: reg 14: [io  0x03f4-0x03f7]
> [    0.121921] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
> [    0.121935] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
> [    0.121949] pci 0000:00:14.1: reg 20: [io  0x8420-0x842f]
> [    0.122002] pci 0000:00:14.2: [1002:4383] type 0 class 0x000403
> [    0.122031] pci 0000:00:14.2: reg 10: [mem 0xf0500000-0xf0503fff 64bit=
]
> [    0.122115] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
> [    0.122142] pci 0000:00:14.3: [1002:438d] type 0 class 0x000601
> [    0.122239] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
> [    0.122304] pci 0000:00:18.0: [1022:1100] type 0 class 0x000600
> [    0.122338] pci 0000:00:18.1: [1022:1101] type 0 class 0x000600
> [    0.122367] pci 0000:00:18.2: [1022:1102] type 0 class 0x000600
> [    0.122396] pci 0000:00:18.3: [1022:1103] type 0 class 0x000600
> [    0.122466] pci 0000:01:05.0: [1002:791f] type 0 class 0x000300
> [    0.122482] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff 64bit=
 pref]
> [    0.122494] pci 0000:01:05.0: reg 18: [mem 0xf0100000-0xf010ffff 64bit=
]
> [    0.122503] pci 0000:01:05.0: reg 20: [io  0x9000-0x90ff]
> [    0.122511] pci 0000:01:05.0: reg 24: [mem 0xf0000000-0xf00fffff]
> [    0.122537] pci 0000:01:05.0: supports D1 D2
> [    0.122559] pci 0000:00:01.0: PCI bridge to [bus 01-01]
> [    0.122566] pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
> [    0.122572] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf01fff=
ff]
> [    0.122579] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffff=
ff 64bit pref]
> [    0.122633] pci 0000:03:00.0: [10ec:8136] type 0 class 0x000200
> [    0.122651] pci 0000:03:00.0: reg 10: [io  0xa000-0xa0ff]
> [    0.122679] pci 0000:03:00.0: reg 18: [mem 0xcfdef000-0xcfdeffff 64bit=
 pref]
> [    0.122698] pci 0000:03:00.0: reg 20: [mem 0xcfdf0000-0xcfdfffff 64bit=
 pref]
> [    0.122712] pci 0000:03:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
> [    0.122771] pci 0000:03:00.0: supports D1 D2
> [    0.122776] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
> [    0.128031] pci 0000:00:05.0: PCI bridge to [bus 03-03]
> [    0.128038] pci 0000:00:05.0:   bridge window [io  0xa000-0xafff]
> [    0.128046] pci 0000:00:05.0:   bridge window [mem 0xcfd00000-0xcfdfff=
ff 64bit pref]
> [    0.128101] pci 0000:04:00.0: [168c:002b] type 0 class 0x000280
> [    0.128125] pci 0000:04:00.0: reg 10: [mem 0xf0200000-0xf020ffff 64bit=
]
> [    0.128219] pci 0000:04:00.0: supports D1
> [    0.128223] pci 0000:04:00.0: PME# supported from D0 D1 D3hot
> [    0.136022] pci 0000:00:06.0: PCI bridge to [bus 04-04]
> [    0.136030] pci 0000:00:06.0:   bridge window [mem 0xf0200000-0xf02fff=
ff]
> [    0.136111] pci 0000:00:14.4: PCI bridge to [bus 09-09] (subtractive d=
ecode)
> [    0.136126] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bff=
ff] (subtractive decode)
> [    0.136132] pci 0000:00:14.4:   bridge window [mem 0x000ce000-0x000cff=
ff] (subtractive decode)
> [    0.136137] pci 0000:00:14.4:   bridge window [mem 0x000d2000-0x000d3f=
ff] (subtractive decode)
> [    0.136143] pci 0000:00:14.4:   bridge window [mem 0x000d4000-0x000d5f=
ff] (subtractive decode)
> [    0.136149] pci 0000:00:14.4:   bridge window [mem 0x000d6000-0x000d7f=
ff] (subtractive decode)
> [    0.136155] pci 0000:00:14.4:   bridge window [mem 0x000d8000-0x000d9f=
ff] (subtractive decode)
> [    0.136160] pci 0000:00:14.4:   bridge window [mem 0x000da000-0x000dbf=
ff] (subtractive decode)
> [    0.136166] pci 0000:00:14.4:   bridge window [mem 0x000dc000-0x000ddf=
ff] (subtractive decode)
> [    0.136172] pci 0000:00:14.4:   bridge window [mem 0x000de000-0x000dff=
ff] (subtractive decode)
> [    0.136177] pci 0000:00:14.4:   bridge window [mem 0x000e0000-0x000e1f=
ff] (subtractive decode)
> [    0.136183] pci 0000:00:14.4:   bridge window [mem 0x000e2000-0x000e3f=
ff] (subtractive decode)
> [    0.136189] pci 0000:00:14.4:   bridge window [mem 0x80000000-0xdfffff=
ff] (subtractive decode)
> [    0.136195] pci 0000:00:14.4:   bridge window [mem 0xf0000000-0xffffff=
ff] (subtractive decode)
> [    0.136201] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (sub=
tractive decode)
> [    0.136206] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (sub=
tractive decode)
> [    0.136228] pci_bus 0000:00: on NUMA node 0
> [    0.136235] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [    0.136397] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB5_._PRT]
> [    0.136473] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
> [    0.136601] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
> [    0.136642] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> [    0.136818]  pci0000:00: Requesting ACPI _OSC control (0x1d)
> [    0.136935]  pci0000:00: ACPI _OSC request failed (AE_SUPPORT), return=
ed control mask: 0x00
> [    0.136940] ACPI _OSC control for PCIe not granted, disabling ASPM
> [    0.143491] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
> [    0.143570] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
> [    0.143648] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
> [    0.143726] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
> [    0.143804] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
> [    0.143882] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
> [    0.143961] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
> [    0.144051] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
> [    0.144265] vgaarb: device added: PCI:0000:01:05.0,decodes=3Dio+mem,ow=
ns=3Dio+mem,locks=3Dnone
> [    0.144272] vgaarb: loaded
> [    0.144274] vgaarb: bridge control possible 0000:01:05.0
> [    0.144365] PCI: Using ACPI for IRQ routing
> [    0.144579] PCI: pci_cache_line_size set to 64 bytes
> [    0.144692] reserve RAM buffer: 000000000009f800 - 000000000009ffff=
=20
> [    0.144698] reserve RAM buffer: 000000006fed0000 - 000000006fffffff=
=20
> [    0.144922] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [    0.144931] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
> [    0.146992] Switching to clocksource hpet
> [    0.147007] pnp: PnP ACPI init
> [    0.147007] ACPI: bus type pnp registered
> [    0.148714] pnp 00:00: [bus 00-ff]
> [    0.148720] pnp 00:00: [mem 0x000a0000-0x000bffff window]
> [    0.148725] pnp 00:00: [mem 0x000c0000-0x000c1fff window]
> [    0.148730] pnp 00:00: [mem 0x000c2000-0x000c3fff window]
> [    0.148735] pnp 00:00: [mem 0x000c4000-0x000c5fff window]
> [    0.148740] pnp 00:00: [mem 0x000c6000-0x000c7fff window]
> [    0.148744] pnp 00:00: [mem 0x000c8000-0x000c9fff window]
> [    0.148749] pnp 00:00: [mem 0x000ca000-0x000cbfff window]
> [    0.148756] pnp 00:00: [mem 0x000cc000-0x000cdfff window]
> [    0.148761] pnp 00:00: [mem 0x000ce000-0x000cffff window]
> [    0.148766] pnp 00:00: [mem 0x000d0000-0x000d1fff window]
> [    0.148771] pnp 00:00: [mem 0x000d2000-0x000d3fff window]
> [    0.148776] pnp 00:00: [mem 0x000d4000-0x000d5fff window]
> [    0.148780] pnp 00:00: [mem 0x000d6000-0x000d7fff window]
> [    0.148785] pnp 00:00: [mem 0x000d8000-0x000d9fff window]
> [    0.148790] pnp 00:00: [mem 0x000da000-0x000dbfff window]
> [    0.148795] pnp 00:00: [mem 0x000dc000-0x000ddfff window]
> [    0.148800] pnp 00:00: [mem 0x000de000-0x000dffff window]
> [    0.148804] pnp 00:00: [mem 0x000e0000-0x000e1fff window]
> [    0.148809] pnp 00:00: [mem 0x000e2000-0x000e3fff window]
> [    0.148814] pnp 00:00: [mem 0x000e4000-0x000e5fff window]
> [    0.148819] pnp 00:00: [mem 0x000e6000-0x000e7fff window]
> [    0.148823] pnp 00:00: [mem 0x000e8000-0x000e9fff window]
> [    0.148828] pnp 00:00: [mem 0x000ea000-0x000ebfff window]
> [    0.148833] pnp 00:00: [mem 0x000ec000-0x000edfff window]
> [    0.148838] pnp 00:00: [mem 0x000ee000-0x000effff window]
> [    0.148843] pnp 00:00: [mem 0x80000000-0xdfffffff window]
> [    0.148848] pnp 00:00: [mem 0xf0000000-0xffffffff window]
> [    0.148853] pnp 00:00: [io  0x0cf8-0x0cff]
> [    0.148857] pnp 00:00: [io  0x0000-0x0cf7 window]
> [    0.148862] pnp 00:00: [io  0x0d00-0xffff window]
> [    0.148962] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 =
(active)
> [    0.149051] pnp 00:01: [mem 0xfec00000-0xfec00fff]
> [    0.149056] pnp 00:01: [mem 0xfee00000-0xfee00fff]
> [    0.149165] system 00:01: [mem 0xfec00000-0xfec00fff] could not be res=
erved
> [    0.149171] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserve=
d
> [    0.149178] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.149731] pnp 00:02: [io  0x0000-0x001f]
> [    0.149736] pnp 00:02: [io  0x0080-0x008f]
> [    0.149740] pnp 00:02: [io  0x00c0-0x00df]
> [    0.149745] pnp 00:02: [dma 4]
> [    0.149808] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
> [    0.149825] pnp 00:03: [io  0x00f0-0x00fe]
> [    0.149846] pnp 00:03: [irq 13]
> [    0.149908] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
> [    0.149928] pnp 00:04: [io  0x0070-0x0071]
> [    0.149939] pnp 00:04: [irq 8]
> [    0.150000] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.150016] pnp 00:05: [io  0x0061]
> [    0.150082] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
> [    0.150101] pnp 00:06: [io  0x0060]
> [    0.150105] pnp 00:06: [io  0x0064]
> [    0.150116] pnp 00:06: [irq 1]
> [    0.150181] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
> [    0.150229] pnp 00:07: [irq 12]
> [    0.150295] pnp 00:07: Plug and Play ACPI device, IDs SYN1b20 SYN1b00 =
SYN0002 PNP0f13 (active)
> [    0.150347] pnp 00:08: [io  0x0022-0x0023]
> [    0.150352] pnp 00:08: [io  0x002e-0x002f]
> [    0.150356] pnp 00:08: [io  0x0068]
> [    0.150360] pnp 00:08: [io  0x006c]
> [    0.150364] pnp 00:08: [io  0x0072-0x0073]
> [    0.150368] pnp 00:08: [io  0x1080]
> [    0.150372] pnp 00:08: [io  0x00b0-0x00b1]
> [    0.150376] pnp 00:08: [io  0x0092]
> [    0.150380] pnp 00:08: [io  0x0220-0x022f]
> [    0.150384] pnp 00:08: [io  0x040b]
> [    0.150388] pnp 00:08: [io  0x04d0-0x04d1]
> [    0.150392] pnp 00:08: [io  0x04d6]
> [    0.150396] pnp 00:08: [io  0x0530-0x0537]
> [    0.150400] pnp 00:08: [io  0x0c00-0x0c01]
> [    0.150404] pnp 00:08: [io  0x0c14]
> [    0.150408] pnp 00:08: [io  0x0c50-0x0c52]
> [    0.150412] pnp 00:08: [io  0x0c6c]
> [    0.150416] pnp 00:08: [io  0x0c6f]
> [    0.150420] pnp 00:08: [io  0x0cd0-0x0cd1]
> [    0.150427] pnp 00:08: [io  0x0cd2-0x0cd3]
> [    0.150431] pnp 00:08: [io  0x0cd4-0x0cd5]
> [    0.150436] pnp 00:08: [io  0x0cd6-0x0cd7]
> [    0.150440] pnp 00:08: [io  0x0cd8-0x0cdf]
> [    0.150444] pnp 00:08: [io  0x8000-0x805f]
> [    0.150449] pnp 00:08: [io  0x8100-0x81ff window]
> [    0.150453] pnp 00:08: [io  0x8200-0x82ff window]
> [    0.150458] pnp 00:08: [io  0x0f40-0x0f47]
> [    0.150462] pnp 00:08: [io  0x087f]
> [    0.150595] system 00:08: [io  0x1080] has been reserved
> [    0.150602] system 00:08: [io  0x0220-0x022f] has been reserved
> [    0.150607] system 00:08: [io  0x040b] has been reserved
> [    0.150613] system 00:08: [io  0x04d0-0x04d1] has been reserved
> [    0.150618] system 00:08: [io  0x04d6] has been reserved
> [    0.150624] system 00:08: [io  0x0530-0x0537] has been reserved
> [    0.150629] system 00:08: [io  0x0c00-0x0c01] has been reserved
> [    0.150635] system 00:08: [io  0x0c14] has been reserved
> [    0.150640] system 00:08: [io  0x0c50-0x0c52] has been reserved
> [    0.150646] system 00:08: [io  0x0c6c] has been reserved
> [    0.150651] system 00:08: [io  0x0c6f] has been reserved
> [    0.150657] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
> [    0.150662] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
> [    0.150668] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
> [    0.150674] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
> [    0.150679] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
> [    0.150685] system 00:08: [io  0x8000-0x805f] has been reserved
> [    0.150691] system 00:08: [io  0x8100-0x81ff window] has been reserved
> [    0.150697] system 00:08: [io  0x8200-0x82ff window] has been reserved
> [    0.150703] system 00:08: [io  0x0f40-0x0f47] has been reserved
> [    0.150708] system 00:08: [io  0x087f] has been reserved
> [    0.150715] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.150813] pnp 00:09: [mem 0x000e0000-0x000fffff]
> [    0.150818] pnp 00:09: [mem 0xfff00000-0xffffffff]
> [    0.150823] pnp 00:09: [mem 0x00000000-0xffffffffffffffff disabled]
> [    0.150828] pnp 00:09: [mem 0xff800000-0xff80ffff]
> [    0.150833] pnp 00:09: [mem 0xf0609900-0xf06098ff disabled]
> [    0.150926] system 00:09: [mem 0x000e0000-0x000fffff] could not be res=
erved
> [    0.150932] system 00:09: [mem 0xfff00000-0xffffffff] has been reserve=
d
> [    0.150938] system 00:09: [mem 0xff800000-0xff80ffff] has been reserve=
d
> [    0.150945] system 00:09: Plug and Play ACPI device, IDs PNP0c01 (acti=
ve)
> [    0.151100] pnp 00:0a: [mem 0xfed00000-0xfed003ff]
> [    0.151164] pnp 00:0a: Plug and Play ACPI device, IDs PNP0103 (active)
> [    0.151214] pnp: PnP ACPI: found 11 devices
> [    0.151218] ACPI: ACPI bus type pnp unregistered
> [    0.151224] PnPBIOS: Disabled by ACPI PNP
> [    0.189669] PCI: max bus depth: 1 pci_try_num: 2
> [    0.189720] pci 0000:00:05.0: BAR 14: assigned [mem 0x80000000-0x800ff=
fff]
> [    0.189727] pci 0000:00:01.0: PCI bridge to [bus 01-01]
> [    0.189732] pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
> [    0.189738] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf01fff=
ff]
> [    0.189745] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffff=
ff 64bit pref]
> [    0.189754] pci 0000:03:00.0: BAR 6: assigned [mem 0xcfd00000-0xcfd0ff=
ff pref]
> [    0.189760] pci 0000:00:05.0: PCI bridge to [bus 03-03]
> [    0.189765] pci 0000:00:05.0:   bridge window [io  0xa000-0xafff]
> [    0.189771] pci 0000:00:05.0:   bridge window [mem 0x80000000-0x800fff=
ff]
> [    0.189777] pci 0000:00:05.0:   bridge window [mem 0xcfd00000-0xcfdfff=
ff 64bit pref]
> [    0.189785] pci 0000:00:06.0: PCI bridge to [bus 04-04]
> [    0.189791] pci 0000:00:06.0:   bridge window [mem 0xf0200000-0xf02fff=
ff]
> [    0.189799] pci 0000:00:14.4: PCI bridge to [bus 09-09]
> [    0.189829] pci 0000:00:05.0: setting latency timer to 64
> [    0.189837] pci 0000:00:06.0: setting latency timer to 64
> [    0.189848] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000bffff]
> [    0.189853] pci_bus 0000:00: resource 5 [mem 0x000ce000-0x000cffff]
> [    0.189858] pci_bus 0000:00: resource 6 [mem 0x000d2000-0x000d3fff]
> [    0.189863] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d5fff]
> [    0.189868] pci_bus 0000:00: resource 8 [mem 0x000d6000-0x000d7fff]
> [    0.189873] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000d9fff]
> [    0.189878] pci_bus 0000:00: resource 10 [mem 0x000da000-0x000dbfff]
> [    0.189883] pci_bus 0000:00: resource 11 [mem 0x000dc000-0x000ddfff]
> [    0.189888] pci_bus 0000:00: resource 12 [mem 0x000de000-0x000dffff]
> [    0.189893] pci_bus 0000:00: resource 13 [mem 0x000e0000-0x000e1fff]
> [    0.189898] pci_bus 0000:00: resource 14 [mem 0x000e2000-0x000e3fff]
> [    0.189903] pci_bus 0000:00: resource 15 [mem 0x80000000-0xdfffffff]
> [    0.189908] pci_bus 0000:00: resource 16 [mem 0xf0000000-0xffffffff]
> [    0.189913] pci_bus 0000:00: resource 17 [io  0x0000-0x0cf7]
> [    0.189918] pci_bus 0000:00: resource 18 [io  0x0d00-0xffff]
> [    0.189923] pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
> [    0.189928] pci_bus 0000:01: resource 1 [mem 0xf0000000-0xf01fffff]
> [    0.189933] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64b=
it pref]
> [    0.189939] pci_bus 0000:03: resource 0 [io  0xa000-0xafff]
> [    0.189944] pci_bus 0000:03: resource 1 [mem 0x80000000-0x800fffff]
> [    0.189949] pci_bus 0000:03: resource 2 [mem 0xcfd00000-0xcfdfffff 64b=
it pref]
> [    0.189955] pci_bus 0000:04: resource 1 [mem 0xf0200000-0xf02fffff]
> [    0.189960] pci_bus 0000:09: resource 4 [mem 0x000a0000-0x000bffff]
> [    0.189965] pci_bus 0000:09: resource 5 [mem 0x000ce000-0x000cffff]
> [    0.189970] pci_bus 0000:09: resource 6 [mem 0x000d2000-0x000d3fff]
> [    0.189975] pci_bus 0000:09: resource 7 [mem 0x000d4000-0x000d5fff]
> [    0.189980] pci_bus 0000:09: resource 8 [mem 0x000d6000-0x000d7fff]
> [    0.189985] pci_bus 0000:09: resource 9 [mem 0x000d8000-0x000d9fff]
> [    0.189990] pci_bus 0000:09: resource 10 [mem 0x000da000-0x000dbfff]
> [    0.189995] pci_bus 0000:09: resource 11 [mem 0x000dc000-0x000ddfff]
> [    0.190001] pci_bus 0000:09: resource 12 [mem 0x000de000-0x000dffff]
> [    0.190006] pci_bus 0000:09: resource 13 [mem 0x000e0000-0x000e1fff]
> [    0.190011] pci_bus 0000:09: resource 14 [mem 0x000e2000-0x000e3fff]
> [    0.190016] pci_bus 0000:09: resource 15 [mem 0x80000000-0xdfffffff]
> [    0.190021] pci_bus 0000:09: resource 16 [mem 0xf0000000-0xffffffff]
> [    0.190026] pci_bus 0000:09: resource 17 [io  0x0000-0x0cf7]
> [    0.190030] pci_bus 0000:09: resource 18 [io  0x0d00-0xffff]
> [    0.190111] NET: Registered protocol family 2
> [    0.190216] IP route cache hash table entries: 32768 (order: 5, 131072=
 bytes)
> [    0.190727] TCP established hash table entries: 131072 (order: 8, 1048=
576 bytes)
> [    0.191812] TCP bind hash table entries: 65536 (order: 7, 524288 bytes=
)
> [    0.192415] TCP: Hash tables configured (established 131072 bind 65536=
)
> [    0.192420] TCP reno registered
> [    0.192427] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.192450] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.192617] NET: Registered protocol family 1
> [    0.192864] pci 0000:01:05.0: Boot video device
> [    0.192876] PCI: CLS 32 bytes, default 64
> [    0.192986] Unpacking initramfs...
> [    0.706882] Freeing initrd memory: 9864k freed
> [    0.715672] Simple Boot Flag at 0x36 set to 0x1
> [    0.716324] audit: initializing netlink socket (disabled)
> [    0.716346] type=3D2000 audit(1357473241.712:1): initialized
> [    0.744565] highmem bounce pool size: 64 pages
> [    0.744576] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.745134] VFS: Disk quotas dquot_6.5.2
> [    0.745184] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.745302] msgmni has been set to 1739
> [    0.745557] alg: No test for stdrng (krng)
> [    0.745598] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 253)
> [    0.745604] io scheduler noop registered
> [    0.745608] io scheduler deadline registered
> [    0.745621] io scheduler cfq registered (default)
> [    0.745773] pcieport 0000:00:05.0: setting latency timer to 64
> [    0.745817] pcieport 0000:00:05.0: irq 40 for MSI/MSI-X
> [    0.745890] pcieport 0000:00:06.0: setting latency timer to 64
> [    0.745922] pcieport 0000:00:06.0: irq 41 for MSI/MSI-X
> [    0.746046] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    0.746099] pciehp: PCI Express Hot Plug Controller Driver version: 0.=
4
> [    0.746103] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.746604] ERST: Table is not found!
> [    0.746607] GHES: HEST is not enabled!
> [    0.746631] isapnp: Scanning for PnP cards...
> [    1.103367] isapnp: No Plug & Play device found
> [    1.103469] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.104457] Linux agpgart interface v0.103
> [    1.105052] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at=
 0x60,0x64 irq 1,12
> [    1.111606] i8042: Detected active multiplexing controller, rev 1.1
> [    1.115208] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.115220] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [    1.115283] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [    1.115335] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [    1.115386] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [    1.115605] mousedev: PS/2 mouse device common for all mice
> [    1.115688] rtc_cmos 00:04: RTC can wake from S4
> [    1.115837] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
> [    1.115875] rtc0: alarms up to one month, 114 bytes nvram, hpet irqs
> [    1.115897] cpuidle: using governor ladder
> [    1.115901] cpuidle: using governor menu
> [    1.116347] TCP cubic registered
> [    1.116388] NET: Registered protocol family 10
> [    1.117335] Mobile IPv6
> [    1.117340] NET: Registered protocol family 17
> [    1.117347] Registering the dns_resolver key type
> [    1.117387] Using IPI No-Shortcut mode
> [    1.117549] PM: Hibernation image not present or could not be loaded.
> [    1.117567] registered taskstats version 1
> [    1.118169] rtc_cmos 00:04: setting system clock to 2013-01-06 11:54:0=
4 UTC (1357473244)
> [    1.118263] Initializing network drop monitor service
> [    1.118448] Freeing unused kernel memory: 416k freed
> [    1.118890] Write protecting the kernel text: 2848k
> [    1.118945] Write protecting the kernel read-only data: 1092k
> [    1.118949] NX-protecting the kernel data: 3296k
> [    1.135008] udevd[44]: starting version 175
> [    1.138573] input: AT Translated Set 2 keyboard as /devices/platform/i=
8042/serio0/input/input0
> [    1.332166] thermal LNXTHERM:00: registered as thermal_zone0
> [    1.332172] ACPI: Thermal Zone [THRM] (54 C)
> [    1.341198] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    1.341267] r8169 0000:03:00.0: setting latency timer to 64
> [    1.341326] r8169 0000:03:00.0: irq 42 for MSI/MSI-X
> [    1.342241] r8169 0000:03:00.0: eth0: RTL8102e at 0xf820c000, 00:23:8b=
:ef:35:34, XID 04c00000 IRQ 42
> [    1.395798] SCSI subsystem initialized
> [    1.427008] usbcore: registered new interface driver usbfs
> [    1.427060] usbcore: registered new interface driver hub
> [    1.448134] usbcore: registered new device driver usb
> [    1.449061] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.449136] ehci_hcd 0000:00:13.5: EHCI Host Controller
> [    1.449181] ehci_hcd 0000:00:13.5: new USB bus registered, assigned bu=
s number 1
> [    1.449233] ehci_hcd 0000:00:13.5: applying AMD SB600/SB700 USB freeze=
 workaround
> [    1.449252] ehci_hcd 0000:00:13.5: debug port 1
> [    1.449291] ehci_hcd 0000:00:13.5: irq 19, io mem 0xf0508400
> [    1.469991] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00
> [    1.470081] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
> [    1.470087] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    1.470092] usb usb1: Product: EHCI Host Controller
> [    1.470096] usb usb1: Manufacturer: Linux 3.2.0-4-686-pae ehci_hcd
> [    1.470100] usb usb1: SerialNumber: 0000:00:13.5
> [    1.470330] hub 1-0:1.0: USB hub found
> [    1.470341] hub 1-0:1.0: 10 ports detected
> [    1.471146] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.471211] ohci_hcd 0000:00:13.0: OHCI Host Controller
> [    1.471229] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bu=
s number 2
> [    1.471278] ohci_hcd 0000:00:13.0: irq 16, io mem 0xf0504000
> [    1.524122] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    1.524130] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    1.524136] usb usb2: Product: OHCI Host Controller
> [    1.524140] usb usb2: Manufacturer: Linux 3.2.0-4-686-pae ohci_hcd
> [    1.524144] usb usb2: SerialNumber: 0000:00:13.0
> [    1.524379] hub 2-0:1.0: USB hub found
> [    1.524394] hub 2-0:1.0: 2 ports detected
> [    1.524564] ohci_hcd 0000:00:13.1: OHCI Host Controller
> [    1.524581] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bu=
s number 3
> [    1.524631] ohci_hcd 0000:00:13.1: irq 17, io mem 0xf0505000
> [    1.540304] libata version 3.00 loaded.
> [    1.580099] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    1.580106] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    1.580112] usb usb3: Product: OHCI Host Controller
> [    1.580116] usb usb3: Manufacturer: Linux 3.2.0-4-686-pae ohci_hcd
> [    1.580120] usb usb3: SerialNumber: 0000:00:13.1
> [    1.580382] hub 3-0:1.0: USB hub found
> [    1.580397] hub 3-0:1.0: 2 ports detected
> [    1.580584] ohci_hcd 0000:00:13.3: OHCI Host Controller
> [    1.580602] ohci_hcd 0000:00:13.3: new USB bus registered, assigned bu=
s number 4
> [    1.580633] ohci_hcd 0000:00:13.3: irq 17, io mem 0xf0506000
> [    1.636099] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    1.636107] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    1.636113] usb usb4: Product: OHCI Host Controller
> [    1.636117] usb usb4: Manufacturer: Linux 3.2.0-4-686-pae ohci_hcd
> [    1.636121] usb usb4: SerialNumber: 0000:00:13.3
> [    1.636372] hub 4-0:1.0: USB hub found
> [    1.636387] hub 4-0:1.0: 2 ports detected
> [    1.636562] ohci_hcd 0000:00:13.4: OHCI Host Controller
> [    1.636580] ohci_hcd 0000:00:13.4: new USB bus registered, assigned bu=
s number 5
> [    1.636628] ohci_hcd 0000:00:13.4: irq 18, io mem 0xf0507000
> [    1.692090] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    1.692098] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    1.692103] usb usb5: Product: OHCI Host Controller
> [    1.692107] usb usb5: Manufacturer: Linux 3.2.0-4-686-pae ohci_hcd
> [    1.692111] usb usb5: SerialNumber: 0000:00:13.4
> [    1.692366] hub 5-0:1.0: USB hub found
> [    1.692382] hub 5-0:1.0: 2 ports detected
> [    1.692786] ahci 0000:00:12.0: version 3.0
> [    1.692867] ahci 0000:00:12.0: controller can't do 64bit DMA, forcing =
32bit
> [    1.693043] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps =
0xf impl SATA mode
> [    1.693051] ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio=
 slum part ccc=20
> [    1.698013] scsi0 : ahci
> [    1.702951] scsi1 : ahci
> [    1.703243] scsi2 : ahci
> [    1.703441] scsi3 : ahci
> [    1.703694] ata1: SATA max UDMA/133 abar m1024@0xf0508000 port 0xf0508=
100 irq 22
> [    1.703701] ata2: SATA max UDMA/133 abar m1024@0xf0508000 port 0xf0508=
180 irq 22
> [    1.703708] ata3: SATA max UDMA/133 abar m1024@0xf0508000 port 0xf0508=
200 irq 22
> [    1.703715] ata4: SATA max UDMA/133 abar m1024@0xf0508000 port 0xf0508=
280 irq 22
> [    1.704100] pata_atiixp 0000:00:14.1: setting latency timer to 64
> [    1.705130] scsi4 : pata_atiixp
> [    1.705652] scsi5 : pata_atiixp
> [    1.706454] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x8420 i=
rq 14
> [    1.706459] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x8428 i=
rq 15
> [    1.712030] Refined TSC clocksource calibration: 1197.000 MHz.
> [    1.712039] Switching to clocksource tsc
> [    1.836019] usb 1-4: new high-speed USB device number 3 using ehci_hcd
> [    2.001899] usb 1-4: New USB device found, idVendor=3D04f2, idProduct=
=3Db175
> [    2.001904] usb 1-4: New USB device strings: Mfr=3D2, Product=3D1, Ser=
ialNumber=3D3
> [    2.001909] usb 1-4: Product: CNF9011
> [    2.001913] usb 1-4: Manufacturer: Chicony Electronics Co., Ltd.
> [    2.001917] usb 1-4: SerialNumber: SN0001
> [    2.025991] ata3: SATA link down (SStatus 0 SControl 300)
> [    2.026043] ata2: SATA link down (SStatus 0 SControl 300)
> [    2.026085] ata4: SATA link down (SStatus 0 SControl 300)
> [    2.136024] usb 3-1: new low-speed USB device number 2 using ohci_hcd
> [    2.196013] ata1: softreset failed (device not ready)
> [    2.196066] ata1: applying PMP SRST workaround and retrying
> [    2.301075] usb 3-1: New USB device found, idVendor=3D2188, idProduct=
=3D0ae1
> [    2.301081] usb 3-1: New USB device strings: Mfr=3D0, Product=3D1, Ser=
ialNumber=3D0
> [    2.301086] usb 3-1: Product:  USB OPTICAL MOUSE
> [    2.368038] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.414533] ata1.00: ATA-8: TOSHIBA MK2555GSX, FG001J, max UDMA/100
> [    2.414540] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/=
32), AA
> [    2.414547] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
> [    2.415334] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
> [    2.415340] ata1.00: configured for UDMA/100
> [    2.415536] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK2555GS =
FG00 PQ: 0 ANSI: 5
> [    2.433595] input:  USB OPTICAL MOUSE as /devices/pci0000:00/0000:00:1=
3.1/usb3/3-1/3-1:1.0/input/input1
> [    2.433859] generic-usb 0003:2188:0AE1.0001: input,hidraw0: USB HID v1=
.11 Mouse [ USB OPTICAL MOUSE] on usb-0000:00:13.1-1/input0
> [    2.433896] usbcore: registered new interface driver usbhid
> [    2.433900] usbhid: USB HID core driver
> [    2.436238] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 =
GB/232 GiB)
> [    2.436319] sd 0:0:0:0: [sda] Write Protect is off
> [    2.436325] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    2.436360] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [    2.540074]  sda: sda1 < sda5 sda6 sda7 sda8 > sda2
> [    2.541112] sd 0:0:0:0: [sda] Attached SCSI disk
> [    2.545066] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    3.261457] EXT4-fs (sda6): mounted filesystem with ordered data mode.=
 Opts: (null)
> [   10.170094] udevd[312]: starting version 175
> [   10.511409] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0=
D:00/input/input2
> [   10.511540] ACPI: Lid Switch [LID]
> [   10.511661] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0=
C0E:00/input/input3
> [   10.511669] ACPI: Sleep Button [SLPB]
> [   10.511788] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0=
C0C:00/input/input4
> [   10.511794] ACPI: Power Button [PWRB]
> [   10.511936] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input5
> [   10.511942] ACPI: Power Button [PWRF]
> [   10.551658] wmi: Mapper loaded
> [   10.570205] ACPI: AC Adapter [ACAD] (on-line)
> [   10.581771] ACPI: Battery Slot [BAT1] (battery present)
> [   10.590208] Marking TSC unstable due to TSC halts in idle
> [   10.590235] ACPI: acpi_idle registered with cpuidle
> [   10.607187] Switching to clocksource hpet
> [   10.721848] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
> [   10.755699] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0x8410,=
 revision 0
> [   10.798155] udevd[362]: renamed network interface eth0 to eth1
> [   10.840317] SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
> [   10.840447] SP5100 TCO timer: mmio address 0xfec000f0 already in use
> [   10.858171] k8temp 0000:00:18.3: Temperature readouts might be wrong -=
 check erratum #141
> [   10.963905] input: PC Speaker as /devices/platform/pcspkr/input/input6
> [   10.978061] cfg80211: Calling CRDA to update world regulatory domain
> [   11.111045] acerhdf: Acer Aspire One Fan driver, v.0.5.24
> [   11.111060] acerhdf: Fan control off, to enable do:
> [   11.111064] acerhdf: echo -n "enabled" > /sys/class/thermal/thermal_zo=
ne0/mode
> [   11.118406] powernow-k8: Found 1 AMD Athlon(tm) Processor L110 (1 cpu =
cores) (version 2.20.00)
> [   11.188343] [drm] Initialized drm 1.1.0 20060810
> [   11.263240] Linux media interface: v0.10
> [   11.275446] Linux video capture interface: v2.00
> [   11.324846] uvcvideo: Found UVC 1.00 device CNF9011 (04f2:b175)
> [   11.528501] acer_wmi: Acer Laptop ACPI-WMI Extras
> [   11.534387] ath9k 0000:04:00.0: setting latency timer to 64
> [   11.585928] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1=
4.2/input/input7
> [   11.590297] input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/=
sound/card0/input8
> [   11.590456] input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00=
:14.2/sound/card0/input9
> [   11.592712] ath: EEPROM regdomain: 0x65
> [   11.592716] ath: EEPROM indicates we should expect a direct regpair ma=
p
> [   11.592724] ath: Country alpha2 being used: 00
> [   11.592727] ath: Regpair used: 0x65
> [   11.600904] ieee80211 phy0: Selected rate control algorithm 'ath9k_rat=
e_control'
> [   11.602065] Registered led device: ath9k-phy0
> [   11.602080] ieee80211 phy0: Atheros AR9285 Rev:2 mem=3D0xf8740000, irq=
=3D18
> [   11.603356] acer_wmi: Function bitmap for Communication Device: 0x7
> [   11.630585] powernow-k8: PST out of sequence
> [   11.630939] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08=
:00/device:17/LNXVIDEO:00/input/input10
> [   11.631947] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: =
no)
> [   11.633016] [drm] radeon defaulting to kernel modesetting.
> [   11.633026] [drm] radeon kernel modesetting enabled.
> [   11.634766] [drm] initializing kernel modesetting (RS690 0x1002:0x791F=
 0x1025:0x028C).
> [   11.634824] [drm] register mmio base: 0xF0100000
> [   11.634828] [drm] register mmio size: 65536
> [   11.635165] ATOM BIOS: ATI
> [   11.635203] radeon 0000:01:05.0: VRAM: 384M 0x0000000068000000 - 0x000=
000007FFFFFFF (384M used)
> [   11.635210] radeon 0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x0000=
00009FFFFFFF
> [   11.635245] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010)=
.
> [   11.635249] [drm] Driver supports precise vblank timestamp query.
> [   11.635292] radeon 0000:01:05.0: irq 43 for MSI/MSI-X
> [   11.635299] radeon 0000:01:05.0: radeon: using MSI.
> [   11.635330] [drm] radeon: irq initialized.
> [   11.635642] [drm] Detected VRAM RAM=3D384M, BAR=3D256M
> [   11.635649] [drm] RAM width 128bits DDR
> [   11.646659] input: CNF9011 as /devices/pci0000:00/0000:00:13.5/usb1/1-=
4/1-4:1.0/input/input11
> [   11.646829] usbcore: registered new interface driver uvcvideo
> [   11.646834] USB Video Class driver (1.1.1)
> [   11.647473] [TTM] Zone  kernel: Available graphics memory: 445434 kiB.
> [   11.647478] [TTM] Zone highmem: Available graphics memory: 906654 kiB.
> [   11.647482] [TTM] Initializing pool allocator.
> [   11.647528] [drm] radeon: 384M of VRAM memory ready
> [   11.647532] [drm] radeon: 512M of GTT memory ready.
> [   11.647562] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   11.727091] [drm] radeon: 1 quad pipes, 1 z pipes initialized.
> [   11.735523] [drm] PCIE GART of 512M enabled (table at 0x0000000033E800=
00).
> [   11.803184] radeon 0000:01:05.0: WB enabled
> [   11.803277] [drm] Loading RS690/RS740 Microcode
> [   12.071594] cfg80211: World regulatory domain updated:
> [   12.071602] cfg80211:     (start_freq - end_freq @ bandwidth), (max_an=
tenna_gain, max_eirp)
> [   12.071610] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz), (30=
0 mBi, 2000 mBm)
> [   12.071616] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz), (30=
0 mBi, 2000 mBm)
> [   12.071621] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz), (30=
0 mBi, 2000 mBm)
> [   12.071626] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz), (30=
0 mBi, 2000 mBm)
> [   12.071632] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz), (30=
0 mBi, 2000 mBm)
> [   12.166487] platform radeon_cp.0: firmware: agent loaded radeon/RS690_=
cp.bin into memory
> [   12.166860] [drm] radeon: ring at 0x0000000080001000
> [   12.166882] [drm] ring test succeeded in 1 usecs
> [   12.167095] [drm] radeon: ib pool ready.
> [   12.167196] [drm] ib test succeeded in 0 usecs
> [   12.167594] [drm] Radeon Display Connectors
> [   12.167598] [drm] Connector 0:
> [   12.167601] [drm]   VGA
> [   12.167605] [drm]   DDC: 0x7e50 0x7e40 0x7e54 0x7e44 0x7e58 0x7e48 0x7=
e5c 0x7e4c
> [   12.167609] [drm]   Encoders:
> [   12.167612] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [   12.167615] [drm] Connector 1:
> [   12.167618] [drm]   LVDS
> [   12.167622] [drm]   DDC: 0x7e40 0x7e50 0x7e44 0x7e54 0x7e48 0x7e58 0x7=
e4c 0x7e5c
> [   12.167626] [drm]   Encoders:
> [   12.167629] [drm]     LCD1: INTERNAL_LVTM1
> [   12.167653] [drm] radeon: power management initialized
> [   12.378898] psmouse serio2: synaptics: Touchpad model: 1, fw: 7.2, id:=
 0x1c0b1, caps: 0xd04733/0xa40000/0xa0000
> [   12.426768] input: SynPS/2 Synaptics TouchPad as /devices/platform/i80=
42/serio2/input/input12
> [   12.634977] [drm] fb mappable at 0xD0040000
> [   12.634983] [drm] vram apper at 0xD0000000
> [   12.634987] [drm] size 4325376
> [   12.634990] [drm] fb depth is 24
> [   12.634993] [drm]    pitch is 5632
> [   12.635229] fbcon: radeondrmfb (fb0) is primary device
> [   13.001222] Console: switching to colour frame buffer device 170x48
> [   13.013658] fb0: radeondrmfb frame buffer device
> [   13.013661] drm: registered panic notifier
> [   13.013674] [drm] Initialized radeon 2.12.0 20080528 for 0000:01:05.0 =
on minor 0
> [   13.593908] Adding 2293756k swap on /dev/sda8.  Priority:-1 extents:1 =
across:2293756k=20
> [   13.622518] EXT4-fs (sda6): re-mounted. Opts: errors=3Dremount-ro
> [   13.803525] fuse init (API version 7.17)
> [   13.833193] loop: module loaded
> [   15.532694] EXT4-fs (sda7): mounted filesystem with ordered data mode.=
 Opts: errors=3Dremount-ro
> [   17.616306] r8169 0000:03:00.0: eth1: link down
> [   17.616318] r8169 0000:03:00.0: eth1: link down
> [   17.620937] ADDRCONF(NETDEV_UP): eth1: link is not ready
> [   18.199570] powernow-k8: Found 1 AMD Athlon(tm) Processor L110 (1 cpu =
cores) (version 2.20.00)
> [   18.210327] powernow-k8: PST out of sequence
>=20
>=20
> $ lspci
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] nee ATI RS690 Host Brid=
ge
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RS690 PCI to PCI=
 Bridge (Internal gfx)
> 00:05.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RS690 PCI to PCI=
 Bridge (PCI Express Port 1)
> 00:06.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RS690 PCI to PCI=
 Bridge (PCI Express Port 2)
> 00:12.0 SATA controller: Advanced Micro Devices [AMD] nee ATI SB600 Non-R=
aid-5 SATA
> 00:13.0 USB controller: Advanced Micro Devices [AMD] nee ATI SB600 USB (O=
HCI0)
> 00:13.1 USB controller: Advanced Micro Devices [AMD] nee ATI SB600 USB (O=
HCI1)
> 00:13.3 USB controller: Advanced Micro Devices [AMD] nee ATI SB600 USB (O=
HCI3)
> 00:13.4 USB controller: Advanced Micro Devices [AMD] nee ATI SB600 USB (O=
HCI4)
> 00:13.5 USB controller: Advanced Micro Devices [AMD] nee ATI SB600 USB Co=
ntroller (EHCI)
> 00:14.0 SMBus: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controlle=
r (rev 14)
> 00:14.1 IDE interface: Advanced Micro Devices [AMD] nee ATI SB600 IDE
> 00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (=
Intel HDA)
> 00:14.3 ISA bridge: Advanced Micro Devices [AMD] nee ATI SB600 PCI to LPC=
 Bridge
> 00:14.4 PCI bridge: Advanced Micro Devices [AMD] nee ATI SBx00 PCI to PCI=
 Bridge
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] H=
yperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] A=
ddress Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] D=
RAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] M=
iscellaneous Control
> 01:05.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI R=
S690M [Radeon X1200 Series]
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/RTL=
8102E PCI Express Fast Ethernet controller (rev 02)
> 04:00.0 Network controller: Atheros Communications Inc. AR9285 Wireless N=
etwork Adapter (PCI-Express) (rev 01)
>=20
>=20

--=20
Ben Hutchings
Kids!  Bringing about Armageddon can be dangerous.  Do not attempt it in
your own home. - Terry Pratchett and Neil Gaiman, `Good Omens'

--=-8OpOzLXZ9HJ0t3O51Sis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUr9UTee/yOyVhhEJAQqYrxAAwqZjOJQBeRlgUYVvXpunEgGlJ38hZWVF
HDWOEaC+tAUIAThB2Ij7XJTbWgr61gFkfNB9yuTkKFkLn/5WieUCT8Wgbb828N76
MgIKyiCLXx1I0jvr25ek9JgbCmwhfs3U65S3lcOiB8AQhyM0aiBV++JNL9GbhT0U
Z1/uMSJ+qTzFz2buNfZ7lqXGscKGsIfXRv+C33/LHa3oRcDRM7kOFm0QGLTe2HT3
8bDs4P0SyPSP/qKV9j2ax+GhfCcQbZBrt4IzhG/maVVNu8Hbzj5K0W0qtSogfRTr
U6busGwYiGQ4E7Qw84cFFv15Yp4JhdkzFn63MQr3YBw7yFCcPylEi5M05ZUxgQv9
G/7YrcxdAjf1OLaN+BicKDrMr9K7HSV1GgcgDWs6/xdG52DvmiWZRPgAr34cKX9v
iEveEUwiXDGDmxfCmmnSUdDGOL0ByTOwXxWFvIluGCFfkDM4MTHwGZsyRqhY395h
1G4JPnIh7LND7Nqf67QsEDHUJnTntLAxP6XK0s0IBI0zFCQ6CCH8jgflW5McP4Vo
+P6VaRZPU5xmmDLsU3m8EerZPs2Bgfc8ko24yfR1FNjeHMjXHhWFluVzLu6iAdSy
+a94iTz+xi+zwAvxc03IK5UkBo6tOAsAVCKzRDE5Uk/xF9ynr7zDnAysNm8/bXNg
voWVYk3KocM=
=+Ijz
-----END PGP SIGNATURE-----

--=-8OpOzLXZ9HJ0t3O51Sis--
