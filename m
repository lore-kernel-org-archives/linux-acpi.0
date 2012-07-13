From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 4/5] acpi : remove power from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 20:17:01 -0400
Message-ID: <20120713001701.GB13574@phenom.dumpdata.com>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
 <1342127026-1526-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:30613 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab2GMAZg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 20:25:36 -0400
Content-Disposition: inline
In-Reply-To: <1342127026-1526-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jul 12, 2012 at 11:03:45PM +0200, Daniel Lezcano wrote:
> Remove the power field as it is not used.
> 
It looks to be used in drivers/xen/xen-acpi-processor.c.

I could emulate some value and stick it in there.. but I am
more curious - what is the intent of this value?


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/processor_idle.c |    2 --
>  include/acpi/processor.h      |    1 -
>  2 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index d044588..99ba58f 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -485,8 +485,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
>  		if (obj->type != ACPI_TYPE_INTEGER)
>  			continue;
>  
> -		cx.power = obj->integer.value;
> -
>  		current_count++;
>  		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
>  
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 0957457..87bb9d7 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -58,7 +58,6 @@ struct acpi_processor_cx {
>  	u32 address;
>  	u8 entry_method;
>  	u32 latency;
> -	u32 power;
>  	u64 time;
>  	u8 bm_sts_skip;
>  	char desc[ACPI_CX_DESC_LEN];
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
