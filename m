From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] Fix _STA checking in acpi_bus_add
Date: Fri, 2 Jan 2004 16:35:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401021635.25419.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In 2.6.1-rc1, acpi_bus_add() calls acpi_bus_get_status() to evaluate
_STA, but botches checking the return value.  The result is that _STA
is ignored (if it was evaluated correctly), or we check garbage (if
the evaluation failed).  Here's a patch to fix it:

===== drivers/acpi/scan.c 1.19 vs edited =====
--- 1.19/drivers/acpi/scan.c	Sun May 25 18:00:00 2003
+++ edited/drivers/acpi/scan.c	Fri Jan  2 16:14:25 2004
@@ -703,11 +703,11 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (!result)
-			break;
-		if (!device->status.present) 
+		if (ACPI_FAILURE(result) || !device->status.present) {
 			result = -ENOENT;
-		goto end;
+			goto end;
+		}
+		break;
 	default:
 		STRUCT_TO_INT(device->status) = 0x0F;
 		break;



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
