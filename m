From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI dock/bay: Use ACPI_EXCEPTION instead of printk(KERN_ERR
Date: Sat, 19 Jul 2008 05:52:51 +0200
Message-ID: <1216439571-27128-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:42737 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbYGSDwx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 23:52:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, kristen.c.accardi@intel.com, Thomas Renninger <trenn@suse.de>

Getting this error:
ACPI: \_SB_.PCI0.IDE1.PRI_.MAST: found ejectable bay
ACPI: \_SB_.PCI0.IDE1.PRI_.MAST: Adding notify handler
ACPI: Error installing bay notify handler

there could be various reasons why installing the notify handler failed.
It is expected that the dock driver already has installed the notify
handler for this device, but this is not clear.
printk suppresses this information.
The return value of the previous called and failed acpica function
holds this information and should be printed using ACPI_EXCEPTION which
is designed for printing error messages on failed acpica calls.

IMO this should get documented in Documentation/acpi/..., but I
was unsure whether it's worth to start a acpi_programming_rules.txt
(couldn't think of much more ading there for now) or
whether it's worth to add print_acpica_errors_in_kernel_drivers.txt
(or similar).
---
 drivers/acpi/bay.c  |    3 ++-
 drivers/acpi/dock.c |   10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 61b6c5b..c8cc7dc 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -305,7 +305,8 @@ static int bay_add(acpi_handle handle, int id)
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 			bay_notify, new_bay);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_INFO PREFIX "Error installing bay notify handler\n");
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Error installing bay notify handler\n"));
 		platform_device_unregister(new_bay->pdev);
 		goto bay_add_err;
 	}
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index bb7c51f..875a1a1 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -415,8 +415,8 @@ static void handle_dock(struct dock_station *ds, int dock)
 	arg.integer.value = dock;
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
 	if (ACPI_FAILURE(status))
-		printk(KERN_ERR PREFIX "%s - failed to execute _DCK\n",
-			 (char *)name_buffer.pointer);
+		ACPI_EXCEPTION((AE_INFO, status, "%s - failed to execute"
+				" _DCK\n", (char *)name_buffer.pointer));
 	kfree(buffer.pointer);
 	kfree(name_buffer.pointer);
 }
@@ -829,7 +829,8 @@ static int dock_add(acpi_handle handle)
 					     dock_notify, dock_station);
 
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing notify handler\n");
+		ACPI_EXCEPTION((AE_INFO, status, "Error installing notify"
+				" handler\n"));
 		ret = -ENODEV;
 		goto dock_add_err;
 	}
@@ -872,7 +873,8 @@ static int dock_remove(void)
 					    ACPI_SYSTEM_NOTIFY,
 					    dock_notify);
 	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Error removing notify handler\n");
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Error removing notify handler\n"));
 
 	/* cleanup sysfs */
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
-- 
1.5.4.5

