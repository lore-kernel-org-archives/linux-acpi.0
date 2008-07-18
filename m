From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Fri, 18 Jul 2008 14:38:58 +0200
Message-ID: <20080718123858.GR6875@elte.hu>
References: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:42746 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725AbYGRMjM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 08:39:12 -0400
Content-Disposition: inline
In-Reply-To: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, takayoshi.kochi@gmail.com, Yinghai Lu <yhlu.kernel@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>


* John Keller <jpk@sgi.com> wrote:

> SGI UV will have MMCFG base addresses that are greater than 4GB (32 
> bits).

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

hm. If then it should be enabled very carefully and initially probably 
on a per system (i.e. DMI driven whitelist) basis.

	Ingo
