From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/26] ACPI: thermal: Check whether cooling device exists before unregistering
Date: Thu, 21 Feb 2008 04:25:18 -0500
Message-ID: <f28bb45e2863173a7464d98907677e903f42c68b.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36615 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756166AbYBUJ3E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:04 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

OS should check whether the cooling device exists before it is unregistered.
If it doesn't exists, it is unnecessary to remove the sysfs link
and call the function of thermal_cooling_device_unregister.

http://bugzilla.kernel.org/show_bug.cgi?id=9982

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Tested-by    : Dhaval Giani <dhaval@linux.vnet.ibm.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 75ccf5d..697335c 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -809,10 +809,12 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 
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
1.5.4.2

