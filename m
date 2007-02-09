From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 05/13] ACPI: Make bay depend on dock
Date: Fri, 9 Feb 2007 00:50:10 -0500
Message-ID: <200702090050.10271.lenb@kernel.org>
References: <200702060010.l160AE0G003732@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60198 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946129AbXBIFv3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 00:51:29 -0500
In-Reply-To: <200702060010.l160AE0G003732@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

Did you intend to make ACPI_BAY depend on ACPI_DOCK
instead of making ACPI_DOCK depend on ACPI_DOCK?

-Len

On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> Since the bay driver depends on the dock driver for proper notification, make
> this driver depend on the dock driver.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/acpi/Kconfig~acpi-make-bay-depend-on-dock drivers/acpi/Kconfig
> --- a/drivers/acpi/Kconfig~acpi-make-bay-depend-on-dock
> +++ a/drivers/acpi/Kconfig
> @@ -151,6 +151,7 @@ config ACPI_FAN
>  config ACPI_DOCK
>  	tristate "Dock"
>  	depends on EXPERIMENTAL
> +	depends on ACPI_DOCK
>  	help
>  	  This driver adds support for ACPI controlled docking stations
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
