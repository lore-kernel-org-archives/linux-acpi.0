From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Wed, 9 Jul 2008 14:02:33 -0700
Message-ID: <86802c440807091402x7042c25dnb20a6d00d0f55307@mail.gmail.com>
References: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:42122 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYGIVCd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 17:02:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3708721rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jul 2008 14:02:33 -0700 (PDT)
In-Reply-To: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, takayoshi.kochi@gmail.com

On Wed, Jul 9, 2008 at 1:41 PM, John Keller <jpk@sgi.com> wrote:
> SGI UV will have MMCFG base addresses that are greater than 4GB (32 bits).
>
> Signed-off-by: John Keller <jpk@sgi.com>
> ---
>
> A similar patch was submitted over a year ago, but apparently was not
> merged in.
>
>   http://marc.info/?l=linux-acpi&m=117283388212912&w=2
>
>
> Index: linux-2.6/arch/x86/kernel/acpi/boot.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/boot.c  2008-07-09 13:02:54.000000000 -0500
> +++ linux-2.6/arch/x86/kernel/acpi/boot.c       2008-07-09 15:25:32.000000000 -0500
> @@ -200,6 +200,7 @@ int __init acpi_parse_mcfg(struct acpi_t
>        }
>
>        memcpy(pci_mmcfg_config, &mcfg[1], config_size);
> +#ifndef CONFIG_X86_64
>        for (i = 0; i < pci_mmcfg_config_num; ++i) {
>                if (pci_mmcfg_config[i].address > 0xFFFFFFFF) {
>                        printk(KERN_ERR PREFIX
> @@ -209,6 +210,7 @@ int __init acpi_parse_mcfg(struct acpi_t
>                        return -ENODEV;
>                }
>        }
> +#endif
>
>        return 0;
>  }

CONFIG_RESOURCES_64BIT ?

YH
