From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 09/12] ACPI: add clarifying comment about processor throttling in HW reduced mode
Date: Sun, 17 Nov 2013 23:20:18 +0100
Message-ID: <4621090.bSNFRSzQnY@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-10-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57175 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752205Ab3KQWHm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:07:42 -0500
In-Reply-To: <1384047382-20623-10-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:19 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_throttling.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index e7dd2c1..200738e 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -942,6 +942,10 @@ static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * NB: in HW reduced mode, duty_width is always zero
> +	 * so this count may not be what is wanted.
> +	 */
>  	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
>  
>  	/*
> @@ -991,6 +995,10 @@ static int acpi_processor_set_throttling_fadt(struct acpi_processor *pr,
>  		/* Used to clear all duty_value bits */
>  		duty_mask = pr->throttling.state_count - 1;
>  
> +		/*
> +		 * NB: in HW reduced mode, duty_offset is always zero
> +		 * so this mask may not be what is wanted.
> +		 */
>  		duty_mask <<= acpi_gbl_FADT.duty_offset;
>  		duty_mask = ~duty_mask;
>  	}

I'm not sure how these comments help to be honest.  It looks like
pr->throttling.state_count should be 0 in HW reduced mode, shouldn't it?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
