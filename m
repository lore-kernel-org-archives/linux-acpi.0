From: Matthias Hopf <mhopf@suse.de>
Subject: [PATCH] ACPI / PM: Traverse video_device_list for backlight
	restoration
Date: Tue, 3 Aug 2010 12:05:05 +0200
Message-ID: <20100803100505.GA26948@suse.de>
Mime-Version: 1.0
Content-Type: text/x-patch; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36345 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546Ab0HCKFH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Aug 2010 06:05:07 -0400
Content-Disposition: attachment; filename="0001-ACPI-PM-Traverse-video_device_list-for-backlight.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <julia@diku.dk>, oneukum@suse.de
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org

.bind_info in active_list[] is NULL by construction - and used to determine
the acpi_video_device pointer during backlight restoration during resume.

Using the list instead fixes backlight restoration for systems where the BIOS
doesn't do this by itself already.

Signed-off-by: Matthias Hopf <mhopf@suse.de>
---
 drivers/acpi/video.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9865d46..887ac2b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2346,7 +2346,6 @@ static int acpi_video_resume(struct notifier_block *nb,
 {
 	struct acpi_video_bus *video;
 	struct acpi_video_device *video_device;
-	int i;
 
 	switch (val) {
 	case PM_HIBERNATION_PREPARE:
@@ -2359,11 +2358,12 @@ static int acpi_video_resume(struct notifier_block *nb,
 
 	dev_info(&video->device->dev, "Restoring backlight state\n");
 
-	for (i = 0; i < video->attached_count; i++) {
-		video_device = video->attached_array[i].bind_info;
+	mutex_lock(&video->device_list_lock);
+	list_for_each_entry(video_device, &video->video_device_list, entry) {
 		if (video_device && video_device->backlight)
 			acpi_video_set_brightness(video_device->backlight);
 	}
+	mutex_unlock(&video->device_list_lock);
 
 	return NOTIFY_OK;
 }
-- 
1.6.0.2

