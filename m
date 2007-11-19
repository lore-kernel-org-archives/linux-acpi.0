From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: Don't init EC early if it has no _INI
Date: Mon, 19 Nov 2007 01:45:21 -0500
Message-ID: <200711190145.21457.lenb@kernel.org>
References: <20071115185247.6712.53371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58043 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbXKSQYx (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 11:24:53 -0500
In-Reply-To: <20071115185247.6712.53371.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Thursday 15 November 2007 13:52, Alexey Starikovskiy wrote:
> Option to init EC early inserted to handle #8598 ASUS problem,
> introduced several others. 
> EC driver in this particular case has fake _INI method, not present on
> other machines, which don't need or break from this workaround, so lets use
> its presence as a flag for early init.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9262
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=8598
> Reference: https://bugzilla.novell.com/show_bug.cgi?id=334806
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 06b78e5..56afe13 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -881,12 +881,20 @@ int __init acpi_ec_ecdt_probe(void)
>  		boot_ec->gpe = ecdt_ptr->gpe;
>  		boot_ec->handle = ACPI_ROOT_OBJECT;
>  	} else {
> +		/* This workaround is needed only on some broken machines,
> +		 * which require early EC, but fail to provide ECDT */
> +		acpi_handle x;
>  		printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
>  		status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
>  						boot_ec, NULL);
>  		/* Check that acpi_get_devices actually find something */
>  		if (ACPI_FAILURE(status) || !boot_ec->handle)
>  			goto error;
> +		/* We really need to limit this workaround, the only ASUS,
> +		 * which needs it, has fake EC._INI method, so use it as flag.
> +		 */
> +		if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &x)))
> +			goto error;
>  	}
>  
>  	ret = ec_install_handlers(boot_ec);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
