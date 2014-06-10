From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / battery: use callback for setting up quirks
Date: Tue, 10 Jun 2014 10:13:41 +0800
Message-ID: <CAOLK0pzosZtwkcqHDPyaC_ZtHeQBmbjbf5y0fCJKG+H3N9KGRQ@mail.gmail.com>
References: <1401822083-4866-1-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44667 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028AbaFJCNl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2014 22:13:41 -0400
Received: by mail-qa0-f53.google.com with SMTP id k15so8194583qaq.26
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jun 2014 19:13:41 -0700 (PDT)
In-Reply-To: <1401822083-4866-1-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-06-04 3:01 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
> Use callback for setting up quirk instead of checking return code
> of dmi_check_system(). This change will allow using bat_dmi_table
> for other quirks.
>

Acked-by: Lan Tianyu <tianyu.lan@intel.com>

> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
> ---
>  drivers/acpi/battery.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6e7b2a1..f17bc7e 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1058,8 +1058,15 @@ static int battery_notify(struct notifier_block *nb,
>         return 0;
>  }
>
> +static int battery_bix_broken_package_quirk(const struct dmi_system_id *d)
> +{
> +       battery_bix_broken_package = 1;
> +       return 0;
> +}
> +
>  static struct dmi_system_id bat_dmi_table[] = {
>         {
> +               .callback = battery_bix_broken_package_quirk,
>                 .ident = "NEC LZ750/LS",
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> @@ -1176,8 +1183,7 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
>         if (acpi_disabled)
>                 return;
>
> -       if (dmi_check_system(bat_dmi_table))
> -               battery_bix_broken_package = 1;
> +       dmi_check_system(bat_dmi_table);
>
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>         acpi_battery_dir = acpi_lock_battery_dir();
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
