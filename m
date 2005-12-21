From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: acpica 20051202 regression
Date: Wed, 21 Dec 2005 12:22:25 -0500
Message-ID: <20051221172225.GA31784@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi acpi folks,
 I tried out the latest acpica patch from Len's kernel.org page,
and noticed that it stops my EM64T from booting unless I now
boot with pci=3Dnoacpi.

Boot log attached.  This kernel was based on 2.6.15rc6.

		Dave

Bootdata ok (command line is ro root=3D/dev/VolGroup00/LogVol00 vga=3D791=
 console=3DttyS0,38400 console=3Dtty0 profile=3D1 libusual.bias=3Dub debu=
g time initcall_debug)
Linux version 2.6.14-1.1777_FC5 (bhcompile-RC4msc60od7y+ZiRM8QlFPXAX3CI6PSWQQ4Iyu8u01E@public.gmane.org) (=
gcc version 4.1.0 20051214 (Red Hat 4.1.0-0.9)) #1 SMP Tue Dec 20 02:29:4=
1 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe8ac00 (usable)
 BIOS-e820: 000000003fe8ac00 - 000000003fe8cc00 (ACPI NVS)
 BIOS-e820: 000000003fe8cc00 - 000000003fe8ec00 (ACPI data)
 BIOS-e820: 000000003fe8ec00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 DELL                                  ) @ 0x00000000000f=
