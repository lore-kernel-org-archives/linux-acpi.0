From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 2/4] gpu/drm: Stop selecting VIDEO_OUTPUT_CONTROL
Date: Mon, 17 Mar 2014 15:47:33 +0100
Message-ID: <20140317154733.173b78ce@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPI_VIDEO no longer depends on VIDEO_OUTPUT_CONTROL, so drivers which
want to select ACPI_VIDEO no longer have to select
VIDEO_OUTPUT_CONTROL.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
I can split that one further if needed.

 drivers/gpu/drm/gma500/Kconfig  |    1 -
 drivers/gpu/drm/i915/Kconfig    |    1 -
 drivers/gpu/drm/nouveau/Kconfig |    1 -
 3 files changed, 3 deletions(-)

--- linux-3.14-rc7.orig/drivers/gpu/drm/gma500/Kconfig	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc7/drivers/gpu/drm/gma500/Kconfig	2014-03-17 14:17:10.476457313 +0100
@@ -10,7 +10,6 @@ config DRM_GMA500
 	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
 	select ACPI_VIDEO if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select VIDEO_OUTPUT_CONTROL if ACPI
 	select INPUT if ACPI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
--- linux-3.14-rc7.orig/drivers/gpu/drm/i915/Kconfig	2014-02-09 16:53:02.370621987 +0100
+++ linux-3.14-rc7/drivers/gpu/drm/i915/Kconfig	2014-03-17 14:17:21.531697723 +0100
@@ -14,7 +14,6 @@ config DRM_I915
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_LCD_SUPPORT if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select VIDEO_OUTPUT_CONTROL if ACPI
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
 	select ACPI_BUTTON if ACPI
--- linux-3.14-rc7.orig/drivers/gpu/drm/nouveau/Kconfig	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc7/drivers/gpu/drm/nouveau/Kconfig	2014-03-17 14:16:52.960076500 +0100
@@ -19,7 +19,6 @@ config DRM_NOUVEAU
 	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
 	select BACKLIGHT_LCD_SUPPORT if ACPI && X86
 	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
-	select VIDEO_OUTPUT_CONTROL if ACPI && X86
 	select INPUT if ACPI && X86
 	select THERMAL if ACPI && X86
 	select ACPI_VIDEO if ACPI && X86


-- 
Jean Delvare
SUSE L3 Support
