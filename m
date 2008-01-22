From: Len Brown <lenb@kernel.org>
Subject: BUG: soft lockup - CPU#0 stuck for 186s (Re: dmidecode (Samsung R40plus))
Date: Mon, 21 Jan 2008 23:45:35 -0500
Message-ID: <200801212345.35795.lenb@kernel.org>
References: <200712282201.42665.ulrich.ivens@gmx.de> <200801210005.22146.lenb@kernel.org> <200801212232.45612.ulrich.ivens@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58652 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbYAVEpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 23:45:52 -0500
In-Reply-To: <200801212232.45612.ulrich.ivens@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ulrich Ivens <ulrich.ivens@gmx.de>
Cc: linux-acpi@vger.kernel.org

> I downloaded the Vanilla Kernel 2.6.24-rc8, compiled an installed it.=
 It=20
> works, but it is the same with it. My Ubuntu need up to 6 Minutes to =
boot.

that is because twice you locked up.

Did this same failure happen back in 2.6.22?
What is the most recent kernel where this did not happen?

I don't understand this message:
> [  344.253937] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'

Since 2.6.24-rc8 does not contain that symbol.

maybe you should boot a static 2.6.24-rc8 kernel with no drivers
and no initrd and see how that works?

thanks,
-Len

> [ =C2=A0 =C2=A00.000000] Linux version 2.6.24-rc8 (root@ubuntunoteboo=
k) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #=
1 SMP Mon Jan 21 20:07:10 CET 2008
> [ =C2=A0 =C2=A00.000000] BIOS-provided physical RAM map:
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000000000000 - 00000000=
0009dc00 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 000000000009dc00 - 00000000=
000a0000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000000ce000 - 00000000=
000d0000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000000dc000 - 00000000=
000e0000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000000e4000 - 00000000=
00100000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000000100000 - 00000000=
37e90000 (usable)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000037e90000 - 00000000=
37e9e000 (ACPI data)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000037e9e000 - 00000000=
37e9f000 (ACPI NVS)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 0000000037e9f000 - 00000000=
38000000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000e0000000 - 00000000=
f0000000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000fec00000 - 00000000=
fec10000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000fee00000 - 00000000=
fee01000 (reserved)
> [ =C2=A0 =C2=A00.000000] =C2=A0BIOS-e820: 00000000fff80000 - 00000001=
00000000 (reserved)
> [ =C2=A0 =C2=A00.000000] 0MB HIGHMEM available.
> [ =C2=A0 =C2=A00.000000] 894MB LOWMEM available.
> [ =C2=A0 =C2=A00.000000] found SMP MP-table at 000f7ea0
> [ =C2=A0 =C2=A00.000000] Entering add_active_range(0, 0, 229008) 0 en=
tries of 256 used
> [ =C2=A0 =C2=A00.000000] Zone PFN ranges:
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0 -> =C2=A0 =C2=A0 4096
> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal =C2=A0 =C2=A0 =C2=A0 4096 -> =C2=
=A0 229008
> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem =C2=A0 =C2=A0229008 -> =C2=A0=
 229008
