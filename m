From: akpm@linux-foundation.org
Subject: [patch 09/11] bay: exit if notify handler cannot be installed
Date: Mon, 09 Jun 2008 16:22:24 -0700
Message-ID: <200806092322.m59NMP01013979@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35370 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755206AbYFIXXX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:23:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, hmacht@suse.de, kristen.c.accardi@intel.com, mjg59@srcf.ucam.org, rui.zhang@intel.com, trenn@suse.de

From: Holger Macht <hmacht@suse.de>

If acpi_install_notify_handler() for a bay device fails, the bay driver is
superfluous.  Most likely, another driver (like libata) is already caring
about this device anyway.  Furthermore,
register_hotplug_dock_device(acpi_handle) from the dock driver must not be
called twice with the same handler.  This would result in an endless loop
consuming 100% of CPU.  So clean up and exit.

Signed-off-by: Holger Macht <hmacht@suse.de>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/bay.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff -puN drivers/acpi/bay.c~bay-exit-if-notify-handler-cannot-be-installed drivers/acpi/bay.c
--- a/drivers/acpi/bay.c~bay-exit-if-notify-handler-cannot-be-installed
+++ a/drivers/acpi/bay.c
@@ -301,16 +301,20 @@ static int bay_add(acpi_handle handle, i
 	 */
 	pdev->dev.uevent_suppress = 0;
 
-	if (acpi_bay_add_fs(new_bay)) {
-		platform_device_unregister(new_bay->pdev);
-		goto bay_add_err;
-	}
-
 	/* register for events on this device */
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 			bay_notify, new_bay);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing bay notify handler\n");
+		printk(KERN_INFO PREFIX "Error installing bay notify handler\n");
+		platform_device_unregister(new_bay->pdev);
+		goto bay_add_err;
+	}
+
+	if (acpi_bay_add_fs(new_bay)) {
+		acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+					   bay_notify);
+		platform_device_unregister(new_bay->pdev);
+		goto bay_add_err;
 	}
 
 	/* if we are on a dock station, we should register for dock
_
