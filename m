From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Mon, 28 Nov 2011 21:45:11 +0100
Message-ID: <4ED3F2D7.2020504@schinagl.nl>
References: <4E9E916A.4050007@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080302000801070801070004"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:48862 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab1K1Uoq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Nov 2011 15:44:46 -0500
Received: from [10.2.0.134] (unknown [10.2.0.134])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 8C0A51E8B3
	for <linux-acpi@vger.kernel.org>; Mon, 28 Nov 2011 21:44:44 +0100 (CET)
In-Reply-To: <4E9E916A.4050007@schinagl.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302000801070801070004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Replying to my own thread once more.

I've taken the time to fix the DSDT and removed all warnings and errors.
But even with this override, USB does not work at all. Unfortunately I
was not able to boot the same kernel as previous times so I booted my
own 3.1.1 gentoo kernel. Find attached the output of my dmesg using the
custom dsdt, the diff to my dsdt (would love some comments if the fixes
I googled ;) are reasonably porper.

Thanks for any pointers on what to try next.

Oliver

P.S. i bziped tmy dmesg as this message was 101kb and not allowed on the
list. Don't think it mentions anything much interesting new though :(

--------------080302000801070801070004
Content-Type: text/x-patch;
 name="dsdt_Asus_M5A97.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dsdt_Asus_M5A97.diff"

--- dsdt.dsl	2011-11-28 00:00:45.470292170 +0100
+++ dsdt_M5A97.dsl	2011-11-27 23:58:04.724297733 +0100
@@ -3,7 +3,7 @@
  * AML Disassembler version 20110922-64 [Nov 27 2011]
  * Copyright (c) 2000 - 2011 Intel Corporation
  * 
- * Disassembly of dsdt.dat, Mon Nov 28 00:00:45 2011
+ * Disassembly of dsdt_m5.dat, Sun Nov 27 22:47:37 2011
  *
  * Original Table Header:
  *     Signature        "DSDT"
@@ -17,7 +17,7 @@
  *     Compiler Version 0x20051117 (537202967)
  */
 
-DefinitionBlock ("dsdt.aml", "DSDT", 2, "ALASKA", "A M I", 0x00000000)
+DefinitionBlock ("dsdt_m5.aml", "DSDT", 2, "ALASKA", "A M I", 0x00000000)
 {
     Name (SP1O, 0x2E)
     Name (IO1B, 0x0290)
@@ -2277,7 +2277,7 @@
                     0x02000000,         // Range Minimum
                     0xFFDFFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
-                    0xFDFC0000,         // Length
+                    0xFDE00000,         // Length
                     ,, _Y04, AddressRangeMemory, TypeStatic)
                 QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                     0x0000000000000000, // Granularity
