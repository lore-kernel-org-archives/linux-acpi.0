From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Avoid enumerating devices more than once
Date: Thu, 20 Apr 2017 00:39:59 +0800
Message-ID: <20170419163959.GB3576@linux-l9pv.suse>
References: <20731969.imAyuWkf7P@aspire.rjw.lan>
 <2231844.zRx0dlJUx2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38667 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966428AbdDSQkK (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 19 Apr 2017 12:40:10 -0400
Content-Disposition: inline
In-Reply-To: <2231844.zRx0dlJUx2@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Apr 17, 2017 at 01:20:48AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> acpi_bus_attach() does not check the visited flag for devices that
> have been enumerated already and some of them may be enumerated
> for multiple times as a result, because some callers of
> acpi_bus_scan() don't check the visited flag either.
> 
> For this reason, modify acpi_bus_attach() to check the visited flag
> and avoid enumerating devices that have already been enumerated.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Joey Lee <jlee@suse.com>

Thanka a lot!
Joey Lee

> ---
>  drivers/acpi/scan.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1850,6 +1850,8 @@ static void acpi_bus_attach(struct acpi_
>  			device->flags.power_manageable = 0;
>  
>  		device->flags.initialized = true;
> +	} else if (device->flags.visited) {
> +		goto ok;
>  	}
>  
>  	ret = acpi_scan_attach_handler(device);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
