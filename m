From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.6 patch] acpi/battery.c: make 2 functions static
Date: Sat, 01 Mar 2008 21:26:41 +0300
Message-ID: <47C99FE1.8080206@gmail.com>
References: <20080301161902.GN25835@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43344 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbYCAS0p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Mar 2008 13:26:45 -0500
Received: by ug-out-1314.google.com with SMTP id z38so973893ugc.16
        for <linux-acpi@vger.kernel.org>; Sat, 01 Mar 2008 10:26:44 -0800 (PST)
In-Reply-To: <20080301161902.GN25835@cs181133002.pp.htv.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

May I keep them inline?

Thanks,
Alex.
Adrian Bunk wrote:
> This patch makes the following functions static instead of global inline:
> - acpi_battery_present()
> - acpi_battery_units()
>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
>
> ---
>
>  drivers/acpi/battery.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> 9cfc2b0a3162d8e2f23537faefb6937c97513f38 foobar
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f6215e8..d941c5a 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -116,7 +116,7 @@ struct acpi_battery {
>  
>  #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
>  
> -inline int acpi_battery_present(struct acpi_battery *battery)
> +static int acpi_battery_present(struct acpi_battery *battery)
>  {
>  	return battery->device->status.battery_present;
>  }
> @@ -235,7 +235,7 @@ static enum power_supply_property energy_battery_props[] = {
>  #endif
>  
>  #ifdef CONFIG_ACPI_PROCFS_POWER
> -inline char *acpi_battery_units(struct acpi_battery *battery)
> +static char *acpi_battery_units(struct acpi_battery *battery)
>  {
>  	return (battery->power_unit)?"mA":"mW";
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

