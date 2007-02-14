From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: use NULL for ptrs
Date: Wed, 14 Feb 2007 18:17:55 -0500
Message-ID: <200702141817.55746.lenb@kernel.org>
References: <20070213161136.e8c8ac5b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50764 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbXBNXTQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Feb 2007 18:19:16 -0500
In-Reply-To: <20070213161136.e8c8ac5b.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, akpm <akpm@osdl.org>

Applied.

thanks,
-Len
On Tuesday 13 February 2007 19:11, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix sparse warnings in ACPI:
> drivers/acpi/osl.c:208:10: warning: Using plain integer as NULL pointer
> drivers/acpi/tables/tbxface.c:411:49: warning: Using plain integer as NULL pointer
> drivers/acpi/processor_core.c:1008:10: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/acpi/osl.c            |    2 +-
>  drivers/acpi/processor_core.c |    2 +-
>  drivers/acpi/tables/tbxface.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.20-git9.orig/drivers/acpi/osl.c
> +++ linux-2.6.20-git9/drivers/acpi/osl.c
> @@ -205,7 +205,7 @@ void __iomem *acpi_os_map_memory(acpi_ph
>  {
>  	if (phys > ULONG_MAX) {
>  		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
> -		return 0;
> +		return NULL;
>  	}
>  	if (acpi_gbl_permanent_mmap)
>  		/*
> --- linux-2.6.20-git9.orig/drivers/acpi/processor_core.c
> +++ linux-2.6.20-git9/drivers/acpi/processor_core.c
> @@ -1005,7 +1005,7 @@ static int __init acpi_processor_init(vo
>  #ifdef CONFIG_SMP
>  	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0,
>  				(struct acpi_table_header **)&madt)))
> -		madt = 0;
> +		madt = NULL;
>  #endif
>  
>  	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> --- linux-2.6.20-git9.orig/drivers/acpi/tables/tbxface.c
> +++ linux-2.6.20-git9/drivers/acpi/tables/tbxface.c
> @@ -408,7 +408,7 @@ acpi_get_table(char *signature,
>  		}
>  
>  		if (!acpi_gbl_permanent_mmap) {
> -			acpi_gbl_root_table_list.tables[i].pointer = 0;
> +			acpi_gbl_root_table_list.tables[i].pointer = NULL;
>  		}
>  
>  		return (status);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
