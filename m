From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/5] ACPI: EC: auto select interrupt mode
Date: Fri, 12 Oct 2007 18:41:46 -0400
Message-ID: <200710121841.46945.lenb@kernel.org>
References: <20071008221906.7071.63939.stgit@samsung> <20071008221918.7071.72288.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39999 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933277AbXJLWmk (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 12 Oct 2007 18:42:40 -0400
In-Reply-To: <20071008221918.7071.72288.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

I'm nervous about deleting ec_intr=
because if auto mode selection fails,
we have no easy workaround.

Also, I'd like to be able to see in dmesg something like:

ACPI: EC: initialized in polling mode

this tells us they're running the new EC driver that starts life in polling mode

ACPI: EC: interrupt mode enabled

this tells us that we successfully switched to interrupt mode.

thanks,
-Len

On Monday 08 October 2007 06:19:18 pm Alexey Starikovskiy wrote:
> Start in POLL mode, and if we receive confirmation GPE,
> switch to INT mode.
> If confirmations are not sent, switch back to POLL.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  Documentation/kernel-parameters.txt |    5 ---
>  drivers/acpi/ec.c                   |   51 +++++++++++------------------------
>  2 files changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 4d175c7..8a4a612 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -569,11 +569,6 @@ and is between 256 and 4096 characters. It is defined in the file
>  
>  	eata=		[HW,SCSI]
>  
> -	ec_intr=	[HW,ACPI] ACPI Embedded Controller interrupt mode
> -			Format: <int>
> -			0: polling mode
> -			non-0: interrupt mode (default)
> -
>  	eda=		[HW,PS2]
>  
>  	edb=		[HW,PS2]
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 167ec80..fa3f2aa 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -71,14 +71,10 @@ enum ec_event {
>  #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
>  #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
>  
> -static enum ec_mode {
> -	EC_INTR = 1,		/* Output buffer full */
> -	EC_POLL,		/* Input buffer empty */
> -} acpi_ec_mode = EC_INTR;
> -
>  enum {
>  	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
>  	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
> +	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
>  };
>  
>  static int acpi_ec_remove(struct acpi_device *device, int type);
> @@ -169,21 +165,23 @@ static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
>  
>  static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
>  {
> -	if (unlikely(force_poll) || acpi_ec_mode == EC_POLL) {
> -		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> -		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
> -		while (time_before(jiffies, delay)) {
> -			if (acpi_ec_check_status(ec, event))
> -				return 0;
> -		}
> -	} else {
> +	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
> +	    likely(!force_poll)) {
>  		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
>  				       msecs_to_jiffies(ACPI_EC_DELAY)))
>  			return 0;
>  		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  		if (acpi_ec_check_status(ec, event)) {
> +			clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
>  			return 0;
>  		}
> +	} else {
> +		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> +		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
> +		while (time_before(jiffies, delay)) {
> +			if (acpi_ec_check_status(ec, event))
> +				return 0;
> +		}
>  	}
>  	printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
>  			       " status = %d, expect_event = %d\n",
> @@ -481,18 +479,17 @@ static u32 acpi_ec_gpe_handler(void *data)
>  	struct acpi_ec *ec = data;
>  
>  	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
> -
> -	if (acpi_ec_mode == EC_INTR) {
> +	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
>  		wake_up(&ec->wait);
> -	}
>  
>  	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI) {
>  		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
>  			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
>  				acpi_ec_gpe_query, ec);
> -	}
> +	} else if (unlikely(!test_bit(EC_FLAGS_GPE_MODE, &ec->flags)))
> +		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
>  
> -	return status == AE_OK ?
> +	return ACPI_SUCCESS(status) ?
>  	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
>  }
>  
> @@ -923,20 +920,4 @@ static void __exit acpi_ec_exit(void)
>  
>  	return;
>  }
> -#endif				/* 0 */
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
> +#endif	/* 0 */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


