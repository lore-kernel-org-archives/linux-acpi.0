From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: Don't do transaction from GPE handler in
	poll mode.
Date: Tue, 11 Nov 2008 17:25:25 +0800
Message-ID: <1226395526.4782.48.camel@yakui_zhao.sh.intel.com>
References: <20081111080614.11705.79007.stgit@thinkpad>
	 <20081111080922.11705.34637.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913AbYKKJSo (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 11 Nov 2008 04:18:44 -0500
In-Reply-To: <20081111080922.11705.34637.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Tue, 2008-11-11 at 16:09 +0800, Alexey Starikovskiy wrote:
> Referencies: http://bugzilla.kernel.org/show_bug.cgi?id=12004
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 628b076..b1dcc08 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -576,11 +576,15 @@ static u32 acpi_ec_gpe_handler(void *data)
>  	pr_debug(PREFIX "~~~> interrupt\n");
>  	status = acpi_ec_read_status(ec);
>  
> -	gpe_transaction(ec, status);
> -	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
> -		wake_up(&ec->wait);
> +	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) {
> +		gpe_transaction(ec, status);
> +		if (ec_transaction_done(ec) &&
> +		    (status & ACPI_EC_FLAG_IBF) == 0)
> +			wake_up(&ec->wait);
> +	}
>  
>  	ec_check_sci(ec, status);
Sorry that I don't describe it very clearly in the previous email.
It seems that the EC won't be switched from polling mode to EC GPE mode
after the following is added.
   >#if 0
   >#endif
   In such case the EC will always work in polling mode. And EC GPE
storm also can't be detected. 

I am not sure what I have said is correct. If not correct, please ignore
it.
If correct, is it appropriate that the default work mode is set as EC
GPE mode?
Thanks.
   Yakui

> +#if 0
>  	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
>  	    !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
>  		/* this is non-query, must be confirmation */
> @@ -589,6 +593,7 @@ static u32 acpi_ec_gpe_handler(void *data)
>  				" switching to interrupt mode\n");
>  		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
>  	}
> +#endif
>  	return ACPI_INTERRUPT_HANDLED;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

