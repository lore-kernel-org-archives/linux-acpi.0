From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC PATCH 1/2] acpi: video: Allow forcing native backlight on non win8 machines
Date: Tue,  3 Mar 2015 08:39:09 +0100
Message-ID: <1425368350-4028-2-git-send-email-hdegoede@redhat.com>
References: <1425368350-4028-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbbCCHjQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2015 02:39:16 -0500
In-Reply-To: <1425368350-4028-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The native backlight behavior (so not registering both the acpi-video and the
vendor backlight driver) can be useful on some non win8 machines too, allow
the user to force this behavior by passing video.use_native_backlight=2
on the kernel commandline.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index debd309..9817b52 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -84,7 +84,7 @@ module_param(allow_duplicates, bool, 0644);
  */
 static int use_native_backlight_param = -1;
 module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
-static bool use_native_backlight_dmi = true;
+static int use_native_backlight_dmi = 1;
 
 static int register_count;
 static struct mutex video_list_lock;
@@ -235,7 +235,7 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct work_struct *work);
 
-static bool acpi_video_use_native_backlight(void)
+static int acpi_video_use_native_backlight(void)
 {
 	if (use_native_backlight_param != -1)
 		return use_native_backlight_param;
@@ -245,7 +245,8 @@ static bool acpi_video_use_native_backlight(void)
 
 bool acpi_video_verify_backlight_support(void)
 {
-	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
+	if (((acpi_video_use_native_backlight() == 2) ||
+	     (acpi_video_use_native_backlight() == 1 && acpi_osi_is_win8())) &&
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
2.3.1

