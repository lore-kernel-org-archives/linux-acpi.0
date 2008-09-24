From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 11/11]add 'type' sysfs file for dock
Date: Tue, 23 Sep 2008 23:37:57 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809232337120.20067@localhost.localdomain>
References: <1219889265.29375.47.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:59615 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYIXDiD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Sep 2008 23:38:03 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K7O007OWKRD94LT@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 23 Sep 2008 22:38:01 -0500 (CDT)
In-reply-to: <1219889265.29375.47.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

shouldn't patches that change sysfs always
update something in Documentation/ABI/*?

-Len

On Thu, 28 Aug 2008, Shaohua Li wrote:

> add a sysfs file to present dock type. Suggested by Holger.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/dock.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> Index: linux/drivers/acpi/dock.c
> ===================================================================
> --- linux.orig/drivers/acpi/dock.c	2008-08-28 09:49:00.000000000 +0800
> +++ linux/drivers/acpi/dock.c	2008-08-28 09:53:05.000000000 +0800
> @@ -911,6 +911,26 @@ static ssize_t show_dock_uid(struct devi
>  }
>  static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
>  
> +static ssize_t show_dock_type(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct dock_station *dock_station = *((struct dock_station **)
> +		dev->platform_data);
> +	char *type;
> +
> +	if (dock_station->flags & DOCK_IS_DOCK)
> +		type = "dock_station";
> +	else if (dock_station->flags & DOCK_IS_ATA)
> +		type = "ata_bay";
> +	else if (dock_station->flags & DOCK_IS_BAT)
> +		type = "battery_bay";
> +	else
> +		type = "unknown";
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", type);
> +}
> +static DEVICE_ATTR(type, S_IRUGO, show_dock_type, NULL);
> +
>  /**
>   * dock_add - add a new dock station
>   * @handle: the dock station handle
> @@ -999,6 +1019,9 @@ static int dock_add(acpi_handle handle)
>  		dock_station = NULL;
>  		return ret;
>  	}
> +	ret = device_create_file(&dock_device->dev, &dev_attr_type);
> +	if (ret)
> +		printk(KERN_ERR"Error %d adding sysfs file\n", ret);
>  
>  	/* Find dependent devices */
>  	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> @@ -1020,6 +1043,7 @@ static int dock_add(acpi_handle handle)
>  	return 0;
>  
>  dock_add_err_unregister:
> +	device_remove_file(&dock_device->dev, &dev_attr_type);
>  	device_remove_file(&dock_device->dev, &dev_attr_docked);
>  	device_remove_file(&dock_device->dev, &dev_attr_undock);
>  	device_remove_file(&dock_device->dev, &dev_attr_uid);
> @@ -1047,6 +1071,7 @@ static int dock_remove(struct dock_stati
>  	    kfree(dd);
>  
>  	/* cleanup sysfs */
> +	device_remove_file(&dock_device->dev, &dev_attr_type);
>  	device_remove_file(&dock_device->dev, &dev_attr_docked);
>  	device_remove_file(&dock_device->dev, &dev_attr_undock);
>  	device_remove_file(&dock_device->dev, &dev_attr_uid);
> 
> 
