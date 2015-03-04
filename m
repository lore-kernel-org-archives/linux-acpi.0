From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 1/2] acpi: video: Allow forcing native backlight on
 non win8 machines
Date: Wed, 04 Mar 2015 10:50:20 +0800
Message-ID: <54F672EC.6010404@intel.com>
References: <1425368350-4028-1-git-send-email-hdegoede@redhat.com> <1425368350-4028-2-git-send-email-hdegoede@redhat.com> <54F57018.7000302@intel.com> <54F5B300.7020904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53643 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189AbbCDCv1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2015 21:51:27 -0500
In-Reply-To: <54F5B300.7020904@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On 03/03/2015 09:11 PM, Hans de Goede wrote:
> Hi,
> 
> On 03-03-15 09:26, Aaron Lu wrote:
>> On 03/03/2015 03:39 PM, Hans de Goede wrote:
>>> The native backlight behavior (so not registering both the acpi-video and the
>>> vendor backlight driver) can be useful on some non win8 machines too, allow
>>> the user to force this behavior by passing video.use_native_backlight=2
>>> on the kernel commandline.
>>
>> Just bikeshedding, what about doing it this way?
>>
>> In the acpi_video_use_native_backlight function:
>> 1 If user has set a cmdline option, use that(no matter if it is a win8
>>    system or not);
>> 2 If the system is in a DMI table, use that(no matter if it is a win8
>>    system or not);
>> 3 return true if this is a win8 system; false otherwise.
>>
>> Something like this:
> 
> That works for me, and has the added advantage of not changing the
> cmdline syntax (but it does change the cmdline behavior ...).

Oh yes, I didn't consider this. Not sure how much impact this will have,
but I don't see an immediate problem with it, so let's see.

> 
> So going either way is fine with me.
> 
> Aaron's version is:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks. Here is the full patch:

From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 4 Mar 2015 10:24:58 +0800
Subject: [PATCH] acpi: video: Allow forcing native backlight on non win8
 machines

The native backlight behavior (so not registering both the acpi-video
and the vendor backlight driver) can be useful on some non win8 machines
too, so change the behavior of the video.use_native_backlight=1 or 0
kernel cmdline option to be: if user has set video.use_native_backlight=1
or 0, use that no matter if it is a win8 system or not. Also, we will
put some known systems into the DMI table to make them either use native
backlight interface or not, so the use_native_backlight_dmi is used to
reflect that.

Original-by: Hans de Goede <hdegoede@redhat.com>
Signed-offby: Aaron Lu <aaron.lu@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index debd30917010..4cd0c8a4fd9d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -84,7 +84,7 @@ module_param(allow_duplicates, bool, 0644);
  */
 static int use_native_backlight_param = -1;
 module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
-static bool use_native_backlight_dmi = true;
+static int use_native_backlight_dmi = -1;
 
 static int register_count;
 static struct mutex video_list_lock;
@@ -239,13 +239,14 @@ static bool acpi_video_use_native_backlight(void)
 {
 	if (use_native_backlight_param != -1)
 		return use_native_backlight_param;
-	else
+	else if (use_native_backlight_dmi != -1)
 		return use_native_backlight_dmi;
+	return acpi_osi_is_win8();
 }
 
 bool acpi_video_verify_backlight_support(void)
 {
-	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
+	if (acpi_video_use_native_backlight() &&
 	    backlight_device_registered(BACKLIGHT_RAW))
 		return false;
 	return acpi_video_backlight_support();
@@ -414,7 +415,7 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 
 static int __init video_disable_native_backlight(const struct dmi_system_id *d)
 {
-	use_native_backlight_dmi = false;
+	use_native_backlight_dmi = 0;
 	return 0;
 }
 
-- 
2.1.0
