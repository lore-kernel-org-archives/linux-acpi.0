From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH v2 4/4] remove include asm/acpi.h in process_driver.c
Date: Tue, 5 Feb 2013 14:43:47 +0900
Message-ID: <51109C13.80907@jp.fujitsu.com>
References: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360031838-26898-5-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:42934 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3BEFoM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2013 00:44:12 -0500
In-Reply-To: <1360031838-26898-5-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, rientjes@google.com

2013/02/05 11:37, liguang wrote:
> process_driver.c include linux/acpi.h which already
> include asm/acpi.h, so remove it.
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> ---

Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>   drivers/acpi/processor_driver.c |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index e83311b..752eedb 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -52,7 +52,6 @@
>   #include <asm/uaccess.h>
>   #include <asm/processor.h>
>   #include <asm/smp.h>
> -#include <asm/acpi.h>
>   
>   #include <acpi/acpi_bus.h>
>   #include <acpi/acpi_drivers.h>
> 


