From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/5] ACPI: Check parameter when calling acpi_processor_get/set_throttling
Date: Sat, 2 Feb 2008 02:29:50 -0500
Message-ID: <200802020229.50224.lenb@kernel.org>
References: <1201499610.17068.21.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45705 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780AbYBBHaG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 02:30:06 -0500
In-Reply-To: <1201499610.17068.21.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

is the patch below still necessary after this (upstream) fix:

http://bugzilla.kernel.org/show_bug.cgi?id=9747#c2

thanks,
-Len

On Monday 28 January 2008 00:53, Zhao Yakui wrote:
> Subject: ACPI : Check parameter when calling acpi_processor_get/set_throttling
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> It is necessary to check the parameter when calling the function of 
> acpi_processor_get/set_throttling function so as to avoid the NULL 
> pointer reference in pr or throttling.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9747
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/processor_throttling.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/processor_throttling.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_throttling.c
> +++ linux-2.6/drivers/acpi/processor_throttling.c
> @@ -589,6 +589,11 @@ static int acpi_processor_get_throttling
>  	cpumask_t saved_mask;
>  	int ret;
>  
> +	if (!pr)
> +		return -EINVAL;
> +
> +	if (!pr->flags.throttling)
> +		return -ENODEV;
>  	/*
>  	 * Migrate task to the cpu pointed by pr.
>  	 */
> @@ -743,6 +748,16 @@ int acpi_processor_set_throttling(struct
>  {
>  	cpumask_t saved_mask;
>  	int ret;
> +
> +	if (!pr)
> +		return -EINVAL;
> +
> +	if (!pr->flags.throttling)
> +		return -ENODEV;
> +
> +	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
> +		return -EINVAL;
> +
>  	/*
>  	 * Migrate task to the cpu pointed by pr.
>  	 */
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
