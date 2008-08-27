From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 11/11]add 'type' sysfs file for dock
Date: Thu, 28 Aug 2008 01:39:07 +0200
Message-ID: <87sksqowo4.fsf@basil.nowhere.org>
References: <1219806902.32665.67.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:46714 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbYH0XjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:39:14 -0400
In-Reply-To: <1219806902.32665.67.camel@sli10-desk.sh.intel.com> (Shaohua Li's message of "Wed, 27 Aug 2008 11:15:02 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Shaohua Li <shaohua.li@intel.com> writes:

> add a sysfs file to present dock type. Suggested by Holger.
>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/dock.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> Index: linux/drivers/acpi/dock.c
> ===================================================================
> --- linux.orig/drivers/acpi/dock.c	2008-08-27 10:22:28.000000000 +0800
> +++ linux/drivers/acpi/dock.c	2008-08-27 10:22:32.000000000 +0800
> @@ -902,6 +902,25 @@ static ssize_t show_dock_uid(struct devi
>  }
>  static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
>  
> +static ssize_t show_dock_type(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);

80 chars?

>  /**
>   * dock_add - add a new dock station
>   * @handle: the dock station handle
> @@ -989,6 +1008,18 @@ static int dock_add(acpi_handle handle)
>  		dock_station = NULL;
>  		return ret;
>  	}
> +	ret = device_create_file(&dock_device->dev, &dev_attr_type);
> +	if (ret) {
> +		printk("Error %d adding sysfs file\n", ret);
> +		device_remove_file(&dock_device->dev, &dev_attr_docked);
> +		device_remove_file(&dock_device->dev, &dev_attr_undock);
> +		device_remove_file(&dock_device->dev, &dev_attr_uid);
> +		device_remove_file(&dock_device->dev, &dev_attr_flags);
> +		platform_device_unregister(dock_device);
> +		kfree(dock_station);
> +		dock_station = NULL;
> +		return ret;

I can just see that path breaking (or is it even tested). And it's
not fatal anyways. Best to just printk and ignore.

-Andi

-- 
ak@linux.intel.com
