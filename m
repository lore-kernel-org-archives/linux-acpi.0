From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH 2/4] drm/i915: force mode set at lid open time
Date: Wed, 15 Jul 2009 15:11:24 -0700
Message-ID: <1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-156.bluehost.com ([67.222.39.36]:50301 "HELO
	outbound-mail-156.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754399AbZGOWSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 18:18:09 -0400
In-Reply-To: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>

Some laptop platforms will disable pipes and/or planes at lid close time
and not restore them when the lid is opened again.  So catch the lid
event, and if the lid was opened, force a mode restore.

Fixes fdo bug #21230.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/gpu/drm/Kconfig              |    1 +
 drivers/gpu/drm/i915/i915_drv.h      |    2 ++
 drivers/gpu/drm/i915/intel_display.c |    2 ++
 drivers/gpu/drm/i915/intel_lvds.c    |   23 +++++++++++++++++++++++
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 39b393d..5873865 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -86,6 +86,7 @@ config DRM_I915
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB
+	select ACPI_BUTTON
 	select FRAMEBUFFER_CONSOLE if !EMBEDDED
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index b05b44d..11d0e28 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -221,6 +221,8 @@ typedef struct drm_i915_private {
 	unsigned int lvds_use_ssc:1;
 	int lvds_ssc_freq;
 
+	struct notifier_block lid_notifier;
+
 	struct drm_i915_fence_reg fence_regs[16]; /* assume 965 */
 	int fence_reg_start; /* 4 if userland hasn't ioctl'd us yet */
 	int num_fence_regs; /* 8 on pre-965, 16 otherwise */
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 3fa0d63..6b0c799 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -24,6 +24,8 @@
  *	Eric Anholt <eric@anholt.net>
  */
 
+#include <linux/module.h>
+#include <linux/input.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include "drmP.h"
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 43c7d9a..1d0d30a 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -27,6 +27,7 @@
  *      Jesse Barnes <jesse.barnes@intel.com>
  */
 
+#include <acpi/button.h>
 #include <linux/dmi.h>
 #include <linux/i2c.h>
 #include "drmP.h"
@@ -642,6 +643,19 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
+static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
+			    void *unused)
+{
+	struct drm_i915_private *dev_priv =
+		container_of(nb, struct drm_i915_private, lid_notifier);
+	struct drm_device *dev = dev_priv->dev;
+
+	if (acpi_lid_open())
+		drm_helper_resume_force_mode(dev);
+
+	return NOTIFY_OK;
+}
+
 /**
  * intel_lvds_destroy - unregister and free LVDS structures
  * @connector: connector to free
@@ -651,10 +665,14 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
  */
 static void intel_lvds_destroy(struct drm_connector *connector)
 {
+	struct drm_device *dev = connector->dev;
 	struct intel_output *intel_output = to_intel_output(connector);
+	struct drm_i915_private *dev_priv = dev->dev_private;
 
 	if (intel_output->ddc_bus)
 		intel_i2c_destroy(intel_output->ddc_bus);
+	if (dev_priv->lid_notifier.notifier_call)
+		acpi_lid_notifier_unregister(&dev_priv->lid_notifier);
 	drm_sysfs_connector_remove(connector);
 	drm_connector_cleanup(connector);
 	kfree(connector);
@@ -1017,6 +1035,11 @@ out:
 		pwm |= PWM_PCH_ENABLE;
 		I915_WRITE(BLC_PWM_PCH_CTL1, pwm);
 	}
+ 	dev_priv->lid_notifier.notifier_call = intel_lid_notify;
+ 	if (acpi_lid_notifier_register(&dev_priv->lid_notifier)) {
+ 		DRM_DEBUG("lid notifier registration failed\n");
+ 		dev_priv->lid_notifier.notifier_call = NULL;
+ 	}
 	drm_sysfs_connector_add(connector);
 	return;
 
-- 
1.6.2.5

