From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Thu, 10 Jul 2008 16:28:25 +0900
Message-ID: <4875BA19.3060101@jp.fujitsu.com>
References: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41823 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbYGJH3S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 03:29:18 -0400
In-Reply-To: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, takayoshi.kochi@gmail.com

John Keller wrote:
> SGI UV will have MMCFG base addresses that are greater than 4GB (32 bits).
> 
> Signed-off-by: John Keller <jpk@sgi.com>

Fujitsu servers also will need this change.

Thanks,
Kenji Kaneshige


> ---
> 
> A similar patch was submitted over a year ago, but apparently was not
> merged in.
> 
>    http://marc.info/?l=linux-acpi&m=117283388212912&w=2
> 
> 
> Index: linux-2.6/arch/x86/kernel/acpi/boot.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/boot.c	2008-07-09 13:02:54.000000000 -0500
> +++ linux-2.6/arch/x86/kernel/acpi/boot.c	2008-07-09 15:25:32.000000000 -0500
> @@ -200,6 +200,7 @@ int __init acpi_parse_mcfg(struct acpi_t
>  	}
>  
>  	memcpy(pci_mmcfg_config, &mcfg[1], config_size);
> +#ifndef CONFIG_X86_64
>  	for (i = 0; i < pci_mmcfg_config_num; ++i) {
>  		if (pci_mmcfg_config[i].address > 0xFFFFFFFF) {
>  			printk(KERN_ERR PREFIX
> @@ -209,6 +210,7 @@ int __init acpi_parse_mcfg(struct acpi_t
>  			return -ENODEV;
>  		}
>  	}
> +#endif
>  
>  	return 0;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