ebf0
ACPI: RSDT (v001 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fcb83
ACPI: FADT (v001 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fcbd7
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000=
fffc7674
ACPI: MADT (v001 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fcc4b
ACPI: BOOT (v001 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fccd5
ACPI: ASF! (v016 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fccfd
ACPI: MCFG (v001 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fcd64
ACPI: HPET (v001 DELL    WS 470  0x00000007 ASL  0x00000061) @ 0x00000000=
000fcda2
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000=
00000000
No NUMA configuration found
Faking a node at 0000000000000000-000000003fe8a000
Bootmem setup node 0 0000000000000000-000000003fe8a000
On node 0 totalpages: 255741
  DMA zone: 2596 pages, LIFO batch:0
  DMA32 zone: 253145 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Checking aperture...
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: ro root=3D/dev/VolGroup00/LogVol00 vga=3D791 console=
=3DttyS0,38400 console=3Dtty0 profile=3D1 libusual.bias=3Dub debug time i=
nitcall_debug
kernel profiling enabled (shift: 1)
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 14.318180 MHz HPET timer.
[    0.000000] time.c: Detected 2793.105 MHz processor.
[   14.149613] Console: colour dummy device 80x25
[   15.184183] Dentry cache hash table entries: 131072 (order: 8, 1048576=
 bytes)
[   15.206382] Inode-cache hash table entries: 65536 (order: 7, 524288 by=
tes)
[   15.239572] Memory: 1014800k/1047080k available (2323k kernel code, 31=
896k reserved, 1627k data, 224k init)
[   15.347734] Calibrating delay using timer specific routine.. 5591.27 B=
ogoMIPS (lpj=3D11182547)
[   15.373307] Security Framework v1.0.0 initialized
[   15.387427] SELinux:  Initializing.
[   15.397936] SELinux:  Starting in permissive mode
[   15.412043] selinux_register_security:  Registering secondary module c=
apability
[   15.433972] Capability LSM initialized as secondary
[   15.448721] Mount-cache hash table entries: 256
[   15.462745] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   15.478435] CPU: L2 cache: 1024K
[   15.488103] using mwait in idle threads.
[   15.499850] CPU: Physical Processor ID: 0
[   15.511877] CPU0: Thermal monitoring enabled (TM1)
[   15.526247] mtrr: v2.0 (20020519)
[   15.615698] Using local APIC timer interrupts.
[   15.664767] Detected 12.469 MHz APIC timer.
[   15.677666] Booting processor 1/4 APIC 0x6
[   15.700331] Initializing CPU#1
[   15.778988] Calibrating delay using timer specific routine.. 5586.28 B=
ogoMIPS (lpj=3D11172568)
[   15.779000] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   15.779002] CPU: L2 cache: 1024K
[   15.779006] CPU: Physical Processor ID: 3
[   15.779017] CPU1: Thermal monitoring enabled (TM1)
[   15.779246]                   Intel(R) Xeon(TM) CPU 2.80GHz stepping 0=
1
[   15.779256] CPU 1: Syncing TSC to CPU 0.
[   15.779420] CPU 1: synchronized TSC with CPU 0 (last diff 10 cycles, m=
axerr 1225 cycles)
[   15.779660] Booting processor 2/4 APIC 0x1
[   15.944377] Initializing CPU#2
[   16.022570] Calibrating delay using timer specific routine.. 5586.15 B=
ogoMIPS (lpj=3D11172319)
[   16.022583] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   16.022587] CPU: L2 cache: 1024K
[   16.022591] CPU: Physical Processor ID: 0
[   16.022604] CPU2: Thermal monitoring enabled (TM1)
[   16.022839]                   Intel(R) Xeon(TM) CPU 2.80GHz stepping 0=
1
[   16.022849] APIC error on CPU2: 00(40)
[   16.022854] CPU 2: Syncing TSC to CPU 0.
[   16.023024] CPU 2: synchronized TSC with CPU 0 (last diff -6 cycles, m=
axerr 917 cycles)
[   16.023301] Booting processor 3/4 APIC 0x7
[   16.198958] Initializing CPU#3
[   16.278130] Calibrating delay using timer specific routine.. 5586.18 B=
ogoMIPS (lpj=3D11172372)
[   16.278141] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   16.278143] CPU: L2 cache: 1024K
[   16.278146] CPU: Physical Processor ID: 3
[   16.278158] CPU3: Thermal monitoring enabled (TM1)
[   16.278389]                   Intel(R) Xeon(TM) CPU 2.80GHz stepping 0=
1
[   16.278397] APIC error on CPU3: 00(40)
[   16.278401] CPU 3: Syncing TSC to CPU 0.
[   16.278604] CPU 3: synchronized TSC with CPU 0 (last diff 17 cycles, m=
axerr 1393 cycles)
[   16.278616] Brought up 4 CPUs
[   16.440769] time.c: Using HPET/TSC based timekeeping.
[   16.455919] testing NMI watchdog ... OK.
[   16.508857] checking if image is initramfs... it is
[   16.714269] Calling initcall 0xffffffff805f834a: cpufreq_tsc+0x0/0x6b(=
)
[   16.734164] Calling initcall 0xffffffff8011c73f: init_smp_flush+0x0/0x=
7c()
[   16.754802] Calling initcall 0xffffffff8060215f: init_elf32_binfmt+0x0=
/0xc()
[   16.775962] Calling initcall 0xffffffff80603443: helper_init+0x0/0x2c(=
)
[   16.795881] Calling initcall 0xffffffff806035f1: pm_init+0x0/0x27()
[   16.814728] Calling initcall 0xffffffff8060364d: pm_disk_init+0x0/0x13=
()
[   16.834862] Calling initcall 0xffffffff806038ee: ksysfs_init+0x0/0x27(=
)
[   16.854742] Calling initcall 0xffffffff806058b4: filelock_init+0x0/0x2=
f()
[   16.875154] Calling initcall 0xffffffff80606184: init_misc_binfmt+0x0/=
0x35()
[   16.896331] Calling initcall 0xffffffff806061b9: init_script_binfmt+0x=
0/0xc()
[   16.917771] Calling initcall 0xffffffff806061c5: init_elf_binfmt+0x0/0=
xc()
[   16.938418] Calling initcall 0xffffffff806069a6: debugfs_init+0x0/0x40=
()
[   16.958551] Calling initcall 0xffffffff80606ece: securityfs_init+0x0/0=
x40()
[   16.979482] Calling initcall 0xffffffff8061085c: netlink_proto_init+0x=
0/0x201()
[   17.001465] NET: Registered protocol family 16
[   17.014812] Calling initcall 0xffffffff806075b1<7>Losing some ticks...=
 checking if CPU frequency changed.
[   17.043556] : kobject_uevent_init+0x0/0x39()
[   17.056380] Calling initcall 0xffffffff80607706: pcibus_class_init+0x0=
/0xc()
[   17.077568] Calling initcall 0xffffffff80607d34: pci_driver_init+0x0/0=
xc()
[   17.098245] Calling initcall 0xffffffff8060af97: tty_class_init+0x0/0x=
27()
[   17.118907] Calling initcall 0xffffffff8060d19a: register_node_type+0x=
0/0xc()
[   17.140343] Calling initcall 0xffffffff805faa08: mtrr_if_init+0x0/0x6a=
()
[   17.160468] Calling initcall 0xffffffff80607eb9: pci_acpi_init+0x0/0x2=
b()
[   17.180855] ACPI: bus type pci registered
[   17.192872] Calling initcall 0xffffffff80609ae2: init_acpi_device_noti=
fy+0x0/0x48()
[   17.215865] Calling initcall 0xffffffff8060f0fb: pci_direct_init+0x0/0=
x184()
[   17.237039] PCI: Using configuration type 1
[   17.249578] Calling initcall 0xffffffff8060fce3: pci_mmcfg_init+0x0/0x=
187()
[   17.277044] PCI: Using MMCONFIG at e0000000
[   17.289632] Calling initcall 0xffffffff805fa86c: mtrr_init_finialize+0=
x0/0x31()
[   17.311582] Calling initcall 0xffffffff80600a11: topology_init+0x0/0xb=
b()
[   17.333421] Calling initcall 0xffffffff80159580: pm_sysrq_init+0x0/0x1=
6()
[   17.353822] Calling initcall 0xffffffff8060569e: init_bio+0x0/0x10c()
[   17.380621] Calling initcall 0xffffffff8060740b: genhd_device_init+0x0=
/0x30()
[   17.402437] Calling initcall 0xffffffff8060850d: fbmem_init+0x0/0x92()
[   17.422083] Calling initcall 0xffffffff80609842: acpi_init+0x0/0x196()
[   17.441694] ACPI: Subsystem revision 20051202
[   17.505374] ACPI: Interpreter enabled
[   17.516350] ACPI: Using IOAPIC for interrupt routing
[   17.531337] Calling initcall 0xffffffff80609d7f: acpi_ec_init+0x0/0x60=
()
[   17.551471] Calling initcall 0xffffffff8060a1d6: acpi_pci_root_init+0x=
0/0x25()
[   17.573160] Calling initcall 0xffffffff8060a21b: acpi_pci_link_init+0x=
0/0x45()
[   17.594844] Calling initcall 0xffffffff8060a38b: acpi_power_init+0x0/0=
x74()
[   17.615747] Calling initcall 0xffffffff8060a548: acpi_system_init+0x0/=
0xbd()
[   17.637231] Calling initcall 0xffffffff8060a605: acpi_event_init+0x0/0=
x3a()
[   17.661498] Calling initcall 0xffffffff8060a74c: acpi_scan_init+0x0/0x=
112()
[   17.690635] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   17.705022] PCI: Probing PCI hardware (bus 00)
[   17.718410] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   17.758914] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[   17.778244] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[   17.795501] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   17.813554] PCI: PXH quirk detected, disabling MSI for SHPC device
[   17.832555] PCI: PXH quirk detected, disabling MSI for SHPC device
[   17.852171] Boot video device is 0000:05:00.0
[   17.865595] PCI: Transparent bridge - 0000:00:1e.0
[   17.880029] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   18.572014] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[   18.600341] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI2._P=
RT]
[   18.629785] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI3._P=
RT]
[   18.659729] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
[   18.685539] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
[   18.711367] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI6._PRT]
[   18.783337] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 1=
2 15)
[   18.805426] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 1=
2 15)
[   18.827497] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 1=
2 15)
[   18.849572] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 1=
2 15)
[   18.871674] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[   18.897174] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[   18.922688] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[   18.948207] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 1=
2 15)
[   18.969506] Calling initcall 0xffffffff8060aa11: pnp_init+0x0/0x1c()
[   18.988589] Linux Plug and Play Support v0.97 (c) Adam Belay
[   19.005597] Calling initcall 0xffffffff8060ac06: pnpacpi_init+0x0/0x67=
()
[   19.025722] pnp: PnP ACPI init
[   19.037532] pnp: PnPACPI: unknown resource type 7
[   19.051640] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[   19.069315] pnp: PnPACPI: unknown resource type 7
[   19.083417] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
[   19.101074] pnp: PnPACPI: unknown resource type 7
[   19.115178] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c04
[   19.132831] pnp: PnPACPI: unknown resource type 7
[   19.146938] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0800
[   19.164594] pnp: PnPACPI: unknown resource type 7
[   19.178693] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0b00
[   19.201066] pnp: PnPACPI: unknown resource type 7
[   19.215169] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0700
[   19.234175] pnp: PnPACPI: unknown resource type 7
[   19.248286] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0303
[   19.269573] pnp: PnPACPI: unknown resource type 7
[   19.283682] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0f13
[   19.306786] pnp: PnPACPI: unknown resource type 7
[   19.320888] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
[   19.342317] pnp: PnPACPI: unknown resource type 7
[   19.356414] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0501
[   19.377834] pnp: PnPACPI: unknown resource type 7
[   19.391940] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0501
[   19.416835] pnp: PnP ACPI: found 0 devices
[   19.429108] Calling initcall 0xffffffff8060b400: misc_init+0x0/0x7d()
[   19.448463] Calling initcall 0xffffffff8060e55e: init_pcmcia_cs+0x0/0x=
61()
[   19.469115] Calling initcall 0xffffffff8060e6aa: usb_init+0x0/0xcc()
[   19.488398] usbcore: registered new driver usbfs
[   19.502408] usbcore: registered new driver hub
[   19.515922] Calling initcall 0xffffffff8060ea77: input_init+0x0/0x155(=
)
[   19.535825] Calling initcall 0xffffffff8060f2e2: pci_acpi_init+0x0/0xa=
4()
[   19.556210] PCI: Using ACPI for IRQ routing
[   19.568752] PCI: If a device doesn't work, try "pci=3Drouteirq".  If i=
t helps, post a report
[   19.593555] Calling initcall 0xffffffff8060f386: pci_legacy_init+0x0/0=
x120()
[   19.614730] Calling initcall 0xffffffff8060f7e3: pcibios_irq_init+0x0/=
0x49a()
[   19.636157] Calling initcall 0xffffffff8060fc7d: pcibios_init+0x0/0x66=
()
[   19.656362] Calling initcall 0xffffffff8060fff2: proto_init+0x0/0x31()
[   19.675977] Calling initcall 0xffffffff80610086: net_dev_init+0x0/0x1f=
a()
[   19.696517] Calling initcall 0xffffffff8061075e: pktsched_init+0x0/0xb=
7()
[   19.716902] Calling initcall 0xffffffff80610821: tc_filter_init+0x0/0x=
3b()
[   19.737561] Calling initcall 0xffffffff80610a5d: genl_init+0x0/0xa5()
[   19.756926] Calling initcall 0xffffffff805f884c: late_hpet_init+0x0/0x=
b7()
[   19.777585] hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IR=
Qs 2, 8, 0
[   19.799810] hpet0: 3 64-bit timers, 14318180 Hz
[   19.814397] Calling initcall 0xffffffff805ffacb: pci_iommu_init+0x0/0x=
5a0()
[   19.835479] PCI-DMA: Disabling IOMMU.
[   19.846454] Calling initcall 0xffffffff8060584a: init_pipe_fs+0x0/0x40=
()
[   19.866607] Calling initcall 0xffffffff8060a85e: acpi_motherboard_init=
+0x0/0x1b3()
[   19.891981] Calling initcall 0xffffffff8060ab0e: pnp_system_init+0x0/0=
xc()
[   19.912783] Calling initcall 0xffffffff8060aee2: chr_dev_init+0x0/0x7d=
()
[   19.934724] Calling initcall 0xffffffff8060e5bf: init_pcmcia_bus+0x0/0=
x48()
[   19.955690] Calling initcall 0xffffffff8060edd4: cpufreq_gov_performan=
ce_init+0x0/0xc()
[   19.979732] Calling initcall 0xffffffff8060ede0: cpufreq_gov_userspace=
_init+0x0/0x1c()
[   20.003509] Calling initcall 0xffffffff8060edfc: pcibios_assign_resour=
ces+0x0/0x74()
[   20.026798] PCI: Bridge: 0000:01:00.0
[   20.037773]   IO window: disabled.
[   20.047964]   MEM window: disabled.
[   20.058410]   PREFETCH window: disabled.
[   20.070164] PCI: Bridge: 0000:01:00.2
[   20.081138]   IO window: d000-dfff
[   20.091332]   MEM window: dfe00000-dfefffff
[   20.103868]   PREFETCH window: disabled.
[   20.115623] PCI: Bridge: 0000:00:02.0
[   20.126593]   IO window: d000-dfff
[   20.136787]   MEM window: dfe00000-dfefffff
[   20.149322]   PREFETCH window: disabled.
[   20.161082] PCI: Bridge: 0000:00:03.0
[   20.172054]   IO window: disabled.
[   20.182243]   MEM window: dfd00000-dfdfffff
[   20.194775]   PREFETCH window: disabled.
[   20.206533] PCI: Bridge: 0000:00:04.0
[   20.217500]   IO window: c000-cfff
[   20.227682]   MEM window: dfb00000-dfcfffff
[   20.240221]   PREFETCH window: d0000000-d7ffffff
[   20.254061] PCI: Bridge: 0000:00:1e.0
[   20.265032]   IO window: b000-bfff
[   20.275224]   MEM window: disabled.
[   20.285666]   PREFETCH window: disabled.
[   20.297447] GSI 16 sharing vector 0xA9 and IRQ 16
[   20.311552] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low)=
 -> IRQ 169
