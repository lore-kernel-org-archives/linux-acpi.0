From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Latest acpica
Date: Thu, 08 Sep 2005 12:15:51 +0200
Message-ID: <43200F57.9040000@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080102090200020505050709"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080102090200020505050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

acpica-unix-20050902.tar.gz
is now available under:
http://developer.intel.com/technology/iapc/acpi/downloads.htm
Thanks.

There is one concern:
This has been discussed some weeks ago.
The compiler throws dozens of errors on some DSDTs:

DSDT.dsl   777:                     , AddressRangeMemory, TypeStatic)
Error    1084 -            Missing ResourceSource string (required) ^

I cannot find the mail now, but IIRC Len said this was added to identify
how many DSDTs violate specs (is it optional or not?) and should be removed
again later.

The patch attached lowers the error to a warning, so that you get a compiled
DSDT as output.
Not sure, maybe the error/warning case should be reverted totally?


      Thomas

--------------080102090200020505050709
Content-Type: text/x-patch;
 name="resource_string_warning.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resource_string_warning.diff"

--- compiler/aslrestype2.c.orig	2005-09-08 12:05:25.000000000 +0200
+++ compiler/aslrestype2.c	2005-09-08 12:08:10.000000000 +0200
@@ -331,7 +331,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -545,7 +545,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -757,7 +757,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -1430,7 +1430,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -1639,7 +1639,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -1846,7 +1846,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -2034,7 +2034,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -2234,7 +2234,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -2431,7 +2431,7 @@
              */
             else if (ResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;
@@ -2592,7 +2592,7 @@
              */
             else if (HasResSourceIndex)
             {
-                AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
+                AslError (ASL_WARNING, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
             }
             break;

--------------080102090200020505050709--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
