From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] [PATCH] ACPI: video: Don't call absent methods
Date: Mon, 03 Sep 2007 16:29:58 +0400
Message-ID: <20070903122958.20082.6843.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:56223 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751939AbXICMaR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2007 08:30:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Tuttle <linux-kernel@ttuttle.net>, linux-acpi@vger.kernel.org, lenb@kernel.org

Signed-off-by: Ryan May <rmay@ou.edu>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

