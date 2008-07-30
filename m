From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/9] ACPI video: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:17 +0200
Message-ID: <1217449342-20312-5-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49432 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756461AbYG3UWZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:25 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/video.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 7abd326..90ab74a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1540,8 +1540,8 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 						     acpi_video_device_notify,
 						     data);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error installing notify handler\n"));
+			ACPI_EXCEPTION((DB_INFO, status,
+					"Error installing notify handler\n"));
 			if(data->brightness)
 				kfree(data->brightness->levels);
 			kfree(data->brightness);
@@ -1755,8 +1755,7 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 
 		status = acpi_video_bus_get_one_device(dev, video);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-					"Cant attach device"));
+			printk(KERN_ERR "Cant attach device [%d]\n", status);
 			continue;
 		}
 	}
@@ -2013,8 +2012,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_video_bus_notify, video);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
+		ACPI_EXCEPTION((DB_INFO, status,
+				"Error installing notify handler\n"));
 		error = -ENODEV;
 		goto err_stop_video;
 	}
-- 
1.5.4.5

