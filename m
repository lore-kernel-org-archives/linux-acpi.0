From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 2/2] ACPI / battery: add quirk for Acer Aspire V5-573G
Date: Tue, 10 Jun 2014 10:15:40 +0800
Message-ID: <CAOLK0py=+4AWKSzoLdELsanDayvE5oVcqiCQJo+RtgDtj=kTyA@mail.gmail.com>
References: <1401822083-4866-1-git-send-email-mezin.alexander@gmail.com>
	<1401822083-4866-2-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:37168 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028AbaFJCPl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2014 22:15:41 -0400
Received: by mail-qa0-f43.google.com with SMTP id m5so8762502qaj.30
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jun 2014 19:15:40 -0700 (PDT)
In-Reply-To: <1401822083-4866-2-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-06-04 3:01 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
> On Acer Aspire V5-573G battery notifications are sometimes
> triggered too early. For example, when AC is unplugged and
> notification is triggered, battery state is still reported as
> "Full", and changes to "Discharging" only after short delay,
> without any notification.
>
> This patch solves the problem by adding 1 second sleep.
> Similar quirk is already implemented in AC driver for other laptop.

Could you provide the output of acpidump?

>
> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
> ---
>  drivers/acpi/battery.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f17bc7e..87d26c3 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -32,6 +32,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/async.h>
>  #include <linux/dmi.h>
> +#include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <asm/unaligned.h>
> @@ -66,6 +67,7 @@ MODULE_DESCRIPTION("ACPI Battery Driver");
>  MODULE_LICENSE("GPL");
>
>  static int battery_bix_broken_package;
> +static int battery_notification_delay_ms;
>  static unsigned int cache_time = 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -1028,6 +1030,14 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
>         if (!battery)
>                 return;
>         old = battery->bat.dev;
> +       /*
> +       * On Acer Aspire V5-573G notifications are sometimes triggered too
> +       * early. For example, when AC is unplugged and notification is
> +       * triggered, battery state is still reported as "Full", and changes to
> +       * "Discharging" only after short delay, without any notification.
> +       */
> +       if (battery_notification_delay_ms > 0)
> +               msleep(battery_notification_delay_ms);
>         if (event == ACPI_BATTERY_NOTIFY_INFO)
>                 acpi_battery_refresh(battery);
>         acpi_battery_update(battery);
> @@ -1064,6 +1074,12 @@ static int battery_bix_broken_package_quirk(const struct dmi_system_id *d)
>         return 0;
>  }
>
> +static int battery_notification_delay_quirk(const struct dmi_system_id *d)
> +{
> +       battery_notification_delay_ms = 1000;
> +       return 0;
> +}
> +
>  static struct dmi_system_id bat_dmi_table[] = {
>         {
>                 .callback = battery_bix_broken_package_quirk,
> @@ -1073,6 +1089,14 @@ static struct dmi_system_id bat_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "PC-LZ750LS"),
>                 },
>         },
> +       {
> +               .callback = battery_notification_delay_quirk,
> +               .ident = "Acer Aspire V5-573G",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
> +               },
> +       },
>         {},
>  };
>
> --
> 2.0.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
