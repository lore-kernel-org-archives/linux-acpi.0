From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/26] ACPI video: check for error from thermal_cooling_device_register
Date: Thu, 21 Feb 2008 04:37:53 -0500
Message-ID: <43ff39f2f6450fa2e9a566f8bf007a26d76f2c9d.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48886 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbYBUJiz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 04:38:55 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Sujith <sujith.thomas@intel.com>

Need to check whether thermal_cooling_device_register
returned ERROR or not.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 7f714fa..12cce69 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -731,6 +731,9 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 
 		device->cdev = thermal_cooling_device_register("LCD",
 					device->dev, &video_cooling_ops);
+		if (IS_ERR(device->cdev))
+			return;
+
 		if (device->cdev) {
 			printk(KERN_INFO PREFIX
 				"%s is registered as cooling_device%d\n",
-- 
1.5.4

