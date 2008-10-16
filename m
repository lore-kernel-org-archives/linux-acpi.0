From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: Check for IBF=0 periodically if not in GPE mode
Date: Thu, 16 Oct 2008 18:14:31 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161814220.3026@localhost.localdomain>
References: <48F379C4.9070105@tuffmail.co.uk>
 <20081015220232.32042.36999.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:33523 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbYJPWPD (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 18:15:03 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8U006BBR48YCE4@vms172071.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Thu, 16 Oct 2008 17:14:33 -0500 (CDT)
In-reply-to: <20081015220232.32042.36999.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi tree, ec branch.

thanks,
-len

On Thu, 16 Oct 2008, Alexey Starikovskiy wrote:

> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 69f5f78..f9c0782 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -300,6 +300,18 @@ static int ec_check_ibf0(struct acpi_ec *ec)
>  	return (status & ACPI_EC_FLAG_IBF) == 0;
>  }
>  
> +static int ec_wait_ibf0(struct acpi_ec *ec)
> +{
> +	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> +	/* interrupt wait manually if GPE mode is not active */
> +	unsigned long timeout = test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ?
> +		msecs_to_jiffies(ACPI_EC_DELAY) : msecs_to_jiffies(1);
> +	while (time_before(jiffies, delay))
> +		if (wait_event_timeout(ec->wait, ec_check_ibf0(ec), timeout))
> +			return 0;
> +	return -ETIME;
> +}
> +
>  static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
>  			       int force_poll)
>  {
> @@ -317,8 +329,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
>  			goto unlock;
>  		}
>  	}
> -	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
> -				msecs_to_jiffies(ACPI_EC_DELAY))) {
> +	if (ec_wait_ibf0(ec)) {
>  		pr_err(PREFIX "input buffer is not empty, "
>  				"aborting transaction\n");
>  		status = -ETIME;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
