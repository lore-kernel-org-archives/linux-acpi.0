From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] drm/i915/opregion: ignore firmware requests for backlight
 change
Date: Tue, 24 Jun 2014 10:35:44 +0800
Message-ID: <53A8E400.5060709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3982 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbaFXCfq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jun 2014 22:35:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Anton Gubarkov <anton.gubarkov@gmail.com>

Some Thinkpad laptops' firmware will initiate a backlight level change
request through operation region on the events of AC plug/unplug, but
since we are not using firmware's interface to do the backlight setting
on these affected laptops, we do not want the firmware to use some
arbitrary value from its ASL variable to set the backlight level on
AC plug/unplug either.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=76491
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=77091
Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Reported-and-tested-by: Anton Gubarkov <anton.gubarkov@gmail.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video.c                  | 3 ++-
 drivers/gpu/drm/i915/intel_opregion.c | 7 +++++++
 include/acpi/video.h                  | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index fb9ffe9adc64..cf99d6d2d491 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -241,13 +241,14 @@ static bool acpi_video_use_native_backlight(void)
 		return use_native_backlight_dmi;
 }
 
-static bool acpi_video_verify_backlight_support(void)
+bool acpi_video_verify_backlight_support(void)
 {
 	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
 	    backlight_device_registered(BACKLIGHT_RAW))
 		return false;
 	return acpi_video_backlight_support();
 }
+EXPORT_SYMBOL(acpi_video_verify_backlight_support);
 
 /* backlight device sysfs support */
 static int acpi_video_get_brightness(struct backlight_device *bd)
diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
index 2e2c71fcc9ed..02943d93e88e 100644
--- a/drivers/gpu/drm/i915/intel_opregion.c
+++ b/drivers/gpu/drm/i915/intel_opregion.c
@@ -403,6 +403,13 @@ static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
 
 	DRM_DEBUG_DRIVER("bclp = 0x%08x\n", bclp);
 
+	/*
+	 * If the acpi_video interface is not supposed to be used, don't
+	 * bother processing backlight level change requests from firmware.
+	 */
+	if (!acpi_video_verify_backlight_support())
+		return 0;
+
 	if (!(bclp & ASLE_BCLP_VALID))
 		return ASLC_BACKLIGHT_FAILED;
 
diff --git a/include/acpi/video.h b/include/acpi/video.h
index ea4c7bbded4d..92f8c4bffefb 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -22,6 +22,7 @@ extern void acpi_video_unregister(void);
 extern void acpi_video_unregister_backlight(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
+extern bool acpi_video_verify_backlight_support(void);
 #else
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
@@ -31,6 +32,7 @@ static inline int acpi_video_get_edid(struct acpi_device *device, int type,
 {
 	return -ENODEV;
 }
+static bool acpi_video_verify_backlight_support() { return false; }
 #endif
 
 #endif
-- 
1.9.3

