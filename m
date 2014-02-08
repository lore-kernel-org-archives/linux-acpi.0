From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Sat, 8 Feb 2014 14:33:04 +0800
Message-ID: <CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:49670 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbaBHGdG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Feb 2014 01:33:06 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so6587974qaq.6
        for <linux-acpi@vger.kernel.org>; Fri, 07 Feb 2014 22:33:04 -0800 (PST)
In-Reply-To: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
> Do the same thing as in acpi_ac_resume.
>
> BIOS on my laptop (HP Pavilion dv6-6179er) don't send proper
> notifications when AC adapter is plugged/unplugged.
> This change makes it possible to workaround the problem by using
> acpid and a shell script.
>
> This patch has the same effect as
> commit 50a2bc5429f07ec4d53df2d287b03bdbceb281bb
> "ACPI / AC: change notification handler type to ACPI_ALL_NOTIFY"
>
> Aforementioned commit could be reverted.

Hi Alexander:
             I don't think the previous commit can be reverted. AC driver
should get system notify events(E,G bus check event) and  process them.
Some drivers(E,G radeon) also need to know AC event and AC driver's
notify handler sends the event to these drivers via block notifier call chain.
Further more, this patch only works when the related sysfs interfaces are
accessed. It's redundant with previous commit.

>
> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
> ---
>  drivers/acpi/ac.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index e7515aa..cdba639 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -90,12 +90,16 @@ static int get_ac_property(struct power_supply *psy,
>                            union power_supply_propval *val)
>  {
>         struct acpi_ac *ac = to_acpi_ac(psy);
> +       unsigned long long old_state;
>
>         if (!ac)
>                 return -ENODEV;
>
> +       old_state = ac->state;
>         if (acpi_ac_get_state(ac))
>                 return -ENODEV;
> +       if (old_state != ac->state)
> +               kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_ONLINE:
> --
> 1.8.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
