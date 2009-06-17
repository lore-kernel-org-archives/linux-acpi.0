From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] ACPICA: Clear power button status before enabling
	event
Date: Wed, 17 Jun 2009 11:21:40 +0800
Message-ID: <1245208900.3583.190.camel@localhost.localdomain>
References: <20090615164907.10901.73210.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21143 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757908AbZFQDU0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 23:20:26 -0400
In-Reply-To: <20090615164907.10901.73210.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Tue, 2009-06-16 at 00:49 +0800, Bjorn Helgaas wrote:
> Clear power button status before enabling event.
> 
> It's unusual to enable an event, then immediately clear it, so this
> looks like a possible bug.  If it was intentional, perhaps a comment
> would be in order.
IMO this patch is unnecessary.
It seems that we will clear the power button event immediately after it
is resumed from OS. (This is done in the function of
acpi_suspend_enter).

Maybe the power event status bit is set before we re-enable the event
bit. And after we re-enable the power button event, OS can handle the
power button event (the acpi_leave_sleep_state is called with interrupts
enabled). 

If the patch is applied, the power button event will be lost.

Thanks.
> 
> This patch may be used under either the GPL v2 or the BSD-style license
> used for the Intel ACPICA.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> CC: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpica/hwsleep.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index db307a3..3558c53 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -613,12 +613,12 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
>  	(void)
>  	    acpi_write_bit_register(acpi_gbl_fixed_event_info
>  			      [ACPI_EVENT_POWER_BUTTON].
> -			      enable_register_id, ACPI_ENABLE_EVENT);
> +			      status_register_id, ACPI_CLEAR_STATUS);
>  
>  	(void)
>  	    acpi_write_bit_register(acpi_gbl_fixed_event_info
>  			      [ACPI_EVENT_POWER_BUTTON].
> -			      status_register_id, ACPI_CLEAR_STATUS);
> +			      enable_register_id, ACPI_ENABLE_EVENT);
>  
>  	arg.integer.value = ACPI_SST_WORKING;
>  	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

