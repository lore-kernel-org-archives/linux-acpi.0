From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / battery: ensure acpi_battery_init() has finish
Date: Fri, 15 May 2015 01:59:24 +0200
Message-ID: <2846184.p0deZ4nZzp@vostro.rjw.lan>
References: <1431380945-2923-1-git-send-email-luis.henriques@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57149 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422986AbbENXeM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 19:34:12 -0400
In-Reply-To: <1431380945-2923-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luis Henriques <luis.henriques@canonical.com>
Cc: Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, May 11, 2015 10:49:05 PM Luis Henriques wrote:
> Make sure that async function scheduled with async_schedule() has already
> been executed.
> 
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>

Queued up for 4.2 (along with the other two battery patches of yours), thanks!

> ---
>  drivers/acpi/battery.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 9c676a6f32ce..547e627611e0 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -70,6 +70,7 @@ MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>  MODULE_DESCRIPTION("ACPI Battery Driver");
>  MODULE_LICENSE("GPL");
>  
> +static async_cookie_t async_cookie;
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
>  static unsigned int cache_time = 1000;
> @@ -1313,12 +1314,13 @@ static int __init acpi_battery_init(void)
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> -	async_schedule(acpi_battery_init_async, NULL);
> +	async_cookie = async_schedule(acpi_battery_init_async, NULL);
>  	return 0;
>  }
>  
>  static void __exit acpi_battery_exit(void)
>  {
> +	async_synchronize_cookie(async_cookie);
>  	acpi_bus_unregister_driver(&acpi_battery_driver);
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  	acpi_unlock_battery_dir(acpi_battery_dir);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
