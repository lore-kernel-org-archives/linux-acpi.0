From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 03/19] acpi/processor: prevent loading module on failures
Date: Wed, 20 Dec 2006 00:43:32 -0500
Message-ID: <200612200043.32815.lenb@kernel.org>
References: <200612192056.kBJKuBhb010014@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39620 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964895AbWLTFoA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 00:44:00 -0500
In-Reply-To: <200612192056.kBJKuBhb010014@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, akinobu.mita@gmail.com

Applied.

thanks,
-Len

On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Make loading processor.ko fail when an error happens.
> 
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/processor_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/processor_core.c~acpi-processor-prevent-loading-module-on-failures drivers/acpi/processor_core.c
> --- a/drivers/acpi/processor_core.c~acpi-processor-prevent-loading-module-on-failures
> +++ a/drivers/acpi/processor_core.c
> @@ -901,13 +901,13 @@ static int __init acpi_processor_init(vo
>  
>  	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
>  	if (!acpi_processor_dir)
> -		return 0;
> +		return -ENOMEM;
>  	acpi_processor_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_processor_driver);
>  	if (result < 0) {
>  		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> -		return 0;
> +		return result;
>  	}
>  
>  	acpi_processor_install_hotplug_notify();
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