> [ =C2=A0 =C2=A00.000000] Movable zone start PFN for each node
> [ =C2=A0 =C2=A00.000000] early_node_map[1] active PFN ranges
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 0: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0 -> =C2=A0 229008
> [ =C2=A0 =C2=A00.000000] On node 0 totalpages: 229008
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 32 pages used for memmap
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 0 pages reserved
> [ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 4064 pages, LIFO batch:0
> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 1757 pages used for memm=
ap
> [ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 223155 pages, LIFO batch=
:31
> [ =C2=A0 =C2=A00.000000] =C2=A0 HighMem zone: 0 pages used for memmap
> [ =C2=A0 =C2=A00.000000] =C2=A0 Movable zone: 0 pages used for memmap
> [ =C2=A0 =C2=A00.000000] DMI present.
> [ =C2=A0 =C2=A00.000000] ACPI: RSDP 000F7E70, 0014 (r0 PTLTD )
> [ =C2=A0 =C2=A00.000000] ACPI: RSDT 37E97718, 0044 (r1 SECCSD LH43STA=
R =C2=A06040000 =C2=A0LTP =C2=A0 =C2=A0 =C2=A0 =C2=A00)
> [ =C2=A0 =C2=A00.000000] ACPI: FACP 37E9DD4E, 0074 (r1 SEC =C2=A0 =C2=
=A0FIRENZE2 =C2=A06040000 SEC =C2=A0 =C2=A0 F4240)
> [ =C2=A0 =C2=A00.000000] ACPI: DSDT 37E98AE0, 526E (r1 =C2=A0 =C2=A0A=
TI =C2=A0 =C2=A0SB600 =C2=A06040000 INTL 20050228)
> [ =C2=A0 =C2=A00.000000] ACPI: FACS 37E9EFC0, 0040
> [ =C2=A0 =C2=A00.000000] ACPI: APIC 37E9DDC2, 0054 (r1 PTLTD =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 APIC =C2=A0 =C2=A06040000 =C2=A0LTP =C2=A0 =C2=A0=
 =C2=A0 =C2=A00)
> [ =C2=A0 =C2=A00.000000] ACPI: MCFG 37E9DE16, 003C (r1 PTLTD =C2=A0 =C2=
=A0MCFG =C2=A0 =C2=A06040000 =C2=A0LTP =C2=A0 =C2=A0 =C2=A0 =C2=A00)
> [ =C2=A0 =C2=A00.000000] ACPI: HPET 37E9DE52, 0038 (r1 PTLTD =C2=A0HP=
ETTBL =C2=A0 6040000 =C2=A0LTP =C2=A0 =C2=A0 =C2=A0 =C2=A01)
> [ =C2=A0 =C2=A00.000000] ACPI: SLIC 37E9DE8A, 0176 (r1 SECCSD LH43STA=
R =C2=A06040000 =C2=A0LTP =C2=A0 =C2=A0 =C2=A0 =C2=A00)
> [ =C2=A0 =C2=A00.000000] ACPI: SSDT 37E97D75, 025F (r1 =C2=A0PmRef =C2=
=A0Cpu0Tst =C2=A0 =C2=A0 3000 INTL 20050228)
> [ =C2=A0 =C2=A00.000000] ACPI: SSDT 37E97CCF, 00A6 (r1 =C2=A0PmRef =C2=
=A0Cpu1Tst =C2=A0 =C2=A0 3000 INTL 20050228)
> [ =C2=A0 =C2=A00.000000] ACPI: SSDT 37E9775C, 0573 (r1 =C2=A0PmRef =C2=
=A0 =C2=A0CpuPm =C2=A0 =C2=A0 3000 INTL 20050228)
> [ =C2=A0 =C2=A00.000000] ATI board detected. Disabling timer routing =
over 8254.
> [ =C2=A0 =C2=A00.000000] ACPI: PM-Timer IO Port: 0x8008
> [ =C2=A0 =C2=A00.000000] ACPI: Local APIC address 0xfee00000
> [ =C2=A0 =C2=A00.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] en=
abled)
> [ =C2=A0 =C2=A00.000000] Processor #0 6:14 APIC version 20
> [ =C2=A0 =C2=A00.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] en=
abled)
> [ =C2=A0 =C2=A00.000000] Processor #1 6:14 APIC version 20
> [ =C2=A0 =C2=A00.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lin=
t[0x1])
> [ =C2=A0 =C2=A00.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lin=
t[0x1])
> [ =C2=A0 =C2=A00.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] g=
si_base[0])
> [ =C2=A0 =C2=A00.000000] IOAPIC[0]: apic_id 2, version 33, address 0x=
fec00000, GSI 0-23
> [ =C2=A0 =C2=A00.000000] ACPI: IRQ9 used by override.
> [ =C2=A0 =C2=A00.000000] Enabling APIC mode: =C2=A0Flat. =C2=A0Using =
1 I/O APICs
> [ =C2=A0 =C2=A00.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
> [ =C2=A0 =C2=A00.000000] Using ACPI (MADT) for SMP configuration info=
rmation
> [ =C2=A0 =C2=A00.000000] Allocating PCI resources starting at 4000000=
0 (gap: 38000000:a8000000)
> [ =C2=A0 =C2=A00.000000] Built 1 zonelists in Zone order, mobility gr=
ouping on. =C2=A0Total pages: 227219
> [ =C2=A0 =C2=A00.000000] Kernel command line: root=3DUUID=3D62696e7b-=
6b0b-40fa-96fc-1dbb91d72f6c ro
> [ =C2=A0 =C2=A00.000000] mapped APIC to ffffb000 (fee00000)
> [ =C2=A0 =C2=A00.000000] mapped IOAPIC to ffffa000 (fec00000)
> [ =C2=A0 =C2=A00.000000] Enabling fast FPU save and restore... done.
> [ =C2=A0 =C2=A00.000000] Enabling unmasked SIMD FPU exception support=
=2E.. done.
> [ =C2=A0 =C2=A00.000000] Initializing CPU#0
> [ =C2=A0 =C2=A00.000000] PID hash table entries: 4096 (order: 12, 163=
84 bytes)
> [ =C2=A0 =C2=A00.000000] Detected 1729.210 MHz processor.
> [ =C2=A0 15.930021] Console: colour VGA+ 80x25
> [ =C2=A0 15.930024] console [tty0] enabled
> [ =C2=A0 15.933057] Dentry cache hash table entries: 131072 (order: 7=
, 524288 bytes)
> [ =C2=A0 15.933570] Inode-cache hash table entries: 65536 (order: 6, =
262144 bytes)
> [ =C2=A0 15.956565] Memory: 862332k/916032k available (2026k kernel c=
ode, 53072k reserved, 940k data, 336k init, 0k highmem)
> [ =C2=A0 15.956624] virtual kernel memory layout:
> [ =C2=A0 15.956625] =C2=A0 =C2=A0 fixmap =C2=A0: 0xfff4c000 - 0xfffff=
000 =C2=A0 ( 716 kB)
> [ =C2=A0 15.956626] =C2=A0 =C2=A0 pkmap =C2=A0 : 0xff800000 - 0xffc00=
000 =C2=A0 (4096 kB)
> [ =C2=A0 15.956628] =C2=A0 =C2=A0 vmalloc : 0xf8800000 - 0xff7fe000 =C2=
=A0 ( 111 MB)
> [ =C2=A0 15.956629] =C2=A0 =C2=A0 lowmem =C2=A0: 0xc0000000 - 0xf7e90=
000 =C2=A0 ( 894 MB)
> [ =C2=A0 15.956630] =C2=A0 =C2=A0 =C2=A0 .init : 0xc03eb000 - 0xc043f=
000 =C2=A0 ( 336 kB)
> [ =C2=A0 15.956631] =C2=A0 =C2=A0 =C2=A0 .data : 0xc02fabb3 - 0xc03e5=
d24 =C2=A0 ( 940 kB)
> [ =C2=A0 15.956632] =C2=A0 =C2=A0 =C2=A0 .text : 0xc0100000 - 0xc02fa=
bb3 =C2=A0 (2026 kB)
> [ =C2=A0 15.956971] Checking if this processor honours the WP bit eve=
n in supervisor mode... Ok.
> [ =C2=A0 15.957091] SLUB: Genslabs=3D11, HWalign=3D64, Order=3D0-1, M=
inObjects=3D4, CPUs=3D2, Nodes=3D1
> [ =C2=A0 15.957287] hpet clockevent registered
> [ =C2=A0 16.037262] Calibrating delay using timer specific routine.. =
3461.40 BogoMIPS (lpj=3D6922809)
> [ =C2=A0 16.037367] Security Framework initialized
> [ =C2=A0 16.037415] SELinux: =C2=A0Disabled at boot.
> [ =C2=A0 16.037469] Mount-cache hash table entries: 512
> [ =C2=A0 16.037632] CPU: After generic identify, caps: bfe9fbff 00000=
000 00000000 00000000 0000c189 00000000 00000000 00000000
> [ =C2=A0 16.037641] monitor/mwait feature present.
> [ =C2=A0 16.037685] using mwait in idle threads.
> [ =C2=A0 16.037730] CPU: L1 I cache: 32K, L1 D cache: 32K
> [ =C2=A0 16.037807] CPU: L2 cache: 2048K
> [ =C2=A0 16.037851] CPU: Physical Processor ID: 0
> [ =C2=A0 16.037894] CPU: Processor Core ID: 0
> [ =C2=A0 16.037936] CPU: After all inits, caps: bfe9fbff 00000000 000=
00000 00002940 0000c189 00000000 00000000 00000000
> [ =C2=A0 16.037945] Compat vDSO mapped to ffffe000.
> [ =C2=A0 16.037999] Checking 'hlt' instruction... OK.
> [ =C2=A0 16.053704] SMP alternatives: switching to UP code
> [ =C2=A0 16.054510] ACPI: Core revision 20070126
> [ =C2=A0 17.096953] CPU0: Intel(R) Core(TM) Duo CPU =C2=A0 =C2=A0 =C2=
=A0T2250 =C2=A0@ 1.73GHz stepping 0c
> [ =C2=A0 17.097080] SMP alternatives: switching to SMP code
> [ =C2=A0 17.097541] Booting processor 1/1 eip 3000
> [ =C2=A0 17.107794] Initializing CPU#1
> [ =C2=A0 17.184833] Calibrating delay using timer specific routine.. =
3458.31 BogoMIPS (lpj=3D6916634)
> [ =C2=A0 17.184841] CPU: After generic identify, caps: bfe9fbff 00000=
000 00000000 00000000 0000c189 00000000 00000000 00000000
> [ =C2=A0 17.184847] monitor/mwait feature present.
> [ =C2=A0 17.184851] CPU: L1 I cache: 32K, L1 D cache: 32K
> [ =C2=A0 17.184853] CPU: L2 cache: 2048K
> [ =C2=A0 17.184855] CPU: Physical Processor ID: 0
> [ =C2=A0 17.184856] CPU: Processor Core ID: 1
> [ =C2=A0 17.184858] CPU: After all inits, caps: bfe9fbff 00000000 000=
00000 00002940 0000c189 00000000 00000000 00000000
> [ =C2=A0 17.185341] CPU1: Intel(R) Core(TM) Duo CPU =C2=A0 =C2=A0 =C2=
=A0T2250 =C2=A0@ 1.73GHz stepping 0c
> [ =C2=A0 17.185762] Total of 2 processors activated (6919.72 BogoMIPS=
).
> [ =C2=A0 17.185961] ENABLING IO-APIC IRQs
> [ =C2=A0 17.186184] ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D0 apic2=3D=
-1 pin2=3D-1
> [ =C2=A0 17.225941] ..MP-BIOS bug: 8254 timer not connected to IO-API=
C
> [ =C2=A0 17.225985] ...trying to set up timer (IRQ0) through the 8259=
A ... =C2=A0failed.
> [ =C2=A0 17.226063] ...trying to set up timer as Virtual Wire IRQ... =
failed.
> [ =C2=A0 17.265860] ...trying to set up timer as ExtINT IRQ... works.
> [ =C2=A0 17.512840] checking TSC synchronization [CPU#0 -> CPU#1]: pa=
ssed.
> [ =C2=A0 17.532930] Brought up 2 CPUs
> [ =C2=A0 17.532990] CPU0 attaching sched-domain:
> [ =C2=A0 17.532993] =C2=A0domain 0: span 03
> [ =C2=A0 17.532995] =C2=A0 groups: 01 02
> [ =C2=A0 17.532999] CPU1 attaching sched-domain:
> [ =C2=A0 17.533000] =C2=A0domain 0: span 03
> [ =C2=A0 17.533002] =C2=A0 groups: 02 01
> [ =C2=A0 17.533301] net_namespace: 64 bytes
> [ =C2=A0 17.533835] Time: 21:38:59 =C2=A0Date: 01/21/08
> [ =C2=A0 17.533907] NET: Registered protocol family 16
> [ =C2=A0 17.534170] EISA bus registered
> [ =C2=A0 17.534215] ACPI: bus type pci registered
> [ =C2=A0 17.534348] PCI: Using MMCONFIG
> [ =C2=A0 17.535212] Setting up standard PCI resources
> [ =C2=A0 17.540361] ACPI: EC: Look up EC in DSDT
> [ =C2=A0 17.543493] ACPI: System BIOS is requesting _OSI(Linux)
> [ =C2=A0 17.543537] ACPI: If "acpi_osi=3DLinux" works better,
> [ =C2=A0 17.543538] Please send dmidecode to linux-acpi@vger.kernel.o=
rg
> [ =C2=A0 19.544569] ACPI: Interpreter enabled
> [ =C2=A0 19.544613] ACPI: (supports S0 S3 S5)
> [ =C2=A0 19.544763] ACPI: Using IOAPIC for interrupt routing
> [ =C2=A0 19.545137] ACPI: EC: non-query interrupt received, switching=
 to interrupt mode
> [ =C2=A0 19.550808] ACPI: EC: GPE =3D 0x3, I/O: command/status =3D 0x=
66, data =3D 0x62
> [ =C2=A0 19.550853] ACPI: EC: driver started in interrupt mode
> [ =C2=A0 19.550947] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [ =C2=A0 19.552478] PCI: Transparent bridge - 0000:00:14.4
> [ =C2=A0 19.552608] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PR=
T]
> [ =C2=A0 19.552825] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P=
_._PRT]
> [ =C2=A0 19.552973] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP=
_._PRT]
> [ =C2=A0 19.555698] ACPI: PCI Interrupt Link [LNKA] (IRQs 11) *0, dis=
abled.
> [ =C2=A0 19.556026] ACPI: PCI Interrupt Link [LNKB] (IRQs 10) *0, dis=
abled.
> [ =C2=A0 19.556356] ACPI: PCI Interrupt Link [LNKC] (IRQs 5) *0, disa=
bled.
> [ =C2=A0 19.556681] ACPI: PCI Interrupt Link [LNKD] (IRQs 5) *0, disa=
bled.
> [ =C2=A0 19.557006] ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, dis=
abled.
> [ =C2=A0 19.557331] ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, dis=
abled.
> [ =C2=A0 19.557656] ACPI: PCI Interrupt Link [LNKG] (IRQs 11) *0, dis=
abled.
> [ =C2=A0 19.557980] ACPI: PCI Interrupt Link [LNKH] (IRQs 5) *0, disa=
bled.
> [ =C2=A0 19.558323] ACPI: Power Resource [FN00] (off)
> [ =C2=A0 19.558425] Linux Plug and Play Support v0.97 (c) Adam Belay
> [ =C2=A0 19.558508] pnp: PnP ACPI init
> [ =C2=A0 19.558555] ACPI: bus type pnp registered
> [ =C2=A0 19.561311] pnp: PnP ACPI: found 11 devices
> [ =C2=A0 19.561354] ACPI: ACPI bus type pnp unregistered
> [ =C2=A0 19.561399] PnPBIOS: Disabled by ACPI PNP
> [ =C2=A0 19.561691] PCI: Using ACPI for IRQ routing
> [ =C2=A0 19.561734] PCI: If a device doesn't work, try "pci=3Drouteir=
q". =C2=A0If it helps, post a report
> [ =C2=A0 19.587931] NET: Registered protocol family 8
> [ =C2=A0 19.587975] NET: Registered protocol family 20
> [ =C2=A0 19.588056] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [ =C2=A0 19.588271] hpet0: 4 32-bit timers, 14318180 Hz
> [ =C2=A0 19.591909] Time: tsc clocksource has been installed.
> [ =C2=A0 19.591961] Switched to high resolution mode on CPU 0
> [ =C2=A0 19.592120] Switched to high resolution mode on CPU 1
> [ =C2=A0 19.607819] system 00:01: iomem range 0xe0000000-0xefffffff c=
ould not be reserved
> [ =C2=A0 19.607877] system 00:08: ioport range 0x1080-0x1080 has been=
 reserved
