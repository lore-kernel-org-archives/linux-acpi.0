From: Valerio Felici <valerio-3NZjWNnCfY8@public.gmane.org>
Subject: Re: Error in dsdt from asus a3527nuh
Date: Thu, 11 Nov 2004 15:35:01 +0100
Message-ID: <200411111535.01558.valerio@bgweb.it>
References: <37F890616C995246BE76B3E6B2DBE05502982B70@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Vi3kBtYdAGLKZ/3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05502982B70-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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


--Boundary-00=_Vi3kBtYdAGLKZ/3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 22:08, mercoled=EC 10 novembre 2004, Moore, Robert ha scritto:
> Just create one, Method (_INI) under _SB_
>
Ok, I've just made that and you can see the attached diff file.
I don't know if my changes are correct.
Now I don't got errors but various warning as you can see here:
=2D------
iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040527 [May 27 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl =A01592: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Scope (\_SB.PCI0)
Warning =A02031 - =A0 =A0 =A0 =A0 =A0 Internal compiler error ^ =A0(Not usi=
ng optimized=20
name- =A0did not find node)

dsdt.dsl =A02053: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 Store (ACPS (), \ACPF)
Warning =A02030 - =A0Called method may not always return a value ^

dsdt.dsl =A02054: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 Store (DCPS (0x00), \DCPF)
Warning =A02030 - =A0Called method may not always return a value ^

dsdt.dsl =A02266: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (ACPS, 0, =
Serialized)
Warning =A02019 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ^ Not all control paths=20
return=A0a value (ACPS)

dsdt.dsl =A02350: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (DCPS, 1, =
Serialized)
Warning =A02019 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ^ Not all control paths=20
return=A0a value (DCPS)

dsdt.dsl =A03105: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Scope (\_SB.PCI0)
Warning =A02031 - =A0 =A0 =A0 =A0 =A0 Internal compiler error ^ =A0(Not usi=
ng optimized
name - =A0did not find node)

dsdt.dsl =A03133: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 If (ACPS =
())
Warning =A02030 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ^ Called method may not
always =A0return a value

dsdt.dsl =A03167: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Scope (\_SB.PCI0)
Warning =A02031 - =A0 =A0 =A0 =A0 =A0 Internal compiler error ^ =A0(Not usi=
ng optimized
name -=A0did not find node)

dsdt.dsl =A03484: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 If (LNot =
(DCPS (0x00)))
Warning =A02030 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ^ Called method
may not always return a value

dsdt.dsl =A04552: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Scope (\_SB.PCI0)
Warning =A02031 - =A0 =A0 =A0 =A0 =A0 Internal compiler error ^ =A0(Not usi=
ng optimized
name - =A0did not find node)

ASL Input: =A0dsdt.dsl - 7943 lines, 271919 bytes, 3643 keywords
AML Output: DSDT.aml - 27867 bytes 873 named objects 2770 executable opcodes

Compilation complete. 0 Errors, 10 Warnings, 0 Remarks, 809 Optimizations
=2D------
Well, what can I do now?
Is that dsdt good to test? or I'm still in errors.
Many thank as always
=2D-=20
A presto
=2DValerio-

--Boundary-00=_Vi3kBtYdAGLKZ/3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dsdt.dsl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt.dsl.diff"

--- dsdt.dsl	2004-11-08 21:54:06.000000000 +0100
+++ dsdtVMF.dsl	2004-11-11 14:15:24.000000000 +0100
@@ -7813,32 +7813,38 @@
                 Return (CRS)
             }
         }
-    }
-
-    If (SS1)
-    {
+	
+	Method (_INI)
+	{
+	If (SS1)
+	{
         Name (\_SB.PCI0._S1D, 0x02)
         Name (\_SB.PCI0.P0P1._S1D, 0x02)
         Name (\_SB.PCI0.USB1._S1D, 0x02)
         Name (\_SB.PCI0.USB2._S1D, 0x02)
         Name (\_SB.PCI0.USB3._S1D, 0x02)
-    }
+	}
 
-    If (SS3)
-    {
+	If (SS3)
+	{
         Name (\_SB.PCI0._S3D, 0x02)
         Name (\_SB.PCI0.P0P1._S3D, 0x02)
         Name (\_SB.PCI0.USB1._S3D, 0x02)
         Name (\_SB.PCI0.USB2._S3D, 0x02)
         Name (\_SB.PCI0.USB3._S3D, 0x02)
-    }
+	}
 
-    If (SS4)
-    {
+	If (SS4)
+	{
         Name (\_SB.PCI0._S4D, 0x02)
         Name (\_SB.PCI0.P0P1._S4D, 0x02)
+	}
+	}
+	
     }
 
+    
+
     Method (_PTS, 1, NotSerialized)
     {
         Store (Arg0, DBG8)
@@ -7872,6 +7878,8 @@
         0x00, 
         0x00
     })
+    Method (_INI)
+    {
     If (SS1)
     {
         Name (_S1, Package (0x04)
@@ -7904,7 +7912,7 @@
             0x00
         })
     }
-
+    }
     Name (_S5, Package (0x04)
     {
         0x07, 

--Boundary-00=_Vi3kBtYdAGLKZ/3--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
