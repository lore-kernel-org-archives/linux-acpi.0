From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 09/12] ACPI: EC: Output changes to operational mode
Date: Wed, 24 Oct 2007 23:59:53 +0200
Message-ID: <200710242359.54409.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101903.2937.29352.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43711 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbXJXV7W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:22 -0400
In-Reply-To: <20071022101903.2937.29352.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, 22 October 2007 12:19, Alexey Starikovskiy wrote:
> Insert printk() for every change in operational mode.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

This has been requested by Len, IIRC.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

>  drivers/acpi/ec.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 202db57..bf60b24 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -173,12 +173,17 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
>  			return 0;
>  		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  		if (acpi_ec_check_status(ec, event)) {
> -			if (event == ACPI_EC_EVENT_OBF_1)
> +			if (event == ACPI_EC_EVENT_OBF_1) {
>  				/* miss OBF = 1 GPE, don't expect it anymore */
> +				printk(KERN_INFO PREFIX "missing OBF_1 confirmation,"
> +					"switching to degraded mode.\n");
>  				set_bit(EC_FLAGS_ONLY_IBF_GPE, &ec->flags);
> -			else
> +			} else {
>  				/* missing GPEs, switch back to poll mode */
> +				printk(KERN_INFO PREFIX "missing IBF_1 confirmations,"
> +					"switch off interrupt mode.\n");
>  				clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
> +			}
>  			return 0;
>  		}
>  	} else {
> @@ -491,8 +496,12 @@ static u32 acpi_ec_gpe_handler(void *data)
>  		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
>  			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
>  				acpi_ec_gpe_query, ec);
> -	} else if (unlikely(!test_bit(EC_FLAGS_GPE_MODE, &ec->flags)))
> +	} else if (unlikely(!test_bit(EC_FLAGS_GPE_MODE, &ec->flags))) {
> +		/* this is non-query, must be confirmation */
> +		printk(KERN_INFO PREFIX "non-query interrupt received,"
> +			" switching to interrupt mode\n");
>  		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
> +	}
>  
>  	return ACPI_SUCCESS(status) ?
>  	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> @@ -740,6 +749,8 @@ static int acpi_ec_add(struct acpi_device *device)
>  	acpi_ec_add_fs(device);
>  	printk(KERN_INFO PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
>  			  ec->gpe, ec->command_addr, ec->data_addr);
> +	printk(KERN_INFO PREFIX "driver started in %s mode\n",
> +		(test_bit(EC_FLAGS_GPE_MODE, &ec->flags))?"interrupt":"poll");
>  	return 0;
>  }
>  
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