[   20.334025] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   20.352838] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   20.371647] PCI: Setting latency timer of device 0000:01:00.2 to 64
[   20.390465] ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low)=
 -> IRQ 0
[   20.412419] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   20.431221] ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low)=
 -> IRQ 0
[   20.453166] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   20.471972] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   20.490780] Calling initcall 0xffffffff8060fe6a: fill_mp_bus_to_cpumas=
k+0x0/0xd8()
[   20.513520] Calling initcall 0xffffffff80113380: time_init_device+0x0/=
0x20()
[   20.534858] Calling initcall 0xffffffff805f939a: i8259A_init_sysfs+0x0=
/0x22()
[   20.556463] Calling initcall 0xffffffff805f937a: init_timer_sysfs+0x0/=
0x20()
[   20.577791] Calling initcall 0xffffffff805f99ae: vsyscall_init+0x0/0x7=
f()
[   20.598198] Calling initcall 0xffffffff805f9bdc: sbf_init+0x0/0xcb()
[   20.617284] Simple Boot Flag at 0x7a set to 0x1
[   20.630864] Calling initcall 0xffffffff805fa66a: i8237A_init_sysfs+0x0=
/0x20()
[   20.652447] Calling initcall 0xffffffff805fa697: periodic_mcheck_init+=
0x0/0x26()
[   20.674672] Calling initcall 0xffffffff805fa6bd: mce_init_device+0x0/0=
x8c()
[   20.696516] Calling initcall 0xffffffff805fa7f3: threshold_init_device=
+0x0/0x79()
[   20.719830] Calling initcall 0xffffffff805fb4c4: msr_init+0x0/0x130()
[   20.740005] Calling initcall 0xffffffff805fb5f4: cpuid_init+0x0/0x130(=
)
[   20.760679] Calling initcall 0xffffffff805fc03e: init_lapic_sysfs+0x0/=
0x32()
[   20.782021] Calling initcall 0xffffffff805fc5fe: ioapic_init_sysfs+0x0=
/0xb7()
[   20.803978] Calling initcall 0xffffffff80124325: cache_sysfs_init+0x0/=
0x70()
[   20.825153] Calling initcall 0xffffffff80600afc: x8664_sysctl_init+0x0=
/0x16()
[   20.846598] Calling initcall 0xffffffff80602136: ia32_init+0x0/0x13()
[   20.865941] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 =
ak Exp $
[   20.887611] Calling initcall 0xffffffff80602149: ia32_binfmt_init+0x0/=
0x16()
[   20.908782] Calling initcall 0xffffffff8060216b: init_syscall32+0x0/0x=
57()
[   20.929445] Calling initcall 0xffffffff80602828: create_proc_profile+0=
x0/0x38e()
[   20.951667] Calling initcall 0xffffffff80602d4f: ioresources_init+0x0/=
0x3f()
[   20.972842] Calling initcall 0xffffffff80602ede: uid_cache_init+0x0/0x=
88()
[   20.993546] Calling initcall 0xffffffff8060322e: param_sysfs_init+0x0/=
0x16c()
[   21.022169] Calling initcall 0xffffffff8060339a: init_posix_timers+0x0=
/0xa9()
[   21.043677] Calling initcall 0xffffffff8060346f: init_posix_cpu_timers=
+0x0/0xb4()
[   21.066166] Calling initcall 0xffffffff80603523: init+0x0/0x7a()
[   21.084249] Calling initcall 0xffffffff8060359d: proc_dma_init+0x0/0x2=
2()
[   21.104644] Calling initcall 0xffffffff801521ce: percpu_modinit+0x0/0x=
70()
[   21.125302] Calling initcall 0xffffffff806035cc: kallsyms_init+0x0/0x2=
5()
[   21.145698] Calling initcall 0xffffffff806037c8: audit_init+0x0/0xe7()
[   21.165307] audit: initializing netlink socket (disabled)
[   21.181528] audit(1135167241.040:1): initialized
[   21.195376] Calling initcall 0xffffffff806038af: init_kprobes+0x0/0x3f=
()
[   21.215516] Calling initcall 0xffffffff806042c6: init_per_zone_pages_m=
in+0x0/0x50()
[   21.238523] Calling initcall 0xffffffff80604e15: pdflush_init+0x0/0x13=
()
[   21.258746] Calling initcall 0xffffffff80604e28: cpucache_init+0x0/0x4=
d()
[   21.279138] Calling initcall 0xffffffff80605363: kswapd_init+0x0/0x5d(=
)
[   21.299025] Calling initcall 0xffffffff806053ee: procswaps_init+0x0/0x=
22()
[   21.319680] Calling initcall 0xffffffff80605440: hugetlb_init+0x0/0x88=
()
[   21.339809] Total HugeTLB memory allocated, 0
[   21.352866] Calling initcall 0xffffffff8060553a: init_tmpfs+0x0/0xd5()
[   21.372530] Calling initcall 0xffffffff8060588a: fasync_init+0x0/0x2a(=
)
[   21.392434] Calling initcall 0xffffffff80605eca: aio_setup+0x0/0x65()
[   21.412025] Calling initcall 0xffffffff80605f2f: inotify_setup+0x0/0xc=
d()
[   21.432493] Calling initcall 0xffffffff80605ffc: eventpoll_init+0x0/0x=
106()
[   21.453490] Calling initcall 0xffffffff80606102: init_sys32_ioctl+0x0/=
0x82()
[   21.474681] Calling initcall 0xffffffff806061d1: init_mbcache+0x0/0x1d=
()
[   21.494811] Calling initcall 0xffffffff806061ee: dquot_init+0x0/0xe7()
[   21.514406] VFS: Disk quotas dquot_6.5.1
[   21.526224] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   21.545544] Calling initcall 0xffffffff806062d5: init_v2_quota_format+=
0x0/0xc()
[   21.567503] Calling initcall 0xffffffff806062e1: dnotify_init+0x0/0x2a=
()
[   21.587662] Calling initcall 0xffffffff80606744: init_devpts_fs+0x0/0x=
33()
[   21.608332] Calling initcall 0xffffffff80606777: init_ext2_fs+0x0/0x63=
()
[   21.628534] Calling initcall 0xffffffff80606817: init_ramfs_fs+0x0/0xc=
()
[   21.648659] Calling initcall 0xffffffff80606823: init_hugetlbfs_fs+0x0=
/0x76()
[   21.670148] Calling initcall 0xffffffff80606899: init_iso9660_fs+0x0/0=
x65()
[   21.691103] Calling initcall 0xffffffff8060698e: init_nls_cp437+0x0/0x=
c()
[   21.711493] Calling initcall 0xffffffff8060699a: init_nls_ascii+0x0/0x=
c()
[   21.731969] Calling initcall 0xffffffff806069e6: ipc_init+0x0/0x14()
[   21.751098] Calling initcall 0xffffffff80606be1: init_mqueue_fs+0x0/0x=
ef()
[   21.771802] Calling initcall 0xffffffff80606e3a: key_proc_init+0x0/0x5=
2()
[   21.792198] Calling initcall 0xffffffff80606fb9: selinux_nf_ip_init+0x=
0/0x57()
[   21.813885] SELinux:  Registering netfilter hooks
[   21.848928] Calling initcall 0xffffffff80607103: init_sel_fs+0x0/0x5e(=
)
[   21.868936] Calling initcall 0xffffffff80607181: selnl_init+0x0/0x3f()
[   21.888546] Calling initcall 0xffffffff806071c0: sel_netif_init+0x0/0x=
63()
[   21.909195] Calling initcall 0xffffffff806072ae: init_crypto+0x0/0x18(=
)
[   21.929062] Initializing Cryptographic API
[   21.941342] Calling initcall 0xffffffff806072e6: init+0x0/0xc()
[   21.959115] Calling initcall 0xffffffff806072f2: init+0x0/0xc()
[   21.976891] Calling initcall 0xffffffff806072fe: ksign_init+0x0/0x3c()
[   21.996491] ksign: Installing public key data
[   22.009545] Loading keyring
[   22.017936] - Added public key 11E9AB2B25FA5C
[   22.031000] - User ID: Red Hat, Inc. (Kernel Module GPG key)
[   22.047974] Calling initcall 0xffffffff8060743b: noop_init+0x0/0xc()
[   22.067047] io scheduler noop registered
[   22.078807] Calling initcall 0xffffffff80607447: as_init+0x0/0x4f()
[   22.097653] io scheduler anticipatory registered
[   22.111498] Calling initcall 0xffffffff80607496: deadline_init+0x0/0x4=
f()
[   22.131907] io scheduler deadline registered
[   22.144714] Calling initcall 0xffffffff806074e5: cfq_init+0x0/0xcc()
[   22.163882] io scheduler cfq registered
[   22.175379] Calling initcall 0xffffffff802117e4: pci_init+0x0/0x2b()
[   22.194461] Intel E7520/7320/7525 detected.<7>Calling initcall 0xfffff=
fff80607d40: pci_sysfs_init+0x0/0x30()
[   22.225343] Calling initcall 0xffffffff80607d70: pci_proc_init+0x0/0x8=
5()
[   22.245797] Calling initcall 0xffffffff80607df5: pcie_portdrv_init+0x0=
/0x23()
[   22.267479] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low)=
 -> IRQ 0