> [ =C2=A0 19.607922] system 00:08: ioport range 0x220-0x22f has been r=
eserved
> [ =C2=A0 19.607966] system 00:08: ioport range 0x40b-0x40b has been r=
eserved
> [ =C2=A0 19.608011] system 00:08: ioport range 0x4d0-0x4d1 has been r=
eserved
> [ =C2=A0 19.608055] system 00:08: ioport range 0x4d6-0x4d6 has been r=
eserved
> [ =C2=A0 19.608100] system 00:08: ioport range 0x530-0x537 has been r=
eserved
> [ =C2=A0 19.608144] system 00:08: ioport range 0xc00-0xc01 has been r=
eserved
> [ =C2=A0 19.608189] system 00:08: ioport range 0xc14-0xc14 has been r=
eserved
> [ =C2=A0 19.608233] system 00:08: ioport range 0xc50-0xc52 has been r=
eserved
> [ =C2=A0 19.608278] system 00:08: ioport range 0xc6c-0xc6c has been r=
eserved
> [ =C2=A0 19.608322] system 00:08: ioport range 0xc6f-0xc6f has been r=
eserved
> [ =C2=A0 19.608367] system 00:08: ioport range 0xcd0-0xcd1 has been r=
eserved
> [ =C2=A0 19.608411] system 00:08: ioport range 0xcd2-0xcd3 has been r=
eserved
> [ =C2=A0 19.608456] system 00:08: ioport range 0xcd4-0xcd5 has been r=
eserved
> [ =C2=A0 19.608500] system 00:08: ioport range 0xcd6-0xcd7 has been r=
eserved
> [ =C2=A0 19.608545] system 00:08: ioport range 0xcd8-0xcdf has been r=
eserved
> [ =C2=A0 19.608590] system 00:08: ioport range 0x8000-0x805f has been=
 reserved
