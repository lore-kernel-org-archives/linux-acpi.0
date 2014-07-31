From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH -next] ACPI / battery: remove duplicated include from battery.c
Date: Fri, 01 Aug 2014 00:35:19 +0200
Message-ID: <2629685.sZftHArbHt@vostro.rjw.lan>
References: <1406553775-30104-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55361 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750789AbaGaWQp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2014 18:16:45 -0400
In-Reply-To: <1406553775-30104-1-git-send-email-weiyj_lk@163.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: weiyj_lk@163.com
Cc: Len Brown <lenb@kernel.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-acpi@vger.kernel.org

On Monday, July 28, 2014 09:22:55 PM weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks!

> ---
>  drivers/acpi/battery.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 130f513..48bcf38 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -35,7 +35,6 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
> -#include <linux/delay.h>
>  #include <asm/unaligned.h>
>  
>  #ifdef CONFIG_ACPI_PROCFS_POWER
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
