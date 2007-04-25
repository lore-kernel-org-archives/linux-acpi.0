From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Disable MSI per FADT
Date: Wed, 25 Apr 2007 08:01:10 -0700
Message-ID: <20070425080110.ab2bbe5f.randy.dunlap@oracle.com>
References: <1177470312.11073.10.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:19198 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161427AbXDYO7R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2007 10:59:17 -0400
In-Reply-To: <1177470312.11073.10.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Greg KH <greg@kroah.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Wed, 25 Apr 2007 11:05:12 +0800 Shaohua Li wrote:

> ACPI spec defines the bit and Microsoft uses it. Suppose Linux should
> use it too.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

ack.  looks familiar.

http://marc.info/?l=linux-kernel&m=116361622308907&w=2
http://marc.info/?l=linux-kernel&m=116362326505789&w=2


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


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
