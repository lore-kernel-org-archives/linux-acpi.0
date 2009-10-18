From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/6] ACPI: dock: convert sysfs attributes to an
	attribute_group
Date: Sun, 18 Oct 2009 00:16:30 -0700
Message-ID: <20091018071630.GC3935@core.coreip.homeip.net>
References: <20091016211323.12126.58457.stgit@bob.kio> <20091016211459.12126.60739.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:54244 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZJRHQa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Oct 2009 03:16:30 -0400
Content-Disposition: inline
In-Reply-To: <20091016211459.12126.60739.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Alex,

On Fri, Oct 16, 2009 at 03:14:59PM -0600, Alex Chiang wrote:
> As suggested by Dmitry Torokhov, convert the individual sysfs
> attributes into an attribute group.
> 
> This change eliminates quite a bit of copy/paste code in the
> error handling paths.
> 

Looks much better, one more suggestion though:

> +err_unregister:
> +	printk(KERN_ERR "%s encountered error %d\n", __func__, ret);

If you want to print error this it should probably go down, right before
"return ret".

> +	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);

It begs another label right here. There are cases when yo0u already
registered the platform device but haven't added the sysfs group, right?

>  	platform_device_unregister(dock_device);
> +out:
>  	kfree(dock_station);
>  	dock_station = NULL;
>  	return ret;
> @@ -1076,11 +1046,7 @@ static int dock_remove(struct dock_station *dock_station)
>  	    kfree(dd);
>  
>  	/* cleanup sysfs */
> -	device_remove_file(&dock_device->dev, &dev_attr_type);
> -	device_remove_file(&dock_device->dev, &dev_attr_docked);
> -	device_remove_file(&dock_device->dev, &dev_attr_undock);
> -	device_remove_file(&dock_device->dev, &dev_attr_uid);
> -	device_remove_file(&dock_device->dev, &dev_attr_flags);
> +	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
>  	platform_device_unregister(dock_device);
>  
>  	/* free dock station memory */
> 

-- 
Dmitry
