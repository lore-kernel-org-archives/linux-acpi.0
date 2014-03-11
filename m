From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 3/3] ACPI / AC: recheck adapter status upon battery notifications
Date: Tue, 11 Mar 2014 13:59:05 +0800
Message-ID: <CAOLK0pymaxK7gvs-6VJGg2nyb3_0PNi3_Ws+w58i2NoG86DDgA@mail.gmail.com>
References: <1394452061-27777-1-git-send-email-mezin.alexander@gmail.com>
	<1394452061-27777-3-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:48861 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaCKF7G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2014 01:59:06 -0400
Received: by mail-qa0-f47.google.com with SMTP id w5so8023558qac.34
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2014 22:59:06 -0700 (PDT)
In-Reply-To: <1394452061-27777-3-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-03-10 19:47 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
> On HP Pavilion dv6-6179er there are no notifications when AC adapter
> is plugged/unplugged.
> However, when AC status is read (acpi_ac_get_state), and if AC status
> has changed, AML code triggers the notification.
>
> This patch solves the problem by re-reading AC adapter status upon
> battery notifications.
>
> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
> ---
>  drivers/acpi/ac.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 6f190bc..e3f9862 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -33,6 +33,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/acpi.h>
> +#include "battery.h"
>
>  #define PREFIX "ACPI: "
>
> @@ -57,6 +58,7 @@ struct acpi_ac {
>         struct power_supply charger;
>         struct platform_device *pdev;
>         unsigned long long state;
> +       struct notifier_block battery_nb;
>  };
>
>  #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger)
> @@ -152,6 +154,18 @@ static void acpi_ac_notify_handler(acpi_handle handle, u32 event, void *data)
>         return;
>  }
>
> +static int acpi_ac_battery_notify(struct notifier_block *nb,
> +                                 unsigned long action, void *data)
> +{
> +       struct acpi_ac *ac = container_of(nb, struct acpi_ac, battery_nb);
> +       struct acpi_bus_event *event = (struct acpi_bus_event *)data;
> +
> +       if (strcmp(event->device_class, ACPI_BATTERY_CLASS) == 0)
> +               acpi_ac_get_state(ac);

You only needs to get ac status during battery status being changed, right?
If yes, please add the event check and add some comments here about
why need to add this.

> +
> +       return NOTIFY_OK;
> +}
> +
>  static int thinkpad_e530_quirk(const struct dmi_system_id *d)
>  {
>         ac_sleep_before_get_state_ms = 1000;
> @@ -215,6 +229,8 @@ static int acpi_ac_probe(struct platform_device *pdev)
>                acpi_device_name(adev), acpi_device_bid(adev),
>                ac->state ? "on-line" : "off-line");
>
> +       ac->battery_nb.notifier_call = acpi_ac_battery_notify;
> +       register_acpi_notifier(&ac->battery_nb);
>  end:
>         if (result)
>                 kfree(ac);
> @@ -261,6 +277,7 @@ static int acpi_ac_remove(struct platform_device *pdev)
>         ac = platform_get_drvdata(pdev);
>         if (ac->charger.dev)
>                 power_supply_unregister(&ac->charger);
> +       unregister_acpi_notifier(&ac->battery_nb);
>
>         kfree(ac);
>
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