> [ =C2=A0 19.608634] system 00:08: ioport range 0x8210-0x821f has been=
 reserved
> [ =C2=A0 19.608679] system 00:08: ioport range 0xf40-0xf47 has been r=
eserved
> [ =C2=A0 19.608724] system 00:08: ioport range 0x280-0x293 has been r=
eserved
> [ =C2=A0 19.608768] system 00:08: ioport range 0x87f-0x87f has been r=
eserved
> [ =C2=A0 19.608826] system 00:09: iomem range 0xe0000-0xfffff could n=
ot be reserved
> [ =C2=A0 19.608872] system 00:09: iomem range 0xfff00000-0xffffffff c=
ould not be reserved
> [ =C2=A0 19.608921] system 00:09: iomem range 0x0-0xfff could not be =
reserved
> [ =C2=A0 19.639430] PCI: Bridge: 0000:00:01.0
> [ =C2=A0 19.639473] =C2=A0 IO window: 9000-9fff
> [ =C2=A0 19.639516] =C2=A0 MEM window: d0100000-d01fffff
> [ =C2=A0 19.639559] =C2=A0 PREFETCH window: d8000000-dfffffff
> [ =C2=A0 19.639607] PCI: Bus 3, cardbus bridge: 0000:02:09.0
> [ =C2=A0 19.640472] =C2=A0 IO window: 0000a400-0000a4ff
> [ =C2=A0 19.640517] =C2=A0 IO window: 0000a800-0000a8ff
> [ =C2=A0 19.640562] =C2=A0 PREFETCH window: 40000000-43ffffff
> [ =C2=A0 19.640608] =C2=A0 MEM window: 44000000-47ffffff
> [ =C2=A0 19.640653] PCI: Bridge: 0000:00:14.4
> [ =C2=A0 19.640696] =C2=A0 IO window: a000-afff
> [ =C2=A0 19.640741] =C2=A0 MEM window: f0200000-f02fffff
> [ =C2=A0 19.640788] =C2=A0 PREFETCH window: f0300000-f03fffff
> [ =C2=A0 19.640904] ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 20 (le=
vel, low) -> IRQ 16
> [ =C2=A0 19.640999] NET: Registered protocol family 2
> [ =C2=A0 19.680814] IP route cache hash table entries: 32768 (order: =
5, 131072 bytes)
> [ =C2=A0 19.681115] TCP established hash table entries: 131072 (order=
: 8, 1048576 bytes)
> [ =C2=A0 19.681893] TCP bind hash table entries: 65536 (order: 7, 524=
288 bytes)
> [ =C2=A0 19.682337] TCP: Hash tables configured (established 131072 b=
ind 65536)
> [ =C2=A0 19.682382] TCP reno registered
> [ =C2=A0 19.692921] checking if image is initramfs... it is
> [ =C2=A0 23.495235] Freeing initrd memory: 41191k freed
> [ =C2=A0 23.496249] audit: initializing netlink socket (disabled)
> [ =C2=A0 23.496308] audit(1200951544.209:1): initialized
> [ =C2=A0 23.498732] VFS: Disk quotas dquot_6.5.1
> [ =C2=A0 23.498855] Dquot-cache hash table entries: 1024 (order 0, 40=
96 bytes)
> [ =C2=A0 23.499029] io scheduler noop registered
> [ =C2=A0 23.499071] io scheduler anticipatory registered
> [ =C2=A0 23.499114] io scheduler deadline registered
> [ =C2=A0 23.499166] io scheduler cfq registered (default)
> [ =C2=A0 23.499287] Boot video device is 0000:01:05.0
> [ =C2=A0 23.499532] isapnp: Scanning for PnP cards...
> [ =C2=A0 23.853806] isapnp: No Plug & Play device found
> [ =C2=A0 23.878642] Real Time Clock Driver v1.12ac
> [ =C2=A0 23.878967] hpet_resources: 0xfed00000 is busy
> [ =C2=A0 23.878997] Serial: 8250/16550 driver $Revision: 1.90 $ 4 por=
ts, IRQ sharing enabled
> [ =C2=A0 23.880405] RAMDISK driver initialized: 16 RAM disks of 65536=
K size 1024 blocksize
> [ =C2=A0 23.880526] input: Macintosh mouse button emulation as /class=
/input/input0
> [ =C2=A0 23.880673] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] =
at 0x60,0x64 irq 1,12
> [ =C2=A0 23.883400] i8042.c: Detected active multiplexing controller,=
 rev 1.1.
