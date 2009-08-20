From: Stefan Bader <stefan.bader@canonical.com>
Subject: Less strict requirements for video device detection
Date: Thu, 20 Aug 2009 11:14:55 +0200
Message-ID: <4A8D140F.1090909@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010405030507030606070208"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43053 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZHTJO4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 05:14:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, Matthew Garrett <mjg59@srcf.ucam.org>

This is a multi-part message in MIME format.
--------------010405030507030606070208
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hardware: Acer 6920G (from a bug report)

Another case of a broken BIOS. In this case there are several definitions for 
video bus devices but only one has _DOS and _DOD defined. All other definitions 
only have _DOD.
In the past (2.6.27) _ADR was not evaluated to make sure of using a present 
video device, but with that bug brightness could be changed.

Now the video bus having _DOS and _DOD is detected as not being present. The 
other definitions are not considered because they are lacking the _DOS method.
Using the attached patch, would cause the detection code to consider the other 
definitions and has been tested to enable backlight control.

Would this be an acceptable approach? From the ACPI spec it rather sounds like 
_DOD and _DOS must be present for a device for display switching and _DOS would 
indicate possible backlight control as well. So the question might not be so 
much is it the right thing than is it safe enough to allow more compatibility 
with broken implementations without causing other problems...

-Stefan


--------------010405030507030606070208
Content-Type: text/x-diff;
 name="0001-acpi-video-Loosen-strictness-of-video-bus-detectio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-acpi-video-Loosen-strictness-of-video-bus-detectio.patc";
 filename*1="h"

>From 302f148a5eee5226b15c1dec1dbdfb8326bfa17a Mon Sep 17 00:00:00 2001
From: Stefan Bader <stefan.bader@canonical.com>
Date: Thu, 20 Aug 2009 10:45:58 +0200
Subject: [PATCH] acpi: video: Loosen strictness of video bus detection code

BugLink: http://bugs.launchpad.net/bugs/333386

Currently a video bus device must (beside other criteria) define _DOD and
_DOS methods to be considered a video device.
Some broken BIOSes prevented working backlight control by only defining both
for one (non-existing bus) and only _DOD for the rest. With this patch in
place the other bus definitions were considered too and backlight control
started to work again.

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
---
 drivers/acpi/video.c        |    2 +-
 drivers/acpi/video_detect.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8851315..f9efeb8 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1083,7 +1083,7 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 	 */
 
 	/* Does this device support video switching? */
-	if (video->cap._DOS) {
+	if (video->cap._DOS || video->cap._DOD) {
 		video->flags.multihead = 1;
 		status = 0;
 	}
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 7cd2b63..bee5e34 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -82,7 +82,7 @@ long acpi_is_video_device(struct acpi_device *device)
 		return 0;
 
 	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) ||
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
 		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
 
-- 
1.5.4.3


--------------010405030507030606070208--
