From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/6] Restore udelay in poll mode
Date: Mon, 24 Mar 2008 20:52:27 -0400
Message-ID: <200803242052.27924.lenb@kernel.org>
References: <20080321140648.30578.73816.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52938 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbYCYAwp (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2008 20:52:45 -0400
In-Reply-To: <20080321140648.30578.73816.stgit@thinkpad.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

1-6 added to acpi-test

thanks,
-Len

On Friday 21 March 2008, Alexey Starikovskiy wrote:
> Allow EC to serve keyboard even then we polling it.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 7222a18..828c752 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -73,6 +73,7 @@ enum ec_event {
>  
>  #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
>  #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
> +#define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
>  
>  enum {
>  	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
> @@ -227,6 +228,7 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
>  		while (time_before(jiffies, delay)) {
>  			if (acpi_ec_check_status(ec, event))
>  				goto end;
> +			udelay(ACPI_EC_UDELAY);
>  		}
>  	}
>  	pr_err(PREFIX "acpi_ec_wait timeout,"
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


