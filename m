From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/6] cdv: continue synching up with updated reference code
Date: Tue, 24 Apr 2012 16:47:12 +0100
Message-ID: <20120424154659.1631.88945.stgit@bluebook>
References: <20120424154548.1631.58977.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34194 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab2DXPrt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:47:49 -0400
In-Reply-To: <20120424154548.1631.58977.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

In particular clean up the errata handling and correct the crtc masks. We do
this a bit differently using our device abstraction for neatness.

This doesn't address the ACPI opregion and hotplug plumbing, nor the IRQ related
changes that will need. It touches on backlight init but the full backlight
support is not in this change set.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/cdv_device.c        |   20 +++++++++
 drivers/gpu/drm/gma500/cdv_intel_crt.c     |   20 +++------
 drivers/gpu/drm/gma500/cdv_intel_display.c |   61 ++++++++++++----------------
 drivers/gpu/drm/gma500/cdv_intel_lvds.c    |   17 ++++++++
 drivers/gpu/drm/gma500/framebuffer.c       |   13 ++----
 drivers/gpu/drm/gma500/mdfld_device.c      |    2 +
 drivers/gpu/drm/gma500/oaktrail_device.c   |    2 +
 drivers/gpu/drm/gma500/psb_device.c        |    2 +
 drivers/gpu/drm/gma500/psb_drv.h           |    4 ++
 drivers/gpu/drm/gma500/psb_intel_reg.h     |    4 ++
 10 files changed, 89 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index a54cc73..5cc06a8 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -49,6 +49,9 @@ static void cdv_disable_vga(struct drm_device *dev)
 static int cdv_output_init(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
+
+	drm_mode_create_scaling_mode_property(dev);
+
 	cdv_disable_vga(dev);
 
 	cdv_intel_crt_init(dev, &dev_priv->mode_dev);
@@ -238,6 +241,18 @@ static void cdv_init_pm(struct drm_device *dev)
 	dev_err(dev->dev, "GPU: power management timed out.\n");
 }
 
+static void cdv_errata(struct drm_device *dev)
+{
+	/* Disable bonus launch.
+	 *	CPU and GPU competes for memory and display misses updates and flickers.
+	 *	Worst with dual core, dual displays.
+	 *
+	 *	Fixes were done to Win 7 gfx driver to disable a feature called Bonus
+	 *	Launch to work around the issue, by degrading performance.
+	 */
+	 CDV_MSG_WRITE32(3, 0x30, 0x08027108);
+}
+
 /**
  *	cdv_save_display_registers	-	save registers lost on suspend
  *	@dev: our DRM device
@@ -355,7 +370,7 @@ static int cdv_restore_display_registers(struct drm_device *dev)
 	REG_WRITE(PSB_INT_MASK_R, regs->cdv.saveIMR);
 
 	/* Fix arbitration bug */
-	CDV_MSG_WRITE32(3, 0x30, 0x08027108);
+	cdv_errata(dev);
 
 	drm_mode_config_reset(dev);
 
