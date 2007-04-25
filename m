From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Disable MSI per FADT
Date: Wed, 25 Apr 2007 01:14:05 -0400
Message-ID: <200704250114.06004.lenb@kernel.org>
References: <1177470312.11073.10.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35934 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbXDYFPr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 01:15:47 -0400
In-Reply-To: <1177470312.11073.10.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Applied.

thanks,
-Len

On Tuesday 24 April 2007 23:05, Shaohua Li wrote:
> ACPI spec defines the bit and Microsoft uses it. Suppose Linux should
> use it too.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> Index: 2.6.21-rc6/drivers/pci/pci-acpi.c
> ===================================================================
> --- 2.6.21-rc6.orig/drivers/pci/pci-acpi.c	2007-04-06 10:36:56.000000000 +0800
> +++ 2.6.21-rc6/drivers/pci/pci-acpi.c	2007-04-25 10:58:12.000000000 +0800
> @@ -317,6 +317,10 @@ static int __init acpi_pci_init(void)
>  {
>  	int ret;
>  
> +	if (acpi_gbl_FADT.boot_flags & BAF_MSI_NOT_SUPPORTED) {
> +		printk(KERN_INFO"ACPI FADT declares the system doesn't support MSI, so disable it\n");
> +		pci_no_msi();
> +	}
>  	ret = register_acpi_bus_type(&acpi_pci_bus);
>  	if (ret)
>  		return 0;
> Index: 2.6.21-rc6/include/acpi/actbl.h
> ===================================================================
> --- 2.6.21-rc6.orig/include/acpi/actbl.h	2007-04-06 10:36:56.000000000 +0800
> +++ 2.6.21-rc6/include/acpi/actbl.h	2007-04-25 10:22:28.000000000 +0800
> @@ -276,6 +276,7 @@ enum acpi_prefered_pm_profiles {
>  
>  #define BAF_LEGACY_DEVICES              0x0001
>  #define BAF_8042_KEYBOARD_CONTROLLER    0x0002
> +#define BAF_MSI_NOT_SUPPORTED           0x0008
>  
>  #define FADT2_REVISION_ID               3
>  #define FADT2_MINUS_REVISION_ID         2
> 
