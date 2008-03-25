From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: EC: Use default setup handler
Date: Mon, 24 Mar 2008 20:52:51 -0400
Message-ID: <200803242052.51543.lenb@kernel.org>
References: <20080324202228.5055.11326.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52983 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbYCYAxG (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2008 20:53:06 -0400
In-Reply-To: <20080324202228.5055.11326.stgit@thinkpad.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

1-2 addded to acpi-test

thanks,
-Len

On Monday 24 March 2008, Alexey Starikovskiy wrote:
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   16 +---------------
>  1 files changed, 1 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index f0e8216..167af37 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -533,20 +533,6 @@ static void do_ec_poll(struct work_struct *work)
>     -------------------------------------------------------------------------- */
>  
>  static acpi_status
> -acpi_ec_space_setup(acpi_handle region_handle,
> -		    u32 function, void *handler_context, void **return_context)
> -{
> -	/*
> -	 * The EC object is in the handler context and is needed
> -	 * when calling the acpi_ec_space_handler.
> -	 */
> -	*return_context = (function != ACPI_REGION_DEACTIVATE) ?
> -	    handler_context : NULL;
> -
> -	return AE_OK;
> -}
> -
> -static acpi_status
>  acpi_ec_space_handler(u32 function, acpi_physical_address address,
>  		      u32 bits, acpi_integer *value,
>  		      void *handler_context, void *region_context)
> @@ -858,7 +844,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
>  	status = acpi_install_address_space_handler(ec->handle,
>  						    ACPI_ADR_SPACE_EC,
>  						    &acpi_ec_space_handler,
> -						    &acpi_ec_space_setup, ec);
> +						    NULL, ec);
>  	if (ACPI_FAILURE(status)) {
>  		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
>  		return -ENODEV;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