@@ -464,8 +479,11 @@ const struct psb_ops cdv_chip_ops = {
 	.accel_2d = 0,
 	.pipes = 2,
 	.crtcs = 2,
+	.hdmi_mask = (1 << 0) | (1 << 1),
+	.lvds_mask = (1 << 1),
 	.sgx_offset = MRST_SGX_OFFSET,
 	.chip_setup = cdv_chip_setup,
+	.errata = cdv_errata,
 
 	.crtc_helper = &cdv_intel_helper_funcs,
 	.crtc_funcs = &cdv_intel_crtc_funcs,
diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index 1a82843..1874220 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -78,9 +78,6 @@ static int cdv_intel_crt_mode_valid(struct drm_connector *connector,
 	if (mode->clock > 355000)
 		return MODE_CLOCK_HIGH;
 
-	if (mode->hdisplay > 1680 || mode->vdisplay > 1050)
-		return MODE_PANEL;
-
 	return MODE_OK;
 }
 
@@ -148,13 +145,7 @@ static bool cdv_intel_crt_detect_hotplug(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	u32 hotplug_en;
 	int i, tries = 0, ret = false;
-	u32 adpa_orig;
-
-	/* disable the DAC when doing the hotplug detection */
-
-	adpa_orig = REG_READ(ADPA);
-
-	REG_WRITE(ADPA, adpa_orig & ~(ADPA_DAC_ENABLE));
+	u32 orig;
 
 	/*
 	 * On a CDV thep, CRT detect sequence need to be done twice
@@ -162,7 +153,7 @@ static bool cdv_intel_crt_detect_hotplug(struct drm_connector *connector,
 	 */
 	tries = 2;
 
-	hotplug_en = REG_READ(PORT_HOTPLUG_EN);
+	orig = hotplug_en = REG_READ(PORT_HOTPLUG_EN);
 	hotplug_en &= ~(CRT_HOTPLUG_DETECT_MASK);
 	hotplug_en |= CRT_HOTPLUG_FORCE_DETECT;
 
@@ -187,8 +178,11 @@ static bool cdv_intel_crt_detect_hotplug(struct drm_connector *connector,
 	    CRT_HOTPLUG_MONITOR_NONE)
 		ret = true;
 
-	/* Restore the saved ADPA */
-	REG_WRITE(ADPA, adpa_orig);
+	 /* clear the interrupt we just generated, if any */
+	REG_WRITE(PORT_HOTPLUG_STAT, CRT_HOTPLUG_INT_STATUS);
+
+	/* and put the bits back */
+	REG_WRITE(PORT_HOTPLUG_EN, orig);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
index 07b37f5..2fab778 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_display.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
@@ -226,13 +226,13 @@ cdv_dpll_set_clock_cdv(struct drm_device *dev, struct drm_crtc *crtc,
 	int dpll_reg = (pipe == 0) ? DPLL_A : DPLL_B;
 	int ref_sfr = (pipe == 0) ? SB_REF_DPLLA : SB_REF_DPLLB;
 	u32 ref_value;
+	u32 lane_reg, lane_value;
 
 	cdv_sb_reset(dev);
 
-	if ((REG_READ(dpll_reg) & DPLL_SYNCLOCK_ENABLE) == 0) {
-		DRM_ERROR("Attempting to set DPLL with refclk disabled\n");
-		return -EBUSY;
-	}
+	REG_WRITE(dpll_reg, DPLL_SYNCLOCK_ENABLE | DPLL_VGA_MODE_DIS);
+
+	udelay(100);
 
 	/* Follow the BIOS and write the REF/SFR Register. Hardcoded value */
 	ref_value = 0x68A701;
@@ -337,36 +337,29 @@ cdv_dpll_set_clock_cdv(struct drm_device *dev, struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
-	/* always Program the Lane Register for the Pipe A*/
-/* 	if (pipe == 0) */ {
-		/* Program the Lane0/1 for HDMI B */
-		u32 lane_reg, lane_value;
-
-		lane_reg = PSB_LANE0;
-		cdv_sb_read(dev, lane_reg, &lane_value);
-		lane_value &= ~(LANE_PLL_MASK);
-		lane_value |= LANE_PLL_ENABLE;
-		cdv_sb_write(dev, lane_reg, lane_value);
-
-		lane_reg = PSB_LANE1;
-		cdv_sb_read(dev, lane_reg, &lane_value);
-		lane_value &= ~(LANE_PLL_MASK);
-		lane_value |= LANE_PLL_ENABLE;
-		cdv_sb_write(dev, lane_reg, lane_value);
-
-		/* Program the Lane2/3 for HDMI C */
-		lane_reg = PSB_LANE2;
-		cdv_sb_read(dev, lane_reg, &lane_value);
-		lane_value &= ~(LANE_PLL_MASK);
-		lane_value |= LANE_PLL_ENABLE;
-		cdv_sb_write(dev, lane_reg, lane_value);
-
-		lane_reg = PSB_LANE3;
-		cdv_sb_read(dev, lane_reg, &lane_value);
-		lane_value &= ~(LANE_PLL_MASK);
-		lane_value |= LANE_PLL_ENABLE;
-		cdv_sb_write(dev, lane_reg, lane_value);
-	}
+	lane_reg = PSB_LANE0;
+	cdv_sb_read(dev, lane_reg, &lane_value);
+	lane_value &= ~(LANE_PLL_MASK);
+	lane_value |= LANE_PLL_ENABLE | LANE_PLL_PIPE(pipe);
+	cdv_sb_write(dev, lane_reg, lane_value);
+
+	lane_reg = PSB_LANE1;
+	cdv_sb_read(dev, lane_reg, &lane_value);
+	lane_value &= ~(LANE_PLL_MASK);
+	lane_value |= LANE_PLL_ENABLE | LANE_PLL_PIPE(pipe);
+	cdv_sb_write(dev, lane_reg, lane_value);
+
+	lane_reg = PSB_LANE2;
+	cdv_sb_read(dev, lane_reg, &lane_value);
+	lane_value &= ~(LANE_PLL_MASK);
+	lane_value |= LANE_PLL_ENABLE | LANE_PLL_PIPE(pipe);
+	cdv_sb_write(dev, lane_reg, lane_value);
+
+	lane_reg = PSB_LANE3;
+	cdv_sb_read(dev, lane_reg, &lane_value);
+	lane_value &= ~(LANE_PLL_MASK);
+	lane_value |= LANE_PLL_ENABLE | LANE_PLL_PIPE(pipe);
+	cdv_sb_write(dev, lane_reg, lane_value);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index c87b179..44a8353 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -356,6 +356,8 @@ static void cdv_intel_lvds_mode_set(struct drm_encoder *encoder,
 {
 	struct drm_device *dev = encoder->dev;
 	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct psb_intel_crtc *psb_intel_crtc = to_psb_intel_crtc(
+							encoder->crtc);
 	u32 pfit_control;
 
 	/*
@@ -377,6 +379,8 @@ static void cdv_intel_lvds_mode_set(struct drm_encoder *encoder,
 	else
 		pfit_control = 0;
 
+	pfit_control |= psb_intel_crtc->pipe << PFIT_PIPE_SHIFT;
+
 	if (dev_priv->lvds_dither)
 		pfit_control |= PANEL_8TO6_DITHER_ENABLE;
 
@@ -767,6 +771,19 @@ void cdv_intel_lvds_init(struct drm_device *dev,
 		goto failed_find;
 	}
 
+	/* setup PWM */
+	{
+		u32 pwm;
+
+		pwm = REG_READ(BLC_PWM_CTL2);
+		if (pipe == 1)
+			pwm |= PWM_PIPE_B;
+		else
+			pwm &= ~PWM_PIPE_B;
+		pwm |= PWM_ENABLE;
+		REG_WRITE(BLC_PWM_CTL2, pwm);
+	}
+
 out:
 	drm_sysfs_connector_add(connector);
 	return;
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index c2cf6bf..c9fe4bd 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -748,10 +748,7 @@ static void psb_setup_outputs(struct drm_device *dev)
 			clone_mask = (1 << INTEL_OUTPUT_SDVO);
 			break;
 		case INTEL_OUTPUT_LVDS:
-			if (IS_MRST(dev))
-				crtc_mask = (1 << 0);
-			else
-				crtc_mask = (1 << 1);
+		        crtc_mask = dev_priv->ops->lvds_mask;
 			clone_mask = (1 << INTEL_OUTPUT_LVDS);
 			break;
 		case INTEL_OUTPUT_MIPI:
@@ -763,10 +760,7 @@ static void psb_setup_outputs(struct drm_device *dev)
 			clone_mask = (1 << INTEL_OUTPUT_MIPI2);
 			break;
 		case INTEL_OUTPUT_HDMI:
-			if (IS_MFLD(dev))
-				crtc_mask = (1 << 1);
-			else	
-				crtc_mask = (1 << 0);
+		        crtc_mask = dev_priv->ops->hdmi_mask;
 			clone_mask = (1 << INTEL_OUTPUT_HDMI);
 			break;
 		}
@@ -802,6 +796,9 @@ void psb_modeset_init(struct drm_device *dev)
 	dev->mode_config.max_height = 2048;
 
 	psb_setup_outputs(dev);
+
+	if (dev_priv->ops->errata)
+	        dev_priv->ops->errata(dev);
 }
 
 void psb_modeset_cleanup(struct drm_device *dev)
diff --git a/drivers/gpu/drm/gma500/mdfld_device.c b/drivers/gpu/drm/gma500/mdfld_device.c
index af65678..a0bd48c 100644
--- a/drivers/gpu/drm/gma500/mdfld_device.c
+++ b/drivers/gpu/drm/gma500/mdfld_device.c
@@ -672,6 +672,8 @@ const struct psb_ops mdfld_chip_ops = {
 	.accel_2d = 0,
 	.pipes = 3,
 	.crtcs = 3,
+	.lvds_mask = (1 << 1);
+	.hdmi_mask = (1 << 1);
 	.sgx_offset = MRST_SGX_OFFSET,
 
 	.chip_setup = mid_chip_setup,
diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/drm/gma500/oaktrail_device.c
index 41d1924..4c5a186 100644
--- a/drivers/gpu/drm/gma500/oaktrail_device.c
+++ b/drivers/gpu/drm/gma500/oaktrail_device.c
@@ -487,6 +487,8 @@ const struct psb_ops oaktrail_chip_ops = {
 	.accel_2d = 1,
 	.pipes = 2,
 	.crtcs = 2,
+	.hdmi_mask = (1 << 0),
+	.lvds_mask = (1 << 0),
 	.sgx_offset = MRST_SGX_OFFSET,
 
 	.chip_setup = oaktrail_chip_setup,
diff --git a/drivers/gpu/drm/gma500/psb_device.c b/drivers/gpu/drm/gma500/psb_device.c
index 95d163e..34e6866 100644
--- a/drivers/gpu/drm/gma500/psb_device.c
+++ b/drivers/gpu/drm/gma500/psb_device.c
@@ -308,6 +308,8 @@ const struct psb_ops psb_chip_ops = {
 	.accel_2d = 1,
 	.pipes = 2,
 	.crtcs = 2,
+	.hdmi_mask = (1 << 0),
+	.lvds_mask = (1 << 1),
 	.sgx_offset = PSB_SGX_OFFSET,
 	.chip_setup = psb_chip_setup,
 	.chip_teardown = psb_chip_teardown,
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 64de248..6235499 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -688,6 +688,8 @@ struct psb_ops {
 	int pipes;		/* Number of output pipes */
 	int crtcs;		/* Number of CRTCs */
 	int sgx_offset;		/* Base offset of SGX device */
+	int hdmi_mask;		/* Mask of HDMI CRTCs */
+	int lvds_mask;		/* Mask of LVDS CRTCs */
 
 	/* Sub functions */
 	struct drm_crtc_helper_funcs const *crtc_helper;
@@ -696,6 +698,8 @@ struct psb_ops {
 	/* Setup hooks */
 	int (*chip_setup)(struct drm_device *dev);
 	void (*chip_teardown)(struct drm_device *dev);
+	/* Optional helper caller after modeset */
+	void (*errata)(struct drm_device *dev);
 
 	/* Display management hooks */
 	int (*output_init)(struct drm_device *dev);
diff --git a/drivers/gpu/drm/gma500/psb_intel_reg.h b/drivers/gpu/drm/gma500/psb_intel_reg.h
index 46792fc..cbd8aee 100644
--- a/drivers/gpu/drm/gma500/psb_intel_reg.h
+++ b/drivers/gpu/drm/gma500/psb_intel_reg.h
@@ -91,6 +91,9 @@
 
 #define BLC_PWM_CTL		0x61254
 #define BLC_PWM_CTL2		0x61250
+#define  PWM_ENABLE		(1 << 31)
+#define  PWM_LEGACY_MODE	(1 << 30)
+#define  PWM_PIPE_B		(1 << 29)
 #define BLC_PWM_CTL_C		0x62254
 #define BLC_PWM_CTL2_C		0x62250
 #define BACKLIGHT_MODULATION_FREQ_SHIFT		(17)
@@ -1338,6 +1341,7 @@ No status bits are changed.
 
 #define LANE_PLL_MASK		(0x7 << 20)
 #define LANE_PLL_ENABLE		(0x3 << 20)
+#define LANE_PLL_PIPE(p)	(((p) == 0) ? (1 << 21) : (0 << 21))
 
 
 #endif

