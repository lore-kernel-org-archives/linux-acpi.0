From: TJ <linux@tjworld.net>
Subject: acpi_scan_rsdp() breaks some PCs by not honouring ACPI
	specification
Date: Tue, 25 Sep 2007 08:37:43 +0100
Message-ID: <1190705863.9409.7.camel@hephaestion.lan.tjworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [66.6.122.20] ([66.6.122.20]:54468 "EHLO tjworld.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbXIYHpJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2007 03:45:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

I've been debugging an ACPI-disabled-at-boot failure on an Acer
Travelmate C104TCi (C100) with a Wistron BIOS.

[ 0.000000] DMI 2.3 present.
[ 0.000000] ACPI: RSDP 000EC2D0, 0014 (r0 Acer )
[ 0.000000] ACPI: =01 00000000, F000FF5A (r195 Z=C3=BF F000FF57 Z=C3=BF=
 F000FEA5)
[ 27.751333] ACPI: Core revision 20070126
[ 27.751501] ACPI Exception (tbxface-0618): AE_NO_ACPI_TABLES, While
loading namespace from ACPI tables [20070126]
[ 27.751654] ACPI: Unable to load the System Description Tables
[ 27.783596] ACPI: Interpreter disabled.

There are several references to this problem around the net and a coupl=
e
of invasive kernel patches that don't address the cause.

I wrote a user-space application that scans memory using the method
described in the ACPI specifications. It reports:

$ sudo ./find-RSDP

find-RSDP version 0.1 =C2=A9 2007 TJ
Licensed on the terms of GPL version 3

=46inds ACPI Root System Descriptor Pointer (for supported BIOS's only)=
=2E

0x00000000FFFFFFFF Memory size
0x00000000000EC2D0 "RSD PTR "
0x00000000000FE030 "RSD PTR " RSDT @ 0FFE0000 OEM: "Acer " sum: 0
0x0000000005FBFE10 "RSD PTR "

Unfortunately the kernel function

arch/i386/kernel/acpi/boot.c::acpi_scan_rsdp()

doesn't fully implement the ACPI specification - it simply looks for th=
e
first "RSD PTR " signature but doesn't check it has found a valid table
by calculating the checksum.

Because this series of BIOSs happen to have multiple instances of "RSD
PTR " and an invalid instance appears first in memory, the kernel tries
to use an invalid pointer to the RSDT, leading to the problems.

I've prepared a simple patch that calculates the checksum and only
returns an RSDT pointer if the checksum =3D=3D 0.


Regards,

TJ.
Ubuntu Kernel ACPI Team

=3D=3D Results With Patch Applied =3D=3D
[    0.000000]  BIOS-e820: 000000000ffe0000 - 000000000ffe8000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 000000000ffe8000 - 0000000010000000 (ACPI NV=
S)
[    0.000000] ACPI: RSDP signature @ 0xC00EC2D0 checksum 218
[    0.000000] ACPI: RSDP signature @ 0xC00FE030 checksum 0
[    0.000000] ACPI: RSDP 000FE030, 0014 (r0 Acer  )
[    0.000000] ACPI: RSDT 0FFE0000, 002C (r1 Acer   TM100           1 M=
SFT        1)
[    0.000000] ACPI: FACP 0FFE0054, 0074 (r1 Acer   TM100           1 M=
SFT        1)
[    0.000000] ACPI: DSDT 0FFE00CC, 3E26 (r1   Acer   AN100      1000 M=
SFT  100000E)
[    0.000000] ACPI: FACS 0FFE8000, 0040
[    0.000000] ACPI: BOOT 0FFE002C, 0028 (r1 Acer   TM100           1 M=
SFT        1)
[    0.000000] ACPI: PM-Timer IO Port: 0xf008
[   18.351112] ACPI: Core revision 20070126
[   18.351387] ACPI: Looking for DSDT in initramfs... successfully read=
 13997 bytes from /DSDT.aml.
[   18.351656] ACPI: Table DSDT replaced by host OS
[   18.351784] ACPI: DSDT 00000000, 36AD (r1   Acer   AN100      1000 I=
NTL 20061109)
[   18.355337] ACPI: setting ELCR to 0200 (from 0c00)
[   18.407892] ACPI: bus type pci registered
[   18.438953] ACPI: EC: Look up EC in DSDT
[   18.445067] ACPI: EC: GPE=3D0x18, ports=3D0x66, 0x62
[   18.451387] ACPI: Interpreter enabled
[   18.451446] ACPI: (supports S0 S3 S4 S5)
[   18.451694] ACPI: Using PIC for interrupt routing
[   18.472224] ACPI: EC: GPE=3D0x18, ports=3D0x66, 0x62
[   18.472379] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   18.473052] PCI quirk: region f000-f03f claimed by PIIX4 ACPI
[   18.473388] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   18.476877] ACPI: PCI Interrupt Link [PILA] (IRQs *10 15)
[   18.477341] ACPI: PCI Interrupt Link [PILB] (IRQs *11 15)
[   18.477796] ACPI: PCI Interrupt Link [PILD] (IRQs *10 15)
[   18.478266] pnp: PnP ACPI init
[   18.478338] ACPI: bus type pnp registered
[   18.489473] pnp: PnP ACPI: found 10 devices
[   18.489535] ACPI: ACPI bus type pnp unregistered
[   18.489597] PnPBIOS: Disabled by ACPI PNP
[   18.489773] PCI: Using ACPI for IRQ routing
[   18.534358] ACPI: PCI Interrupt Link [PILA] enabled at IRQ 10
[   18.534429] ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [PILA] -> GS=
I 10 (level, low) -> IRQ 10
[   18.534590] ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [PILA] -> GS=
I 10 (level, low) -> IRQ 10
[   20.334950] ACPI: PCI Interrupt Link [PILB] enabled at IRQ 11
[   20.335025] ACPI: PCI Interrupt 0000:00:00.2[B] -> Link [PILB] -> GS=
I 11 (level, low) -> IRQ 11
[   20.335180] ACPI: PCI interrupt for device 0000:00:00.2 disabled
[   20.794419] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[   20.807239] ACPI: Thermal Zone [THR1] (32 C)
[   20.817398] ACPI: Thermal Zone [THR2] (30 C)
[   22.067049] ACPI: PCI Interrupt Link [PILD] enabled at IRQ 10
[   22.068169] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [PILD] -> GS=
I 10 (level, low) -> IRQ 10
[   22.173209] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [PILD] -> GS=
I 10 (level, low) -> IRQ 10
[   22.474602] ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [PILD] -> GS=
I 10 (level, low) -> IRQ 10
[   23.608000] ACPI: PCI Interrupt 0000:00:00.1[B] -> Link [PILB] -> GS=
I 11 (level, low) -> IRQ 11

