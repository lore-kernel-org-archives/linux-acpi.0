From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 01/13] ACPI: Clear GPE before disabling it
Date: Fri, 15 Dec 2006 01:17:11 -0500
Message-ID: <200612150117.12222.lenb@kernel.org>
References: <200612042250.kB4MokjY007352@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60514 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbWLOGRu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 01:17:50 -0500
In-Reply-To: <200612042250.kB4MokjY007352@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, william.morrow@amd.com, jordan.crouse@amd.com
Cc: linux-acpi@vger.kernel.org, luming.yu@intel.com, robert.moore@intel.com

William,
Please test if this is still necessary when you are running ACPICA 20061109.

You can get that release in several ways:

A plain patch on top of 2.6.19:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-test-20061109-2.6.19.diff.gz
or pull it from git:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica

In both cases, you'll result in a 2.6.19 base plus only the ACPICA update.

thanks,
-Len

On Monday 04 December 2006 17:49, akpm@osdl.org wrote:
> From: William Morrow <william.morrow@amd.com>
>
> On some BIOSen, the GPE bit will remain set even if it is disabled,
> resulting in a interrupt storm.  This patch clears the bit before disabling
> it.
>
> Signed-off-by: William Morrow <william.morrow@amd.com>
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> Cc: "Yu, Luming" <luming.yu@intel.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Cc: "Moore, Robert" <robert.moore@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  drivers/acpi/events/evgpe.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff -puN drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
> drivers/acpi/events/evgpe.c ---
> a/drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it +++
> a/drivers/acpi/events/evgpe.c
> @@ -677,10 +677,22 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
>  	case ACPI_GPE_DISPATCH_METHOD:
>
>  		/*
> -		 * Disable GPE, so it doesn't keep firing before the method has a
> +		 * Clear GPE, so it doesn't keep firing before the method has a
>  		 * chance to run.
>  		 */
> +		status = acpi_hw_clear_gpe(gpe_event_info);
> +		if (ACPI_FAILURE(status)) {
> +			ACPI_EXCEPTION((AE_INFO, status,
> +					"Unable to clear GPE[%2X]",
> +					gpe_number));
> +			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
> +		}
> +		/*
> +		 * Disable GPE, so it doesn't keep happen again.
> +		 */
> +
>  		status = acpi_ev_disable_gpe(gpe_event_info);
> +
>  		if (ACPI_FAILURE(status)) {
>  			ACPI_EXCEPTION((AE_INFO, status,
>  					"Unable to disable GPE[%2X]",
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
