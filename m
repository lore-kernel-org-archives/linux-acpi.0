From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: disable stray gpe correctly
Date: Tue, 11 Mar 2008 02:06:45 -0400
Message-ID: <200803110206.45590.lenb@kernel.org>
References: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47525 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757408AbYCKGgs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 02:36:48 -0400
In-Reply-To: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, robert.moore@intel.com, davej@redhat.com

applied.

thanks,
-Len

On Sunday 09 March 2008, Zhang, Rui wrote:
> Disable stray GPE correctly
> https://bugzilla.redhat.com/show_bug.cgi?id=251744
> http://bugzilla.kernel.org/show_bug.cgi?id=6217
> 
> Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/events/evgpe.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/events/evgpe.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/events/evgpe.c
> +++ linux-2.6/drivers/acpi/events/evgpe.c
> @@ -248,7 +248,8 @@ acpi_status acpi_ev_disable_gpe(struct a
>  
>  	ACPI_FUNCTION_TRACE(ev_disable_gpe);
>  
> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
> +	if (gpe_event_info->flags &&
> +		(!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
>  		return_ACPI_STATUS(AE_OK);
>  	}
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


