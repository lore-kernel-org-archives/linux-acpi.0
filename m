From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/32] ACPI: video: Don't call absent methods
Date: Fri, 21 Sep 2007 23:46:23 -0400
Message-ID: <11904328122495-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:60100 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757187AbXIVDqx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:53 -0400
In-Reply-To: <11904328111749-git-send-email-lenb@kernel.org>
Message-Id: <4500ca8e221e72cc38e7c239b9b1a041031ee450.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
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
1.5.3.1.27.g57543
