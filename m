From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / Kconfig: Remove redundant depends on ACPI
Date: Wed, 19 Nov 2014 00:29:01 +0100
Message-ID: <2328327.v8Xh1u8vIt@vostro.rjw.lan>
References: <1415958247-7143-1-git-send-email-hanjun.guo@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58111 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754553AbaKRXH4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 18:07:56 -0500
In-Reply-To: <1415958247-7143-1-git-send-email-hanjun.guo@linaro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.com>

On Friday, November 14, 2014 05:44:07 PM Hanjun Guo wrote:
> Since config ACPI_REDUCED_HARDWARE_ONLY is already depended
> on ACPI (inside if ACPI / endif), so depdens on ACPI is redundant,
> remove it and fix the minor syntax problem also.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.com>

Queued up for 3.19-rc1, thanks!

> ---
>  drivers/acpi/Kconfig | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b23fe37..79078b8 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -360,15 +360,14 @@ config ACPI_BGRT
>  config ACPI_REDUCED_HARDWARE_ONLY
>  	bool "Hardware-reduced ACPI support only" if EXPERT
>  	def_bool n
> -	depends on ACPI
>  	help
> -	This config item changes the way the ACPI code is built.  When this
> -	option is selected, the kernel will use a specialized version of
> -	ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
> -	resulting kernel will be smaller but it will also be restricted to
> -	running in ACPI reduced hardware mode ONLY.
> +	  This config item changes the way the ACPI code is built.  When this
> +	  option is selected, the kernel will use a specialized version of
> +	  ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
> +	  resulting kernel will be smaller but it will also be restricted to
> +	  running in ACPI reduced hardware mode ONLY.
>  
> -	If you are unsure what to do, do not enable this option.
> +	  If you are unsure what to do, do not enable this option.
>  
>  source "drivers/acpi/apei/Kconfig"
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
