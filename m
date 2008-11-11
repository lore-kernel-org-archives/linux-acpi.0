From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/5] ACPI: EC: wait for last write gpe
Date: Tue, 11 Nov 2008 13:26:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111325260.4480@localhost.localdomain>
References: <20081109155847.13635.15244.stgit@thinkpad>
 <20081109160050.13635.46234.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:54246 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYKKS1a (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 13:27:30 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA60024QLUGREP9@vms173007.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 12:25:28 -0600 (CST)
In-reply-to: <20081109160050.13635.46234.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi-test.

we struggled with ec burst mode for a long time before enabling it
finally in 2005.  have we had any problems with it since then
that might be addressed by this race?

thanks,
-Len


On Sun, 9 Nov 2008, Alexey Starikovskiy wrote:

> There is a possibility that EC might break if next command is
> issued within 1 us after write or burst-disable command.
> This "possibility" was in EC driver for 3.5 years, after
> 451566f45a2e6cd10ba56e7220a9dd84ba3ef550.
> 
> References: http://marc.info/?l=linux-acpi&m=122616284402886&w=4
> Cc: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   21 +++++++++++++--------
>  1 files changed, 13 insertions(+), 8 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e5dbe21..d6007ac 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -102,6 +102,7 @@ struct transaction {
>  	u8 command;
>  	u8 wlen;
>  	u8 rlen;
> +	bool done;
>  };
>  
>  static struct acpi_ec {
> @@ -178,7 +179,7 @@ static int ec_transaction_done(struct acpi_ec *ec)
>  	unsigned long flags;
>  	int ret = 0;
>  	spin_lock_irqsave(&ec->curr_lock, flags);
> -	if (!ec->curr || (!ec->curr->wlen && !ec->curr->rlen))
> +	if (!ec->curr || ec->curr->done)
>  		ret = 1;
>  	spin_unlock_irqrestore(&ec->curr_lock, flags);
>  	return ret;
> @@ -195,17 +196,20 @@ static void gpe_transaction(struct acpi_ec *ec, u8 status)
>  			acpi_ec_write_data(ec, *(ec->curr->wdata++));
>  			--ec->curr->wlen;
>  		} else
> -			/* false interrupt, state didn't change */
> -			++ec->curr->irq_count;
> -
> +			goto err;
>  	} else if (ec->curr->rlen > 0) {
>  		if ((status & ACPI_EC_FLAG_OBF) == 1) {
>  			*(ec->curr->rdata++) = acpi_ec_read_data(ec);
> -			--ec->curr->rlen;
> +			if (--ec->curr->rlen == 0)
> +				ec->curr->done = true;
>  		} else
> -			/* false interrupt, state didn't change */
> -			++ec->curr->irq_count;
> -	}
> +			goto err;
> +	} else if (ec->curr->wlen == 0 && (status & ACPI_EC_FLAG_IBF) == 0)
> +		ec->curr->done = true;
> +	goto unlock;
> +err:
> +	/* false interrupt, state didn't change */
> +	++ec->curr->irq_count;
>  unlock:
>  	spin_unlock_irqrestore(&ec->curr_lock, flags);
>  }
> @@ -265,6 +269,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
>  	spin_lock_irqsave(&ec->curr_lock, tmp);
>  	/* following two actions should be kept atomic */
>  	t->irq_count = 0;
> +	t->done = false;
>  	ec->curr = t;
>  	acpi_ec_write_cmd(ec, ec->curr->command);
>  	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
