From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] gma500: handle poulsbo cursor restriction
Date: Mon, 21 May 2012 15:27:30 +0100
Message-ID: <20120521142725.18168.60417.stgit@bluebook>
References: <20120521142145.18168.28248.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53254 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2EUN1o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 May 2012 09:27:44 -0400
In-Reply-To: <20120521142145.18168.28248.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

Poulsbo needs a physical address in the cursor base register. We allocate a
stolen memory buffer and copy the cursor image provided by userspace into it.
When/If we get our own userspace driver we can map this stolen memory directly.
The patch also adds a mark in chip ops so we can identify devices that has this
requirement.

Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
---

 drivers/gpu/drm/gma500/cdv_device.c        |    1 
 drivers/gpu/drm/gma500/mdfld_device.c      |    1 
 drivers/gpu/drm/gma500/oaktrail_device.c   |    1 
 drivers/gpu/drm/gma500/psb_device.c        |    1 
 drivers/gpu/drm/gma500/psb_drv.h           |    1 
 drivers/gpu/drm/gma500/psb_intel_display.c |   62 +++++++++++++++++++++++++---
 drivers/gpu/drm/gma500/psb_intel_drv.h     |    6 ---
 7 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 8e39330..9764045 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -563,6 +563,7 @@ const struct psb_ops cdv_chip_ops = {
 	.crtcs = 2,
 	.hdmi_mask = (1 << 0) | (1 << 1),
 	.lvds_mask = (1 << 1),
+	.cursor_needs_phys = 0,
 	.sgx_offset = MRST_SGX_OFFSET,
 	.chip_setup = cdv_chip_setup,
 	.errata = cdv_errata,
diff --git a/drivers/gpu/drm/gma500/mdfld_device.c b/drivers/gpu/drm/gma500/mdfld_device.c
index 2d8e741..265ad0d 100644
--- a/drivers/gpu/drm/gma500/mdfld_device.c
+++ b/drivers/gpu/drm/gma500/mdfld_device.c
@@ -531,6 +531,7 @@ const struct psb_ops mdfld_chip_ops = {
 	.crtcs = 3,
 	.lvds_mask = (1 << 1),
 	.hdmi_mask = (1 << 1),
+	.cursor_needs_phys = 0,
 	.sgx_offset = MRST_SGX_OFFSET,
 
 	.chip_setup = mdfld_chip_setup,
diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/drm/gma500/oaktrail_device.c
index 7a8ff8e..0f9b7db 100644
--- a/drivers/gpu/drm/gma500/oaktrail_device.c
+++ b/drivers/gpu/drm/gma500/oaktrail_device.c
@@ -544,6 +544,7 @@ const struct psb_ops oaktrail_chip_ops = {
 	.crtcs = 2,
 	.hdmi_mask = (1 << 0),
 	.lvds_mask = (1 << 0),
+	.cursor_needs_phys = 0,
 	.sgx_offset = MRST_SGX_OFFSET,
 
 	.chip_setup = oaktrail_chip_setup,
diff --git a/drivers/gpu/drm/gma500/psb_device.c b/drivers/gpu/drm/gma500/psb_device.c
index 1726c04..2a3e2da 100644
--- a/drivers/gpu/drm/gma500/psb_device.c
+++ b/drivers/gpu/drm/gma500/psb_device.c
@@ -373,6 +373,7 @@ const struct psb_ops psb_chip_ops = {
 	.crtcs = 2,
 	.hdmi_mask = (1 << 0),
 	.lvds_mask = (1 << 1),
+	.cursor_needs_phys = 1,
 	.sgx_offset = PSB_SGX_OFFSET,
 	.chip_setup = psb_chip_setup,
 	.chip_teardown = psb_chip_teardown,
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index a1b0c0b..1bd115e 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -655,6 +655,7 @@ struct psb_ops {
 	int sgx_offset;		/* Base offset of SGX device */
 	int hdmi_mask;		/* Mask of HDMI CRTCs */
 	int lvds_mask;		/* Mask of LVDS CRTCs */
+	int cursor_needs_phys;  /* If cursor base reg need physical address */
 
 	/* Sub functions */
 	struct drm_crtc_helper_funcs const *crtc_helper;
diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
index f3a3160..36c3c99 100644
--- a/drivers/gpu/drm/gma500/psb_intel_display.c
+++ b/drivers/gpu/drm/gma500/psb_intel_display.c
@@ -928,6 +928,7 @@ static int psb_intel_crtc_cursor_set(struct drm_crtc *crtc,
 				 uint32_t width, uint32_t height)
 {
 	struct drm_device *dev = crtc->dev;
+	struct drm_psb_private *dev_priv = dev->dev_private;
 	struct psb_intel_crtc *psb_intel_crtc = to_psb_intel_crtc(crtc);
 	int pipe = psb_intel_crtc->pipe;
 	uint32_t control = (pipe == 0) ? CURACNTR : CURBCNTR;
@@ -935,8 +936,10 @@ static int psb_intel_crtc_cursor_set(struct drm_crtc *crtc,
 	uint32_t temp;
 	size_t addr = 0;
 	struct gtt_range *gt;
+	struct gtt_range *cursor_gt = psb_intel_crtc->cursor_gt;
 	struct drm_gem_object *obj;
-	int ret;
+	void *tmp_dst, *tmp_src;
+	int ret, i, cursor_pages;
 
 	/* if we want to turn of the cursor ignore width and height */
 	if (!handle) {
@@ -985,10 +988,32 @@ static int psb_intel_crtc_cursor_set(struct drm_crtc *crtc,
 		return ret;
 	}
 
+	if (dev_priv->ops->cursor_needs_phys) {
+		if (cursor_gt == NULL) {
+			dev_err(dev->dev, "No hardware cursor mem available");
+			return -ENOMEM;
+		}
 
-	addr = gt->offset;	/* Or resource.start ??? */
+		/* Prevent overflow */
+		if (gt->npage > 4)
+			cursor_pages = 4;
+		else
+			cursor_pages = gt->npage;
+
+		/* Copy the cursor to cursor mem */
+		tmp_dst = dev_priv->vram_addr + cursor_gt->offset;
+		for (i = 0; i < cursor_pages; i++) {
+			tmp_src = kmap(gt->pages[i]);
+			memcpy(tmp_dst, tmp_src, PAGE_SIZE);
+			kunmap(gt->pages[i]);
+			tmp_dst += PAGE_SIZE;
+		}
 
-	psb_intel_crtc->cursor_addr = addr;
+		addr = psb_intel_crtc->cursor_addr;
+	} else {
+		addr = gt->offset;      /* Or resource.start ??? */
+		psb_intel_crtc->cursor_addr = addr;
+	}
 
 	temp = 0;
 	/* set the pipe for the cursor */
@@ -1213,6 +1238,9 @@ void psb_intel_crtc_destroy(struct drm_crtc *crtc)
 		drm_gem_object_unreference(psb_intel_crtc->cursor_obj);
 		psb_intel_crtc->cursor_obj = NULL;
 	}
+
+	if (psb_intel_crtc->cursor_gt != NULL)
+		psb_gtt_free_range(crtc->dev, psb_intel_crtc->cursor_gt);
 	kfree(psb_intel_crtc->crtc_state);
 	drm_crtc_cleanup(crtc);
 	kfree(psb_intel_crtc);
@@ -1241,13 +1269,33 @@ const struct drm_crtc_funcs psb_intel_crtc_funcs = {
  * Set the default value of cursor control and base register
  * to zero. This is a workaround for h/w defect on Oaktrail
  */
-static void psb_intel_cursor_init(struct drm_device *dev, int pipe)
+static void psb_intel_cursor_init(struct drm_device *dev,
+				  struct psb_intel_crtc *psb_intel_crtc)
 {
+	struct drm_psb_private *dev_priv = dev->dev_private;
 	u32 control[3] = { CURACNTR, CURBCNTR, CURCCNTR };
 	u32 base[3] = { CURABASE, CURBBASE, CURCBASE };
+	struct gtt_range *cursor_gt;
+
+	if (dev_priv->ops->cursor_needs_phys) {
+		/* Allocate 4 pages of stolen mem for a hardware cursor. That
+		 * is enough for the 64 x 64 ARGB cursors we support.
+		 */
+		cursor_gt = psb_gtt_alloc_range(dev, 4 * PAGE_SIZE, "cursor", 1);
+		if (!cursor_gt) {
+			psb_intel_crtc->cursor_gt = NULL;
+			goto out;
+		}
+		psb_intel_crtc->cursor_gt = cursor_gt;
+		psb_intel_crtc->cursor_addr = dev_priv->stolen_base +
+							cursor_gt->offset;
+	} else {
+		psb_intel_crtc->cursor_gt = NULL;
+	}
 
-	REG_WRITE(control[pipe], 0);
-	REG_WRITE(base[pipe], 0);
+out:
+	REG_WRITE(control[psb_intel_crtc->pipe], 0);
+	REG_WRITE(base[psb_intel_crtc->pipe], 0);
 }
 
 void psb_intel_crtc_init(struct drm_device *dev, int pipe,
@@ -1313,7 +1361,7 @@ void psb_intel_crtc_init(struct drm_device *dev, int pipe,
 	psb_intel_crtc->mode_set.connectors =
 	    (struct drm_connector **) (psb_intel_crtc + 1);
 	psb_intel_crtc->mode_set.num_connectors = 0;
-	psb_intel_cursor_init(dev, pipe);
+	psb_intel_cursor_init(dev, psb_intel_crtc);
 }
 
 int psb_intel_get_pipe_from_crtc_id(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
index 81852b4..2515f83 100644
--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -106,11 +106,6 @@ struct psb_intel_mode_device {
 	 size_t(*bo_offset) (struct drm_device *dev, void *bo);
 
 	/*
-	 * Cursor (Can go ?)
-	 */
-	int cursor_needs_physical;
-
-	/*
 	 * LVDS info
 	 */
 	int backlight_duty_cycle;	/* restore backlight to this value */
@@ -176,6 +171,7 @@ struct psb_intel_crtc {
 	int pipe;
 	int plane;
 	uint32_t cursor_addr;
+	struct gtt_range *cursor_gt;
 	u8 lut_r[256], lut_g[256], lut_b[256];
 	u8 lut_adj[256];
 	struct psb_intel_framebuffer *fbdev_fb;

