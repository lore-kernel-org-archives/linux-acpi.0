From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: count interrupts only if called from interrupt
 handler.
Date: Wed, 26 Nov 2008 17:16:59 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811261716510.3895@localhost.localdomain>
References: <1226539214.4006.70.camel@yakui_zhao.sh.intel.com>
 <20081113090003.26620.82051.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33387 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYKZWRc (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 26 Nov 2008 17:17:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAY003WZOKF7RE0@vms173001.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Wed, 26 Nov 2008 16:17:04 -0600 (CST)
In-reply-to: <20081113090003.26620.82051.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied for 2.6.28

thanks,
-len

On Thu, 13 Nov 2008, Alexey Starikovskiy wrote:

> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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