[   22.289426] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   22.308230] pcie_portdrv_probe->Dev[3595:8086] has invalid IRQ. Check =
vendor BIOS
[   22.330728] Allocate Port Service[pcie00]
[   22.342933] Allocate Port Service[pcie01]
[   22.355135] ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low)=
 -> IRQ 0
[   22.377094] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   22.395904] pcie_portdrv_probe->Dev[3596:8086] has invalid IRQ. Check =
vendor BIOS
[   22.418383] Allocate Port Service[pcie00]
[   22.430576] Allocate Port Service[pcie01]
[   22.442766] ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low)=
 -> IRQ 0
[   22.464718] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   22.483522] pcie_portdrv_probe->Dev[3597:8086] has invalid IRQ. Check =
vendor BIOS
[   22.506005] Allocate Port Service[pcie00]
[   22.518184] Allocate Port Service[pcie01]
[   22.530395] Calling initcall 0xffffffff80607e18: pci_hotplug_init+0x0/=
0x50()
[   22.551587] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   22.568308] Calling initcall 0xffffffff806081ed: fb_console_init+0x0/0=
x63()
[   22.589221] Calling initcall 0xffffffff80608c3a: vesafb_init+0x0/0x207=
()
[   22.609712] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc200101=
00000, using 3072k, total 16384k
[   22.637658] vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D9
[   22.655931] vesafb: scrolling: redraw
[   22.666904] vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
[   22.683612] vesafb: Mode is not VGA compatible
[   22.736770] Console: switching to colour frame buffer device 128x48
[   22.755810] fb0: VESA VGA frame buffer device
[   22.769044] Calling initcall 0xffffffff8060a179: acpi_fan_init+0x0/0x5=
d()
[   22.789718] Calling initcall 0xffffffff8060a260: irqrouter_init_sysfs+=
0x0/0x37()
[   22.812382] Calling initcall 0xffffffff8060a3ff: acpi_processor_init+0=
x0/0xa9()
[   22.834810] Calling initcall 0xffffffff8060a4a8: acpi_container_init+0=
x0/0x43()
[   22.926843] Calling initcall 0xffffffff8060a4eb: acpi_thermal_init+0x0=
/0x5d()
[   22.948588] Calling initcall 0xffffffff8060af6d: rand_initialize+0x0/0=
x2a()
[   22.969783] Calling initcall 0xffffffff8060afec: tty_init+0x0/0x1cc()
[   23.004504] Calling initcall 0xffffffff8060b1b8: pty_init+0x0/0x248()
[   23.024170] Calling initcall 0xffffffff8060b89f: rtc_init+0x0/0x1ca()
[   23.043964] Real Time Clock Driver v1.12
[   23.055878] Calling initcall 0xffffffff8060ba69: hpet_init+0x0/0x62()
[   23.075646] Calling initcall 0xffffffff8060bacb: agp_init+0x0/0x23()
[   23.095002] Linux agpgart interface v0.101 (c) Dave Jones
[   23	=CA=AA=82=82=BA=EA=81Calling initcall 0xffffffff8060bbe9: agp_inte=
l_init+0x0/0x1d()
[   23.095308] Calling initcall 0xffffffff8060bc06: serio_init+0x0/0x96()
[   23.095416] Calling initcall 0xffffffff8060bd1f: i8042_init+0x0/0x8f2(=
)
[   23.109350] PNP: No PS/2 controller found. Probing ports directly.
[   23.111613] serio: i8042 AUX port at 0x60,0x64 irq 12
[   23.111807] serio: i8042 KBD port at 0x60,0x64 irq 1
[   23.111814] Calling initcall 0xffffffff8060c611: serport_init+0x0/0x2a=
()
[   23.111822] Calling initcall 0xffffffff8060c94e: serial8250_init+0x0/0=
x105()
[   23.111829] Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ =
sharing enabled
=FF[   23.368301] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[   23.647821] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[   23.677434] Calling initcall 0xffffffff8060cb22: serial8250_pnp_init+0=
x0/0xc()
[   23.703698] Calling initcall 0xffffffff8060cb2e: serial8250_pci_init+0=
x0/0xe()
[   23.729946] Calling initcall 0xffffffff8060d132: firmware_class_init+0=
x0/0x68()
[   23.756399] Calling initcall 0xffffffff8060d1d7: rd_init+0x0/0x1c6()
[   23.783921] RAMDISK driver initialized: 16 RAM disks of 16384K size 10=
24 blocksize
[   23.811528] Calling initcall 0xffffffff8060d3e3: net_olddevs_init+0x0/=
0xa9()
[   23.837990] Calling initcall 0xffffffff80278eba: aec62xx_ide_init+0x0/=
0xe()
[   23.864048] Calling initcall 0xffffffff802794b4: ali15x3_ide_init+0x0/=
0xe()
[   23.890135] Calling initcall 0xffffffff8027aa24: amd74xx_ide_init+0x0/=
0xe()
[   23.910796] Calling initcall 0xffffffff8027bd77: atiixp_ide_init+0x0/0=
xe()
[   23.910805] Calling initcall 0xffffffff8027c360: cmd64x_ide_init+0x0/0=
xe()
[   23.910813] Calling initcall 0xffffffff8027d616: cs5520_ide_init+0x0/0=
xe()
[   23.910819] Calling initcall 0xffffffff8027da30: cs5530_ide_init+0x0/0=
xe()
[   23.910826] Calling initcall 0xffffffff8027e064: cy82c693_ide_init+0x0=
/0xe()
[   23.910832] Calling initcall 0xffffffff8027e308: hpt34x_ide_init+0x0/0=
xe()
[   23.910838] Calling initcall 0xffffffff8027e919: hpt366_ide_init+0x0/0=
xe()
[   23.910844] Calling initcall 0xffffffff8060d4d4: it821x_ide_init+0x0/0=
xe()
[   23.910851] Calling initcall 0xffffffff80280e05: pdc202xx_ide_init+0x0=
/0xe()
[   23.910861] Calling initcall 0xffffffff80281d39: pdc202new_ide_init+0x=
0/0xe()
[   23.910878] Calling initcall 0xffffffff8060d4e2: piix_ide_init+0x0/0xc=
0()
[   23.910892] Calling initcall 0xffffffff802830b0: rz1000_ide_init+0x0/0=
xe()
[   23.910902] Calling initcall 0xffffffff8028331f: svwks_ide_init+0x0/0x=
e()
[   23.910912] Calling initcall 0xffffffff80283e83: siimage_ide_init+0x0/=
0xe()
[   23.910922] Calling initcall 0xffffffff80285410: sis5513_ide_init+0x0/=
0xe()
[   23.910933] Calling initcall 0xffffffff802868fc: slc90e66_ide_init+0x0=
/0xe()
[   23.910948] Calling initcall 0xffffffff80286ffb: triflex_ide_init+0x0/=
0xe()
[   23.910958] Calling initcall 0xffffffff8028740d: via_ide_init+0x0/0xe(=
)
[   23.910968] Calling initcall 0xffffffff80287fb2: generic_ide_init+0x0/=
0xe()
[   23.910979] Calling initcall 0xffffffff8060d622: ide_init+0x0/0x74()
[   23.910988] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   23.910994] ide: Assuming 33MHz system bus speed for PIO modes; overri=
de with idebus=3Dxx
[   23.911151] ICH5: IDE controller at PCI slot 0000:00:1f.1
[   23.911195] GSI 18 sharing vector 0xB1 and IRQ 18
[   23.911201] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low)=
 -> IRQ 177
