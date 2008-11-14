From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: count interrupts only if called from
	interrupt handler.
Date: Fri, 14 Nov 2008 09:21:56 +0800
Message-ID: <1226625716.4006.178.camel@yakui_zhao.sh.intel.com>
References: <1226539214.4006.70.camel@yakui_zhao.sh.intel.com>
	 <20081113090003.26620.82051.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49791 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbYKNBOF (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 20:14:05 -0500
In-Reply-To: <20081113090003.26620.82051.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Thu, 2008-11-13 at 17:00 +0800, Alexey Starikovskiy wrote:
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Thanks for the patch.
   After applying the patch, there is no EC GPE storm and EC will work
in EC GPE interrupt mode. It works as what we expected.
Thanks for the patch again.

> ---
> 
>  drivers/acpi/ec.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index cf41f9f..30f3ef2 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -219,7 +219,8 @@ static void gpe_transaction(struct acpi_ec *ec, u8 status)
>  	goto unlock;
>  err:
>  	/* false interrupt, state didn't change */
> -	++ec->curr->irq_count;
> +	if (in_interrupt())
> +		++ec->curr->irq_count;
>  unlock:
>  	spin_unlock_irqrestore(&ec->curr_lock, flags);
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

