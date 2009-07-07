From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
 detection
Date: Tue, 7 Jul 2009 15:51:20 -0700
Message-ID: <20090707155120.4bf56053@jbarnes-g45>
References: <20090513115734.338b7d55@jbarnes-g45>
	<1242264144.3773.415.camel@localhost.localdomain>
	<20090519171545.GA17801@srcf.ucam.org>
	<1242896273.32574.10.camel@rzhang-dt>
	<20090521093418.3f1a03d5@jbarnes-g45>
	<4A15FE57.7040002@linux.intel.com>
	<20090527015801.2f47089f@jbarnes-x200>
	<1244704587.3616.109.camel@localhost.localdomain>
	<20090616113320.69fa477d@jbarnes-g45>
	<1245205951.3583.169.camel@localhost.localdomain>
	<20090617161039.45027d45@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-01.bluehost.com ([69.89.21.11]:55617 "HELO
	outbound-mail-01.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755580AbZGGW6F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2009 18:58:05 -0400
In-Reply-To: <20090617161039.45027d45@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, 17 Jun 2009 16:10:39 -0700
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Wed, 17 Jun 2009 10:32:31 +0800
> yakui_zhao <yakui.zhao@intel.com> wrote:
> 
> > On Wed, 2009-06-17 at 02:33 +0800, Jesse Barnes wrote:
> > > Well, what should we use then?  Think of a common use case: you
> > > plug in
> > > an external monitor and shut your lid.  Do we want to make the
> > > user manually change their configuration?  Or detect that the lid
> > > is no longer in use?  And what about the case where they boot
> > > with the lid closed (e.g. in a docked scenario)?  We want to
> > > support that automatically too...
> > This feature should work on most laptops. When the LID is closed,
> > the LVDS is marked as disconnected.
> > 
> > But this can't work for some boxes on which the initial Lid state is
> > incorrect. We see such an exception on several laptops in ACPI
> > bugzilla.
> > 
> > If we expect this feature for most laptops, how about adding the
> > exception boxes into the blacklist that doesn't support this
> > feature?
> 
> Yeah, that's fine with me.  Is there a list somewhere?  Please don't
> make me troll through ACPI bugzilla! :)

Here's an update of this patch, that restores the last configuration at
lid open time.  That's needed on at least some machines since the
firmware will disable planes at lid close time to save power.

-- 
Jesse Barnes, Intel Open Source Technology Center

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9195deb..ebb593e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -113,6 +113,9 @@ static const struct file_operations acpi_button_state_fops = {
 	.release = single_release,
 };
 
+static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
+static struct acpi_device *lid_device;
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -229,11 +232,38 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 /* --------------------------------------------------------------------------
                                 Driver Interface
    -------------------------------------------------------------------------- */
+int acpi_lid_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
+}
+EXPORT_SYMBOL(acpi_lid_notifier_register);
+
+int acpi_lid_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
+}
+EXPORT_SYMBOL(acpi_lid_notifier_unregister);
+
+int acpi_lid_open(void)
+{
+	acpi_status status;
+	unsigned long long state;
+
+	status = acpi_evaluate_integer(lid_device->handle, "_LID", NULL,
+				       &state);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return !!state;
+}
+EXPORT_SYMBOL(acpi_lid_open);
+
 static int acpi_lid_send_state(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	unsigned long long state;
 	acpi_status status;
+	int ret;
 
 	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
 	if (ACPI_FAILURE(status))
@@ -242,7 +272,12 @@ static int acpi_lid_send_state(struct acpi_device *device)
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
-	return 0;
+
+	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
+	if (ret == NOTIFY_DONE)
+		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
+						   device);
+	return ret;
 }
 
 static void acpi_button_notify(struct acpi_device *device, u32 event)
@@ -364,8 +399,14 @@ static int acpi_button_add(struct acpi_device *device)
 	error = input_register_device(input);
 	if (error)
 		goto err_remove_fs;
-	if (button->type == ACPI_BUTTON_TYPE_LID)
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		acpi_lid_send_state(device);
+		/*
+		 * This assumes there's only one lid device, or if there are
+		 * more we only care about the last one...
+		 */
+		lid_device = device;
+	}
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
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
index 47ecb61..166b5ae 100644
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
index 508838e..d08f286 100644
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
index f65044b..9020e74 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -27,6 +27,7 @@
  *      Jesse Barnes <jesse.barnes@intel.com>
  */
 
+#include <acpi/button.h>
 #include <linux/dmi.h>
 #include <linux/i2c.h>
 #include "drmP.h"
@@ -597,12 +598,18 @@ static void intel_lvds_mode_set(struct drm_encoder *encoder,
 /**
  * Detect the LVDS connection.
  *
- * This always returns CONNECTOR_STATUS_CONNECTED.  This connector should only have
- * been set up if the LVDS was actually connected anyway.
+ * Since LVDS doesn't have hotlug, we use the lid as a proxy.  Open means
+ * connected and closed means disconnected.  We also send hotplug events as
+ * needed, using lid status notification from the input layer.
  */
 static enum drm_connector_status intel_lvds_detect(struct drm_connector *connector)
 {
-	return connector_status_connected;
+	enum drm_connector_status status = connector_status_connected;
+
+	if (!acpi_lid_open())
+		status = connector_status_disconnected;
+
+	return status;
 }
 
 /**
@@ -641,6 +648,20 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
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
+	drm_sysfs_hotplug_event(dev_priv->dev);
+
+	return NOTIFY_OK;
+}
+
 /**
  * intel_lvds_destroy - unregister and free LVDS structures
  * @connector: connector to free
@@ -650,10 +671,14 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
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
@@ -939,6 +964,11 @@ out:
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
 

