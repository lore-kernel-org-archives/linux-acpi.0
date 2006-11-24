From: Len Brown <len.brown@intel.com>
Subject: Re: [11/12] acpi: acpi pci bridge driver
Date: Thu, 23 Nov 2006 22:39:33 -0500
Message-ID: <200611232239.34046.len.brown@intel.com>
References: <1158918689.11985.84.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53221 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S934217AbWKXDgl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Nov 2006 22:36:41 -0500
In-Reply-To: <1158918689.11985.84.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org


> Index: linux-2.6.18-rc7/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.18-rc7.orig/drivers/acpi/scan.c	2006-09-19 19:55:25.000000000 +0800
> +++ linux-2.6.18-rc7/drivers/acpi/scan.c	2006-09-19 19:55:52.000000000 +0800
> @@ -865,12 +865,13 @@ static int acpi_bus_remove(struct acpi_d
>  
>  	if (!rmdevice)
>  		return 0;
> -
> +	/* FIXME: device_release_driver will automically call unbind, is this ok */
> +#if 0
>  	if (dev->flags.bus_address) {
>  		if ((dev->parent) && (dev->parent->ops.unbind))
>  			dev->parent->ops.unbind(dev);
>  	}
> -
> +#endif

eh?
