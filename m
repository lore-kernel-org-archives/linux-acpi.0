From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Make Embedded Controller command timeout delay configurable
Date: Thu, 21 Oct 2010 21:53:03 +0200
Message-ID: <201010212153.03664.rjw@sisk.pl>
References: <201010211824.57893.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41686 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403Ab0JUTyK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Oct 2010 15:54:10 -0400
In-Reply-To: <201010211824.57893.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday, October 21, 2010, Thomas Renninger wrote:
> Here and then there show up machines which need higher timeout values.
> Finding this on affected machines can be cumbersome, because
> ACPI_EC_DELAY is a compile option -> make it configurable via boot param.

I think the users should not be allowed to decrease the delay below certain
reasonable limit (perhaps current value of ACPI_EC_DELAY).

> This can even be provided writable at runtime via:
> /sys/modules/acpi/parameters/ec_delay

Would it be safe?

> Known machines where this helps:
> Some HP machines where for whatever reasons specific EC accesses take
> very long at resume from S3 (in _WAK function).
> The AE_TIME error is passed upwards and the ACPI interpreter will
> not execute the rest of the _WAK function which results in not properly
> initialized devices/variables with different side-effects.
> 
> Afaik, on some MSI machines this helped as well.
> 
> If this param is needed there probably are underlying problems like:
>   - EC firmware bug
>   - A kernel EC driver bug
>   - An ACPI interpreter behavior (e.g. timings when specific
>     EC accesses happen and how) which the EC does not like
>   - ...
> which should get evaluated further, but often are nasty or
> impossible to fix from OS side.
> 
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: lenb@kernel.org
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> CC: linux-acpi@vger.kernel.org
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index f31291b..6499cc4 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -83,6 +83,11 @@ enum {
>  	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
>  };
>  
> +/* ec.c is compiled in acpi namespace so this shows up as acpi.ec_delay param */
> +static unsigned int ec_delay __read_mostly = ACPI_EC_DELAY;
> +module_param(ec_delay, uint, 0644);
> +MODULE_PARM_DESC(ec_delay, "Timeout(ms) waited until an EC command completes");
> +
>  /* If we find an EC via the ECDT, we need to keep a ptr to its context */
>  /* External interfaces use first EC only, so remember */
>  typedef int (*acpi_ec_query_func) (void *data);
> @@ -210,7 +215,7 @@ static int ec_poll(struct acpi_ec *ec)
>  	int repeat = 2; /* number of command restarts */
>  	while (repeat--) {
>  		unsigned long delay = jiffies +
> -			msecs_to_jiffies(ACPI_EC_DELAY);
> +			msecs_to_jiffies(ec_delay);
>  		do {
>  			/* don't sleep with disabled interrupts */
>  			if (EC_FLAGS_MSI || irqs_disabled()) {
> @@ -265,7 +270,7 @@ static int ec_check_ibf0(struct acpi_ec *ec)
>  
>  static int ec_wait_ibf0(struct acpi_ec *ec)
>  {
> -	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> +	unsigned long delay = jiffies + msecs_to_jiffies(ec_delay);
>  	/* interrupt wait manually if GPE mode is not active */
>  	while (time_before(jiffies, delay))
>  		if (wait_event_timeout(ec->wait, ec_check_ibf0(ec),

Thanks,
Rafael
