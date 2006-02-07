From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: [PATCH] acpi: make message more descriptive/meaningful
Date: Tue, 7 Feb 2006 10:18:09 -0800
Message-ID: <20060207181809.GA3692@linux.intel.com>
References: <20060206192910.66cb9c86.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:29408 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750995AbWBGSPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Feb 2006 13:15:19 -0500
Content-Disposition: inline
In-Reply-To: <20060206192910.66cb9c86.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

On Mon, Feb 06, 2006 at 07:29:10PM -0800, Randy.Dunlap wrote:

> Identify which device is not power-manageable to make
> the message more useful.


> --- linux-2615-rc6g4.orig/drivers/acpi/bus.c
> +++ linux-2615-rc6g4/drivers/acpi/bus.c
> @@ -198,7 +198,8 @@ int acpi_bus_set_power(acpi_handle handl
>  
>  	if (!device->flags.power_manageable) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> -				  "Device is not power manageable\n"));
> +				  "Device '%s' is not power manageable\n",
> +					device->kobj.name));


This is good information, but does it have to come in such a scary message?
It appears that something is wrong with the device, when in fact, it just
doesn't support an optional capability.

Could we demote the message to e.g. ACPI_DB_INFO? 

Thanks,


	Patrick
