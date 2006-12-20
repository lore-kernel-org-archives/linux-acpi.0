From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 07/19] acpi: don't select PM
Date: Wed, 20 Dec 2006 01:36:36 -0500
Message-ID: <200612200136.36287.lenb@kernel.org>
References: <200612192056.kBJKuE4F010026@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47591 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964921AbWLTGhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 01:37:11 -0500
In-Reply-To: <200612192056.kBJKuE4F010026@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org

On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Make ACPI depend on PM rather than selecting it.  Otherwise it's a nightmare
> working out why CONFIG_PM keeps getting set.
> 
> (And why does ACPI require power management?)

I believe that this was to address a build failure
where ACPI and PM are entwined.  It seemed to
make more sense to prohibit the uninteresting
configuration of (ACPI && !PM) rather than
to add a bunch of ifdefs.

I think the error in our ways was to use select
rather than depends -- not realizing the inherent
evils of select.

Applied.

thanks,
-Len


> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/Kconfig~acpi-dont-select-pm drivers/acpi/Kconfig
> --- a/drivers/acpi/Kconfig~acpi-dont-select-pm
> +++ a/drivers/acpi/Kconfig
> @@ -11,7 +11,7 @@ config ACPI
>  	bool "ACPI Support"
>  	depends on IA64 || X86
>  	depends on PCI
> -	select PM
> +	depends on PM
>  	default y
>  	---help---
>  	  Advanced Configuration and Power Interface (ACPI) support for 
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
