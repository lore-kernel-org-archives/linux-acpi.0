From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/37] ACPI: video: Don't call absent methods
Date: Wed, 10 Oct 2007 01:06:12 -0400
Message-ID: <1191992804-14965-6-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:45224 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751002AbXJJFGt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:49 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <4500ca8e221e72cc38e7c239b9b1a041031ee450.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Ryan May <rmay@ou.edu>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Ryan May <rmay@ou.edu>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 3c9bb85..83aa41c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -409,14 +409,16 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
 static int
 acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 {
-	int status;
+	int status = AE_OK;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
 
 	arg0.integer.value = level;
-	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
-
+	if (device->cap._BCM)
+		status = acpi_evaluate_object(device->dev->handle, "_BCM",
+					      &args, NULL);
+	device->brightness->curr = level;
 	printk(KERN_DEBUG "set_level status: %x\n", status);
 	return status;
 }
@@ -425,11 +427,11 @@ static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long *level)
 {
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_BQC", NULL, level);
-
-	return status;
+	if (device->cap._BQC)
+		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
+					     level);
+	*level = device->brightness->curr;
+	return AE_OK;
 }
 
 static int
-- 
1.5.3.4.206.g58ba4
