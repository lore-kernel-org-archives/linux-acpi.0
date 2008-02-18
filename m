From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 2/4] use pr->cdev as a condition for cleanup
Date: Mon, 18 Feb 2008 17:56:51 -0300
Message-ID: <1203368213-30528-2-git-send-email-gcosta@redhat.com>
References: <1203368213-30528-1-git-send-email-gcosta@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43142 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760550AbYBRVDp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 16:03:45 -0500
In-Reply-To: <1203368213-30528-1-git-send-email-gcosta@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, andrew.grover@intel.com, paul.s.diefenbaugh@intel.com, linux@brodo.de, anil.s.keshavamurthy@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, Glauber Costa <gcosta@redhat.com>

The acpi_processor_start() function can fail before creating the
sysfs nodes for thermal cooling. In this case, pr->cdev will be NULL,
and the removal code will break.

This patch uses pr->cdev as a criteria for termination of the
mentioned code, and avoids it, if it was never initialized.

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 drivers/acpi/processor_core.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9480203..5023410 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -811,10 +811,12 @@ static int acpi_processor_remove(struct 
 
 	acpi_processor_remove_fs(device);
 
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-	sysfs_remove_link(&pr->cdev->device.kobj, "device");
-	thermal_cooling_device_unregister(pr->cdev);
-	pr->cdev = NULL;
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev = NULL;
+	}
 
 	processors[pr->id] = NULL;
 
-- 
1.4.2

