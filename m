From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Asus K8V Delux broken acpi tables?
Date: Mon, 10 Oct 2005 12:00:20 +0200
Message-ID: <434A3BB4.1050404@suse.de>
References: <43475CDB.6070204@cfl.rr.com> <4347ED97.1090504@cfl.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010500030805060000040802"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4347ED97.1090504-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010500030805060000040802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Phillip Susi wrote:
> Oops!  NOW the tarball is attached.
> Phillip Susi wrote:
> 
>> As requested, I have attached the output of lspci, dmidecode, dmesg, 
>> and acpidump.   To keep the size down, they are in a tarball.
>> There seems to be something wrong with the acpi tables in the bios 
>> because when I try to suspend or hibernate I see things like this:
>>
>> [   32.830712]     ACPI-0508: *** Error: Method execution failed 
>> [\_SB_.PCI0.IDE C.RATA] (Node ffff81003f0da980), AE_AML_OPERAND_VALUE
>> [   32.830794]     ACPI-0508: *** Error: Method execution failed 
>> [\_SB_.PCI0.IDE C.CHN0.DRV0._GTF] (Node ffff81003f0d9100), 
>> AE_AML_OPERAND_VALUE
>>
>> Hibernation seems to work anyhow, but suspend to ram does not.  When I 
>> wake back up from being suspended to ram, the sata disk driver 
>> complained that a register was in an incorrect state, and the system 
>> hung.
>> Could someone help me figure out how to correct this?
>>
I guess that the
         Name (ATA0, Buffer (0x1D) {})
declaration needs to be before it is actually used.

I wonder why the SATA drive only does not work after STR?!?
Attached are my changes, which hopefully let above errors vanish.
Chances are high that this is related to your machine's uncorrect SATA register 
state complains.
I also exchanged some WordAcc to AnyAcc field declarations so that the compiler 
does not complain about wrong field widths, maybe it's even this what causes 
incorrect register reads/writes.

Do you know how to recompile and override your DSDT?

Do you already have the lates BIOS installed? Better check that first.

       Thomas


--------------010500030805060000040802
Content-Type: text/x-patch;
 name="dsdt_fixed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsdt_fixed.diff"

--- dsdt.dsl.orig	2005-10-10 11:19:06.655976980 +0200
+++ dsdt.dsl	2005-10-10 11:34:05.224968654 +0200
@@ -2246,6 +2246,13 @@
                 Name (GSUE, 0x00)
                 Name (GSUT, 0x00)
                 Name (GSCR, 0x00)
+
+		Name (ATA0, Buffer (0x1D) {})
+                Name (ATA1, Buffer (0x1D) {})
+                Name (ATA2, Buffer (0x1D) {})
+                Name (ATA3, Buffer (0x1D) {})
+                Name (ATAB, Buffer (0x1D) {})
+                
                 Device (CHN0)
                 {
                     Name (_ADR, 0x00)
@@ -2473,11 +2480,6 @@
                 {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x91
                 })
-                Name (ATA0, Buffer (0x1D) {})
-                Name (ATA1, Buffer (0x1D) {})
-                Name (ATA2, Buffer (0x1D) {})
-                Name (ATA3, Buffer (0x1D) {})
-                Name (ATAB, Buffer (0x1D) {})
                 CreateByteField (ATAB, 0x00, CMDC)
                 Method (GTFB, 3, Serialized)
                 {
@@ -2612,19 +2614,19 @@
             {
                 Name (_ADR, 0x00100000)
                 OperationRegion (WAU1, PCI_Config, 0x84, 0x01)
-                Field (WAU1, WordAcc, NoLock, Preserve)
+                Field (WAU1, ByteAcc, NoLock, Preserve)
                 {
                     U184,   8
                 }
 
                 OperationRegion (U1D3, PCI_Config, 0x49, 0x01)
-                Field (U1D3, WordAcc, NoLock, Preserve)
+                Field (U1D3, AnyAcc, NoLock, Preserve)
                 {
                     UR49,   3
                 }
 
                 OperationRegion (UBP1, PCI_Config, 0x85, 0x01)
-                Field (UBP1, WordAcc, NoLock, Preserve)
+                Field (UBP1, AnyAcc, NoLock, Preserve)
                 {
                     U1PE,   1
                 }
@@ -2651,13 +2653,13 @@
             {
                 Name (_ADR, 0x00100001)
                 OperationRegion (WAU2, PCI_Config, 0x84, 0x01)
-                Field (WAU2, WordAcc, NoLock, Preserve)
+                Field (WAU2, AnyAcc, NoLock, Preserve)
                 {
                     U284,   8
                 }
 
                 OperationRegion (UBP2, PCI_Config, 0x85, 0x01)
-                Field (UBP2, WordAcc, NoLock, Preserve)
+                Field (UBP2, AnyAcc, NoLock, Preserve)
                 {
                     U2PE,   1
                 }
@@ -2684,13 +2686,13 @@
             {
                 Name (_ADR, 0x00100002)
                 OperationRegion (WAU3, PCI_Config, 0x84, 0x01)
-                Field (WAU3, WordAcc, NoLock, Preserve)
+                Field (WAU3, AnyAcc, NoLock, Preserve)
                 {
                     U384,   8
                 }
 
                 OperationRegion (UBP3, PCI_Config, 0x85, 0x01)
-                Field (UBP3, WordAcc, NoLock, Preserve)
+                Field (UBP3, AnyAcc, NoLock, Preserve)
                 {
                     U3PE,   1
                 }
@@ -2717,13 +2719,13 @@
             {
                 Name (_ADR, 0x00100003)
                 OperationRegion (WAU4, PCI_Config, 0x84, 0x01)
-                Field (WAU4, WordAcc, NoLock, Preserve)
+                Field (WAU4, AnyAcc, NoLock, Preserve)
                 {
                     U484,   8
                 }
 
                 OperationRegion (UBP4, PCI_Config, 0x85, 0x01)
-                Field (UBP4, WordAcc, NoLock, Preserve)
+                Field (UBP4, AnyAcc, NoLock, Preserve)
                 {
                     U4PE,   1
                 }
@@ -2750,7 +2752,7 @@
             {
                 Name (_ADR, 0x00100004)
                 OperationRegion (WAU5, PCI_Config, 0x84, 0x01)
-                Field (WAU5, WordAcc, NoLock, Preserve)
+                Field (WAU5, AnyAcc, NoLock, Preserve)
                 {
                     U584,   8
                 }

--------------010500030805060000040802--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
