From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: Less strict requirements for video device detection (v2)
Date: Fri, 21 Aug 2009 12:00:02 +0200
Message-ID: <4A8E7022.8000707@canonical.com>
References: <4A8D140F.1090909@canonical.com> <1250817458.17853.141.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090602030006070603070908"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:36687 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbZHUKAD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2009 06:00:03 -0400
In-Reply-To: <1250817458.17853.141.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

This is a multi-part message in MIME format.
--------------090602030006070603070908
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Zhang Rui wrote:
> On Thu, 2009-08-20 at 17:14 +0800, Stefan Bader wrote:
>> Hardware: Acer 6920G (from a bug report)
>>
>> Another case of a broken BIOS. In this case there are several definitions for 
>> video bus devices but only one has _DOS and _DOD defined. All other definitions 
>> only have _DOD.
> 
> I have seen such kind of BIOS too.
> 
>> In the past (2.6.27) _ADR was not evaluated to make sure of using a present 
>> video device, but with that bug brightness could be changed.
>>
>> Now the video bus having _DOS and _DOD is detected as not being present. The 
>> other definitions are not considered because they are lacking the _DOS method.
>> Using the attached patch, would cause the detection code to consider the other 
>> definitions and has been tested to enable backlight control.
>>
> 
>> Would this be an acceptable approach?
> 
> I think so. I generated a similar patch before, but didn't sent it out
> for some reason.
> My suggestion is that we should also print out a warning message if _DOS
> is missed, what do you think?

Some indication about the problem can't hurt. Probably not in 
acpi_is_video_device as that would trigger for even unused devices.
So I added a warning to acpi_video_bus_check for the case when _DOS is missing. 
The case of _DOS being present but _DOD not might also be worth a warning but 
(though the check in acpi_is_video_device prevented this) would have been 
accepted by the current code.

-Stefan

> thanks,
> rui
> 
>>  From the ACPI spec it rather sounds like 
>> _DOD and _DOS must be present for a device for display switching and _DOS would 
>> indicate possible backlight control as well. So the question might not be so 
>> much is it the right thing than is it safe enough to allow more compatibility 
>> with broken implementations without causing other problems...
>>
>> -Stefan
>>
> 


-- 

When all other means of communication fail, try words!



--------------090602030006070603070908
Content-Type: text/x-diff;
 name="0001-acpi-video-Loosen-strictness-of-video-bus-detectio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-acpi-video-Loosen-strictness-of-video-bus-detectio.patc";
 filename*1="h"

>From 6b483015524f67dee3ae2f08f3c0cef27c9d84c6 Mon Sep 17 00:00:00 2001
From: Stefan Bader <stefan.bader@canonical.com>
Date: Fri, 21 Aug 2009 11:03:05 +0200
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
 drivers/acpi/video.c        |    7 ++++++-
 drivers/acpi/video_detect.c |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8851315..acd4636 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1083,7 +1083,12 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 	 */
 
 	/* Does this device support video switching? */
-	if (video->cap._DOS) {
+	if (video->cap._DOS || video->cap._DOD) {
+		if (!video->cap._DOS) {
+			printk(KERN_WARNING PREFIX
+				"BIOS bug: %s declares _DOD but not _DOS\n",
+				acpi_device_bid(video->device));
+		}
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


--------------090602030006070603070908--
