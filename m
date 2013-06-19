From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH] ACPI: Remove the use of CONFIG_ACPI_HOTPLUG_MEMORY_MODULE
Date: Wed, 19 Jun 2013 13:43:47 +0900
Message-ID: <51C13703.8040909@jp.fujitsu.com>
References: <1371589605-15638-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35130 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab3FSEo0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2013 00:44:26 -0400
In-Reply-To: <1371589605-15638-1-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

2013/06/19 6:06, Toshi Kani wrote:
> config ACPI_HOTPLUG_MEMORY has been changed to bool (y/n), and
> its module option is no longer valid.  So, remove the use of
> CONFIG_ACPI_HOTPLUG_MEMORY_MODULE.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> ---
>   include/linux/acpi.h |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 17b5b59..353ba25 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -352,8 +352,7 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
>   
>   /* Enable _OST when all relevant hotplug operations are enabled */
>   #if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
> -	(defined(CONFIG_ACPI_HOTPLUG_MEMORY) ||		\
> -	 defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) &&	\
> +	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
>   	defined(CONFIG_ACPI_CONTAINER)
>   #define ACPI_HOTPLUG_OST
>   #endif
> --
Good catch!!

Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


