From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH] ACPI / AC: Introduce the use of the managed version of kzalloc
Date: Mon, 5 May 2014 11:30:49 +0800
Message-ID: <CAOLK0pySpeXvnjikaMTugiM-9cLfPsKayUW3us+x4bmf6OBoKg@mail.gmail.com>
References: <20140504123520.GA16892@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:52082 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbaEEDat (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 May 2014 23:30:49 -0400
In-Reply-To: <20140504123520.GA16892@himangi-Dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>

2014-05-04 20:35 GMT+08:00 Himangi Saraogi <himangi774@gmail.com>:
> This patch moves data allocated using kzalloc to managed data allocated
> using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> functions.

Acked-by: Lan Tianyu <tianyu.lan@intel.com>

>
> The following Coccinelle semantic patch was used for making the change:
> @platform@
> identifier p, probefn, removefn;
> @@
> struct platform_driver p = {
>   .probe = probefn,
>   .remove = removefn,
> };
>
> @prb@
> identifier platform.probefn, pdev;
> expression e, e1, e2;
> @@
> probefn(struct platform_device *pdev, ...) {
>   <+...
> - e = kzalloc(e1, e2)
> + e = devm_kzalloc(&pdev->dev, e1, e2)
>   ...
> ?-kfree(e);
>   ...+>
> }
>
> @rem depends on prb@
> identifier platform.removefn;
> expression e;
> @@
> removefn(...) {
>   <...
> - kfree(e);
>   ...>
> }
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> ---
>  drivers/acpi/ac.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 2c01c1d..98b613a 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -205,7 +205,7 @@ static int acpi_ac_probe(struct platform_device *pdev)
>         if (!adev)
>                 return -ENODEV;
>
> -       ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
> +       ac = devm_kzalloc(&pdev->dev, sizeof(struct acpi_ac), GFP_KERNEL);
>         if (!ac)
>                 return -ENOMEM;
>
> @@ -240,9 +240,6 @@ static int acpi_ac_probe(struct platform_device *pdev)
>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>         register_acpi_notifier(&ac->battery_nb);
>  end:
> -       if (result)
> -               kfree(ac);
> -
>         dmi_check_system(ac_dmi_table);
>         return result;
>  }
> @@ -287,8 +284,6 @@ static int acpi_ac_remove(struct platform_device *pdev)
>                 power_supply_unregister(&ac->charger);
>         unregister_acpi_notifier(&ac->battery_nb);
>
> -       kfree(ac);
> -
>         return 0;
>  }
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
