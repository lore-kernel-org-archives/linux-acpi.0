From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC] i915/acpi: add lid status notification and detection
Date: Thu, 21 May 2009 09:34:18 -0700
Message-ID: <20090521093418.3f1a03d5@jbarnes-g45>
References: <20090513115734.338b7d55@jbarnes-g45>
	<1242264144.3773.415.camel@localhost.localdomain>
	<20090519171545.GA17801@srcf.ucam.org>
	<1242896273.32574.10.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/H72ymUQqHD.1MpLc03noMCp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-153.bluehost.com ([67.222.39.33]:45809 "HELO
	outbound-mail-153.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754919AbZEUQed (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 12:34:33 -0400
In-Reply-To: <1242896273.32574.10.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lenb@kernel.org

--MP_/H72ymUQqHD.1MpLc03noMCp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 21 May 2009 16:57:53 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> On Wed, 2009-05-20 at 01:15 +0800, Matthew Garrett wrote:
> > > > There's also a policy question here.  On some machines, a lid
> > > > close will cause the ACPI firmware to program the GPU,
> > > > disabling the pipe associated with the panel.  Should we detect
> > > > this and turn it back on at open time?  That could be dangerous
> > > > if userspace has received the LVDS hotplug event and changed
> > > > the config out from under us...
> > > > 
> > > > Comments?
> > > It seems that the LID status is used to determine whether the
> > > LVDS is connected.
> > > It is not reliable. On some boxes the initial LID status is
> > > incorrect. Maybe the LID status is open. But the ACPI returns
> > > that the LID is close. In such case the LVDS is not initialized
> > > and user can't get the output.
> > 
> > Really? I haven't seen any cases of this. They'll fail in all sorts
> > of fun ways with modern userland.
> > 
> This is rare, and if this happens, a bug should be filed against ACPI.
> BTW: we have fixed/root caused all such kind of bugs that have been
> reported.
> So I think it makes sense to trust the Lid state reported by ACPI
> button driver.

So is that two acks for the patch?  If so, should it be split or can it
just go in through the i915 driver tree?

Len?  (Patch attached for reference.)

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center

--MP_/H72ymUQqHD.1MpLc03noMCp
Content-Type: text/x-patch; name=i915-lvds-lid-detect-2.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=i915-lvds-lid-detect-2.patch

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
index 3a22eb9..dde56b6 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -71,6 +71,7 @@ config DRM_I915
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB
+	select ACPI_BUTTON
 	tristate "i915 driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 2506592..fb12fb9 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -190,6 +190,8 @@ typedef struct drm_i915_private {
 	unsigned int lvds_use_ssc:1;
 	int lvds_ssc_freq;
 
+	struct notifier_block lid_notifier;
+
 	struct drm_i915_fence_reg fence_regs[16]; /* assume 965 */
 	int fence_reg_start; /* 4 if userland hasn't ioctl'd us yet */
 	int num_fence_regs; /* 8 on pre-965, 16 otherwise */
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index bdcda36..08c1260 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -24,6 +24,8 @@
  *	Eric Anholt <eric@anholt.net>
  */
 
+#include <linux/module.h>
+#include <linux/input.h>
 #include <linux/i2c.h>
 #include "drmP.h"
 #include "intel_drv.h"
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 6619f26..8f05b09 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -27,6 +27,7 @@
  *      Jesse Barnes <jesse.barnes@intel.com>
  */
 
+#include <acpi/button.h>
 #include <linux/dmi.h>
 #include <linux/i2c.h>
 #include "drmP.h"
@@ -277,12 +278,18 @@ static void intel_lvds_mode_set(struct drm_encoder *encoder,
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
@@ -321,6 +328,17 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
+static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
+			    void *unused)
+{
+	struct drm_i915_private *dev_priv =
+		container_of(nb, struct drm_i915_private, lid_notifier);
+
+	drm_sysfs_hotplug_event(dev_priv->dev);
+
+	return NOTIFY_OK;
+}
+
 /**
  * intel_lvds_destroy - unregister and free LVDS structures
  * @connector: connector to free
@@ -330,10 +348,14 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
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
@@ -508,6 +530,11 @@ void intel_lvds_init(struct drm_device *dev)
 		goto failed;
 
 out:
+	dev_priv->lid_notifier.notifier_call = intel_lid_notify;
+	if (acpi_lid_notifier_register(&dev_priv->lid_notifier)) {
+		DRM_DEBUG("lid notifier registration failed\n");
+		dev_priv->lid_notifier.notifier_call = NULL;
+	}
 	drm_sysfs_connector_add(connector);
 	return;
 
diff --git a/include/acpi/button.h b/include/acpi/button.h
new file mode 100644
index 0000000..bb643a7
--- /dev/null
+++ b/include/acpi/button.h
@@ -0,0 +1,10 @@
+#ifndef ACPI_BUTTON_H
+#define ACPI_BUTTON_H
+
+#include <linux/notifier.h>
+
+extern int acpi_lid_notifier_register(struct notifier_block *nb);
+extern int acpi_lid_notifier_unregister(struct notifier_block *nb);
+extern int acpi_lid_open(void);
+
+#endif /* ACPI_BUTTON_H */

--MP_/H72ymUQqHD.1MpLc03noMCp--
