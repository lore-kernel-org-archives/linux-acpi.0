From: Kamal Mostafa <kamal@canonical.com>
Subject: [RFC PATCH 2/2] drm/i915: override acpi brightness control
Date: Wed,  2 Jun 2010 15:11:42 -0700
Message-ID: <1275516702-27090-3-git-send-email-kamal@canonical.com>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:49463 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756Ab0FBWMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 18:12:07 -0400
In-Reply-To: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Kamal Mostafa <kamal@canonical.com>

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/568611

Override acpi brightness control with i915-opregion method.

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/gpu/drm/i915/i915_opregion.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_opregion.c b/drivers/gpu/drm/i915/i915_opregion.c
index 7cc8410..a69033e 100644
--- a/drivers/gpu/drm/i915/i915_opregion.c
+++ b/drivers/gpu/drm/i915/i915_opregion.c
@@ -32,6 +32,9 @@
 #include "i915_drm.h"
 #include "i915_drv.h"
 
+unsigned int i915_brightness = 1;
+module_param_named(brightness, i915_brightness, int, 0400);
+
 #define PCI_ASLE 0xe4
 #define PCI_LBPC 0xf4
 #define PCI_ASLS 0xfc
@@ -422,6 +425,18 @@ static void intel_didl_outputs(struct drm_device *dev)
 		opregion->acpi->didl[i] = 0;
 }
 
+static unsigned int i915_set_brightness(void *dev, unsigned int brightness)
+{
+        /* Nb. brightness value range is 0 to 255. */
+    	u32 bclp = ASLE_BCLP_VALID | brightness;
+	struct drm_device *drmdev = dev;
+
+	if (IS_IRONLAKE(drmdev))
+	    return asle_set_backlight_ironlake(drmdev, bclp);
+	else
+	    return asle_set_backlight(drmdev, bclp);
+}
+
 int intel_opregion_init(struct drm_device *dev, int resume)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
@@ -469,6 +484,10 @@ int intel_opregion_init(struct drm_device *dev, int resume)
 		DRM_DEBUG_DRIVER("ASLE supported\n");
 		opregion->asle = base + OPREGION_ASLE_OFFSET;
 		opregion_enable_asle(dev);
+	        /* Register the i915-based brightness control with ACPI */
+		if (!resume && i915_brightness)
+			acpi_brightness_hook_register("i915",
+					i915_set_brightness, dev, 255);
 	}
 
 	if (!resume)
-- 
1.7.0.4

