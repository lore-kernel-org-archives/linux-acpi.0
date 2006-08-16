From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 12/14] ACPI: Clear GPE before disabling it
Date: Wed, 16 Aug 2006 14:50:20 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4C772C9@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7302 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932265AbWHPVwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Aug 2006 17:52:54 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, william.morrow@amd.com, jordan.crouse@amd.com, "Yu, Luming" <luming.yu@intel.com>

How does this patch relate to level-triggered GPEs, where we have the
following comment in the code just after the patch:

        /*
         * Execute the method associated with the GPE
         * NOTE: Level-triggered GPEs are cleared after the method
completes.
         */
        Status = AcpiOsExecute (OSL_GPE_HANDLER,
                    AcpiEvAsynchExecuteGpeMethod, GpeEventInfo);

> -----Original Message-----
> From: akpm@osdl.org [mailto:akpm@osdl.org]
> Sent: Monday, August 14, 2006 10:38 PM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; william.morrow@amd.com;
> jordan.crouse@amd.com; Yu, Luming; Moore, Robert
> Subject: [patch 12/14] ACPI: Clear GPE before disabling it
> 
> From: William Morrow <william.morrow@amd.com>
> 
> On some BIOSen, the GPE bit will remain set even if it is disabled,
> resulting in a interrupt storm.  This patch clears the bit before
> disabling
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
> diff -puN
drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
> drivers/acpi/events/evgpe.c
> --- a/drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
> +++ a/drivers/acpi/events/evgpe.c
> @@ -677,10 +677,22 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
>  	case ACPI_GPE_DISPATCH_METHOD:
> 
>  		/*
> -		 * Disable GPE, so it doesn't keep firing before the
method
> has a
> +		 * Clear GPE, so it doesn't keep firing before the
method has
> a
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
