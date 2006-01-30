From: Andy <winxp_escapee@btinternet.com>
Subject: ACPI dsdt.dsl Compilation Parse Error
Date: Mon, 30 Jan 2006 16:17:30 +0000 (UTC)
Message-ID: <loom.20060130T170445-625@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:29158 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932369AbWA3Qc1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jan 2006 11:32:27 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1F3bwC-00031e-UJ
	for linux-acpi@vger.kernel.org; Mon, 30 Jan 2006 17:31:33 +0100
Received: from host86-138-33-82.range86-138.btcentralplus.com ([86.138.33.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2006 17:31:32 +0100
Received: from winxp_escapee by host86-138-33-82.range86-138.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2006 17:31:32 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm trying to debug ACPI on an emachines 2220, D845GVSR motherboard,  =20
SR84510B.44T.009.PO3 system BIOS running Suse 9.3 Pro' Linux. =20
 =20
When I attempt to recompile the dsdt.dsl file I get a Parse error, =20
 =20
Suse:~ # iasl -tc dsdt.dsl =20
 =20
Intel ACPI Component Architecture =20
ASL Optimizing Compiler / AML Disassembler version 20050309 [Mar 19 20 =
=20
05] =20
Copyright (C) 2000 - 2005 Intel Corporation =20
Supports ACPI Specification Revision 3.0 =20
 =20
dsdt.dsl =C2=A03531: =C2=A0 =C2=A0 If (SS1) =20
Error =C2=A0 =C2=A01037 - =C2=A0 =C2=A0 =C2=A0^ syntax error, unexpecte=
d PARSEOP_IF =20
 =20
ASL Input: =C2=A0dsdt.dsl - 3797 lines, 118111 bytes, 1730 keywords =20
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations =
=20
Suse:~ # =20
 =20
I'm unfamiliar with this error and am uncertain how to go about fixing =
it.  =20
If anyone has any advice I'd really appreciate it. Relevant code below.=
 =20
 =20
Thanks. =20
 =20
If (SS1) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0._S1D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.P0P1._S1D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB0._S1D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB1._S1D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB2._S1D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB3._S1D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.AC97._S1D, 0x02) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 If (SS3) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0._S3D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.P0P1._S3D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB0._S3D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB1._S3D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB2._S3D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.USB3._S3D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.AC97._S3D, 0x02) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 If (SS4) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0._S4D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.P0P1._S4D, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_SB.PCI0.AC97._S4D, 0x02) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (_PTS, 1, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (Arg0, DBG8) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PTS (Arg0) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, Index (WAKP, 0x00)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, Index (WAKP, 0x01)) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 OperationRegion (RNTR, SystemIO, 0x06C0, 0x10) =20
=C2=A0 =C2=A0 Field (RNTR, ByteAcc, NoLock, WriteAsZeros) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PMST, =C2=A0 1,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x01) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Field (RNTR, ByteAcc, NoLock, Preserve) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x04),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PMEE, =C2=A0 1,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x05) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Field (RNTR, ByteAcc, NoLock, WriteAsZeros) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x0A),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EVST, =C2=A0 8 =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Field (RNTR, ByteAcc, NoLock, Preserve) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x0E),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 , =C2=A0 2,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RI1E, =C2=A0 1,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 KBDE, =C2=A0 1,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSEE, =C2=A0 1,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x0F) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 OperationRegion (\_SB.PCI0.SBRG.PMC3, PCI_Config, 0xA4, 0=
x01) =20
=C2=A0 =C2=A0 Field (\_SB.PCI0.SBRG.PMC3, ByteAcc, NoLock, Preserve) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AFG3, =C2=A0 1 =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (\_SB.PCI0.SBRG.SIOS, 1, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LOr (LEqual (Arg0, 0x01), LEqual (Arg0,=
 0x03))) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0xFF, EVST) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, KBDE) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, MSEE) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, PMST) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, PMEE) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LEqual (Arg0, 0x01)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ENFG () =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (SDID, Local0) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LEqual (Local0, 0xF0)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (LDMO, LD=
N) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, AC=
TR) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (LDKB, LD=
N) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, AC=
TR) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Else =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x06, LD=
N) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x60, OP=
T0) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EXFG () =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LEqual (Arg0, 0x05)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LEqual (LAST, 0x02)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, AF=
G3) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Else =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, AF=
G3) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (_WAK, 1, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ShiftLeft (Arg0, 0x04, DBG8) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WAK (Arg0) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, SLPS) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, SLPE) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 If (DerefOf (Index (WAKP, 0x00))) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, Index (WAKP, 0x0=
1)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Else =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (Arg0, Index (WAKP, 0x0=
1)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Return (WAKP) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (\_SB.PCI0.SBRG.SIOW, 1, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LEqual (Arg0, 0x01)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ENFG () =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (SDID, Local0) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (LEqual (Local0, 0xF0)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (LDKB, LD=
N) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, AC=
TR) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (LDMO, LD=
N) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x01, AC=
TR) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Else =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x06, LD=
N) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, OP=
T0) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EXFG () =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, PMEE) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (0x00, RI1E) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (\_SB.PCI0.SBRG.SIOH, 0, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Noop =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (\_SB.PCI0.SBRG.UAR1._PRW, 0, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Return (Package (0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1D,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Method (\_SB.PCI0.SBRG.UAR1._PSW, 1, NotSerialized) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Store (Arg0, RI1E) =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 OperationRegion (CBK2, SystemIO, 0x72, 0x02) =20
=C2=A0 =C2=A0 Field (CBK2, ByteAcc, NoLock, Preserve) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 IND, =C2=A0 =C2=A08,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DAT, =C2=A0 =C2=A08 =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 IndexField (IND, DAT, ByteAcc, NoLock, Preserve) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0xB5),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LAST, =C2=A0 2,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0xD9),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRVI, =C2=A0 8,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0xFE),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 , =C2=A0 6,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OSYS, =C2=A0 1,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PSWP, =C2=A0 1 =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 OperationRegion (SBIO, SystemIO, 0x0430, 0x08) =20
=C2=A0 =C2=A0 Field (SBIO, ByteAcc, NoLock, Preserve) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP, =C2=A0 4,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SLPE, =C2=A0 1 =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Field (SBIO, ByteAcc, NoLock, WriteAsZeros) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset (0x04),  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NONE, =C2=A0 4,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SLPS, =C2=A0 1 =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Scope (\_GPE) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L0B, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.PCI0.P0P1, 0x02)=
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L1D, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \_SB.PCI0.SBRG.SIOH () =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L03, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.PCI0.USB0, 0x02)=
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L04, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.PCI0.USB1, 0x02)=
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L0C, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.PCI0.USB2, 0x02)=
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L0D, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.PCI0.USB3, 0x02)=
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_L05, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.PCI0.AC97, 0x02)=
 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify (\_SB.SLPB, 0x02) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Device (\_SB.SLPB) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (_HID, EisaId ("PNP0C0E")) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (_UID, 0x1D) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (_STA, 0x0B) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Method (_PRW, 0, NotSerialized) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Return (GPRW (0x1D, 0x05)) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } =20
=C2=A0 =C2=A0 } =20
 =20
=C2=A0 =C2=A0 Name (\_S0, Package (0x04) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00 =20
=C2=A0 =C2=A0 }) =20
=C2=A0 =C2=A0 If (SS1) =20
=C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name (\_S1, Package (0x04) =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,  =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00 =20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) =20
=C2=A0 =C2=A0 } =20
 =20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
