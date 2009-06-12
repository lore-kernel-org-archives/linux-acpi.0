From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] RFC] [Patch] [DRM/I915] :Check the LID device to
	decide whether	the LVDS should be initialized
Date: Fri, 12 Jun 2009 09:00:01 +0800
Message-ID: <1244768401.3618.17.camel@localhost.localdomain>
References: <1244187921.3558.223.camel@localhost.localdomain>
	 <1244200261.11142.20.camel@gaiman.anholt.net>
	 <1244422347.3698.6.camel@localhost.localdomain>
	 <1244585813.4896.34.camel@gaiman.anholt.net>
	 <20090609153559.2e93479d@jbarnes-x200>
	 <1244714614.3618.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29198 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbZFLA6o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2009 20:58:44 -0400
In-Reply-To: <1244714614.3618.10.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Thu, 2009-06-11 at 18:03 +0800, yakui_zhao wrote:
cc: Linux-acpi
> Hi, All
> 
>     This is a patch that the LID device is checked to decide whether the LVDS should
> be initialized. If there is no LID device, it won't initialize the LVDS output device
> in KMS mode on the boxes based on intel mobile chipset. In such case the pipe occupied
> by LVDS can be used for other output device.
>     If the LID device can be found, it will continue the current flowchart.
>     
>     On some boxes the mobile chipset is used and there is no LVDS device. In such
> case we had better not initialize the LVDS output device so that one pipe can
> be used for other output device. For example: E-TOP in bug 21496
> 
> But unfortunately the LVDS device is still initialized on such boxes based on
> mobile chipset in KMS mode. It brings that this pipe occupied by LVDS can't be
> used for other output device.
> 
> After checking the acpidump we find that there is no LID device on such boxes.
> In such case we can use the LID device to decide whether the LVDS device should
> be initialized. 
> 
> If there is no LID device, we can think that there is no LVDS device. It is
> unnecessary to initialize the LVDS output device.
> If there exists the LID device, it will continue the current flowchart.
> 
> Maybe on some boxes there is no LVDS device but the LID device is found. In
> such case it had better be added to the quirk table.
> 
> Welcome the comments.
>    Yakui
> ---
>  drivers/gpu/drm/i915/intel_lvds.c |   79 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> Index: linux-2.6/drivers/gpu/drm/i915/intel_lvds.c
> ===================================================================
> --- linux-2.6.orig/drivers/gpu/drm/i915/intel_lvds.c	2009-06-11 15:27:07.000000000 +0800
> +++ linux-2.6/drivers/gpu/drm/i915/intel_lvds.c	2009-06-11 17:42:07.000000000 +0800
> @@ -36,6 +36,7 @@
>  #include "intel_drv.h"
>  #include "i915_drm.h"
>  #include "i915_drv.h"
> +#include <linux/acpi.h>
>  
>  /**
>   * Sets the backlight level.
> @@ -503,7 +504,74 @@
>  
>  	{ }	/* terminating entry */
>  };
> +#ifdef CONFIG_ACPI
> +/*
> + * check_lid_device -- check whether it is ACPI LID device.
> + * @handle: ACPI device handle
> + * @level : depth in the ACPI namespace tree
> + * @context: the number of LID device when we find the device
> + * @rv: a return value to fill if desired (Not use)
> + *
> + * check whether it is a LID device by comparing the HID. If it is,
> + * increase the number of LID device.
> + */
> +static acpi_status
> +check_lid_device(acpi_handle handle, u32 level, void *context,
> +			void **retyurn_value)
> +{
> +#define		ACPI_HID_LID		"PNP0C0D"
> +	struct acpi_device *acpi_dev;
> +	int *p_lid = (int *)context;
> +
> +	acpi_dev = NULL;
> +	/* Get the acpi device for device handle */
> +	if (acpi_bus_get_device(handle, &acpi_dev) || !acpi_dev) {
> +		/* If there is no ACPI device for handle, return */
> +		return AE_OK;
> +	}
> +	if (!strncmp(acpi_device_hid(acpi_dev), ACPI_HID_LID, 7)) {
> +		/*
> +		 * compare the device HID with "PNP0C0D". If it is equal, the
> +		 * LID device is found. Increase the count
> +		 */
> +		(*p_lid)++;
> +	}
> +	return AE_OK;
> +}
> +/**
> + * check whether there exists the ACPI LID device by enumerating the ACPI
> + * device tree.
> + * If ACPI is disabled, there is no ACPI device tree. 0 is returned.
> + * If the LID device is found, it will return zero.
> + * If no LID device is found, it will return  -ENODEV.
> + */
> +static int intel_lvds_find_lid(void)
> +{
> +	int lid_count = 0;
>  
> +	if (acpi_disabled) {
> +		/*
> +		 * if ACPI is disabled, there is no ACPI device tree. And
> +		 * we don't know whether there exists the LID device.
> +		 * In such case we will return 0.
> +		 */
> +		return 0;
> +	}
> +
> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +				ACPI_UINT32_MAX,
> +				check_lid_device, &lid_count, NULL);
> +
> +	if (!lid_count) {
> +		/* No LID device is not found. Return -ENODEV */
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static inline int intel_lvds_find_lid(void) { return 0; }
> +#endif
>  /**
>   * intel_lvds_init - setup LVDS connectors on this device
>   * @dev: drm device
> @@ -526,6 +594,17 @@
>  	if (dmi_check_system(intel_no_lvds))
>  		return;
>  
> +	if (intel_lvds_find_lid()) {
> +		/* If there is no LID device, we can think that there is
> +		 * no LVDS output device. In such case it is unnecessary to
> +		 * create the LVDS output device.
> +		 * But maybe on some boxes there is no LVDS device while the
> +		 * LID device is found. If so, it had better be added to
> +		 * the quirk list.
> +		 */
> +		return;
> +	}
> +
>  	if (IS_IGDNG(dev)) {
>  		if ((I915_READ(PCH_LVDS) & LVDS_DETECTED) == 0)
>  			return;
> 
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

