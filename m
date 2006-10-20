From: fseidel@suse.de
Subject: [patch 2/2] acpi: driverregistration again can report ENODEV
Date: Fri, 20 Oct 2006 11:25:49 +0200
Message-ID: <20061020092902.370992000@neutrino.suse.de>
References: <20061020092547.519734000@neutrino.suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:40917 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751486AbWJTJ3D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 05:29:03 -0400
Content-Disposition: inline; filename=acpi_asus_cleanup.diff
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>

From: Frank Seidel <fseidel@suse.de>

Cleanups in asus_acpi that are not need anymore
as of the fix of acpi_bus_register_driver.

Signed-off-by: Frank Seidel <fseidel@suse.de>
---
 drivers/acpi/asus_acpi.c |   17 -----------------
 1 files changed, 17 deletions(-)

Index: linux-2.6/drivers/acpi/asus_acpi.c
===================================================================
--- linux-2.6.orig/drivers/acpi/asus_acpi.c
+++ linux-2.6/drivers/acpi/asus_acpi.c
@@ -1239,8 +1239,6 @@ static int asus_hotk_check(void)
 	return result;
 }
 
-static int asus_hotk_found;
-
 static int asus_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -1301,8 +1299,6 @@ static int asus_hotk_add(struct acpi_dev
 		}
 	}
 
-	asus_hotk_found = 1;
-
 	/* LED display is off by default */
 	hotk->ledd_status = 0xFFF;
 
@@ -1357,19 +1353,6 @@ static int __init asus_acpi_init(void)
 		return result;
 	}
 
-	/*
-	 * This is a bit of a kludge.  We only want this module loaded
-	 * for ASUS systems, but there's currently no way to probe the
-	 * ACPI namespace for ASUS HIDs.  So we just return failure if
-	 * we didn't find one, which will cause the module to be
-	 * unloaded.
-	 */
-	if (!asus_hotk_found) {
-		acpi_bus_unregister_driver(&asus_hotk_driver);
-		remove_proc_entry(PROC_ASUS, acpi_root_dir);
-		return result;
-	}
-
 	return 0;
 }
 

--
