From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/6] gma500: implement backlight functionality for Cedartrail
 devices
Date: Tue, 24 Apr 2012 16:47:30 +0100
Message-ID: <20120424154726.1631.13138.stgit@bluebook>
References: <20120424154548.1631.58977.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34197 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab2DXPsF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:48:05 -0400
In-Reply-To: <20120424154548.1631.58977.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Basically a straight cut/paste from the reference driver code then
cleaned up a spot.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/cdv_device.c |  113 ++++++++++++++++-------------------
 1 files changed, 51 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 5cc06a8..292bcec 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -57,8 +57,7 @@ static int cdv_output_init(struct drm_device *dev)
 	cdv_intel_crt_init(dev, &dev_priv->mode_dev);
 	cdv_intel_lvds_init(dev, &dev_priv->mode_dev);
 
-	/* These bits indicate HDMI not SDVO on CDV, but we don't yet support
-	   the HDMI interface */
+	/* These bits indicate HDMI not SDVO on CDV */
 	if (REG_READ(SDVOB) & SDVO_DETECTED)
 		cdv_hdmi_init(dev, &dev_priv->mode_dev, SDVOB);
 	if (REG_READ(SDVOC) & SDVO_DETECTED)
@@ -69,76 +68,71 @@ static int cdv_output_init(struct drm_device *dev)
 #ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 
 /*
- *	Poulsbo Backlight Interfaces
+ *	Cedartrail Backlght Interfaces
  */
 
-#define BLC_PWM_PRECISION_FACTOR 100	/* 10000000 */
-#define BLC_PWM_FREQ_CALC_CONSTANT 32
-#define MHz 1000000
-
-#define PSB_BLC_PWM_PRECISION_FACTOR    10
-#define PSB_BLC_MAX_PWM_REG_FREQ        0xFFFE
-#define PSB_BLC_MIN_PWM_REG_FREQ        0x2
-
-#define PSB_BACKLIGHT_PWM_POLARITY_BIT_CLEAR (0xFFFE)
-#define PSB_BACKLIGHT_PWM_CTL_SHIFT	(16)
-
-static int cdv_brightness;
 static struct backlight_device *cdv_backlight_device;
 
-static int cdv_get_brightness(struct backlight_device *bd)
+static int cdv_backlight_combination_mode(struct drm_device *dev)
 {
-	/* return locally cached var instead of HW read (due to DPST etc.) */
-	/* FIXME: ideally return actual value in case firmware fiddled with
-	   it */
-	return cdv_brightness;
+	return REG_READ(BLC_PWM_CTL2) & PWM_LEGACY_MODE;
 }
 
-
-static int cdv_backlight_setup(struct drm_device *dev)
+static int cdv_get_brightness(struct backlight_device *bd)
 {
-	struct drm_psb_private *dev_priv = dev->dev_private;
-	unsigned long core_clock;
-	/* u32 bl_max_freq; */
-	/* unsigned long value; */
-	u16 bl_max_freq;
-	uint32_t value;
-	uint32_t blc_pwm_precision_factor;
-
-	/* get bl_max_freq and pol from dev_priv*/
-	if (!dev_priv->lvds_bl) {
-		dev_err(dev->dev, "Has no valid LVDS backlight info\n");
-		return -ENOENT;
-	}
-	bl_max_freq = dev_priv->lvds_bl->freq;
-	blc_pwm_precision_factor = PSB_BLC_PWM_PRECISION_FACTOR;
+	struct drm_device *dev = bl_get_data(bd);
+	u32 val = REG_READ(BLC_PWM_CTL) & BACKLIGHT_DUTY_CYCLE_MASK;
 
-	core_clock = dev_priv->core_freq;
+	if (cdv_backlight_combination_mode(dev)) {
+		u8 lbpc;
 
-	value = (core_clock * MHz) / BLC_PWM_FREQ_CALC_CONSTANT;
-	value *= blc_pwm_precision_factor;
-	value /= bl_max_freq;
-	value /= blc_pwm_precision_factor;
+		val &= ~1;
+		pci_read_config_byte(dev->pdev, 0xF4, &lbpc);
+		val *= lbpc;
+	}
+	return val;
+}
 
