From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/4] ACPI: EC: Add more debug info and trivial code cleanup
Date: Fri, 02 Nov 2012 13:47:57 +0100
Message-ID: <1374812.gtOaaeg0ZA@vostro.rjw.lan>
References: <1351561961-23821-1-git-send-email-feng.tang@intel.com> <1351561961-23821-2-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52143 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab2KBMnv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2012 08:43:51 -0400
In-Reply-To: <1351561961-23821-2-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, October 30, 2012 09:52:39 AM Feng Tang wrote:
> Add more debug info for EC transaction debugging, like the interrupt
> status register value, the detail info of a EC transaction.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael



> ---
>  drivers/acpi/ec.c |   37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 29f349c..f272880 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -175,30 +175,32 @@ static void start_transaction(struct acpi_ec *ec)
>  static void advance_transaction(struct acpi_ec *ec, u8 status)
>  {
>  	unsigned long flags;
> +	struct transaction *t = ec->curr;
> +
>  	spin_lock_irqsave(&ec->lock, flags);
> -	if (!ec->curr)
> +	if (!t)
>  		goto unlock;
> -	if (ec->curr->wlen > ec->curr->wi) {
> +	if (t->wlen > t->wi) {
>  		if ((status & ACPI_EC_FLAG_IBF) == 0)
>  			acpi_ec_write_data(ec,
> -				ec->curr->wdata[ec->curr->wi++]);
> +				t->wdata[t->wi++]);
>  		else
>  			goto err;
> -	} else if (ec->curr->rlen > ec->curr->ri) {
> +	} else if (t->rlen > t->ri) {
>  		if ((status & ACPI_EC_FLAG_OBF) == 1) {
> -			ec->curr->rdata[ec->curr->ri++] = acpi_ec_read_data(ec);
> -			if (ec->curr->rlen == ec->curr->ri)
> -				ec->curr->done = true;
> +			t->rdata[t->ri++] = acpi_ec_read_data(ec);
> +			if (t->rlen == t->ri)
> +				t->done = true;
>  		} else
>  			goto err;
> -	} else if (ec->curr->wlen == ec->curr->wi &&
> +	} else if (t->wlen == t->wi &&
>  		   (status & ACPI_EC_FLAG_IBF) == 0)
> -		ec->curr->done = true;
> +		t->done = true;
>  	goto unlock;
>  err:
>  	/* false interrupt, state didn't change */
>  	if (in_interrupt())
> -		++ec->curr->irq_count;
> +		++t->irq_count;
>  unlock:
>  	spin_unlock_irqrestore(&ec->lock, flags);
>  }
> @@ -310,7 +312,8 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
>  		status = -ETIME;
>  		goto end;
>  	}
> -	pr_debug(PREFIX "transaction start\n");
> +	pr_debug(PREFIX "transaction start (cmd=0x%02x, addr=0x%02x)\n",
> +			t->command, t->wdata ? t->wdata[0] : 0 );
>  	/* disable GPE during transaction if storm is detected */
>  	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
>  		/* It has to be disabled, so that it doesn't trigger. */
> @@ -326,8 +329,9 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
>  		/* It is safe to enable the GPE outside of the transaction. */
>  		acpi_enable_gpe(NULL, ec->gpe);
>  	} else if (t->irq_count > ec_storm_threshold) {
> -		pr_info(PREFIX "GPE storm detected, "
> -			"transactions will use polling mode\n");
> +		pr_info(PREFIX "GPE storm detected(%d GPEs), "
> +			"transactions will use polling mode\n",
> +			t->irq_count);
>  		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
>  	}
>  	pr_debug(PREFIX "transaction end\n");
> @@ -403,7 +407,7 @@ int ec_burst_disable(void)
>  
>  EXPORT_SYMBOL(ec_burst_disable);
>  
> -int ec_read(u8 addr, u8 * val)
> +int ec_read(u8 addr, u8 *val)
>  {
>  	int err;
>  	u8 temp_data;
> @@ -622,10 +626,11 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
>  	u32 gpe_number, void *data)
>  {
>  	struct acpi_ec *ec = data;
> +	u8 status = acpi_ec_read_status(ec);
>  
> -	pr_debug(PREFIX "~~~> interrupt\n");
> +	pr_debug(PREFIX "~~~> interrupt, status:0x%02x\n", status);
>  
> -	advance_transaction(ec, acpi_ec_read_status(ec));
> +	advance_transaction(ec, status);
>  	if (ec_transaction_done(ec) &&
>  	    (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF) == 0) {
>  		wake_up(&ec->wait);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
