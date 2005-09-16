From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: print wakeup device list on same line as label
Date: Fri, 16 Sep 2005 11:39:49 -0600
Message-ID: <200509161139.49697.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Print the ACPI wakeup device list on the same line as the label
to make "dmesg | grep ACPI" output more useful.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work-vga2/drivers/acpi/sleep/wakeup.c
===================================================================
--- work-vga2.orig/drivers/acpi/sleep/wakeup.c	2005-09-14 09:28:10.000000000 -0600
+++ work-vga2/drivers/acpi/sleep/wakeup.c	2005-09-15 14:18:29.000000000 -0600
@@ -58,8 +58,8 @@
 {
 	struct list_head *node, *next;
 
-	/* 
-	 * Caution: this routine must be invoked when interrupt is disabled 
+	/*
+	 * Caution: this routine must be invoked when interrupt is disabled
 	 * Refer ACPI2.0: P212
 	 */
 	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
@@ -155,7 +155,7 @@
 
 	if (acpi_disabled)
 		return 0;
-	printk("ACPI wakeup devices: \n");
+	printk(KERN_INFO PREFIX "wakeup devices: ");
 
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
@@ -187,7 +187,7 @@
 
 /*
  * Disable all wakeup GPEs before power off.
- * 
+ *
  * Since acpi_enter_sleep_state() will disable all
  * RUNTIME GPEs, we simply mark all GPES that
  * are not enabled for wakeup from S5 as RUNTIME.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
