From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI: EC: restart failed command
Date: Tue, 11 Nov 2008 13:10:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111310130.4480@localhost.localdomain>
References: <20081109155847.13635.15244.stgit@thinkpad>
 <20081109160058.13635.23640.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:48532 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbYKKSKp (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 13:10:45 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA600HD6L5VUF93@vms042.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 12:10:44 -0600 (CST)
In-reply-to: <20081109160058.13635.23640.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

ignored, per request of Alexey on IRC
due to thrash in bugzilla 11896

On Sun, 9 Nov 2008, Alexey Starikovskiy wrote:

> Restart current transaction if status unexpectedly becomes clear.
> There is an external timeout for transaction completion, thus there is
> no need to place additional restriction on restart count.
> Referencies: http://bugzilla.kernel.org/show_bug.cgi?id=11896
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   41 +++++++++++++++++++++++++++--------------
>  1 files changed, 27 insertions(+), 14 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index d6007ac..9646604 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -100,6 +100,8 @@ struct transaction {
>  	u8 *rdata;
>  	unsigned short irq_count;
>  	u8 command;
> +	u8 wi;
> +	u8 ri;
>  	u8 wlen;
>  	u8 rlen;
>  	bool done;
> @@ -185,31 +187,44 @@ static int ec_transaction_done(struct acpi_ec *ec)
>  	return ret;
>  }
>  
> +static void start_transaction(struct acpi_ec *ec)
> +{
> +	ec->curr->irq_count = ec->curr->wi = ec->curr->ri = 0;
> +	ec->curr->done = false;
> +	acpi_ec_write_cmd(ec, ec->curr->command);
> +}
> +
>  static void gpe_transaction(struct acpi_ec *ec, u8 status)
>  {
>  	unsigned long flags;
>  	spin_lock_irqsave(&ec->curr_lock, flags);
>  	if (!ec->curr)
>  		goto unlock;
> -	if (ec->curr->wlen > 0) {
> -		if ((status & ACPI_EC_FLAG_IBF) == 0) {
> -			acpi_ec_write_data(ec, *(ec->curr->wdata++));
> -			--ec->curr->wlen;
> -		} else
> +	if (ec->curr->wlen > ec->curr->wi) {
> +		if ((status & ACPI_EC_FLAG_IBF) == 0)
> +			acpi_ec_write_data(ec,
> +				ec->curr->wdata[ec->curr->wi++]);
> +		else
>  			goto err;
> -	} else if (ec->curr->rlen > 0) {
> +	} else if (ec->curr->rlen > ec->curr->ri) {
>  		if ((status & ACPI_EC_FLAG_OBF) == 1) {
> -			*(ec->curr->rdata++) = acpi_ec_read_data(ec);
> -			if (--ec->curr->rlen == 0)
> +			ec->curr->rdata[ec->curr->ri++] = acpi_ec_read_data(ec);
> +			if (ec->curr->rlen == ec->curr->ri)
>  				ec->curr->done = true;
>  		} else
>  			goto err;
> -	} else if (ec->curr->wlen == 0 && (status & ACPI_EC_FLAG_IBF) == 0)
> +	} else if (ec->curr->wlen == ec->curr->wi &&
> +		   (status & ACPI_EC_FLAG_IBF) == 0)
>  		ec->curr->done = true;
>  	goto unlock;
>  err:
> -	/* false interrupt, state didn't change */
> -	++ec->curr->irq_count;
> +	/* restart command */
> +	if (!status) {
> +		pr_debug(PREFIX "controller reset, restart transaction\n");
> +		start_transaction(ec);
> +	} else
> +		/* false interrupt, state didn't change */
> +		++ec->curr->irq_count;
>  unlock:
>  	spin_unlock_irqrestore(&ec->curr_lock, flags);
>  }
> @@ -268,10 +283,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
>  	/* start transaction */
>  	spin_lock_irqsave(&ec->curr_lock, tmp);
>  	/* following two actions should be kept atomic */
> -	t->irq_count = 0;
> -	t->done = false;
>  	ec->curr = t;
> -	acpi_ec_write_cmd(ec, ec->curr->command);
> +	start_transaction(ec);
>  	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
>  		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>  	spin_unlock_irqrestore(&ec->curr_lock, tmp);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
