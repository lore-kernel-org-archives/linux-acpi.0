From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: [PATCH] invalid resource lists and extra checking
Date: Fri, 19 Sep 2003 08:09:02 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030918221109.L16619@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-jp-l7ZBCLq5RC066kwqclu8Pg@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

A FreeBSD user has been having a problem where his system panics on
transition to battery from AC.  The PR is below:

    http://www.freebsd.org/cgi/query-pr.cgi?pr=56254

After some tracking, I found that his GPE block was being overwritten by
the end of a resource list (type Address16).  It also happened for
Address32.  I did some more debugging and found that he does not have a
Resource Index or Resource Source String but his resources have an extra
trailing zero byte on Address type resources (but not fixed-length
resources like IO ports).  For instance, here is an Address16 resource:

   0x88, 0xe, 0x0, 0x2, 0xc, 0x0, 0x0, 0x0,
   0x0, 0x0, 0xff, 0x0, 0x0, 0x0, 0x0, 0x1,
   0x0

As you can see, it has a length of 14 (total length 17) which is one extra
byte but there is no Resource Source String.  The spec explicitly says on
page 194 (Table 6-27):

====
Byte 16 -- Resource Source Index (Optional)
Only present if Resource Source (below) is present. This field gives an
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
index to the specific resource descriptor that this device consumes from
in the current resource template for the device object pointed to in
Resource Source.

String -- Resource Source (Optional)
If present, the device ...
====

This can be read that for an Address16, valid lengths are 13 and > 14
since if Resource Index is present, Resource Source String also must be
present.  I'm not sure if a zero-length string (other than the terminating
NUL) is valid.  If not, then the valid lengths are 13 and > 15.  This is
already assumed by AcpiRsGetListLength() where it subtracts the length
from 14 to get the length of the Resource Source String.

This allowed me to develop the following patch for Address16.  It also
includes extra checks that the length meets the minimum specified by the
standard and for the extended interrupt resource, that there is at least
one interrupt present.

Let me know that I can commit this to our vendor branch and can expect it
in a future release.

-Nate

Index: rsaddr.c
===================================================================
RCS file: /home/ncvs/src/sys/contrib/dev/acpica/rsaddr.c,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 rsaddr.c
--- rsaddr.c	13 Jul 2003 22:43:31 -0000	1.1.1.11
+++ rsaddr.c	19 Sep 2003 04:59:50 -0000
@@ -168,6 +168,10 @@
     Buffer += 1;
     ACPI_MOVE_16_TO_16 (&Temp16, Buffer);

+    /* Check for the minimum length. */
+    if (Temp16 < 13)
+        return_ACPI_STATUS (AE_AML_INVALID_RESOURCE_TYPE);
+
     *BytesConsumed = Temp16 + 3;
     OutputStruct->Id = ACPI_RSTYPE_ADDRESS16;

@@ -275,11 +279,13 @@
     /*
      * This will leave us pointing to the Resource Source Index
      * If it is present, then save it off and calculate the
-     * pointer to where the null terminated string goes:
-     * Each Interrupt takes 32-bits + the 5 bytes of the
-     * stream that are default.
+     * pointer to where the null terminated string goes.
+     *
+     * Note that some buggy resources have a length that indicates the
+     * Index byte is present even though it isn't (since there is no
+     * following Resource String.)  We add one to catch these.
      */
-    if (*BytesConsumed > 16)
+    if (*BytesConsumed > 16 + 1)
     {
         /* Dereference the Index */

@@ -555,6 +561,10 @@
      */
     Buffer += 1;
     ACPI_MOVE_16_TO_16 (&Temp16, Buffer);
+
+    /* Check for the minimum length. */
+    if (Temp16 < 23)
+        return_ACPI_STATUS (AE_AML_INVALID_RESOURCE_TYPE);
     *BytesConsumed = Temp16 + 3;

     OutputStruct->Id = ACPI_RSTYPE_ADDRESS32;
@@ -667,9 +677,13 @@
     /*
      * This will leave us pointing to the Resource Source Index
      * If it is present, then save it off and calculate the
-     * pointer to where the null terminated string goes:
+     * pointer to where the null terminated string goes.
+     *
+     * Note that some buggy resources have a length that indicates the
+     * Index byte is present even though it isn't (since there is no
+     * following Resource String.)  We add one to catch these.
      */
-    if (*BytesConsumed > 26)
+    if (*BytesConsumed > 26 + 1)
     {
         /* Dereference the Index */

@@ -944,7 +958,11 @@
     Buffer += 1;
     ACPI_MOVE_16_TO_16 (&Temp16, Buffer);

+    /* Check for the minimum length. */
+    if (Temp16 < 43)
+        return_ACPI_STATUS (AE_AML_INVALID_RESOURCE_TYPE);
     *BytesConsumed = Temp16 + 3;
+
     OutputStruct->Id = ACPI_RSTYPE_ADDRESS64;

     /*
@@ -1056,11 +1074,13 @@
     /*
      * This will leave us pointing to the Resource Source Index
      * If it is present, then save it off and calculate the
-     * pointer to where the null terminated string goes:
-     * Each Interrupt takes 32-bits + the 5 bytes of the
-     * stream that are default.
+     * pointer to where the null terminated string goes.
+     *
+     * Note that some buggy resources have a length that indicates the
+     * Index byte is present even though it isn't (since there is no
+     * following Resource String.)  We add one to catch these.
      */
-    if (*BytesConsumed > 46)
+    if (*BytesConsumed > 46 + 1)
     {
         /* Dereference the Index */

Index: rsirq.c
===================================================================
RCS file: /home/ncvs/src/sys/contrib/dev/acpica/rsirq.c,v
retrieving revision 1.1.1.12
diff -u -r1.1.1.12 rsirq.c
--- rsirq.c	13 Jul 2003 22:43:39 -0000	1.1.1.12
+++ rsirq.c	19 Sep 2003 05:03:51 -0000
@@ -408,7 +408,11 @@
     Buffer += 1;
     ACPI_MOVE_16_TO_16 (&Temp16, Buffer);

+    /* Check for the minimum length. */
+    if (Temp16 < 6)
+        return_ACPI_STATUS (AE_AML_INVALID_RESOURCE_TYPE);
     *BytesConsumed = Temp16 + 3;
+
     OutputStruct->Id = ACPI_RSTYPE_EXT_IRQ;

     /*
@@ -446,6 +450,12 @@
     Buffer += 1;
     Temp8 = *Buffer;

+    /* Minimum number of IRQs is one. */
+    if (Temp8 < 1) {
+        *BytesConsumed = 0;
+        return_ACPI_STATUS (AE_AML_INVALID_RESOURCE_TYPE);
+    }
+
     OutputStruct->Data.ExtendedIrq.NumberOfInterrupts = Temp8;

     /*
@@ -480,7 +490,8 @@
      * stream that are default.
      */
     if (*BytesConsumed >
-        ((ACPI_SIZE) OutputStruct->Data.ExtendedIrq.NumberOfInterrupts * 4) + 5)
+        ((ACPI_SIZE) OutputStruct->Data.ExtendedIrq.NumberOfInterrupts * 4)
+        + 5 + 1)
     {
         /* Dereference the Index */



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
