From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 01/13] gma500: address the lid code
Date: Wed, 02 May 2012 19:12:48 +0100
Message-ID: <20120502181237.26650.97502.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56271 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab2EBSNc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:13:32 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We need this for Poulsbo

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/psb_drv.c |    2 +-
 drivers/gpu/drm/gma500/psb_drv.h |    1 -
 drivers/gpu/drm/gma500/psb_lid.c |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index fc6045f..0e85978 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -351,7 +351,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long chipset)
 	PSB_WSGX32(0x30000000, PSB_CR_BIF_3D_REQ_BASE);
 
 	acpi_video_register();
-	if (dev_priv->lid_state)
+	if (dev_priv->opregion.lid_state)
 		psb_lid_timer_init(dev_priv);
 
 	ret = drm_vblank_init(dev, dev_priv->num_pipe);
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 3773936..5c5c3d0 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -640,7 +640,6 @@ struct drm_psb_private {
 	spinlock_t lid_lock;
 	struct timer_list lid_timer;
 	struct psb_intel_opregion opregion;
-	u32 *lid_state;
 	u32 lid_last_state;
 
 	/*
diff --git a/drivers/gpu/drm/gma500/psb_lid.c b/drivers/gpu/drm/gma500/psb_lid.c
index b867aab..7ff8bb2b 100644
--- a/drivers/gpu/drm/gma500/psb_lid.c
+++ b/drivers/gpu/drm/gma500/psb_lid.c
@@ -29,7 +29,7 @@ static void psb_lid_timer_func(unsigned long data)
 	struct drm_device *dev = (struct drm_device *)dev_priv->dev;
 	struct timer_list *lid_timer = &dev_priv->lid_timer;
 	unsigned long irq_flags;
-	u32 *lid_state = dev_priv->lid_state;
+	u32 __iomem *lid_state = dev_priv->opregion.lid_state;
 	u32 pp_status;
 
 	if (readl(lid_state) == dev_priv->lid_last_state)

