From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: switch to poll mode automatically
Date: Mon, 1 Oct 2007 16:04:22 -0400
Message-ID: <200710011604.22854.lenb@kernel.org>
References: <20071001192143.1640.48524.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43912 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXJAUEj (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2007 16:04:39 -0400
In-Reply-To: <20071001192143.1640.48524.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

I like the direction of this patch.

On Monday 01 October 2007 15:21, Alexey Starikovskiy wrote:
> Make selection of mode automatic.
> If EC sends confirmation interrupts -- switch to interrupt mode, otherwise
> poll it.
> If EC fails to send confirmation interrupt within a timeout, 
> switch back to poll mode.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   42 +++++++++++++++---------------------------
>  1 files changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e9a8805..5183769 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -72,9 +72,9 @@ enum ec_event {
>  #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
>  
>  static enum ec_mode {
> -	EC_INTR = 1,		/* Output buffer full */
> -	EC_POLL,		/* Input buffer empty */
> -} acpi_ec_mode = EC_INTR;
> +	EC_INTR = 1,		/* EC sends GPE to complete transaction */
> +	EC_POLL,		/* EC does not send anything */
> +} acpi_ec_mode = EC_POLL;	/* start with safer assumptions */

s/start with safer assumptions/start in poll mode/

BTW, I don't see why EC_INTR needs to be specified as 1,
we always compare acpi_ec_mode to an explicit value,
so the enum defaults should work fine, yes?

>  static int acpi_ec_remove(struct acpi_device *device, int type);
>  static int acpi_ec_start(struct acpi_device *device);
> @@ -177,16 +177,18 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event,
>  	} else {
>  		if (wait_event_timeout(ec->wait,
>  				       acpi_ec_check_status(ec, event, count),
> -				       msecs_to_jiffies(ACPI_EC_DELAY)) ||
> -		    acpi_ec_check_status(ec, event, 0)) {
> +				       msecs_to_jiffies(ACPI_EC_DELAY)))
> +			return 0;
> +		if (acpi_ec_check_status(ec, event, 0)) {
> +			printk(KERN_WARNING PREFIX "EC did not send confirm "
> +				"interrupt, switch to poll mode\n");
> +			acpi_ec_mode = EC_POLL;

This message will be extremely useful for the 2.6.23 case
that starts in interrupt mode, detects a failure on some machines,
and then transitions into polling mode as a backup to handle those boxes.

But this patch changes the default initial state to polling mode and
transitions to interrupt mode w/o any message.

ie. maybe it should mention in the EC probe messages what mode
it is starting life in, and when it transitions from polling
to interrupt mode we get somethign like this:

ACPI: EC: enabling interrupt mode.

Which would be a KERN_NOTICE message, as it is normal but significant.

>  			return 0;
> -		} else {
> -			printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
> -			       " status = %d, expect_event = %d\n",
> -			       acpi_ec_read_status(ec), event);
>  		}
>  	}
> -
> +	printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
> +		" status = %d, expect_event = %d\n",
> +		acpi_ec_read_status(ec), event);
>  	return -ETIME;
>  }
>  
> @@ -490,8 +492,10 @@ static u32 acpi_ec_gpe_handler(void *data)
>  		atomic_set(&ec->query_pending, 1);
>  		status =
>  		    acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> +	} else {
> +		/* Non-query intterrupt from EC, must be confirmation */
> +		acpi_ec_mode = EC_INTR;
>  	}
> -
>  	return status == AE_OK ?
>  	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
>  }
> @@ -925,19 +929,3 @@ static void __exit acpi_ec_exit(void)
>  	return;
>  }
>  #endif				/* 0 */
> -
> -static int __init acpi_ec_set_intr_mode(char *str)
> -{
> -	int intr;
> -
> -	if (!get_option(&str, &intr))
> -		return 0;
> -
> -	acpi_ec_mode = (intr) ? EC_INTR : EC_POLL;
> -
> -	printk(KERN_NOTICE PREFIX "%s mode.\n", intr ? "interrupt" : "polling");
> -
> -	return 1;
> -}
> -
> -__setup("ec_intr=", acpi_ec_set_intr_mode);

I think if we go with a scheme that has any automatic
switching between poll mode and interrupt mode, that
we should retain ec_intr= as an override to disable
automatic switching in the event there is a problem with it.
eg. there may be some box that starts switching back and forth,
and it would start to spam dmesg with messages, as well as
pay the 500ms timeout penalty for every failed interrupt.

For such a box, we'd want to boot with ec_intr=0 -
and probably invoke that automatically via DMI strings.

Conversely, there may be a box there polling causes
some sort of failure, we may want ec_intr=1 on that box --
as that would match what we are shipping today.

thanks,
-Len
