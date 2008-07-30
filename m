From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/9] ACPI scan: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:18 +0200
Message-ID: <1217449342-20312-6-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49443 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756590AbYG3UW0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:26 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/scan.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2dcb953..ffbf8f6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -113,15 +113,15 @@ static int acpi_bus_hot_remove_device(void *context)
 
 
 	if (acpi_bus_trim(device, 1)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Removing device failed\n"));
+		printk(KERN_ERR "Removing device [%s] failed\n",
+		       acpi_device_bid(device));
 		return -1;
 	}
 
 	/* power off device */
 	status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+		ACPI_EXCEPTION((DB_INFO, status,
 				"Power-off device failed\n"));
 
 	if (device->flags.lockable) {
@@ -477,7 +477,8 @@ static int acpi_device_register(struct acpi_device *device,
 
 	result = acpi_device_setup_files(device);
 	if(result)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->dev.bus_id));
+		printk(KERN_ERR "Error creating sysfs interface for device"
+		       " %s [%d]\n", device->dev.bus_id), result);
 
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 	return 0;
-- 
1.5.4.5

