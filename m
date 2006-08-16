From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 03/14] acpi: fix boot with acpi=off
Date: Tue, 15 Aug 2006 23:23:06 -0400
Message-ID: <200608152323.06572.len.brown@intel.com>
References: <200608150537.k7F5bM6t011533@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:20386 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750874AbWHPDVd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 23:21:33 -0400
In-Reply-To: <200608150537.k7F5bM6t011533@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, pavel@ucw.cz, pavel@suse.cz

Applied.

(and I did the same to acpi_sbs_init)

thanks,
-Len

On Tuesday 15 August 2006 01:37, akpm@osdl.org wrote:
> From: Pavel Machek <pavel@ucw.cz>
> 
> With acpi=off and acpi_ac/battery compiled into kernel, acpi breaks
> boot. This fixes it.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/ac.c      |    2 ++
>  drivers/acpi/battery.c |    3 +++
>  2 files changed, 5 insertions(+)
> 
> diff -puN drivers/acpi/ac.c~acpi-fix-boot-with-acpi=off drivers/acpi/ac.c
> --- a/drivers/acpi/ac.c~acpi-fix-boot-with-acpi=off
> +++ a/drivers/acpi/ac.c
> @@ -285,6 +285,8 @@ static int __init acpi_ac_init(void)
>  {
>  	int result;
>  
> +	if (acpi_disabled)
> +		return -ENODEV;
>  
>  	acpi_ac_dir = acpi_lock_ac_dir();
>  	if (!acpi_ac_dir)
> diff -puN drivers/acpi/battery.c~acpi-fix-boot-with-acpi=off drivers/acpi/battery.c
> --- a/drivers/acpi/battery.c~acpi-fix-boot-with-acpi=off
> +++ a/drivers/acpi/battery.c
> @@ -757,6 +757,9 @@ static int __init acpi_battery_init(void
>  {
>  	int result;
>  
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
>  	acpi_battery_dir = acpi_lock_battery_dir();
>  	if (!acpi_battery_dir)
>  		return -ENODEV;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
