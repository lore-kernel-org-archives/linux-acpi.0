From: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Subject: RE: Problem with Compaq Presario 27xx
Date: Thu, 1 Aug 2002 18:31:28 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D8C1802AADD0D346BE5C0A1D117075CC02C1C863@cceexc17.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Oops, that makes more sense now.  Now I need to figure out what's broke.

Also, after running pacpidump I updated my download file with the =
corrected .asl output just in case anyone needs it.
http://www.cpqlinux.com/Pres2701_dsdt.tgz

Here are the differences I see from "faye".  Do these changes make sense =
in order to get the battery info to work?  There seem to be quite a few =
differences from my original to "faye's" original (diff not shown):

[root@p2701 try2.dir]# diff -Naurb acpi_dsdt-orig.asl acpi_dsdt-1.7.asl
--- acpi_dsdt-orig.asl  Thu Aug  1 18:20:53 2002
+++ acpi_dsdt-1.7.asl   Thu Aug  1 18:20:53 2002
@@ -1,36 +1,28 @@
 /*
-RSD PTR: Checksum=3D163, OEMID=3DPTLTD, RsdtAddress=3D0x1ff6d2af
- */
-/*
-RSDT: Length=3D44, Revision=3D1, Checksum=3D80,
-       OEMID=3DPTLTD, OEM Table ID=3D       RSDT, OEM =
Revision=3D0x6040000,
-       Creator ID=3D LTP, Creator Revision=3D0x0
- */
-/*
-       Entries=3D{ 0x1ff73b64, 0x1ff73bd8 }
- */
-/*
-       DSDT=3D0x1ff6d2db
-       INT_MODEL=3DPIC
-       SCI_INT=3D9
-       SMI_CMD=3D0xb2, ACPI_ENABLE=3D0xf0, ACPI_DISABLE=3D0xf1, =
S4BIOS_REQ=3D0xf2
-       PM1a_EVT_BLK=3D0x1000-0x1003
-       PM1a_CNT_BLK=3D0x1004-0x1005
-       PM2_CNT_BLK=3D0x1020-0x1020
-       PM2_TMR_BLK=3D0x1008-0x100b
-       PM2_GPE0_BLK=3D0x1028-0x102b
-       PM2_GPE1_BLK=3D0x102c-0x102f, GPE1_BASE=3D16
-       P_LVL2_LAT=3D1ms, P_LVL3_LAT=3D1001ms
-       FLUSH_SIZE=3D0, FLUSH_STRIDE=3D0
-       DUTY_OFFSET=3D1, DUTY_WIDTH=3D0
-       DAY_ALRM=3D13, MON_ALRM=3D8, CENTURY=3D50
-       Flags=3D{WBINVD,PROC_C1,SLP_BUTTON}
- */
-/*
-DSDT: Length=3D26761, Revision=3D1, Checksum=3D52,
-       OEMID=3DINTEL, OEM Table ID=3DALMADOR, OEM Revision=3D0x6040000,
-       Creator ID=3DMSFT, Creator Revision=3D0x100000d
+ * $Header: /usr/local/cvs/compaq_2701ea_dsdt/acpi_dsdt.asl,v 1.7 =
2002/07/13 15
:55:49 faye Exp $
+ * $Log: acpi_dsdt.asl,v $
+ * Revision 1.7  2002/07/13 15:55:49  faye
+ * Cleaned up the headers
+ *
+ * Revision 1.6  2002/07/13 15:46:45  faye
+ * Forgot case-sensitivity.  Use Header and Log instead
+ *
+ * Revision 1.5  2002/07/13 15:31:55  faye
+ * earlier attempt to insert version didn't work
+ *
+ * Revision 1.4  2002/07/13 15:29:42  faye
+ * Added id comment
+ *
+ * Revision 1.3  2002/07/13 15:28:18  faye
+ * that's 8 BITS not 8 BYTES
+ *
+ * Revision 1.2  2002/07/11 19:12:55  faye
+ * First update. Fixes scope and region
+ *
+ * Revision 1.1  2002/07/11 19:07:48  root
+ * Initial revision
  */
+
 DefinitionBlock (
        "acpi_dsdt.aml",        //Output filename
        "DSDT",         //Signature
@@ -184,6 +176,7 @@
     Store(Zero, \_SB_.ACOK)
     Store(0x8d, \_SB_.BCMD)
     Store(Zero, \_SB_.SMIC)
+       Return(0x0)
 }
 Scope(_GPE) {
     Method(_L00) {
@@ -219,7 +212,7 @@
         Notify(\_SB_.PCI0.USB3, 0x2)
     }
 }
-Scope(_SB_) {
+Scope(\_SB_) {
     OperationRegion(SMI0, SystemIO, 0x0000fe00, 0x00000002)
     Field(SMI0, AnyAcc, NoLock, Preserve) {
         SMIC,  8
@@ -1525,7 +1518,7 @@
                     }
                 }
             }
-            Scope(_SB_) {
+            Scope(\_SB_) {
                 Name(OKEC, 0x0)
                 Name(ACOK, 0x1)
             }
@@ -2095,7 +2088,7 @@
                 Method(_PS3) {
                     Store(0x1, PMST)
                 }
-                OperationRegion(CCRD, PCI_Config, 0x0, 0xa7)
+                OperationRegion(CCRD, PCI_Config, 0x0, 0xa8)
                 Field(CCRD, DWordAcc, Lock, Preserve) {
                     Offset(0x3c),
                     CD3C,      32,
@@ -3518,8 +3511,3 @@
 }

 }
-/*
-BOOT: Length=3D40, Revision=3D1, Checksum=3D164,
-       OEMID=3DPTLTD, OEM Table ID=3D$SBFTBL$, OEM =
Revision=3D0x6040000,
-       Creator ID=3D LTP, Creator Revision=3D0x1
- */
[root@p2701 try2.dir]#


Sincerely,
Richard Black
http://www.cpqlinux.com
http://www.geocities.com/rlcomp_1999
http://www.compaq.com/linux


-----Original Message-----
From: Sourav K Mandal [mailto:smandal-DPNOqEs/LNQ@public.gmane.org]
Sent: Thursday, August 01, 2002 6:03 PM
To: Black, Richard (Hou)
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] Problem with Compaq Presario 27xx



> What fix do I need so that I can proceed to repack my dsdt table?

Use:

http://people.freebsd.org/~takawata/pacpidump.tar.gz

cat dsdt.dat | pacpidump > dsdt.asl

Then proceed.  The output you see with acpidisasm is _not_
assembly code.


Sourav


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