@@ -2391,15 +2391,15 @@
                     Add (MIN3, Decrement (Local0), MAX3)
                     If (LOr (MALH, MALL))
                     {
-                        CreateDWordField (CRS1, \_SB.PCI0._Y05._MIN, MN8L)
+                        CreateQWordField (CRS1, \_SB.PCI0._Y05._MIN, MN8L)
                         Add (0xB4, 0x04, Local0)
                         CreateDWordField (CRS1, Local0, MN8H)
                         Store (MABL, MN8L)
                         Store (MABH, MN8H)
-                        CreateDWordField (CRS1, \_SB.PCI0._Y05._MAX, MX8L)
+                        CreateQWordField (CRS1, \_SB.PCI0._Y05._MAX, MX8L)
                         Add (0xBC, 0x04, Local1)
                         CreateDWordField (CRS1, Local1, MX8H)
-                        CreateDWordField (CRS1, \_SB.PCI0._Y05._LEN, LN8L)
+                        CreateQWordField (CRS1, \_SB.PCI0._Y05._LEN, LN8L)
                         Add (0xCC, 0x04, Local2)
                         CreateDWordField (CRS1, Local2, LN8H)
                         Store (MABL, MN8L)
@@ -2453,13 +2453,13 @@
                     Add (MIN5, Decrement (Local1), MAX5)
                     If (LOr (MALH, MALL))
                     {
-                        CreateDWordField (CRS2, \_SB.PCI0._Y0B._MIN, MN9L)
+                        CreateQWordField (CRS2, \_SB.PCI0._Y0B._MIN, MN9L)
                         Add (0x72, 0x04, Local0)
                         CreateDWordField (CRS2, Local0, MN9H)
-                        CreateDWordField (CRS2, \_SB.PCI0._Y0B._MAX, MX9L)
+                        CreateQWordField (CRS2, \_SB.PCI0._Y0B._MAX, MX9L)
                         Add (0x7A, 0x04, Local1)
                         CreateDWordField (CRS2, Local1, MX9H)
-                        CreateDWordField (CRS2, \_SB.PCI0._Y0B._LEN, LN9L)
+                        CreateQWordField (CRS2, \_SB.PCI0._Y0B._LEN, LN9L)
                         Add (0x8A, 0x04, Local2)
                         CreateDWordField (CRS2, Local2, LN9H)
                         Store (MABL, MN9L)
@@ -3549,7 +3549,7 @@
                     Mutex (MUT0, 0x00)
                     Method (ENFG, 1, NotSerialized)
                     {
-                        Acquire (MUT0, 0x0FFF)
+                        Acquire (MUT0, 0x0FFFF)
                         Store (0x87, INDX)
                         Store (One, INDX)
                         Store (0x55, INDX)
@@ -3743,7 +3743,7 @@
                             {}
                     })
                     CreateWordField (CRS4, \_SB.PCI0.SBRG.SIO1._Y1F._INT, IRQL)
-                    CreateByteField (CRS4, \_SB.PCI0.SBRG.SIO1._Y1F._HE, IRQS)
+                    CreateBitField (CRS4, \_SB.PCI0.SBRG.SIO1._Y1F._HE, IRQS)
                     CreateWordField (CRS4, \_SB.PCI0.SBRG.SIO1._Y20._MIN, IOHL)
                     CreateWordField (CRS4, \_SB.PCI0.SBRG.SIO1._Y20._MAX, IORL)
                     CreateByteField (CRS4, \_SB.PCI0.SBRG.SIO1._Y20._ALN, ALMN)
@@ -6467,57 +6467,57 @@
             Method (WMBC, 3, NotSerialized)
             {
                 Store (One, Local0)
-                Name (_T_0, Zero)
-                Store (Arg1, _T_0)
-                If (LEqual (_T_0, 0x43455053))
+                Name (T_0, Zero)
+                Store (Arg1, T_0)
+                If (LEqual (T_0, 0x43455053))
                 {
                     Return (SPEC (Arg2))
                 }
                 Else
                 {
-                    If (LEqual (_T_0, 0x50564544))
+                    If (LEqual (T_0, 0x50564544))
                     {
                         Return (DEVP (Arg2))
                     }
                     Else
                     {
-                        If (LEqual (_T_0, 0x50534453))
+                        If (LEqual (T_0, 0x50534453))
                         {
                             Return (SDSP (Arg2))
                         }
                         Else
                         {
-                            If (LEqual (_T_0, 0x50534447))
+                            If (LEqual (T_0, 0x50534447))
                             {
                                 Return (GDSP (Arg2))
                             }
                             Else
                             {
-                                If (LEqual (_T_0, 0x53564544))
+                                If (LEqual (T_0, 0x53564544))
                                 {
                                     Return (DEVS (Arg2))
                                 }
                                 Else
                                 {
-                                    If (LEqual (_T_0, 0x53544344))
+                                    If (LEqual (T_0, 0x53544344))
                                     {
                                         Return (DSTS (Arg2))
                                     }
                                     Else
                                     {
-                                        If (LEqual (_T_0, 0x44495047))
+                                        If (LEqual (T_0, 0x44495047))
                                         {
                                             Return (GPID ())
                                         }
                                         Else
                                         {
-                                            If (LEqual (_T_0, 0x5446424B))
+                                            If (LEqual (T_0, 0x5446424B))
                                             {
                                                 Return (KBFT (Arg2))
                                             }
                                             Else
                                             {
-                                                If (LEqual (_T_0, 0x59454B48))
+                                                If (LEqual (T_0, 0x59454B48))
                                                 {
                                                     Return (HKEY ())
                                                 }
@@ -6570,39 +6570,39 @@
             Method (WMBD, 3, NotSerialized)
             {
                 Store (One, Local0)
-                Name (_T_0, Zero)
-                Store (Arg1, _T_0)
-                If (LEqual (_T_0, 0x424D5352))
+                Name (T_0, Zero)
+                Store (Arg1, T_0)
+                If (LEqual (T_0, 0x424D5352))
                 {
                     Return (RSMB (Arg2))
                 }
                 Else
                 {
-                    If (LEqual (_T_0, 0x424D5357))
+                    If (LEqual (T_0, 0x424D5357))
                     {
                         Return (WSMB (Arg2))
                     }
                     Else
                     {
-                        If (LEqual (_T_0, 0x574D5352))
+                        If (LEqual (T_0, 0x574D5352))
                         {
                             Return (RSMW (Arg2))
                         }
                         Else
                         {
-                            If (LEqual (_T_0, 0x574D5357))
+                            If (LEqual (T_0, 0x574D5357))
                             {
                                 Return (WSMW (Arg2))
                             }
                             Else
                             {
-                                If (LEqual (_T_0, 0x4B4D5352))
+                                If (LEqual (T_0, 0x4B4D5352))
                                 {
                                     Return (RSMK (Arg2))
                                 }
                                 Else
                                 {
-                                    If (LEqual (_T_0, 0x4B4D5357))
+                                    If (LEqual (T_0, 0x4B4D5357))
                                     {
                                         Return (WSMK (Arg2))
                                     }
@@ -6974,123 +6974,123 @@
                 CreateDWordField (Arg0, 0x04, PARA)
                 If (LEqual (PARA, One))
                 {
-                    Name (_T_0, Zero)
-                    Store (DVID, _T_0)
-                    If (LEqual (_T_0, 0x00010011))
+                    Name (T_0, Zero)
+                    Store (DVID, T_0)
+                    If (LEqual (T_0, 0x00010011))
                     {
                         Or (\_SB.DSAF, One, \_SB.DSAF)
                     }
                     Else
                     {
-                        If (LEqual (_T_0, 0x00010013))
+                        If (LEqual (T_0, 0x00010013))
                         {
                             Or (\_SB.DSAF, 0x02, \_SB.DSAF)
                         }
                         Else
                         {
-                            If (LEqual (_T_0, 0x00010023))
+                            If (LEqual (T_0, 0x00010023))
                             {
                                 Or (\_SB.DSAF, 0x04, \_SB.DSAF)
                             }
                             Else
                             {
-                                If (LEqual (_T_0, 0x00060013))
+                                If (LEqual (T_0, 0x00060013))
                                 {
                                     Or (\_SB.DSAF, 0x08, \_SB.DSAF)
                                 }
                                 Else
                                 {
-                                    If (LEqual (_T_0, 0x00060015))
+                                    If (LEqual (T_0, 0x00060015))
                                     {
                                         Or (\_SB.DSAF, 0x10, \_SB.DSAF)
                                     }
                                     Else
                                     {
-                                        If (LEqual (_T_0, 0x00010015))
+                                        If (LEqual (T_0, 0x00010015))
                                         {
                                             Or (\_SB.DSAF, 0x20, \_SB.DSAF)
                                         }
                                         Else
                                         {
-                                            If (LEqual (_T_0, 0x00090011))
+                                            If (LEqual (T_0, 0x00090011))
                                             {
                                                 Or (\_SB.DSAF, 0x40, \_SB.DSAF)
                                             }
                                             Else
                                             {
-                                                If (LEqual (_T_0, 0x00070011))
+                                                If (LEqual (T_0, 0x00070011))
                                                 {
                                                     Or (\_SB.DSAF, 0x80, \_SB.DSAF)
                                                 }
                                                 Else
                                                 {
-                                                    If (LEqual (_T_0, 0x00080013))
+                                                    If (LEqual (T_0, 0x00080013))
                                                     {
                                                         Or (\_SB.DSAF, 0x0100, \_SB.DSAF)
                                                     }
                                                     Else
                                                     {
-                                                        If (LEqual (_T_0, 0x00010019))
+                                                        If (LEqual (T_0, 0x00010019))
                                                         {
                                                             Or (\_SB.DSAF, 0x0200, \_SB.DSAF)
                                                         }
                                                         Else
                                                         {
-                                                            If (LEqual (_T_0, 0x00010017))
+                                                            If (LEqual (T_0, 0x00010017))
                                                             {
                                                                 Or (\_SB.DSAF, 0x0400, \_SB.DSAF)
                                                             }
                                                             Else
                                                             {
-                                                                If (LEqual (_T_0, 0x00050011))
+                                                                If (LEqual (T_0, 0x00050011))
                                                                 {
                                                                     Or (\_SB.DSAF, 0x0800, \_SB.DSAF)
                                                                 }
                                                                 Else
                                                                 {
-                                                                    If (LEqual (_T_0, 0x00050012))
+                                                                    If (LEqual (T_0, 0x00050012))
                                                                     {
                                                                         Or (\_SB.DSAF, 0x1000, \_SB.DSAF)
                                                                     }
                                                                     Else
                                                                     {
-                                                                        If (LEqual (_T_0, 0x00060017))
+                                                                        If (LEqual (T_0, 0x00060017))
                                                                         {
                                                                             Or (\_SB.DSAF, 0x2000, \_SB.DSAF)
                                                                         }
                                                                         Else
                                                                         {
-                                                                            If (LEqual (_T_0, 0x00080021))
+                                                                            If (LEqual (T_0, 0x00080021))
                                                                             {
                                                                                 Or (\_SB.DSAF, 0x4000, \_SB.DSAF)
                                                                             }
                                                                             Else
                                                                             {
-                                                                                If (LEqual (_T_0, 0x00100011))
+                                                                                If (LEqual (T_0, 0x00100011))
                                                                                 {
                                                                                     Or (\_SB.DSAF, 0x8000, \_SB.DSAF)
                                                                                 }
                                                                                 Else
                                                                                 {
-                                                                                    If (LEqual (_T_0, 0x00050001))
+                                                                                    If (LEqual (T_0, 0x00050001))
                                                                                     {
                                                                                         Or (\_SB.DSAF, 0x00010000, \_SB.DSAF)
                                                                                     }
                                                                                     Else
                                                                                     {
-                                                                                        If (LEqual (_T_0, 0x00120000))
+                                                                                        If (LEqual (T_0, 0x00120000))
                                                                                         {
                                                                                             Or (\_SB.DSAF, 0x00020000, \_SB.DSAF)
                                                                                         }
                                                                                         Else
                                                                                         {
-                                                                                            If (LEqual (_T_0, 0x00120021))
+                                                                                            If (LEqual (T_0, 0x00120021))
                                                                                             {
                                                                                                 Or (\_SB.DSAF, 0x00040000, \_SB.DSAF)
                                                                                             }
                                                                                             Else
                                                                                             {
-                                                                                                If (LEqual (_T_0, 0x00120011))
+                                                                                                If (LEqual (T_0, 0x00120011))
                                                                                                 {
                                                                                                     Or (\_SB.DSAF, 0x00080000, \_SB.DSAF)
                                                                                                 }
@@ -7122,123 +7122,123 @@
                 {
                     If (LEqual (PARA, Zero))
                     {
-                        Name (_T_1, Zero)
-                        Store (DVID, _T_1)
-                        If (LEqual (_T_1, 0x00010011))
+                        Name (T_1, Zero)
+                        Store (DVID, T_1)
+                        If (LEqual (T_1, 0x00010011))
                         {
                             And (\_SB.DSAF, 0xFFFFFFFFFFFFFFFE, \_SB.DSAF)
                         }
                         Else
                         {
-                            If (LEqual (_T_1, 0x00010013))
+                            If (LEqual (T_1, 0x00010013))
                             {
                                 And (\_SB.DSAF, 0xFFFFFFFFFFFFFFFD, \_SB.DSAF)
                             }
                             Else
                             {
-                                If (LEqual (_T_1, 0x00010023))
+                                If (LEqual (T_1, 0x00010023))
                                 {
                                     And (\_SB.DSAF, 0xFFFFFFFFFFFFFFFB, \_SB.DSAF)
                                 }
                                 Else
                                 {
-                                    If (LEqual (_T_1, 0x00060013))
+                                    If (LEqual (T_1, 0x00060013))
                                     {
                                         And (\_SB.DSAF, 0xFFFFFFFFFFFFFFF7, \_SB.DSAF)
                                     }
                                     Else
                                     {
-                                        If (LEqual (_T_1, 0x00060015))
+                                        If (LEqual (T_1, 0x00060015))
                                         {
                                             And (\_SB.DSAF, 0xFFFFFFFFFFFFFFEF, \_SB.DSAF)
                                         }
                                         Else
                                         {
-                                            If (LEqual (_T_1, 0x00010015))
+                                            If (LEqual (T_1, 0x00010015))
                                             {
                                                 And (\_SB.DSAF, 0xFFFFFFFFFFFFFFDF, \_SB.DSAF)
                                             }
                                             Else
                                             {
-                                                If (LEqual (_T_1, 0x00090011))
+                                                If (LEqual (T_1, 0x00090011))
                                                 {
                                                     And (\_SB.DSAF, 0xFFFFFFFFFFFFFFBF, \_SB.DSAF)
                                                 }
                                                 Else
                                                 {
-                                                    If (LEqual (_T_1, 0x00070011))
+                                                    If (LEqual (T_1, 0x00070011))
                                                     {
                                                         And (\_SB.DSAF, 0xFFFFFFFFFFFFFF7F, \_SB.DSAF)
                                                     }
                                                     Else
                                                     {
-                                                        If (LEqual (_T_1, 0x00080013))
+                                                        If (LEqual (T_1, 0x00080013))
                                                         {
                                                             And (\_SB.DSAF, 0xFFFFFFFFFFFFFEFF, \_SB.DSAF)
                                                         }
                                                         Else
                                                         {
-                                                            If (LEqual (_T_1, 0x00010019))
+                                                            If (LEqual (T_1, 0x00010019))
                                                             {
                                                                 And (\_SB.DSAF, 0xFFFFFFFFFFFFFDFF, \_SB.DSAF)
                                                             }
                                                             Else
                                                             {
-                                                                If (LEqual (_T_1, 0x00010017))
+                                                                If (LEqual (T_1, 0x00010017))
                                                                 {
                                                                     And (\_SB.DSAF, 0xFFFFFFFFFFFFFBFF, \_SB.DSAF)
                                                                 }
                                                                 Else
                                                                 {
-                                                                    If (LEqual (_T_1, 0x00050011))
+                                                                    If (LEqual (T_1, 0x00050011))
                                                                     {
                                                                         And (\_SB.DSAF, 0xFFFFFFFFFFFFF7FF, \_SB.DSAF)
                                                                     }
                                                                     Else
                                                                     {
-                                                                        If (LEqual (_T_1, 0x00050012))
+                                                                        If (LEqual (T_1, 0x00050012))
                                                                         {
                                                                             And (\_SB.DSAF, 0xFFFFFFFFFFFFEFFF, \_SB.DSAF)
                                                                         }
                                                                         Else
                                                                         {
-                                                                            If (LEqual (_T_1, 0x00060017))
+                                                                            If (LEqual (T_1, 0x00060017))
                                                                             {
                                                                                 And (\_SB.DSAF, 0xFFFFFFFFFFFFDFFF, \_SB.DSAF)
                                                                             }
                                                                             Else
                                                                             {
-                                                                                If (LEqual (_T_1, 0x00080021))
+                                                                                If (LEqual (T_1, 0x00080021))
                                                                                 {
                                                                                     And (\_SB.DSAF, 0xFFFFFFFFFFFFBFFF, \_SB.DSAF)
                                                                                 }
                                                                                 Else
                                                                                 {
-                                                                                    If (LEqual (_T_1, 0x00100011))
+                                                                                    If (LEqual (T_1, 0x00100011))
                                                                                     {
                                                                                         And (\_SB.DSAF, 0xFFFFFFFFFFFF7FFF, \_SB.DSAF)
                                                                                     }
                                                                                     Else
                                                                                     {
-                                                                                        If (LEqual (_T_1, 0x00050001))
+                                                                                        If (LEqual (T_1, 0x00050001))
                                                                                         {
                                                                                             And (\_SB.DSAF, 0xFFFFFFFFFFFEFFFF, \_SB.DSAF)
                                                                                         }
                                                                                         Else
                                                                                         {
-                                                                                            If (LEqual (_T_1, 0x00120000))
+                                                                                            If (LEqual (T_1, 0x00120000))
                                                                                             {
                                                                                                 And (\_SB.DSAF, 0xFFFFFFFFFFFDFFFF, \_SB.DSAF)
                                                                                             }
                                                                                             Else
                                                                                             {
-                                                                                                If (LEqual (_T_1, 0x00120021))
+                                                                                                If (LEqual (T_1, 0x00120021))
                                                                                                 {
                                                                                                     And (\_SB.DSAF, 0xFFFFFFFFFFFBFFFF, \_SB.DSAF)
                                                                                                 }
                                                                                                 Else
                                                                                                 {
-                                                                                                    If (LEqual (_T_1, 0x00120011))
+                                                                                                    If (LEqual (T_1, 0x00120011))
                                                                                                     {
                                                                                                         And (\_SB.DSAF, 0xFFFFFFFFFFF7FFFF, \_SB.DSAF)
                                                                                                     }
@@ -7287,9 +7287,9 @@
             {
                 CreateDWordField (Arg0, Zero, DVID)
                 CreateDWordField (Arg0, 0x04, CPAR)
-                Name (_T_0, Zero)
-                Store (DVID, _T_0)
-                If (LEqual (_T_0, Zero))
+                Name (T_0, Zero)
+                Store (DVID, T_0)
+                If (LEqual (T_0, Zero))
                 {
                     Return (Zero)
                 }
@@ -7302,15 +7302,15 @@
             Method (DSTS, 1, Serialized)
             {
                 CreateDWordField (Arg0, Zero, DVID)
-                Name (_T_0, Zero)
-                Store (DVID, _T_0)
-                If (LEqual (_T_0, 0xA0000000))
+                Name (T_0, Zero)
+                Store (DVID, T_0)
+                If (LEqual (T_0, 0xA0000000))
                 {
                     Store (One, Local0)
                 }
                 Else
                 {
-                    If (LEqual (_T_0, Zero))
+                    If (LEqual (T_0, Zero))
                     {
                         Return (Zero)
                     }
@@ -7497,7 +7497,6 @@
                     Store (CDW3, CTRL)
                     If (LNotEqual (And (SUPP, 0x16), 0x16))
                     {
-                        And (CTRL, 0x1E)
                     }
 
                     And (CTRL, 0x1D, CTRL)



--------------080302000801070801070004
Content-Type: application/x-bzip;
 name="dmesg_(gentoo)_64.bit.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg_(gentoo)_64.bit.bz2"

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
NvQCxGwQFdThDIP/xdyRThQkAuqOS8A=
--------------080302000801070801070004--