-	if (value > (unsigned long long)PSB_BLC_MAX_PWM_REG_FREQ ||
-		 value < (unsigned long long)PSB_BLC_MIN_PWM_REG_FREQ)
-				return -ERANGE;
-	else {
-		/* FIXME */
+static u32 cdv_get_max_backlight(struct drm_device *dev)
+{
+	u32 max = REG_READ(BLC_PWM_CTL);
+
+	if (max == 0) {
+		DRM_DEBUG_KMS("LVDS Panel PWM value is 0!\n");
+		/* i915 does this, I believe which means that we should not
+		 * smash PWM control as firmware will take control of it. */
+		return 1;
 	}
-	return 0;
+
+	max >>= 16;
+	if (cdv_backlight_combination_mode(dev))
+		max *= 0xff;
+	return max;
 }
 
 static int cdv_set_brightness(struct backlight_device *bd)
 {
+	struct drm_device *dev = bl_get_data(bd);
 	int level = bd->props.brightness;
+	u32 blc_pwm_ctl;
 
 	/* Percentage 1-100% being valid */
 	if (level < 1)
 		level = 1;
 
-	/*cdv_intel_lvds_set_brightness(dev, level); FIXME */
-	cdv_brightness = level;
+	if (cdv_backlight_combination_mode(dev)) {
+		u32 max = cdv_get_max_backlight(dev);
+		u8 lbpc;
+
+		lbpc = level * 0xfe / max + 1;
+		level /= lbpc;
+
+		pci_write_config_byte(dev->pdev, 0xF4, lbpc);
+	}
+
+	blc_pwm_ctl = REG_READ(BLC_PWM_CTL) & ~BACKLIGHT_DUTY_CYCLE_MASK;
+	REG_WRITE(BLC_PWM_CTL, (blc_pwm_ctl |
+				(level << BACKLIGHT_DUTY_CYCLE_SHIFT)));
 	return 0;
 }
 
@@ -150,7 +144,6 @@ static const struct backlight_ops cdv_ops = {
 static int cdv_backlight_init(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	int ret;
 	struct backlight_properties props;
 
 	memset(&props, 0, sizeof(struct backlight_properties));
@@ -162,13 +155,8 @@ static int cdv_backlight_init(struct drm_device *dev)
 	if (IS_ERR(cdv_backlight_device))
 		return PTR_ERR(cdv_backlight_device);
 
-	ret = cdv_backlight_setup(dev);
-	if (ret < 0) {
-		backlight_device_unregister(cdv_backlight_device);
-		cdv_backlight_device = NULL;
-		return ret;
-	}
-	cdv_backlight_device->props.brightness = 100;
+	cdv_backlight_device->props.brightness =
+			cdv_get_brightness(cdv_backlight_device);
 	cdv_backlight_device->props.max_brightness = 100;
 	backlight_update_status(cdv_backlight_device);
 	dev_priv->backlight_device = cdv_backlight_device;
@@ -244,11 +232,12 @@ static void cdv_init_pm(struct drm_device *dev)
 static void cdv_errata(struct drm_device *dev)
 {
 	/* Disable bonus launch.
-	 *	CPU and GPU competes for memory and display misses updates and flickers.
-	 *	Worst with dual core, dual displays.
+	 *	CPU and GPU competes for memory and display misses updates and
+	 *	flickers. Worst with dual core, dual displays.
 	 *
-	 *	Fixes were done to Win 7 gfx driver to disable a feature called Bonus
-	 *	Launch to work around the issue, by degrading performance.
+	 *	Fixes were done to Win 7 gfx driver to disable a feature called
+	 *	Bonus Launch to work around the issue, by degrading
+	 *	performance.
 	 */
 	 CDV_MSG_WRITE32(3, 0x30, 0x08027108);
 }