=3D=3D Patch =3D=3D
--- arch/i386/kernel/acpi/boot.c.orig	2007-09-25 02:17:12.000000000 +01=
00
+++ arch/i386/kernel/acpi/boot.c	2007-09-25 08:31:05.000000000 +0100
@@ -592,9 +592,25 @@
 	 * RSDP signature.
 	 */
 	for (offset =3D 0; offset < length; offset +=3D 16) {
-		if (strncmp((char *)(phys_to_virt(start) + offset), "RSD PTR ", sig_=
len))
-			continue;
-		return (start + offset);
+		if (strncmp((char *)(phys_to_virt(start) + offset), "RSD PTR ", sig_=
len) =3D=3D 0) {
+			/* 2007-09-24 TJ <linux@tjworld.net>
+			 * The ACPI specification states the first 20 bytes of the RSDP tab=
le
+			 * must have a checksum of 0 (ACPI 1.0b RSDP table is 20 bytes long=
).
+			 * The signature can appear in multiple memory locations so don't r=
ely
+			 * on it as the sole proof of a valid table.
+			 * This fixes broken/disabled ACPI problems with Acer Travelmate C1=
00
+			 * (and others) where the first signature match is accepted without
+			 *  confirming the checksum.
+			 */
+			unsigned int i;
+			unsigned char checksum;
+			unsigned char *table =3D (unsigned char *)(phys_to_virt(start) + of=
fset);
+			for (checksum =3D 0, i =3D 0; i < 20; i++)
+				checksum +=3D table[i];
+
+		printk(KERN_WARNING PREFIX "RSDP signature @ 0x%0.8lX checksum %d\n"=
, table, checksum);
+			if (checksum =3D=3D 0) return (start + offset);
+		}
 	}
=20
 	return 0;

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
