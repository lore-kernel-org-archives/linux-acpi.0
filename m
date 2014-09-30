From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / video: check _DOD list when creating backlight device
Date: Tue, 30 Sep 2014 14:10:17 +0800
Message-ID: <542A4949.2020208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35226 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbaI3GKU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Sep 2014 02:10:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ntrrgc@gmail.com
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

The _DOD method lists which video output device is currently attached so
we should only care about them and ignore others. An user recently
reported that there are two acpi_video interfaces appeared on his system
and one of them doesn't work. From the acpidump, it is found that there
are more than one video output devices that have _BCM control method but
the _DOD lists only one of them. So this patch checks if the video output
device is in the _DOD list and will not create backlight device if it is
not in the list. Also, we consider the broken _DOD case(reflected by the
video->attached_count is 0) and do not change behaviour for those broken
_DOD systems.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=84111
Reported-and-tested-by: ntrrgc@gmail.com
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 7285c7f9a935..807a88a0f394 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1154,6 +1154,23 @@ acpi_video_device_bind(struct acpi_video_bus *video,
 	}
 }
 
+static bool acpi_video_device_in_dod(struct acpi_video_device *device)
+{
+	struct acpi_video_bus *video = device->video;
+	int i;
+
+	/* If we have a broken _DOD, no need to test */
+	if (!video->attached_count)
+		return true;
+
+	for (i = 0; i < video->attached_count; i++) {
+		if (video->attached_array[i].bind_info == device)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  *  Arg:
  *	video	: video bus device
@@ -1593,6 +1610,15 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	static int count;
 	char *name;
 
+	/*
+	 * Do not create backlight device for video output
+	 * device that is not in the enumerated list.
+	 */
+	if (!acpi_video_device_in_dod(device)) {
+		dev_dbg(&device->dev->dev, "not in _DOD list, ignore\n");
+		return;
+	}
+
 	result = acpi_video_init_brightness(device);
 	if (result)
 		return;
-- 
1.9.3

