From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/8] [-mm] ACPI: add ACPI Fan sysfs interface
Date: Thu, 22 Mar 2007 00:47:51 -0400
Message-ID: <200703220047.51688.lenb@kernel.org>
References: <1174382484.8833.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36063 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbXCVEtI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 00:49:08 -0400
In-Reply-To: <1174382484.8833.82.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>

On Tuesday 20 March 2007 05:21, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Add ACPI Fan device sysfs interface.
> 
> Attribute	Mode	Description
> state		RW	Fan state.
> 			0: Fan is in D0 state(on).
> 			3: Fan is in D3 state(off).

I hate the current /proc/acpi/fan/*/interface,
and don't think we should carry it forward into sysfs.

Forced to propose an alternative, I'd say:

0: off
1: on-lowest speed
2: on-next faster speed
3: on-next faster speed
...
n: maximum speed

Where n may be device dependent -- probably exported in an additional file.

So the state file would show the number, not the words on/off
(because, echo "on" and "off" into the file has no effect,
 which is the confusing mess we have today)

Note that for some systems, the different fan speeds are actually
exported as multiple fan devices, each with a simple on/off.

thanks,
-Len

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/fan.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 87 insertions(+), 11 deletions(-)
> 
> Index: linux-2.6.21-rc3-mm2/drivers/acpi/fan.c
> ===================================================================
> --- linux-2.6.21-rc3-mm2.orig/drivers/acpi/fan.c	2007-03-16 10:08:06.000000000 +0800
> +++ linux-2.6.21-rc3-mm2/drivers/acpi/fan.c	2007-03-16 10:20:02.000000000 +0800
> @@ -67,8 +67,57 @@ struct acpi_fan {
>  };
>  
>  /* --------------------------------------------------------------------------
> +                              FS Interface (/sys)
> +   -------------------------------------------------------------------------- */
> +
> +static ssize_t
> +acpi_fan_state_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_fan *fan = acpi_driver_data(dev);
> +	int state = 0;
> +	ssize_t result = 0;
> +
> +	if (!fan)
> +		return -EINVAL;
> +
> +	result = acpi_bus_get_power(fan->device->handle, &state);
> +	if (!result)
> +		result = sprintf(buf, "%u\n", state);
> +
> +	return result;
> +}
> +
> +static ssize_t
> +acpi_fan_state_store(struct acpi_device *dev, const char *buf, size_t count)
> +{
> +	struct acpi_fan *fan = acpi_driver_data(dev);
> +	ssize_t result;
> +	char * end;
> +	int state;
> +
> +	if (!fan)
> +		return -EINVAL;
> +
> +	state = simple_strtoul(buf, &end, 0);
> +	if (*end == '\0')
> +		return -EINVAL;
> +
> +	result = acpi_bus_set_power(fan->device->handle, state);
> +	if (!result)
> +		result = count;
> +
> +	return result;
> +}
> +static ACPI_DEVICE_ATTR(state, 0644, acpi_fan_state_show, acpi_fan_state_store);
> +
> +static struct device_attribute* fan_attr[] = {
> +	GET_DEV_ATTR(state),
> +	NULL,
> +};
> +/* --------------------------------------------------------------------------
>                                FS Interface (/proc)
>     -------------------------------------------------------------------------- */
> +#ifdef CONFIG_ACPI_PROCFS
>  
>  static struct proc_dir_entry *acpi_fan_dir;
>  
> @@ -128,7 +177,7 @@ static const struct file_operations acpi
>  	.owner = THIS_MODULE,
>  };
>  
> -static int acpi_fan_add_fs(struct acpi_device *device)
> +static int acpi_fan_add_procfs(struct acpi_device *device)
>  {
>  	struct proc_dir_entry *entry = NULL;
>  
> @@ -159,7 +208,7 @@ static int acpi_fan_add_fs(struct acpi_d
>  	return 0;
>  }
>  
> -static int acpi_fan_remove_fs(struct acpi_device *device)
> +static int acpi_fan_remove_procfs(struct acpi_device *device)
>  {
>  
>  	if (acpi_device_dir(device)) {
> @@ -171,6 +220,25 @@ static int acpi_fan_remove_fs(struct acp
>  	return 0;
>  }
>  
> +static int acpi_fan_procfs_init(void)
> +{
> +	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
> +	if (!acpi_fan_dir)
> +		return -ENODEV;
> +	acpi_fan_dir->owner = THIS_MODULE;
> +
> +	return 0;
> +}
> +
> +static int acpi_fan_procfs_exit(void)
> +{
> +	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
> +
> +	return 0;
> +}
> +#else
> +DECLARE_ACPI_DEVICE_PROCFS(fan);
> +#endif
>  /* --------------------------------------------------------------------------
>                                   Driver Interface
>     -------------------------------------------------------------------------- */
> @@ -204,18 +272,25 @@ static int acpi_fan_add(struct acpi_devi
>  	acpi_bus_set_power(device->handle, state);
>  	device->flags.force_power_state = 0;
>  
> -	result = acpi_fan_add_fs(device);
> +	result = acpi_device_add_sysfs(device, fan_attr);
>  	if (result)
>  		goto end;
>  
> +	result = acpi_fan_add_procfs(device);
> +	if (result)
> +		goto procfs_error;
> +
>  	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
>  	       acpi_device_name(device), acpi_device_bid(device),
>  	       !device->power.state ? "on" : "off");
>  
> +	goto end;
> +
> +      procfs_error:
> +	acpi_device_remove_sysfs(device,fan_attr);
>        end:
>  	if (result)
>  		kfree(fan);
> -
>  	return result;
>  }
>  
> @@ -229,7 +304,9 @@ static int acpi_fan_remove(struct acpi_d
>  
>  	fan = acpi_driver_data(device);
>  
> -	acpi_fan_remove_fs(device);
> +	acpi_fan_remove_procfs(device);
> +
> +	acpi_device_remove_sysfs(device, fan_attr);
>  
>  	kfree(fan);
>  
> @@ -272,15 +349,14 @@ static int __init acpi_fan_init(void)
>  {
>  	int result = 0;
>  
> -
> -	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
> -	if (!acpi_fan_dir)
> +	result = acpi_fan_procfs_init();
> +	if (result)
>  		return -ENODEV;
> -	acpi_fan_dir->owner = THIS_MODULE;
>  
> +	acpi_fan_driver.owner = THIS_MODULE;
>  	result = acpi_bus_register_driver(&acpi_fan_driver);
>  	if (result < 0) {
> -		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
> +		acpi_fan_procfs_exit();
>  		return -ENODEV;
>  	}
>  
> @@ -292,7 +368,7 @@ static void __exit acpi_fan_exit(void)
>  
>  	acpi_bus_unregister_driver(&acpi_fan_driver);
>  
> -	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
> +	acpi_fan_procfs_exit();
>  
>  	return;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
