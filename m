From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] ACPI / PM: Expose power states of ACPI devices to
 user space
Date: Tue, 22 Jan 2013 15:47:18 -0800
Message-ID: <20130122234718.GC694@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <4247313.2G7Z3nCgM0@vostro.rjw.lan>
 <2760421.6nE3tkh92K@vostro.rjw.lan>
 <4706454.hY2fLkUfhN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:37544 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3AVXrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2013 18:47:22 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so4372674pad.32
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jan 2013 15:47:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4706454.hY2fLkUfhN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Tue, Jan 22, 2013 at 03:25:15AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it possible to retrieve the current power state of a device with
> ACPI power management from user space via sysfs by adding two new
> attributes, power_state and real_power_state, to the sysfs directory
> associated with the struct acpi_device object representing the
> device's ACPI node.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-power_state      |   20 ++++++
>  Documentation/ABI/testing/sysfs-devices-real_power_state |   23 +++++++
>  drivers/acpi/scan.c                                      |   49 ++++++++++++++-
>  3 files changed, 91 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -178,6 +178,32 @@ err_out:
>  }
>  EXPORT_SYMBOL(acpi_bus_hot_remove_device);
>  
> +static ssize_t real_power_state_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	int state;
> +	int ret;
> +
> +	ret = acpi_device_get_power(adev, &state);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%s\n", acpi_power_state_string(state));
> +}
> +
> +static DEVICE_ATTR(real_power_state, 0444, real_power_state_show, NULL);
> +
> +static ssize_t power_state_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +
> +	return sprintf(buf, "%s\n", acpi_power_state_string(adev->power.state));
> +}
> +
> +static DEVICE_ATTR(power_state, 0444, power_state_show, NULL);
> +
>  static ssize_t
>  acpi_eject_store(struct device *d, struct device_attribute *attr,
>  		const char *buf, size_t count)
> @@ -369,8 +395,22 @@ static int acpi_device_setup_files(struc
>           * hot-removal function from userland.
>           */
>  	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
> -	if (ACPI_SUCCESS(status))
> +	if (ACPI_SUCCESS(status)) {
>  		result = device_create_file(&dev->dev, &dev_attr_eject);
> +		if (result)
> +			return result;
> +	}
> +
> +	if (dev->flags.power_manageable) {
> +		result = device_create_file(&dev->dev, &dev_attr_power_state);
> +		if (result)
> +			return result;
> +
> +		if (dev->power.flags.power_resources)
> +			result = device_create_file(&dev->dev,
> +						    &dev_attr_real_power_state);
> +	}
> +

It isn't your fault, but I just noticed this when reading patch 2/4, but
I think you are racing userspace here.  The device is registered,
userspace is notified that the device is present, and _then_ the acpi
core creates the sysfs files for the device.

That's not good, and needs to be fixed, especially now that you are
adding more and more sysfs files for these ACPI devices.

To do that, you need to set up "default" files for ACPI devices, they
can be enabled or not by the driver core, and will be created before the
event that the device is created is sent to userspace.

Care to fix that all up in a follow-on patchset before some tools start
to get confused?

thanks,

greg k-h
