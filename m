From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] [PATCH 2/4] drm/i915: force mode set at lid open
	time
Date: Thu, 16 Jul 2009 09:36:13 +0800
Message-ID: <1247708173.4113.35.camel@localhost.localdomain>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	 <1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48506 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909AbZGPBfb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 21:35:31 -0400
In-Reply-To: <1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-07-16 at 06:11 +0800, Jesse Barnes wrote:
> Some laptop platforms will disable pipes and/or planes at lid close time
> and not restore them when the lid is opened again.  So catch the lid
> event, and if the lid was opened, force a mode restore.
Why is it necessary to force a mode restore when the LID is reopened?
Do you mean that the pipes/planes are disabled automatically by BIOS
when the LID is closed? 
If so, maybe it will be better that this feature is limited to some
boxes. It is unnecessary to add this feature for all the laptops.
    
Is it enough to mark the LVDS as disconnected/connected according to the
LID status? And this is done by user-space tool.
Thanks.
> 
> Fixes fdo bug #21230.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> ---
>  drivers/gpu/drm/Kconfig              |    1 +
>  drivers/gpu/drm/i915/i915_drv.h      |    2 ++
>  drivers/gpu/drm/i915/intel_display.c |    2 ++
>  drivers/gpu/drm/i915/intel_lvds.c    |   23 +++++++++++++++++++++++
>  4 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 39b393d..5873865 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -86,6 +86,7 @@ config DRM_I915
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	select FB
> +	select ACPI_BUTTON
How about 
  +	  select ACPI_BUTTON if ACPI
>  	select FRAMEBUFFER_CONSOLE if !EMBEDDED
>  	# i915 depends on ACPI_VIDEO when ACPI is enabled
>  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index b05b44d..11d0e28 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -221,6 +221,8 @@ typedef struct drm_i915_private {
>  	unsigned int lvds_use_ssc:1;
>  	int lvds_ssc_freq;
>  
> +	struct notifier_block lid_notifier;
> +
>  	struct drm_i915_fence_reg fence_regs[16]; /* assume 965 */
>  	int fence_reg_start; /* 4 if userland hasn't ioctl'd us yet */
>  	int num_fence_regs; /* 8 on pre-965, 16 otherwise */
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index 3fa0d63..6b0c799 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -24,6 +24,8 @@
>   *	Eric Anholt <eric@anholt.net>
>   */
>  
> +#include <linux/module.h>
> +#include <linux/input.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include "drmP.h"
> diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
> index 43c7d9a..1d0d30a 100644
> --- a/drivers/gpu/drm/i915/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/intel_lvds.c
> @@ -27,6 +27,7 @@
>   *      Jesse Barnes <jesse.barnes@intel.com>
>   */
>  
> +#include <acpi/button.h>
>  #include <linux/dmi.h>
>  #include <linux/i2c.h>
>  #include "drmP.h"
> @@ -642,6 +643,19 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
>  	return 0;
>  }
>  
> +static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
> +			    void *unused)
> +{
> +	struct drm_i915_private *dev_priv =
> +		container_of(nb, struct drm_i915_private, lid_notifier);
> +	struct drm_device *dev = dev_priv->dev;
> +
> +	if (acpi_lid_open())
> +		drm_helper_resume_force_mode(dev);
> +
> +	return NOTIFY_OK;
> +}
> +
>  /**
>   * intel_lvds_destroy - unregister and free LVDS structures
>   * @connector: connector to free
> @@ -651,10 +665,14 @@ static int intel_lvds_get_modes(struct drm_connector *connector)
>   */
>  static void intel_lvds_destroy(struct drm_connector *connector)
>  {
> +	struct drm_device *dev = connector->dev;
>  	struct intel_output *intel_output = to_intel_output(connector);
> +	struct drm_i915_private *dev_priv = dev->dev_private;
>  
>  	if (intel_output->ddc_bus)
>  		intel_i2c_destroy(intel_output->ddc_bus);
> +	if (dev_priv->lid_notifier.notifier_call)
> +		acpi_lid_notifier_unregister(&dev_priv->lid_notifier);
>  	drm_sysfs_connector_remove(connector);
>  	drm_connector_cleanup(connector);
>  	kfree(connector);
> @@ -1017,6 +1035,11 @@ out:
>  		pwm |= PWM_PCH_ENABLE;
>  		I915_WRITE(BLC_PWM_PCH_CTL1, pwm);
>  	}
> + 	dev_priv->lid_notifier.notifier_call = intel_lid_notify;
> + 	if (acpi_lid_notifier_register(&dev_priv->lid_notifier)) {
> + 		DRM_DEBUG("lid notifier registration failed\n");
> + 		dev_priv->lid_notifier.notifier_call = NULL;
> + 	}
>  	drm_sysfs_connector_add(connector);
>  	return;
>  

