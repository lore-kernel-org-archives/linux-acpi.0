From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI:Fix goto flows in thermal-sys
Date: Wed, 23 Mar 2011 01:54:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103230151240.10549@x980>
References: <1299106813-13726-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:46795 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab1CWFyz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 01:54:55 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00AK4XRIV662@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 00:54:55 -0500 (CDT)
In-reply-to: <1299106813-13726-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Thu, 3 Mar 2011, Durgadoss R wrote:

> This patch fixes two minor bugs in thermal_sys:
> (a) The flow of goto's in thermal_hwmon_add_sysfs.
> (b) Remove the temp*_crit only if there is a get_crit_temp defined, in
>     thermal_remove_hwmon_sysfs.

2 patches for two logical changes, please.

> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 13c72c6..b826dfb 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -495,7 +495,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  	dev_set_drvdata(hwmon->device, hwmon);
>  	result = device_create_file(hwmon->device, &dev_attr_name);
>  	if (result)
> -		goto unregister_hwmon_device;
> +		goto free_mem;

hwmon_device_register() succeeded if we got here,
so why don't we need to hwmon_device_unregister() in the error path?

thanks,
-Len Brown, Intel Open Source Technology Center

>   register_sys_interface:
>  	tz->hwmon = hwmon;
> @@ -509,7 +509,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  	sysfs_attr_init(&tz->temp_input.attr.attr);
>  	result = device_create_file(hwmon->device, &tz->temp_input.attr);
>  	if (result)
> -		goto unregister_hwmon_device;
> +		goto unregister_name;
>  
>  	if (tz->ops->get_crit_temp) {
>  		unsigned long temperature;
> @@ -523,7 +523,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  			result = device_create_file(hwmon->device,
>  						    &tz->temp_crit.attr);
>  			if (result)
> -				goto unregister_hwmon_device;
> +				goto unregister_input;
>  		}
>  	}
>  
> @@ -535,9 +535,9 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  
>  	return 0;
>  
> - unregister_hwmon_device:
> -	device_remove_file(hwmon->device, &tz->temp_crit.attr);
> + unregister_input:
>  	device_remove_file(hwmon->device, &tz->temp_input.attr);
> + unregister_name:
>  	if (new_hwmon_device) {
>  		device_remove_file(hwmon->device, &dev_attr_name);
>  		hwmon_device_unregister(hwmon->device);
> @@ -556,7 +556,8 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  
>  	tz->hwmon = NULL;
>  	device_remove_file(hwmon->device, &tz->temp_input.attr);
> -	device_remove_file(hwmon->device, &tz->temp_crit.attr);
> +	if (tz->ops->get_crit_temp)
> +		device_remove_file(hwmon->device, &tz->temp_crit.attr);
>  
>  	mutex_lock(&thermal_list_lock);
>  	list_del(&tz->hwmon_node);
> -- 
> 1.7.4
> 
