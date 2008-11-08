From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: declare victory in _OSI(Linux) wars and go home
Date: Sat, 08 Nov 2008 01:35:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811080132490.9051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:56807 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbYKHGfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:35:25 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA000NYD4YZ3I82@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:35:24 -0600 (CST)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id mA86ZMmS009641	for
 <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2008 01:35:23 -0500
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id mA86ZMoG009637
	for <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2008 01:35:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Several Linux kernel releases have printed DMI info
and asked for e-mail feedback when we see BIOS
AML invoke _OSI(Linux).

We've found exactly two vendors use used _OSI(Linux)
for something on purpose -- Dell and Lenovo, and
those uses are limited to specific models.

We'll work with Dell and Lenovo to get them
out of that mess.  In the mean-time, for everybody else,
simply note that Linux ignores OSI(Linux) and move on.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   44 --------------------------------------------
 1 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4be2521..e1ac995 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -35,7 +35,6 @@
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
-#include <linux/dmi.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
 #include <linux/acpi.h>
@@ -1296,34 +1295,6 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	return (AE_OK);
 }
 
-/**
- *	acpi_dmi_dump - dump DMI slots needed for blacklist entry
- *
- *	Returns 0 on success
- */
-static int acpi_dmi_dump(void)
-{
-
-	if (!dmi_available)
-		return -1;
-
-	printk(KERN_NOTICE PREFIX "DMI System Vendor: %s\n",
-		dmi_get_system_info(DMI_SYS_VENDOR));
-	printk(KERN_NOTICE PREFIX "DMI Product Name: %s\n",
-		dmi_get_system_info(DMI_PRODUCT_NAME));
-	printk(KERN_NOTICE PREFIX "DMI Product Version: %s\n",
-		dmi_get_system_info(DMI_PRODUCT_VERSION));
-	printk(KERN_NOTICE PREFIX "DMI Board Name: %s\n",
-		dmi_get_system_info(DMI_BOARD_NAME));
-	printk(KERN_NOTICE PREFIX "DMI BIOS Vendor: %s\n",
-		dmi_get_system_info(DMI_BIOS_VENDOR));
-	printk(KERN_NOTICE PREFIX "DMI BIOS Date: %s\n",
-		dmi_get_system_info(DMI_BIOS_DATE));
-
-	return 0;
-}
-
-
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_interface
@@ -1350,21 +1321,6 @@ acpi_os_validate_interface (char *interface)
 			osi_linux.cmdline ? " via cmdline" :
 			osi_linux.dmi ? " via DMI" : "");
 
-		if (!osi_linux.dmi) {
-			if (acpi_dmi_dump())
-				printk(KERN_NOTICE PREFIX
-					"[please extract dmidecode output]\n");
-			printk(KERN_NOTICE PREFIX
-				"Please send DMI info above to "
-				"linux-acpi@vger.kernel.org\n");
-		}
-		if (!osi_linux.known && !osi_linux.cmdline) {
-			printk(KERN_NOTICE PREFIX
-				"If \"acpi_osi=%sLinux\" works better, "
-				"please notify linux-acpi@vger.kernel.org\n",
-				osi_linux.enable ? "!" : "");
-		}
-
 		if (osi_linux.enable)
 			return AE_OK;
 	}
-- 
1.6.0.3.640.g6331a
