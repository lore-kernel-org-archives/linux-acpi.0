From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / battery: use callback for setting up quirks
Date: Thu, 19 Jun 2014 02:08:02 +0200
Message-ID: <2264449.8aAuNZj5kJ@vostro.rjw.lan>
References: <1401822083-4866-1-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61448 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756536AbaFRXu0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 19:50:26 -0400
In-Reply-To: <1401822083-4866-1-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

On Wednesday, June 04, 2014 02:01:22 AM Alexander Mezin wrote:
> Use callback for setting up quirk instead of checking return code
> of dmi_check_system(). This change will allow using bat_dmi_table
> for other quirks.
> 
> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>

Both [1-2/2] applied, thanks!

> ---
>  drivers/acpi/battery.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6e7b2a1..f17bc7e 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1058,8 +1058,15 @@ static int battery_notify(struct notifier_block *nb,
>  	return 0;
>  }
>  
> +static int battery_bix_broken_package_quirk(const struct dmi_system_id *d)
> +{
> +	battery_bix_broken_package = 1;
> +	return 0;
> +}
> +
>  static struct dmi_system_id bat_dmi_table[] = {
>  	{
> +		.callback = battery_bix_broken_package_quirk,
>  		.ident = "NEC LZ750/LS",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> @@ -1176,8 +1183,7 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
>  	if (acpi_disabled)
>  		return;
>  
> -	if (dmi_check_system(bat_dmi_table))
> -		battery_bix_broken_package = 1;
> +	dmi_check_system(bat_dmi_table);
>  	
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  	acpi_battery_dir = acpi_lock_battery_dir();
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
