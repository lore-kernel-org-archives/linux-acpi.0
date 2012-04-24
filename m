From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/6] gma500: support 1080p
Date: Tue, 24 Apr 2012 16:46:33 +0100
Message-ID: <20120424154548.1631.58977.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34187 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab2DXPrI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:47:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

The problem in console mode is lack of linear memory. We can solve that by
dropping to 16bpp. The mode setting X server will allocate its own GEM
framebuffer in 32bpp and all will be well.

We could just do 16bpp anyway but that would be a regression on the lower
modes as many distributions don't yet ship the generic mode setting KMS
drivers.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/cdv_intel_crt.c  |    6 ------
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c |    7 -------
 drivers/gpu/drm/gma500/framebuffer.c    |   16 ++++++++++++++++
 drivers/gpu/drm/gma500/oaktrail_hdmi.c  |    6 ------
 drivers/gpu/drm/gma500/psb_intel_sdvo.c |    6 ------
 5 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index a71a6cd..1de27c7 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -67,7 +67,6 @@ static void cdv_intel_crt_dpms(struct drm_encoder *encoder, int mode)
 static int cdv_intel_crt_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
-	struct drm_psb_private *dev_priv = connector->dev->dev_private;
 	int max_clock = 0;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
@@ -84,11 +83,6 @@ static int cdv_intel_crt_mode_valid(struct drm_connector *connector,
 	if (mode->hdisplay > 1680 || mode->vdisplay > 1050)
 		return MODE_PANEL;
 
-	/* We assume worst case scenario of 32 bpp here, since we don't know */
-	if ((ALIGN(mode->hdisplay * 4, 64) * mode->vdisplay) >
-	    dev_priv->vram_stolen_size)
-		return MODE_MEM;
-
 	return MODE_OK;
 }
 
diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index 8d52695..88b59d4 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -242,8 +242,6 @@ static int cdv_hdmi_get_modes(struct drm_connector *connector)
 static int cdv_hdmi_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
-	struct drm_psb_private *dev_priv = connector->dev->dev_private;
-
 	if (mode->clock > 165000)
 		return MODE_CLOCK_HIGH;
 	if (mode->clock < 20000)
@@ -257,11 +255,6 @@ static int cdv_hdmi_mode_valid(struct drm_connector *connector,
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		return MODE_NO_INTERLACE;
 
-	/* We assume worst case scenario of 32 bpp here, since we don't know */
-	if ((ALIGN(mode->hdisplay * 4, 64) * mode->vdisplay) >
-	    dev_priv->vram_stolen_size)
-		return MODE_MEM;
-
 	return MODE_OK;
 }
 
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 8ea202f..c2cf6bf 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -543,9 +543,25 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 				struct drm_fb_helper_surface_size *sizes)
 {
 	struct psb_fbdev *psb_fbdev = (struct psb_fbdev *)helper;
+	struct drm_device *dev = psb_fbdev->psb_fb_helper.dev;
+	struct drm_psb_private *dev_priv = dev->dev_private;
 	int new_fb = 0;
+	int bytespp;
 	int ret;
 
+	bytespp = sizes->surface_bpp / 8;
+	if (bytespp == 3)	/* no 24bit packed */
+		bytespp = 4;
+
+	/* If the mode will not fit in 32bit then switch to 16bit to get
+	   a console on full resolution. The X mode setting server will
+	   allocate its own 32bit GEM framebuffer */
+	if (ALIGN(sizes->fb_width * bytespp, 64) * sizes->fb_height >
+	                dev_priv->vram_stolen_size) {
+                sizes->surface_bpp = 16;
+                sizes->surface_depth = 16;
+        }
+
 	if (!helper->fb) {
 		ret = psbfb_create(psb_fbdev, sizes);
 		if (ret)
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index f8b367b..2595660 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -179,7 +179,6 @@ static void oaktrail_hdmi_dpms(struct drm_encoder *encoder, int mode)
 static int oaktrail_hdmi_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
-	struct drm_psb_private *dev_priv = connector->dev->dev_private;
 	if (mode->clock > 165000)
 		return MODE_CLOCK_HIGH;
 	if (mode->clock < 20000)
@@ -188,11 +187,6 @@ static int oaktrail_hdmi_mode_valid(struct drm_connector *connector,
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
 
-	/* We assume worst case scenario of 32 bpp here, since we don't know */
-	if ((ALIGN(mode->hdisplay * 4, 64) * mode->vdisplay) >
-	    dev_priv->vram_stolen_size)
-		return MODE_MEM;
-
 	return MODE_OK;
 }
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 36330ca..958b4e2 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -1141,7 +1141,6 @@ static void psb_intel_sdvo_dpms(struct drm_encoder *encoder, int mode)
 static int psb_intel_sdvo_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
-	struct drm_psb_private *dev_priv = connector->dev->dev_private;
 	struct psb_intel_sdvo *psb_intel_sdvo = intel_attached_sdvo(connector);
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -1161,11 +1160,6 @@ static int psb_intel_sdvo_mode_valid(struct drm_connector *connector,
 			return MODE_PANEL;
 	}
 
-	/* We assume worst case scenario of 32 bpp here, since we don't know */
-	if ((ALIGN(mode->hdisplay * 4, 64) * mode->vdisplay) >
-	    dev_priv->vram_stolen_size)
-		return MODE_MEM;
-
 	return MODE_OK;
 }
 

