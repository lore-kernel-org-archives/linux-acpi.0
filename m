From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 2/3] ACPI / battery: call ACPI notifier chain in acpi_battery_notify
Date: Tue, 11 Mar 2014 13:47:44 +0800
Message-ID: <CAOLK0pxdm6jHVOR=taGCuwoD4N7sXxa1xgnZib_Vw_Q0N6cp8Q@mail.gmail.com>
References: <1394452061-27777-1-git-send-email-mezin.alexander@gmail.com>
	<1394452061-27777-2-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34392 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaCKFrp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2014 01:47:45 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so3579544qgf.5
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2014 22:47:44 -0700 (PDT)
In-Reply-To: <1394452061-27777-2-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-03-10 19:47 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
> Allow other drivers to subscribe to battery status notifications.
> Just like AC driver does.
>

Acked-by: Lan Tianyu <tianyu.lan@intel.com>

> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
> ---
>  drivers/acpi/battery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 0a19c8f..861e585 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -737,6 +737,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
>         acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                         dev_name(&device->dev), event,
>                                         acpi_battery_present(battery));
> +       acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
>         /* acpi_battery_update could remove power_supply object */
>         if (old && battery->bat.dev)
>                 power_supply_changed(&battery->bat);
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
