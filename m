From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen after EC
	installation
Date: Wed, 30 Apr 2008 18:25:34 +0800
Message-ID: <1209551134.12515.47.camel@yakui_zhao.sh.intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
	 <204470272c3b055b352d5f127d5d5c7dce5fa597.1209457069.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35555 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbYD3Cep (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 22:34:45 -0400
In-Reply-To: <204470272c3b055b352d5f127d5d5c7dce5fa597.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

On Tue, 2008-04-29 at 04:44 -0400, Len Brown wrote:
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> GPE could try to access EC region, so should not be enabled before
> EC is installed
It is caused by broken bios if GPE method tries to access EC region
before EC is initialized correctly. It is more appropriate to fix this
issue by upgrading bios rather than by the patch. 
And this patch will cause some potential problems.

In the course of GPE event initialization the GPE will be set as
RUN_TIME and deferred to be enabled.(Only update the GPE enable mask and
not write the GPE register). And when the acpi_ev_install_fadt_gpes is
called, some GPEs will be changed from the RUN_TIME to WAKEUP and only
RUNTIME GPEs are enabled.(GPE register will be accessed).

If acpi_ev_install_fadt_gpe is called after EC is stalled, the
acpi_enable_gpe will be called , in which some GPEs will be also
enabled. In fact these are the WAKUP GPEs and shouldn't be enabled.
Maybe this will bring some potential problems. 

Best regards.
    Yakui

> http://bugzilla.kernel.org/show_bug.cgi?id=9916
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/utilities/utxface.c |   35 +++++++++++++++++------------------
>  1 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
> index 2d49691..df41312 100644
> --- a/drivers/acpi/utilities/utxface.c
> +++ b/drivers/acpi/utilities/utxface.c
> @@ -192,24 +192,6 @@ acpi_status acpi_enable_subsystem(u32 flags)
>  		}
>  	}
>  
> -	/*
> -	 * Complete the GPE initialization for the GPE blocks defined in the FADT
> -	 * (GPE block 0 and 1).
> -	 *
> -	 * Note1: This is where the _PRW methods are executed for the GPEs. These
> -	 * methods can only be executed after the SCI and Global Lock handlers are
> -	 * installed and initialized.
> -	 *
> -	 * Note2: Currently, there seems to be no need to run the _REG methods
> -	 * before execution of the _PRW methods and enabling of the GPEs.
> -	 */
> -	if (!(flags & ACPI_NO_EVENT_INIT)) {
> -		status = acpi_ev_install_fadt_gpes();
> -		if (ACPI_FAILURE(status)) {
> -			return (status);
> -		}
> -	}
> -
>  	return_ACPI_STATUS(status);
>  }
>  
> @@ -280,6 +262,23 @@ acpi_status acpi_initialize_objects(u32 flags)
>  	}
>  
>  	/*
> +	 * Complete the GPE initialization for the GPE blocks defined in the FADT
> +	 * (GPE block 0 and 1).
> +	 *
> +	 * Note1: This is where the _PRW methods are executed for the GPEs. These
> +	 * methods can only be executed after the SCI and Global Lock handlers are
> +	 * installed and initialized.
> +	 *
> +	 * Note2: Currently, there seems to be no need to run the _REG methods
> +	 * before execution of the _PRW methods and enabling of the GPEs.
> +	 */
> +	if (!(flags & ACPI_NO_EVENT_INIT)) {
> +		status = acpi_ev_install_fadt_gpes();
> +		if (ACPI_FAILURE(status))
> +			return (status);
> +	}
> +
> +	/*
>  	 * Empty the caches (delete the cached objects) on the assumption that
>  	 * the table load filled them up more than they will be at runtime --
>  	 * thus wasting non-paged memory.