[   23.911234] ICH5: chipset revision 2
[   23.911239] ICH5: not 100% native mode: will probe irqs later
[   23.911256]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA,=
 hdd:pio
[   23.911304] Probing IDE interface ide1...
[   24.646177] hdc: HL-DT-ST RW/DVD GCC-4481B, ATAPI CD/DVD-ROM drive
[   25.341098] ide1 at 0x170-0x177,0x376 on irq 15
[   25.365733] Calling initcall 0xffffffff8060e50f: ide_generic_init+0x0/=
0xf()
[   25.392412] Probing IDE interface ide0...
[   25.971777] Calling initcall 0xffffffff8060e51e: idedisk_init+0x0/0xc(=
)
[   25.997653] Calling initcall 0xffffffff8060e52a: ide_cdrom_init+0x0/0x=
c()
[   26.024582] hdc: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(3=
3)
[   26.050830] Uniform CD-ROM driver Revision: 3.20
[   26.052895] Calling initcall 0xffffffff8060e536: idefloppy_init+0x0/0x=
1e()
[   26.052909] ide-floppy driver 0.99.newide
[   26.053185] Calling initcall 0xffffffff8060e554: cdrom_init+0x0/0xa()
[   26.053195] Calling initcall 0xffffffff8060e680: nonstatic_sysfs_init+=
0x0/0xc()
[   26.053215] Calling initcall 0xffffffff8060e68c: yenta_socket_init+0x0=
/0xe()
[   26.060245] Calling initcall 0xffffffff8060e8a5: mon_init+0x0/0xf6()
[   26.060308] Calling initcall 0xffffffff8060e99b: usb_usual_init+0x0/0x=
8b()
[   26.060503] usbcore: registered new driver libusual
[   26.060508] Calling initcall 0xffffffff8060ea2d: hid_init+0x0/0x3e()
[   26.068132] usbcore: registered new driver hiddev
[   26.068322] usbcore: registered new driver usbhid
[   26.068325] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   26.068329] Calling initcall 0xffffffff8060ebcc: mousedev_init+0x0/0xb=
7()
[   26.069005] mice: PS/2 mouse device common for all mice
[   26.069010] Calling initcall 0xffffffff8060ec83: evdev_init+0x0/0x11()
[   26.069018] Calling initcall 0xffffffff8060ec94: atkbd_init+0x0/0x13()
[   26.069028] Calling initcall 0xffffffff8060eca7: psmouse_init+0x0/0x15=
()
[   26.069035] Calling initcall 0xffffffff8060ecbc: md_init+0x0/0x118()
[   26.069041] md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
[   26.069044] md: bitmap version 4.39
[   26.069121] Calling initcall 0xffffffff80610458: flow_cache_init+0x0/0=
x1d2()
[   26.070898] Calling initcall 0xffffffff8061062a: dv_init+0x0/0x3()
[   26.070911] Calling initcall 0xffffffff8061065e: llc_init+0x0/0x58()
[   26.070921] Calling initcall 0xffffffff806106b6: snap_init+0x0/0x2e()
[   26.070934] Calling initcall 0xffffffff806106e4: rif_init+0x0/0x7a()
[   26.070950] Calling initcall 0xffffffff80610815: blackhole_module_init=
+0x0/0xc()
[   26.070962] Calling initcall 0xffffffff806115bc: inet_init+0x0/0x386()
[   26.114947] input: AT Translated Set 2 keyboard as /class/input/input0
[   26.416768] input: ImExPS/2 Logitech Wheel Mouse as /class/input/input=
1
[   26.810118] NET: Registered protocol family 2
[   26.885065] IP route cache hash table entries: 32768 (order: 6, 262144=
 bytes)
