From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 5/6] gma500: Add ops for hotplug support.
Date: Tue, 24 Apr 2012 16:48:09 +0100
Message-ID: <20120424154741.1631.88111.stgit@bluebook>
References: <20120424154548.1631.58977.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34202 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab2DXPsn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:48:43 -0400
In-Reply-To: <20120424154548.1631.58977.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This provides the needed callback hooks to add hotplug display support to
the GMA36x0 devices. 

[The actual enabling device part will follow once I've figured out why it
 breaks suspend/resume on some netbooks]

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/psb_drv.h |    3 +++
 drivers/gpu/drm/gma500/psb_irq.c |   36 +++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 6235499..ab483c3 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -130,6 +130,7 @@ enum {
 #define _PSB_VSYNC_PIPEA_FLAG	  (1<<7)
 #define _MDFLD_MIPIA_FLAG	  (1<<16)
 #define _MDFLD_MIPIC_FLAG	  (1<<17)
+#define _PSB_IRQ_DISP_HOTSYNC	  (1<<17)
 #define _PSB_IRQ_SGX_FLAG	  (1<<18)
 #define _PSB_IRQ_MSVDX_FLAG	  (1<<19)
 #define _LNC_IRQ_TOPAZ_FLAG	  (1<<20)
@@ -703,6 +704,8 @@ struct psb_ops {
 
 	/* Display management hooks */
 	int (*output_init)(struct drm_device *dev);
+	int (*hotplug)(struct drm_device *dev);
+	void (*hotplug_enable)(struct drm_device *dev, bool on);
 	/* Power management hooks */
 	void (*init_pm)(struct drm_device *dev);
 	int (*save_regs)(struct drm_device *dev);
diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index 1869586..4f31312 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -199,11 +199,9 @@ static void psb_vdc_interrupt(struct drm_device *dev, uint32_t vdc_stat)
 
 irqreturn_t psb_irq_handler(DRM_IRQ_ARGS)
 {
-	struct drm_device *dev = (struct drm_device *) arg;
-	struct drm_psb_private *dev_priv =
-	    (struct drm_psb_private *) dev->dev_private;
-
-	uint32_t vdc_stat, dsp_int = 0, sgx_int = 0;
+	struct drm_device *dev = arg;
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	uint32_t vdc_stat, dsp_int = 0, sgx_int = 0, hotplug_int = 0;
 	int handled = 0;
 
 	spin_lock(&dev_priv->irqmask_lock);
@@ -220,6 +218,8 @@ irqreturn_t psb_irq_handler(DRM_IRQ_ARGS)
 
 	if (vdc_stat & _PSB_IRQ_SGX_FLAG)
 		sgx_int = 1;
+	if (vdc_stat & _PSB_IRQ_DISP_HOTSYNC)
+		hotplug_int = 1;
 
 	vdc_stat &= dev_priv->vdc_irq_mask;
 	spin_unlock(&dev_priv->irqmask_lock);
@@ -241,6 +241,13 @@ irqreturn_t psb_irq_handler(DRM_IRQ_ARGS)
 		handled = 1;
 	}
 
+	/* Note: this bit has other meanings on some devices, so we will
+	   need to address that later if it ever matters */
+	if (hotplug_int && dev_priv->ops->hotplug) {
+		handled = dev_priv->ops->hotplug(dev);
+		REG_WRITE(PORT_HOTPLUG_STAT, REG_READ(PORT_HOTPLUG_STAT));
+	}
+
 	PSB_WVDC32(vdc_stat, PSB_INT_IDENTITY_R);
 	(void) PSB_RVDC32(PSB_INT_IDENTITY_R);
 	DRM_READMEMORYBARRIER();
@@ -273,6 +280,10 @@ void psb_irq_preinstall(struct drm_device *dev)
 		dev_priv->vdc_irq_mask |= _MDFLD_PIPEC_EVENT_FLAG;
 	*/
 
+	/* Revisit this area - want per device masks ? */
+	if (dev_priv->ops->hotplug)
+		dev_priv->vdc_irq_mask |= _PSB_IRQ_DISP_HOTSYNC;
+
 	/* This register is safe even if display island is off */
 	PSB_WVDC32(~dev_priv->vdc_irq_mask, PSB_INT_MASK_R);
 	spin_unlock_irqrestore(&dev_priv->irqmask_lock, irqflags);
@@ -305,18 +316,25 @@ int psb_irq_postinstall(struct drm_device *dev)
 	else
 		psb_disable_pipestat(dev_priv, 2, PIPE_VBLANK_INTERRUPT_ENABLE);
 
+	if (dev_priv->ops->hotplug_enable)
+		dev_priv->ops->hotplug_enable(dev, true);
+
 	spin_unlock_irqrestore(&dev_priv->irqmask_lock, irqflags);
 	return 0;
 }
 
 void psb_irq_uninstall(struct drm_device *dev)
 {
-	struct drm_psb_private *dev_priv =
-	    (struct drm_psb_private *) dev->dev_private;
+	struct drm_psb_private *dev_priv = dev->dev_private;
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&dev_priv->irqmask_lock, irqflags);
 
+	if (dev_priv->ops->hotplug_enable) {
+		dev_priv->ops->hotplug_enable(dev, false);
+		dev_priv->vdc_irq_mask &= ~_PSB_IRQ_DISP_HOTSYNC;
+	}
+
 	PSB_WVDC32(0xFFFFFFFF, PSB_HWSTAM);
 
 	if (dev->vblank_enabled[0])
@@ -328,9 +346,9 @@ void psb_irq_uninstall(struct drm_device *dev)
 	if (dev->vblank_enabled[2])
 		psb_disable_pipestat(dev_priv, 2, PIPE_VBLANK_INTERRUPT_ENABLE);
 
-	dev_priv->vdc_irq_mask &= _PSB_IRQ_SGX_FLAG |
+	dev_priv->vdc_irq_mask &= ~(_PSB_IRQ_SGX_FLAG |
 				  _PSB_IRQ_MSVDX_FLAG |
-				  _LNC_IRQ_TOPAZ_FLAG;
+				  _LNC_IRQ_TOPAZ_FLAG);
 
 	/* These two registers are safe even if display island is off */
 	PSB_WVDC32(~dev_priv->vdc_irq_mask, PSB_INT_MASK_R);

