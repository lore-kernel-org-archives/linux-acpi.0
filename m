From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / battery: Add quirk for Asus UX360UA and UX410UAK
Date: Thu, 08 Feb 2018 10:59:35 +0100
Message-ID: <1603805.FnSEaBbLeX@aspire.rjw.lan>
References: <20180129054036.13599-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:42806 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHKBS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2018 05:01:18 -0500
In-Reply-To: <20180129054036.13599-1-kai.heng.feng@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, January 29, 2018 6:40:36 AM CET Kai-Heng Feng wrote:
> Same issue as other Asus laptops, ACPI incorrectly reports discharging
> when battery is full and AC is plugged.
> 
> Use the same battery quirk can workaround the issue.
> 
> BugLink: https://bugs.launchpad.net/bugs/1661876
> BugLink: https://bugs.launchpad.net/bugs/1745032
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/battery.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 19bc440820e6..7128488a3a72 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1209,6 +1209,22 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "UX305LA"),
>  		},
>  	},
> +	{
> +		.callback = battery_full_discharging_quirk,
> +		.ident = "ASUS UX360UA",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "UX360UA"),
> +		},
> +	},
> +	{
> +		.callback = battery_full_discharging_quirk,
> +		.ident = "ASUS UX410UAK",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "UX410UAK"),
> +		},
> +	},
>  	{},
>  };
>  
> 

Applied, thanks!