> [ =C2=A0 23.884803] serio: i8042 KBD port at 0x60,0x64 irq 1
> [ =C2=A0 23.884850] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [ =C2=A0 23.884897] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [ =C2=A0 23.884943] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [ =C2=A0 23.884987] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [ =C2=A0 23.899487] mice: PS/2 mouse device common for all mice
> [ =C2=A0 23.899661] EISA: Probing bus 0 at eisa.0
> [ =C2=A0 23.899711] Cannot allocate resource for EISA slot 1
> [ =C2=A0 23.899781] Cannot allocate resource for EISA slot 8
> [ =C2=A0 23.899824] EISA: Detected 0 cards.
> [ =C2=A0 23.899951] TCP cubic registered
> [ =C2=A0 23.900000] NET: Registered protocol family 1
> [ =C2=A0 23.900070] Using IPI No-Shortcut mode
> [ =C2=A0 23.900254] =C2=A0 Magic number: 8:356:652
> [ =C2=A0 23.900664] Freeing unused kernel memory: 336k freed
> [ =C2=A0 23.922524] input: AT Translated Set 2 keyboard as /class/inp=
ut/input1
> [ =C2=A0 24.082855] fuse init (API version 7.9)
> [ =C2=A0 24.087549] ACPI: Fan [FAN0] (off)
> [ =C2=A0 24.093278] ACPI: SSDT 37E98750, 02E6 (r1 =C2=A0PmRef =C2=A0C=
pu0Ist =C2=A0 =C2=A0 3000 INTL 20050228)
> [ =C2=A0 24.093926] ACPI: SSDT 37E97FD4, 06F7 (r1 =C2=A0PmRef =C2=A0C=
pu0Cst =C2=A0 =C2=A0 3001 INTL 20050228)
> [ =C2=A0 24.096045] ACPI: CPU0 (power states: C1[C1] C2[C2])
> [ =C2=A0 24.096193] ACPI: Processor [CPU0] (supports 8 throttling sta=
tes)
> [ =C2=A0 24.096545] ACPI: SSDT 37E98A36, 00AA (r1 =C2=A0PmRef =C2=A0C=
pu1Ist =C2=A0 =C2=A0 3000 INTL 20050228)
> [ =C2=A0 24.096843] ACPI: SSDT 37E986CB, 0085 (r1 =C2=A0PmRef =C2=A0C=
pu1Cst =C2=A0 =C2=A0 3000 INTL 20050228)
> [ =C2=A0 24.097599] ACPI: CPU1 (power states: C1[C1] C2[C2])
> [ =C2=A0 24.097746] ACPI: Processor [CPU1] (supports 8 throttling sta=
tes)
> [ =C2=A0 24.099633] ACPI: Thermal Zone [TZ00] (53 C)
> [ =C2=A0 24.100131] ACPI: Thermal Zone [TZ01] (53 C)
> [ =C2=A0 24.464056] SCSI subsystem initialized
> [ =C2=A0 24.482064] libata version 3.00 loaded.
> [ =C2=A0 24.485390] ahci 0000:00:12.0: version 3.0
> [ =C2=A0 24.485425] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (le=
vel, low) -> IRQ 17
> [ =C2=A0 24.485537] ahci 0000:00:12.0: controller can't do 64bit DMA,=
 forcing 32bit
