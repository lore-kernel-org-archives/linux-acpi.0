From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH -next] ACPI / table: Remove duplicated include from tables.c
Date: Mon, 26 Sep 2016 14:59:03 +0200
Message-ID: <6553923.hqNOrRhtCr@vostro.rjw.lan>
References: <1473350141-25936-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44303 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1034437AbcIZM5l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Sep 2016 08:57:41 -0400
In-Reply-To: <1473350141-25936-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org

On Thursday, September 08, 2016 03:55:41 PM Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/acpi/tables.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 4dfbf49..cdd56c4 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -35,7 +35,6 @@
>  #include <linux/earlycpio.h>
>  #include <linux/memblock.h>
>  #include <linux/initrd.h>
> -#include <linux/acpi.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT

Applied, thanks!

Rafael

