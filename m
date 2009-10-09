From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Less strict requirements for video device detection (v3)
Date: Fri, 09 Oct 2009 09:30:29 +0800
Message-ID: <1255051829.2656.2.camel@rzhang-dt>
References: <4A8D140F.1090909@canonical.com>
	 <1250817458.17853.141.camel@rzhang-dt>  <4A8E7022.8000707@canonical.com>
	 <1251076781.3483.13.camel@rzhang-dt>  <4A92A73C.7010003@canonical.com>
	 <1251162484.3483.51.camel@rzhang-dt>  <4AC3BE3B.7020304@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60351 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757248AbZJIBcF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Oct 2009 21:32:05 -0400
In-Reply-To: <4AC3BE3B.7020304@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2009-10-01 at 04:23 +0800, Stefan Bader wrote:
> Resending. It feels like being lost.
> 
> -Stefan
> 
Hi, len,

can you apply this patch please? thanks.

From: Stefan Bader <stefan.bader@canonical.com>
Subject: [PATCH] acpi: video: Loosen strictness of video bus detection code

BugLink: http://bugs.launchpad.net/bugs/333386

Currently a video bus device must (beside other criteria) define _DOD and
_DOS methods to be considered a video device.
Some broken BIOSes prevented working backlight control by only defining both
for one (non-existing bus) and only _DOD for the rest. With this patch in
place the other bus definitions were considered too and backlight control
started to work again.

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c        |    7 ++++++-
 drivers/acpi/video_detect.c |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a4fddb2..518910e 100644
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
1.5.4.3