[   26.914892] TCP established hash table entries: 131072 (order: 10, 419=
4304 bytes)
[   26.951049] TCP bind hash table entries: 65536 (order: 9, 2097152 byte=
s)
[   26.981439] TCP: Hash tables configured (established 131072 bind 65536=
)
[   27.008628] TCP reno registered
[   27.025519] Calling initcall 0xffffffff8032a377: init+0x0/0x11()
[   27.050851] Calling initcall 0xffffffff80611b66: init_syncookies+0x0/0=
x16()
[   27.079017] Calling initcall 0xffffffff80611b7c: bictcp_register+0x0/0=
xc()
[   27.106753] TCP bic registered
[   27.122839] Calling initcall 0xffffffff80611ce0: xfrm_user_init+0x0/0x=
4a()
[   27.150724] Initializing IPsec netlink socket
[   27.170915] Calling initcall 0xffffffff80611d2a: af_unix_init+0x0/0x66=
()
[   27.198309] NET: Registered protocol family 1
[   27.218496] Calling initcall 0xffffffff80611d90: packet_init+0x0/0x53(=
)
[   27.245572] NET: Registered protocol family 17
[   27.266007] Calling initcall 0xffffffff805fc300: init_lapic_nmi_sysfs+=
0x0/0x34()
[   27.295816] Calling initcall 0xffffffff805fec6f: powernowk8_init+0x0/0=
x6c()
[   27.324168] Calling initcall 0xffffffff805ff78c: centrino_init+0x0/0x1=
c()
[   27.351917] Calling initcall 0xffffffff80157dd3: software_resume+0x0/0=
x18c()
[   27.380471] Calling initcall 0xffffffff80240a90: acpi_poweroff_init+0x=
0/0x59()
[   27.409660] Calling initcall 0xffffffff806096a3: acpi_wakeup_device_in=
it+0x0/0xe2()
[   27.439947] ACPI wakeup devices:=20
[   27.457015] VBTN PCI0 PCI1 PCI2 PCI3 PCI4 PCI5 PCI6  KBD USB0 USB1 USB=
2 USB3=20
[   27.486095] Calling initcall 0xffffffff806097a6: acpi_sleep_init+0x0/0=
x9c()
[   27.514519] ACPI: (supports S0 S1 S3 S4 S5)
[   27.534619] Calling initcall 0xffffffff80240fc0: acpi_sleep_proc_init+=
0x0/0x6b()
[   27.564410] Calling initcall 0xffffffff8060af5f: seqgen_init+0x0/0xe()
[   27.591497] Calling initcall 0xffffffff8060cc3f: early_uart_console_sw=
itch+0x0/0x7c()
[   27.614800] Calling initcall 0xffffffff802ead95: net_random_reseed+0x0=
/0x4e()
[   27.651955] Freeing unused kernel memory: 224k freed
[   27.674625] Write protecting the kernel read-only data: 850k
[   27.781006] SCSI subsystem initialized
[   27.822936] libata version 1.20 loaded.
[   27.852140] ata_piix 0000:00:1f.2: version 1.05
[   27.872793] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low)=
 -> IRQ 0
