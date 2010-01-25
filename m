From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 2.6.32.stable] ACPI: Advertise to BIOS in
 _OSC: _OST on _PPC changes
Date: Mon, 25 Jan 2010 11:12:41 -0800
Message-ID: <20100125191241.GB21045@kroah.com>
References: <alpine.LFD.2.00.1001231449040.5156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:38848 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab0AYTWu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jan 2010 14:22:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001231449040.5156@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: stable@kernel.org, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org


Hm, this patch doesn't apply to the 2.6.32-stable tree.  Care to rediff
it and send it back so that I can apply it?

thanks,

greg k-h

On Sat, Jan 23, 2010 at 02:51:04PM -0500, Len Brown wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> upstream 6a4e2b7503d1f630bface040cf0f5a7aac1fabdb
> 
> If the BIOS pokes the system-wide OSC bits to see if Linux
> supports evaluating _OST after a _PPC change notification,
> answer yes.
> 
> Also, fix an oversight where we neglected to set the OSC
> bit advertising processor aggregator device support
> when acpi-pad is compiled as a module.
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/bus.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index cf761b9..a52126e 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -490,9 +490,14 @@ static void acpi_bus_osc_support(void)
>  
>  	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
>  	capbuf[OSC_SUPPORT_TYPE] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
> -#ifdef CONFIG_ACPI_PROCESSOR_AGGREGATOR
> +#if defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR) ||\
> +			defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR_MODULE)
>  	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PAD_SUPPORT;
>  #endif
> +
> +#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
> +	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
> +#endif
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>  		return;
>  	if (ACPI_SUCCESS(acpi_run_osc(handle, &context)))
> -- 
> 1.6.6.1.383.g5a9f
> 
> _______________________________________________
> stable mailing list
> stable@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/stable
