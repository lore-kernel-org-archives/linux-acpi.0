From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: disable the gpe that doesn't have a GPE handler
	correctly
Date: Tue, 20 Nov 2007 10:10:03 +0800
Message-ID: <1195524603.2971.15.camel@acpi-hp.sh.intel.com>
References: <1195457566.2971.12.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47033 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758734AbXKTCAe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 21:00:34 -0500
In-Reply-To: <1195457566.2971.12.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org

On Mon, 2007-11-19 at 15:32 +0800, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> The current code only disable the GPE by judging the
> GPE type, which is one of WAKE, RUNTIME and WAKE_RUN.
> In bug 6217, GPE 17 is enabled by the AML code ...
> And it will be triggerred when an extra CRT is connected.
> As GPE 17 is not ec gpe, and there is no _Lxx/_Exx method
> exists in the _GPE scope, the type flag of GPE 17 is cleared
> at the boot time and it's none of the three GPE types.
> In this case, the GPE is not disabled correctly.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6217
> 
Hi, Alexey,
Any comments on this patch? :)

Thanks,
Rui
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/events/evgpe.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/events/evgpe.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/events/evgpe.c
> +++ linux-2.6/drivers/acpi/events/evgpe.c
> @@ -277,11 +277,10 @@ acpi_status acpi_ev_disable_gpe(struct a
>  		/* Disable the requested runtime GPE */
>  
>  		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_RUN_ENABLED);
> -		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
> -		break;
>  
>  	default:
> -		return_ACPI_STATUS(AE_BAD_PARAMETER);
> +		acpi_hw_write_gpe_enable_reg(gpe_event_info);
> +		break;
>  	}
>  
>  	return_ACPI_STATUS(AE_OK);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
