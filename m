From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Fix for Dell Latitude 3350 ethernet not working.
Date: Thu, 24 Nov 2016 02:28:17 +0100
Message-ID: <2602250.11qiJ8VHcr@vostro.rjw.lan>
References: <20161112032914.hg24zqqlkwirxx7z@hotbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57388 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935303AbcKXBUa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Nov 2016 20:20:30 -0500
In-Reply-To: <20161112032914.hg24zqqlkwirxx7z@hotbox>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Pobega <mpobega@neverware.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday, November 11, 2016 10:29:14 PM Michael Pobega wrote:
> The Dell Latitude 3350's ethernet card attempts to use a reserved IRQ (18),
> resulting in ACPI being unable to enable the ethernet.
> 
> This patch forces a specific _REV (ACPI revision) value as a workaround
> to allow the Dell Latitude 3350's board to work correctly.
> 
> The approach is similar to 18d78b64fddc11eb336f01e46ad3303a3f55d039
> 
> Signed-off-by: Michael Pobega <mpobega@neverware.com>
> ---
>  drivers/acpi/blacklist.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index bdc67ba..05cd61f 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -160,6 +160,18 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
>  		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
>  		},
>  	},
> +	/*
> +	 * Resolves a quirk with the Dell Latitude 3350 that
> +	 * causes the ethernet adapter to not function.
> +	 */
> +	{
> +	 .callback = dmi_enable_rev_override,
> +	 .ident = "DELL Latitude 3350",
> +	 .matches = {
> +		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		      DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
> +		},
> +	},
>  #endif
>  	{}
>  };
> 

Applied, with edited changelog.

Thanks,
Rafael