> [ =C2=A0 24.485585] ahci 0000:00:12.0: controller can't do PMP, turni=
ng off CAP_PMP
> [ =C2=A0 24.526923] usbcore: registered new interface driver usbfs
> [ =C2=A0 24.527002] usbcore: registered new interface driver hub
> [ =C2=A0 24.527070] usbcore: registered new device driver usb
> [ =C2=A0 24.551925] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Cont=
roller (OHCI) Driver
> [ =C2=A0 24.781965] Uniform Multi-Platform E-IDE driver Revision: 7.0=
0alpha2
> [ =C2=A0 24.782779] ide: Assuming 33MHz system bus speed for PIO mode=
s; override with idebus=3Dxx
> [ =C2=A0 24.793717] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, =
2004)
> [ =C2=A0 25.485782] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 port=
s 3 Gbps 0xf impl SATA mode
> [ =C2=A0 25.485864] ahci 0000:00:12.0: flags: ncq sntf ilck pm led cl=
o pio slum part=20
> [ =C2=A0 25.486341] scsi0 : ahci
> [ =C2=A0 25.486602] scsi1 : ahci
> [ =C2=A0 25.486793] scsi2 : ahci
> [ =C2=A0 25.486973] scsi3 : ahci
> [ =C2=A0 25.487107] ata1: SATA max UDMA/133 abar m1024@0xd0004000 por=
t 0xd0004100 irq 17
> [ =C2=A0 25.487159] ata2: SATA max UDMA/133 abar m1024@0xd0004000 por=
t 0xd0004180 irq 17
> [ =C2=A0 25.487210] ata3: SATA max UDMA/133 abar m1024@0xd0004000 por=
t 0xd0004200 irq 17
> [ =C2=A0 25.487260] ata4: SATA max UDMA/133 abar m1024@0xd0004000 por=
t 0xd0004280 irq 17
> [ =C2=A0 25.961578] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)
> [ =C2=A0 25.970536] ata1.00: ATA-7: SAMSUNG HM120JI, YF100-13, max UD=
MA7
> [ =C2=A0 25.970599] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (=
depth 31/32)
> [ =C2=A0 25.976640] ata1.00: configured for UDMA/133
> [ =C2=A0 26.285460] ata2: SATA link down (SStatus 0 SControl 300)
> [ =C2=A0 26.597344] ata3: SATA link down (SStatus 0 SControl 300)
> [ =C2=A0 26.910231] ata4: SATA link down (SStatus 0 SControl 300)
> [ =C2=A0 26.910553] scsi 0:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=
=A0 =C2=A0 =C2=A0SAMSUNG HM120JI =C2=A0YF10 PQ: 0 ANSI: 5
> [ =C2=A0 26.911016] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (le=
vel, low) -> IRQ 18
> [ =C2=A0 26.911113] ohci_hcd 0000:00:13.0: OHCI Host Controller
> [ =C2=A0 26.911414] ohci_hcd 0000:00:13.0: new USB bus registered, as=
signed bus number 1
> [ =C2=A0 26.911484] ohci_hcd 0000:00:13.0: irq 18, io mem 0xd0005000
> [ =C2=A0 26.918249] Driver 'sd' needs updating - please use bus_type =
methods
> [ =C2=A0 26.926317] sd 0:0:0:0: [sda] 234441648 512-byte hardware sec=
tors (120034 MB)
> [ =C2=A0 26.926401] sd 0:0:0:0: [sda] Write Protect is off
> [ =C2=A0 26.926459] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ =C2=A0 26.926496] sd 0:0:0:0: [sda] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
> [ =C2=A0 26.926635] sd 0:0:0:0: [sda] 234441648 512-byte hardware sec=
tors (120034 MB)
> [ =C2=A0 26.926689] sd 0:0:0:0: [sda] Write Protect is off
> [ =C2=A0 26.926732] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ =C2=A0 26.926748] sd 0:0:0:0: [sda] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
> [ =C2=A0 26.926800] =C2=A0sda:<6>usb usb1: configuration #1 chosen fr=
om 1 choice
> [ =C2=A0 26.965559] hub 1-0:1.0: USB hub found
> [ =C2=A0 26.965623] hub 1-0:1.0: 2 ports detected
> [ =C2=A0 27.069355] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (le=
vel, low) -> IRQ 19
> [ =C2=A0 27.069483] ohci_hcd 0000:00:13.1: OHCI Host Controller
> [ =C2=A0 27.069578] ohci_hcd 0000:00:13.1: new USB bus registered, as=
signed bus number 2
> [ =C2=A0 27.069645] ohci_hcd 0000:00:13.1: irq 19, io mem 0xd0006000
> [ =C2=A0 27.126353] usb usb2: configuration #1 chosen from 1 choice
> [ =C2=A0 27.126461] hub 2-0:1.0: USB hub found
> [ =C2=A0 27.126531] hub 2-0:1.0: 2 ports detected
> [ =C2=A0 27.230255] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (le=
vel, low) -> IRQ 20
> [ =C2=A0 27.230376] ohci_hcd 0000:00:13.2: OHCI Host Controller
> [ =C2=A0 27.230483] ohci_hcd 0000:00:13.2: new USB bus registered, as=
signed bus number 3
> [ =C2=A0 27.230546] ohci_hcd 0000:00:13.2: irq 20, io mem 0xd0007000
> [ =C2=A0 27.285292] usb usb3: configuration #1 chosen from 1 choice
> [ =C2=A0 27.285397] hub 3-0:1.0: USB hub found
> [ =C2=A0 27.285468] hub 3-0:1.0: 2 ports detected
> [ =C2=A0 27.369067] =C2=A0sda1 sda2 <<6>usb 1-1: new low speed USB de=
vice using ohci_hcd and address 2
> [ =C2=A0 27.389208] ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (le=
vel, low) -> IRQ 19
> [ =C2=A0 27.389329] ohci_hcd 0000:00:13.3: OHCI Host Controller
> [ =C2=A0 27.389432] ohci_hcd 0000:00:13.3: new USB bus registered, as=
signed bus number 4
> [ =C2=A0 27.389492] ohci_hcd 0000:00:13.3: irq 19, io mem 0xd0008000
> [ =C2=A0 27.396915] =C2=A0sda5 >
> [ =C2=A0 27.397255] sd 0:0:0:0: [sda] Attached SCSI disk
> [ =C2=A0 27.411538] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [ =C2=A0 27.446333] usb usb4: configuration #1 chosen from 1 choice
> [ =C2=A0 27.446434] hub 4-0:1.0: USB hub found
> [ =C2=A0 27.446484] hub 4-0:1.0: 2 ports detected
> [ =C2=A0 27.550240] ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (le=
vel, low) -> IRQ 20
> [ =C2=A0 27.550383] ohci_hcd 0000:00:13.4: OHCI Host Controller
> [ =C2=A0 27.550453] ohci_hcd 0000:00:13.4: new USB bus registered, as=
signed bus number 5
> [ =C2=A0 27.550517] ohci_hcd 0000:00:13.4: irq 20, io mem 0xd0009000
> [ =C2=A0 27.598191] usb 1-1: configuration #1 chosen from 1 choice
> [ =C2=A0 27.606217] usb usb5: configuration #1 chosen from 1 choice
> [ =C2=A0 27.606326] hub 5-0:1.0: USB hub found
> [ =C2=A0 27.606388] hub 5-0:1.0: 2 ports detected
> [ =C2=A0 27.709361] ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (le=
vel, low) -> IRQ 21
> [ =C2=A0 27.710327] ehci_hcd 0000:00:13.5: EHCI Host Controller
> [ =C2=A0 27.710413] ehci_hcd 0000:00:13.5: new USB bus registered, as=
signed bus number 6
> [ =C2=A0 27.710504] ehci_hcd 0000:00:13.5: debug port 1
> [ =C2=A0 27.710560] ehci_hcd 0000:00:13.5: irq 21, io mem 0xd0004400
> [ =C2=A0 27.711474] kjournald starting. =C2=A0Commit interval 5 secon=
ds
> [ =C2=A0 27.711488] EXT3-fs: mounted filesystem with ordered data mod=
e.
> [ =C2=A0 27.721920] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00=
, driver 10 Dec 2004
> [ =C2=A0 27.722102] usb usb6: configuration #1 chosen from 1 choice
> [ =C2=A0 27.722172] hub 6-0:1.0: USB hub found
> [ =C2=A0 27.722221] hub 6-0:1.0: 10 ports detected
> [ =C2=A0 27.826113] SB600_PATA: IDE controller (0x1002:0x438c rev 0x0=
0) at =C2=A0PCI slot 0000:00:14.1
> [ =C2=A0 27.826205] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (le=
vel, low) -> IRQ 18
> [ =C2=A0 27.826320] SB600_PATA: not 100% native mode: will probe irqs=
 later
