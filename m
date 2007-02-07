From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 11/13] sony_acpi: add lanpower and audiopower controls
Date: Wed, 7 Feb 2007 16:07:56 -0500
Message-ID: <200702071607.56935.lenb@kernel.org>
References: <200702060010.l160ALCi003751@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37212 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422749AbXBGVJU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 16:09:20 -0500
In-Reply-To: <200702060010.l160ALCi003751@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

NAK
now included in sony-laptop patch series.

-Len

On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: Mattia Dongili <malattia@linux.it>
> 
> audiopower works well on my SZ72B so it's not marked has "debug" while
> lanpower has at least one report of not resuming power happily so morked as
> "debug"
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/sony_acpi.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/sony_acpi.c~sony_acpi-add-lanpower-and-audiopower-controls drivers/acpi/sony_acpi.c
> --- a/drivers/acpi/sony_acpi.c~sony_acpi-add-lanpower-and-audiopower-controls
> +++ a/drivers/acpi/sony_acpi.c
> @@ -102,11 +102,27 @@ static struct sony_acpi_value {
>  		.name		= "cdpower",
>  		.acpiget	= "GCDP",
>  		.acpiset	= "SCDP",
> -		.min		= -1,
> -		.max		= -1,
> +		.min		= 0,
> +		.max		= 1,
>  		.debug		= 0,
>  	},
>  	{
> +		.name           = "audiopower",
> +		.acpiget        = "GAZP",
> +		.acpiset        = "AZPW",
> +		.min            = 0,
> +		.max            = 1,
> +		.debug          = 0,
> +	},
> +	{
> +		.name           = "lanpower",
> +		.acpiget        = "GLNP",
> +		.acpiset        = "LNPW",
> +		.min            = 0,
> +		.max            = 1,
> +		.debug          = 1,
> +	},
> +	{
>  		.name		= "PID",
>  		.acpiget	= "GPID",
>  		.debug		= 1,
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
