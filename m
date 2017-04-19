From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 1/2] ACPI / scan: Apply default enumeration to devices
 with ACPI drivers
Date: Thu, 20 Apr 2017 00:38:51 +0800
Message-ID: <20170419163851.GA3576@linux-l9pv.suse>
References: <20731969.imAyuWkf7P@aspire.rjw.lan>
 <7942620.ijDeSLx5PQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56877 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966388AbdDSQjN (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 19 Apr 2017 12:39:13 -0400
Content-Disposition: inline
In-Reply-To: <7942620.ijDeSLx5PQ@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Apr 17, 2017 at 01:19:50AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code in acpi_bus_attach() is inconsistent with respect
> to device objects with ACPI drivers bound to them, as it allows
> ACPI drivers to bind to device objects with existing "physical"
> device companions, but it doesn't allow "physical" device objects
> to be created for ACPI device objects with ACPI drivers bound to
> them.  Thus, in some cases, the outcome depends on the ordering
> of events which is confusing at best.
> 
> For this reason, modify acpi_bus_attach() to call
> acpi_default_enumeration() for device objects with the 
> pnp.type.platform_id flag set regardless of whether or not
> any ACPI drivers are bound to them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I did my best to review the context of codes in this patchset. 

Reviewed-by: Joey Lee <jlee@suse.com>

Thanka a lot!
Joey Lee

> ---
>  drivers/acpi/scan.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1866,10 +1866,10 @@ static void acpi_bus_attach(struct acpi_
>  	if (ret < 0)
>  		return;
>  
> -	if (ret > 0 || !device->pnp.type.platform_id)
> -		acpi_device_set_enumerated(device);
> -	else
> +	if (device->pnp.type.platform_id)
>  		acpi_default_enumeration(device);
> +	else
> +		acpi_device_set_enumerated(device);
>  
>   ok:
>  	list_for_each_entry(child, &device->children, node)
> 
