From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6 patch] x86_64: remove acpi_pci_link_exit()
Date: Fri, 16 Nov 2007 21:18:34 -0500
Message-ID: <200711162118.34677.lenb@kernel.org>
References: <20071109060313.GS26163@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58945 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbXKQCTJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Nov 2007 21:19:09 -0500
In-Reply-To: <20071109060313.GS26163@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Friday 09 November 2007 01:03, Adrian Bunk wrote:
> acpi_pci_link_exit() is both unused and empty.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 16d6853a1facb9bcb7a4bc19daad6d3b852cace3 
> diff --git a/arch/x86/kernel/acpi/sleep_64.c b/arch/x86/kernel/acpi/sleep_64.c
> index 79475d2..da42de2 100644
> --- a/arch/x86/kernel/acpi/sleep_64.c
> +++ b/arch/x86/kernel/acpi/sleep_64.c
> @@ -115,6 +115,3 @@ static int __init acpi_sleep_setup(char *str)
>  
>  __setup("acpi_sleep=", acpi_sleep_setup);
>  
> -void acpi_pci_link_exit(void)
> -{
> -}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
