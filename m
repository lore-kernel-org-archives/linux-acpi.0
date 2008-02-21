From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/26] intel_menlo: extract return values using PTR_ERR
Date: Thu, 21 Feb 2008 04:25:21 -0500
Message-ID: <69f6b8dd6b94ac594b6920b4530a3390fb1d3fd6.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36627 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755733AbYBUJ3L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:11 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Sujith <sujith.thomas@intel.com>

Need to extract errors using PTR_ERR macro and
process accordingly.thermal_cooling_device_register
returning NULL means that CONFIG_THERMAL=n and in that
case no need to create symbolic links.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/intel_menlow.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
index f70984a..de16e88 100644
--- a/drivers/misc/intel_menlow.c
+++ b/drivers/misc/intel_menlow.c
@@ -170,10 +170,13 @@ static int intel_menlow_memory_add(struct acpi_device *device)
 
 	cdev = thermal_cooling_device_register("Memory controller", device,
 					       &memory_cooling_ops);
-	acpi_driver_data(device) = cdev;
-	if (!cdev)
-		result = -ENODEV;
-	else {
+	if (IS_ERR(cdev)) {
+		result = PTR_ERR(cdev);
+		goto end;
+	}
+
+	if (cdev) {
+		acpi_driver_data(device) = cdev;
 		result = sysfs_create_link(&device->dev.kobj,
 					&cdev->device.kobj, "thermal_cooling");
 		if (result)
-- 
1.5.4.2