> [ =C2=A0 27.826371] =C2=A0 =C2=A0 ide0: BM-DMA at 0x8420-0x8427, BIOS=
 settings: hda:DMA, hdb:pio
> [ =C2=A0 27.826496] Probing IDE interface ide0...
> [ =C2=A0 27.857909] usb 1-1: USB disconnect, address 2
> [ =C2=A0 28.353786] usbcore: registered new interface driver hiddev
> [ =C2=A0 28.664600] usb 1-1: new low speed USB device using ohci_hcd =
and address 3
> [ =C2=A0 28.881741] usb 1-1: configuration #1 chosen from 1 choice
> [ =C2=A0 29.196416] usb 1-2: new low speed USB device using ohci_hcd =
and address 4
> [ =C2=A0 29.232778] hda: TSSTcorpCD/DVDW TS-L632D, ATAPI CD/DVD-ROM d=
rive
> [ =C2=A0 29.232956] hda: host max PIO4 wanted PIO255(auto-tune) selec=
ted PIO4
> [ =C2=A0 29.233342] hda: UDMA/33 mode selected
> [ =C2=A0 29.233890] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [ =C2=A0 29.234968] 8139cp 0000:02:05.0: This (id 10ec:8139 rev 10) i=
s not an 8139C+ compatible chip
> [ =C2=A0 29.235024] 8139cp 0000:02:05.0: Try the "8139too" driver ins=
tead.
> [ =C2=A0 29.430550] usb 1-2: configuration #1 chosen from 1 choice
> [ =C2=A0 29.439825] input: Logitech USB Receiver as /class/input/inpu=
t2
> [ =C2=A0 29.460354] input: USB HID v1.11 Mouse [Logitech USB Receiver=
] on usb-0000:00:13.0-1
> [ =C2=A0 29.471553] input: Logitech USB Receiver as /class/input/inpu=
t3
> [ =C2=A0 29.484377] input,hiddev96: USB HID v1.11 Device [Logitech US=
B Receiver] on usb-0000:00:13.0-1
> [ =C2=A0 29.494799] input: QTRONIX USB Keyboard and Mouse as /class/i=
nput/input4
> [ =C2=A0 29.504300] input: USB HID v1.00 Keyboard [QTRONIX USB Keyboa=
rd and Mouse] on usb-0000:00:13.0-2
> [ =C2=A0 29.520435] input: QTRONIX USB Keyboard and Mouse as /class/i=
nput/input5
> [ =C2=A0 29.544324] input: USB HID v1.00 Mouse [QTRONIX USB Keyboard =
and Mouse] on usb-0000:00:13.0-2
> [ =C2=A0 29.544496] usbcore: registered new interface driver usbhid
> [ =C2=A0 29.544557] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core =
driver
> [ =C2=A0 40.496373] Linux agpgart interface v0.102
> [ =C2=A0 40.543588] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [ =C2=A0 40.648784] shpchp: Standard Hot Plug PCI Controller Driver v=
ersion: 0.4
> [ =C2=A0 40.686141] input: Power Button (FF) as /class/input/input6
> [ =C2=A0 40.740331] ACPI: Power Button (FF) [PWRF]
> [ =C2=A0 40.740589] input: Power Button (CM) as /class/input/input7
> [ =C2=A0 40.788305] ACPI: Power Button (CM) [PWRB]
> [ =C2=A0 40.788415] input: Lid Switch as /class/input/input8
> [ =C2=A0 40.804352] ACPI: Lid Switch [LID0]
> [ =C2=A0 40.804475] input: Sleep Button (CM) as /class/input/input9
> [ =C2=A0 40.868265] ACPI: Sleep Button (CM) [SLPB]
> [ =C2=A0 40.872695] ACPI: Battery Slot [BAT1] (battery present)
> [ =C2=A0 40.875775] ACPI: AC Adapter [ADP1] (on-line)
> [ =C2=A0 41.640961] piix4_smbus 0000:00:14.0: Found 0000:00:14.0 devi=
ce
> [ =C2=A0 41.705712] input: PC Speaker as /class/input/input10
> [ =C2=A0 41.942859] 8139too Fast Ethernet driver 0.9.28
> [ =C2=A0 41.943228] ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 23 (le=
vel, low) -> IRQ 22
> [ =C2=A0 41.944413] eth0: RealTek RTL8139 at 0xf899a000, 00:13:77:36:=
d1:f6, IRQ 22
> [ =C2=A0 41.944465] eth0: =C2=A0Identified 8139 chip type 'RTL-8100B/=
8139D'
> [ =C2=A0 41.970403] sdhci: Secure Digital Host Controller Interface d=
river
> [ =C2=A0 41.970460] sdhci: Copyright(c) Pierre Ossman
> [ =C2=A0 41.970556] sdhci: SDHCI controller found at 0000:02:09.1 [11=
80:0822] (rev 18)
> [ =C2=A0 41.970640] ACPI: PCI Interrupt 0000:02:09.1[C] -> GSI 22 (le=
vel, low) -> IRQ 17
> [ =C2=A0 41.970756] sdhci:slot0: Will use DMA mode even though HW doe=
sn't fully claim to support it.
> [ =C2=A0 41.970861] mmc0: SDHCI at 0xd0210400 irq 17 DMA
> [ =C2=A0 42.054886] Yenta: CardBus bridge found at 0000:02:09.0 [144d=
:c036]
> [ =C2=A0 42.108863] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2=
048kB Cache
> [ =C2=A0 42.109131] Uniform CD-ROM driver Revision: 3.20
> [ =C2=A0 42.181572] Yenta: ISA IRQ mask 0x04b8, PCI irq 16
> [ =C2=A0 42.181623] Socket status: 30000006
> [ =C2=A0 42.181667] pcmcia: parent PCI bridge I/O window: 0xa000 - 0x=
afff
> [ =C2=A0 42.181712] cs: IO port probe 0xa000-0xafff: clean.
> [ =C2=A0 42.182084] pcmcia: parent PCI bridge Memory window: 0xf02000=
00 - 0xf02fffff
> [ =C2=A0 42.182129] pcmcia: parent PCI bridge Memory window: 0xf03000=
00 - 0xf03fffff
> [ =C2=A0 42.820800] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0=
b1, caps: 0xa04713/0x200000
> [ =C2=A0 42.862950] input: SynPS/2 Synaptics TouchPad as /class/input=
/input11
> [ =C2=A0133.087675] cs: IO port probe 0x100-0x3af: clean.
> [ =C2=A0133.089795] cs: IO port probe 0x3e0-0x4ff: clean.
> [ =C2=A0133.090742] cs: IO port probe 0x820-0x8ff: clean.
> [ =C2=A0133.091522] cs: IO port probe 0xc00-0xcf7: clean.
> [ =C2=A0133.092315] cs: IO port probe 0xa00-0xaff: clean.
> [ =C2=A0140.845947] loop: module loaded
> [ =C2=A0140.935354] lp: driver loaded but no devices found
> [ =C2=A0141.100031] Adding 2642652k swap on /dev/sda5. =C2=A0Priority=
:-1 extents:1 across:2642652k
> [ =C2=A0141.478768] EXT3 FS on sda1, internal journal
> [ =C2=A0342.056295] BUG: soft lockup - CPU#0 stuck for 186s! [swapper=
:0]
> [ =C2=A0342.056360]=20
> [ =C2=A0342.056366] Pid: 0, comm: swapper Not tainted (2.6.24-rc8 #1)
> [ =C2=A0342.056372] EIP: 0060:[<f88323b3>] EFLAGS: 00000202 CPU: 0
> [ =C2=A0342.056399] EIP is at acpi_processor_idle+0x2ae/0x45b [proces=
sor]
> [ =C2=A0342.056405] EAX: 00000000 EBX: 2aa50ee0 ECX: a424857e EDX: 00=
00002e
> [ =C2=A0342.056410] ESI: f78acacc EDI: c043e180 EBP: f78ac800 ESP: c0=
3e7f9c
> [ =C2=A0342.056415] =C2=A0DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 006=
8
> [ =C2=A0342.056420] CR0: 8005003b CR2: b7f25570 CR3: 30e65000 CR4: 00=
000690
> [ =C2=A0342.056426] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00=
000000
> [ =C2=A0342.056431] DR6: ffff0ff0 DR7: 00000400
> [ =C2=A0342.056437] =C2=A0[<f8832105>] acpi_processor_idle+0x0/0x45b =
[processor]
> [ =C2=A0342.056454] =C2=A0[<f8832105>] acpi_processor_idle+0x0/0x45b =
[processor]
> [ =C2=A0342.056469] =C2=A0[<c0102633>] cpu_idle+0x53/0xd0
> [ =C2=A0342.056481] =C2=A0[<c03eba2a>] start_kernel+0x2da/0x360
> [ =C2=A0342.056492] =C2=A0[<c03eb130>] unknown_bootoption+0x0/0x1f0
> [ =C2=A0342.056505] =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0344.106222] No dock devices found.
> [ =C2=A0344.253937] toshiba_acpi: Unknown parameter `hotkeys_over_acp=
i'
> [ =C2=A0345.927756] ppdev: user-space parallel port driver
> [ =C2=A0348.189393] RPC: Registered udp transport module.
> [ =C2=A0348.189398] RPC: Registered tcp transport module.
> [ =C2=A0348.663046] Installing knfsd (copyright (C) 1996 okir@monad.s=
wb.de).
> [ =C2=A0348.858706] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 =
state recovery directory
> [ =C2=A0348.892293] NFSD: starting 90-second grace period
> [ =C2=A0646.533279] BUG: soft lockup - CPU#0 stuck for 276s! [swapper=
:0]
> [ =C2=A0646.533357]=20
> [ =C2=A0646.533363] Pid: 0, comm: swapper Not tainted (2.6.24-rc8 #1)
> [ =C2=A0646.533368] EIP: 0060:[<f88323b3>] EFLAGS: 00000206 CPU: 0
> [ =C2=A0646.533400] EIP is at acpi_processor_idle+0x2ae/0x45b [proces=
sor]
> [ =C2=A0646.533406] EAX: 00000000 EBX: 3f233472 ECX: 8861cc37 EDX: 00=
000044
> [ =C2=A0646.533411] ESI: f78acacc EDI: c043e180 EBP: f78ac800 ESP: c0=
3e7f9c
> [ =C2=A0646.533417] =C2=A0DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 006=
8
> [ =C2=A0646.533422] CR0: 8005003b CR2: f8c1c684 CR3: 1fab5000 CR4: 00=
000690
> [ =C2=A0646.533427] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00=
000000
> [ =C2=A0646.533433] DR6: ffff0ff0 DR7: 00000400
> [ =C2=A0646.533441] =C2=A0[<f8832105>] acpi_processor_idle+0x0/0x45b =
[processor]
> [ =C2=A0646.533459] =C2=A0[<f8832105>] acpi_processor_idle+0x0/0x45b =
[processor]
> [ =C2=A0646.533475] =C2=A0[<c0102633>] cpu_idle+0x53/0xd0
> [ =C2=A0646.533489] =C2=A0[<c03eba2a>] start_kernel+0x2da/0x360
> [ =C2=A0646.533500] =C2=A0[<c03eb130>] unknown_bootoption+0x0/0x1f0
> [ =C2=A0646.533515] =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0668.208102] Bluetooth: Core ver 2.11
> [ =C2=A0668.208555] NET: Registered protocol family 31
> [ =C2=A0668.208562] Bluetooth: HCI device and connection manager init=
ialized
> [ =C2=A0668.208570] Bluetooth: HCI socket layer initialized
> [ =C2=A0668.262602] Bluetooth: L2CAP ver 2.9
> [ =C2=A0668.262610] Bluetooth: L2CAP socket layer initialized
> [ =C2=A0668.364867] Bluetooth: RFCOMM socket layer initialized
> [ =C2=A0668.365131] Bluetooth: RFCOMM TTY layer initialized
> [ =C2=A0668.365137] Bluetooth: RFCOMM ver 1.8
> [ =C2=A0669.473983] NET: Registered protocol family 10
> [ =C2=A0669.474492] lo: Disabled Privacy Extensions
> [ 1794.229358] eth0: link down
> [ 1794.231775] ADDRCONF(NETDEV_UP): eth0: link is not ready
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
