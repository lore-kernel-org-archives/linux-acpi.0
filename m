From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 1/2] i915: Unregister ACPI video driver when exiting
Date: Wed, 1 Apr 2009 19:52:29 +0100
Message-ID: <20090401185229.GA16067@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58072 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758219AbZDASwe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 14:52:34 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

The i915 DRM triggers registration of the ACPI video driver on load. It
should unregister it at unload in order to avoid generating backtraces on
being reloaded.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c                 |    3 ++-
 drivers/gpu/drm/i915/i915_dma.c      |    2 +-
 drivers/gpu/drm/i915/i915_drv.c      |    2 +-
 drivers/gpu/drm/i915/i915_drv.h      |    4 ++--
 drivers/gpu/drm/i915/i915_opregion.c |    5 ++++-
 include/acpi/video.h                 |    2 ++
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bcde886..d0bcf71 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2306,7 +2306,7 @@ static int __init acpi_video_init(void)
 	return acpi_video_register();
 }
 
-static void __exit acpi_video_exit(void)
+void __exit acpi_video_exit(void)
 {
 
 	acpi_bus_unregister_driver(&acpi_video_bus);
@@ -2315,6 +2315,7 @@ static void __exit acpi_video_exit(void)
 
 	return;
 }
+EXPORT_SYMBOL(acpi_video_exit);
 
 module_init(acpi_video_init);
 module_exit(acpi_video_exit);
diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
index 67d600e..4f60c5b 100644
--- a/drivers/gpu/drm/i915/i915_dma.c
+++ b/drivers/gpu/drm/i915/i915_dma.c
@@ -1239,7 +1239,7 @@ int i915_driver_unload(struct drm_device *dev)
 	if (dev_priv->regs != NULL)
 		iounmap(dev_priv->regs);
 
-	intel_opregion_free(dev);
+	intel_opregion_free(dev, 0);
 
 	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 		intel_modeset_cleanup(dev);
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 6503e22..98560e1 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -77,7 +77,7 @@ static int i915_suspend(struct drm_device *dev, pm_message_t state)
 		drm_irq_uninstall(dev);
 	}
 
-	intel_opregion_free(dev);
+	intel_opregion_free(dev, 1);
 
 	if (state.event == PM_EVENT_SUSPEND) {
 		/* Shut down the device */
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 7c5995f..6768bee 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -663,12 +663,12 @@ extern int i915_restore_state(struct drm_device *dev);
 #ifdef CONFIG_ACPI
 /* i915_opregion.c */
 extern int intel_opregion_init(struct drm_device *dev, int resume);
-extern void intel_opregion_free(struct drm_device *dev);
+extern void intel_opregion_free(struct drm_device *dev, int suspend);
 extern void opregion_asle_intr(struct drm_device *dev);
 extern void opregion_enable_asle(struct drm_device *dev);
 #else
 static inline int intel_opregion_init(struct drm_device *dev, int resume) { return 0; }
-static inline void intel_opregion_free(struct drm_device *dev) { return; }
+static inline void intel_opregion_free(struct drm_device *dev, int suspend) { return; }
 static inline void opregion_asle_intr(struct drm_device *dev) { return; }
 static inline void opregion_enable_asle(struct drm_device *dev) { return; }
 #endif
diff --git a/drivers/gpu/drm/i915/i915_opregion.c b/drivers/gpu/drm/i915/i915_opregion.c
index 6942772..c63256b 100644
--- a/drivers/gpu/drm/i915/i915_opregion.c
+++ b/drivers/gpu/drm/i915/i915_opregion.c
@@ -408,7 +408,7 @@ err_out:
 	return err;
 }
 
-void intel_opregion_free(struct drm_device *dev)
+void intel_opregion_free(struct drm_device *dev, int suspend)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	struct intel_opregion *opregion = &dev_priv->opregion;
@@ -416,6 +416,9 @@ void intel_opregion_free(struct drm_device *dev)
 	if (!opregion->enabled)
 		return;
 
+	if (!suspend)
+		acpi_video_exit();
+
 	opregion->acpi->drdy = 0;
 
 	system_opregion = NULL;
diff --git a/include/acpi/video.h b/include/acpi/video.h
index f0275bb..af6fe95 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -3,8 +3,10 @@
 
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
 extern int acpi_video_register(void);
+extern int acpi_video_exit(void);
 #else
 static inline int acpi_video_register(void) { return 0; }
+static inline void acpi_video_exit(void) { return; }
 #endif
 
 #endif

-- 
Matthew Garrett | mjg59@srcf.ucam.org
