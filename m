From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/8] ACPI: video: Loosen strictness of video bus detection code
Date: Thu, 15 Oct 2009 00:59:42 -0400
Message-ID: <3a1151e3f124fd1a2c54b8153f510f1a7c715369.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:60870 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbZJOFAf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:35 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ00BBFHVT0U4K@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:57 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stefan Bader <stefan.bader@canonical.com>, Len Brown <len.brown@intel.com>

From: Stefan Bader <stefan.bader@canonical.com>

BugLink: http://bugs.launchpad.net/bugs/333386

Currently a video bus device must (beside other criteria) define _DOD and
_DOS methods to be considered a video device.
Some broken BIOSes prevented working backlight control by only defining both
for one (non-existing bus) and only _DOD for the rest. With this patch in
place the other bus definitions were considered too and backlight control
started to work again.

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c        |    7 ++++++-
 drivers/acpi/video_detect.c |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index f6e54bf..64e3c58 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1109,7 +1109,12 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 	 */
 
 	/* Does this device support video switching? */
-	if (video->cap._DOS) {
+	if (video->cap._DOS || video->cap._DOD) {
+		if (!video->cap._DOS) {
+			printk(KERN_WARNING FW_BUG
+				"ACPI(%s) defines _DOD but not _DOS\n",
+				acpi_device_bid(video->device));
+		}
 		video->flags.multihead = 1;
 		status = 0;
 	}
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 7032f25..575593a 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -84,7 +84,7 @@ long acpi_is_video_device(struct acpi_device *device)
 		return 0;
 
 	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) ||
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
 		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
 
-- 
1.6.0.6

