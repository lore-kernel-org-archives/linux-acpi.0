From: Len Brown <lenb@kernel.org>
Subject: Re: acpi: struct device - replace bus_id with dev_name(),
 dev_set_name()
Date: Fri, 06 Feb 2009 22:48:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902062248010.26256@localhost.localdomain>
References: <1232923256.2924.3.camel@nga>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:28157 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbZBGDs3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 22:48:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00KAFFVX49Q1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 06 Feb 2009 21:47:58 -0600 (CST)
In-reply-to: <1232923256.2924.3.camel@nga>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

applied
thanks,
--
Len Brown, Intel Open Source Technology Center

On Sun, 25 Jan 2009, Kay Sievers wrote:

> From: Kay Sievers <kay.sievers@vrfy.org>
> Subject: acpi: struct device - replace bus_id with dev_name(), dev_set_name()
> 
> Cc: lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
> 
> ---
>  drivers/acpi/glue.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -255,12 +255,12 @@ static int acpi_platform_notify(struct d
>  	}
>  	type = acpi_get_bus_type(dev->bus);
>  	if (!type) {
> -		DBG("No ACPI bus support for %s\n", dev->bus_id);
> +		DBG("No ACPI bus support for %s\n", dev_name(dev));
>  		ret = -EINVAL;
>  		goto end;
>  	}
>  	if ((ret = type->find_device(dev, &handle)) != 0)
> -		DBG("Can't get handler for %s\n", dev->bus_id);
> +		DBG("Can't get handler for %s\n", dev_name(dev));
>        end:
>  	if (!ret)
>  		acpi_bind_one(dev, handle);
> @@ -271,10 +271,10 @@ static int acpi_platform_notify(struct d
>  
>  		acpi_get_name(dev->archdata.acpi_handle,
>  			      ACPI_FULL_PATHNAME, &buffer);
> -		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
> +		DBG("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
>  		kfree(buffer.pointer);
>  	} else
> -		DBG("Device %s -> No ACPI support\n", dev->bus_id);
> +		DBG("Device %s -> No ACPI support\n", dev_name(dev));
>  #endif
>  
>  	return ret;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> From: Kay Sievers <kay.sievers@vrfy.org>
> Subject: acpi: struct device - replace bus_id with dev_name(), dev_set_name()
> 
> Cc: lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
> 
> ---
>  drivers/acpi/glue.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -255,12 +255,12 @@ static int acpi_platform_notify(struct d
>  	}
>  	type = acpi_get_bus_type(dev->bus);
>  	if (!type) {
> -		DBG("No ACPI bus support for %s\n", dev->bus_id);
> +		DBG("No ACPI bus support for %s\n", dev_name(dev));
>  		ret = -EINVAL;
>  		goto end;
>  	}
>  	if ((ret = type->find_device(dev, &handle)) != 0)
> -		DBG("Can't get handler for %s\n", dev->bus_id);
> +		DBG("Can't get handler for %s\n", dev_name(dev));
>        end:
>  	if (!ret)
>  		acpi_bind_one(dev, handle);
> @@ -271,10 +271,10 @@ static int acpi_platform_notify(struct d
>  
>  		acpi_get_name(dev->archdata.acpi_handle,
>  			      ACPI_FULL_PATHNAME, &buffer);
> -		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
> +		DBG("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
>  		kfree(buffer.pointer);
>  	} else
> -		DBG("Device %s -> No ACPI support\n", dev->bus_id);
> +		DBG("Device %s -> No ACPI support\n", dev_name(dev));
>  #endif
>  
>  	return ret;
> 