[   27.901789] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   27.927731] ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0=
 irq 0
[   27.956018] ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8=
 irq 0
[   27.984182] Unable to handle kernel NULL pointer dereference at 000000=
0000000000 RIP:=20
[   28.000848] <ffffffff802742c5>{make_class_name+27}
[   28.019121] PGD 3ecef067 PUD 3ecf0067 PMD 0=20
[   28.019128] Oops: 0000 [1] SMP=20
[   28.019131] last sysfs file: /block/ram0/dev
[   28.019133] CPU 1=20
[   28.019135] Modules linked in: ata_piix libata sd_mod scsi_mod
[   28.019142] Pid: 393, comm: insmod Not tainted 2.6.14-1.1777_FC5 #1
[   28.019144] RIP: 0010:[<ffffffff802742c5>] <ffffffff802742c5>{make_cla=
ss_name+27}
[   28.019150] RSP: 0000:ffff81003ece1a38  EFLAGS: 00010246
[   28.019153] RAX: 0000000000000000 RBX: ffff81003f539420 RCX: fffffffff=
fffffff
[   28.019156] RDX: ffff81003f539420 RSI: ffffffffffffffff RDI: 000000000=
0000000
[   28.019159] RBP: ffff81003f539420 R08: 0000000000000000 R09: ffff81003=
ecc09f0
[   28.019163] R10: 0000000000000002 R11: ffffffff88047033 R12: ffffffff8=
80272b0
[   28.019166] R13: ffffffff880271c0 R14: 000000000000fea8 R15: 000000000=
0000000
[   28.019170] FS:  000000000057e850(0063) GS:ffffffff805c7080(0000) knlG=
S:0000000000000000
[   28.019172] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   28.019175] CR2: 0000000000000000 CR3: 000000003f5e0000 CR4: 000000000=
00006e0
[   28.019179] Process insmod (pid: 393, threadinfo ffff81003ece0000, tas=
k ffff81003fa3b7e0)
[   28.019181] Stack: ffff81003fe89080 0000000004000000 ffff810002a61b20 =
ffff81003f539420=20
[   28.019190]        ffffffff880272a0 ffffffff8027454a ffffffff80593620 =
ffff81003f539420=20
[   28.019198]        ffff81003f539000 0000000000000246=20
[   28.019203] Call Trace:<ffffffff8027454a>{class_device_del+187} <fffff=
fff80274605>{class_device_unregister+9}
[   28.019213]        <ffffffff88003d4e>{:scsi_mod:scsi_remove_host+274} =
<ffffffff88040a34>{:libata:ata_host_remove+16}
[   28.019247]        <ffffffff88044221>{:libata:ata_device_add+3558} <ff=
ffffff80139c05>{printk+78}
[   28.019264]        <ffffffff80139c05>{printk+78} <ffffffff8016ac96>{po=
ison_obj+35}
[   28.019274]        <ffffffff802d8595>{pci_mmcfg_read+70} <ffffffff8020=
fa41>{pci_bus_write_config_byte+79}
[   28.019286]        <ffffffff802d6c22>{pcibios_set_master+126} <fffffff=
f88044572>{:libata:ata_pci_init_one+633}
[   28.019300]        <ffffffff8020fb36>{pci_bus_read_config_word+111} <f=
fffffff802d854f>{pci_mmcfg_read+0}
[   28.019307]        <ffffffff88059707>{:ata_piix:piix_init_one+465} <ff=
ffffff802138e0>{pci_device_probe+248}
[   28.019321]        <ffffffff80273b6b>{driver_probe_device+63} <fffffff=
f80273c82>{__driver_attach+76}
[   28.019329]        <ffffffff80273c36>{__driver_attach+0} <ffffffff8027=
36fa>{bus_for_each_dev+67}
[   28.019336]        <ffffffff80273251>{bus_add_driver+115} <ffffffff802=
1363a>{__pci_register_driver+167}
[   28.019344]        <ffffffff88065014>{:ata_piix:piix_init+20} <fffffff=
f80154acd>{sys_init_module+278}
[   28.019354]        <ffffffff8010f8ca>{system_call+126}=20
[   28.019362]=20
[   28.019362] Code: f2 ae 48 89 ca 48 f7 d2 48 8b 45 60 48 8b 38 48 89 f=
1 44 89=20
[   28.019374] RIP <ffffffff802742c5>{make_class_name+27} RSP <ffff81003e=
ce1a38>
[   28.019379] CR2: 0000000000000000
[   28.019381]  <6>device-mapper: 4.4.0-ioctl (2005-01-12) initialised: d=
m-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   29.243103] cdrom: open failed.
[   29.288795] cdrom: open failed.
[   29.443190] Kernel panic - not syncing: Attempted to kill init!



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
