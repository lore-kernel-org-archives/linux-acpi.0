From: "Alan Jenkins" <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 01/11] ACPI: EC: count interrupts only if called from interrupt handler.
Date: Sat, 29 Nov 2008 18:36:34 +0000
Message-ID: <9b2b86520811291036w399fce94ib93a71d2475c6577@mail.gmail.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
	 <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:10642 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYK2Sgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Nov 2008 13:36:35 -0500
Received: by yw-out-2324.google.com with SMTP id 9so714692ywe.1
        for <linux-acpi@vger.kernel.org>; Sat, 29 Nov 2008 10:36:34 -0800 (PST)
In-Reply-To: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, stable@kernel.org

On 11/27/08, Len Brown <lenb@kernel.org> wrote:
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>
> fix 2.6.28 EC interrupt storm regression
>
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---

Yay, this means my EeePC no longer reports interrupt storms.

The patch looks obviously correct.  What about -stable?  -stable has
all the previous EC fixes, so I assume it's affected by this
regression.

The patch solves a bug I was about to report.  In storm avoidance
mode, the polling is still not 100% robust against the flaky EC.

1) If I hold down brightness up/down and then remove the power cable,
the EC stops working immediately.

2) I had an odd one-off occasion with the familiar "out of sync
hotkeys" & eventual EC death.

Thanks
Alan

>  drivers/acpi/ec.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index cf41f9f..30f3ef2 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -219,7 +219,8 @@ static void gpe_transaction(struct acpi_ec *ec, u8
> status)
>  	goto unlock;
>  err:
>  	/* false interrupt, state didn't change */
> -	++ec->curr->irq_count;
> +	if (in_interrupt())
> +		++ec->curr->irq_count;
>  unlock:
>  	spin_unlock_irqrestore(&ec->curr_lock, flags);
>  }
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
