From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI: EC: Add workaround for "optimized" controllers
Date: Fri, 12 Oct 2007 18:42:55 -0400
Message-ID: <200710121842.55315.lenb@kernel.org>
References: <20071008221906.7071.63939.stgit@samsung> <20071008221924.7071.75243.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40019 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934103AbXJLWnp (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 12 Oct 2007 18:43:45 -0400
In-Reply-To: <20071008221924.7071.75243.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

I'd like to see a (single) printk when we enter this hybrid mode also,
as we want to find out how common it is - does it happen just
on FSC machines, or others also.

thanks,
-Len

On Monday 08 October 2007 06:19:24 pm Alexey Starikovskiy wrote:
> Some controllers do not send interrupts for OBF=1 event, but send
> them for IBF=0. Add workaround for them.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=8459
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index fa3f2aa..91eb94a 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -75,6 +75,7 @@ enum {
>  	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
>  	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
>  	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
> +	EC_FLAGS_ONLY_IBF_GPE,		/* Expect GPE only for IBF = 0 event */
>  };
>  
>  static int acpi_ec_remove(struct acpi_device *device, int type);
> @@ -172,7 +173,12 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
>  			return 0;
>  		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  		if (acpi_ec_check_status(ec, event)) {
> -			clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
> +			if (event == ACPI_EC_EVENT_OBF_1)
> +				/* miss OBF = 1 GPE, don't expect it anymore */
> +				set_bit(EC_FLAGS_ONLY_IBF_GPE, &ec->flags);
> +			else
> +				/* missing GPEs, switch back to poll mode */
> +				clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
>  			return 0;
>  		}
>  	} else {
> @@ -220,6 +226,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
>  		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>  
>  	for (; rdata_len > 0; --rdata_len) {
> +		if (test_bit(EC_FLAGS_ONLY_IBF_GPE, &ec->flags))
> +			force_poll = 1;
>  		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
>  		if (result) {
>  			printk(KERN_ERR PREFIX "read timeout, command = %d\n",
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


