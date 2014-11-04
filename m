From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: blacklist Win8 OSI for Dell Vostro 3546
Date: Tue, 04 Nov 2014 01:55:56 +0100
Message-ID: <3155964.sJj5L6X0pf@vostro.rjw.lan>
References: <1414389345-4723-1-git-send-email-adam.lee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49814 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750770AbaKDAfM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2014 19:35:12 -0500
In-Reply-To: <1414389345-4723-1-git-send-email-adam.lee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Lee <adam.lee@canonical.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Monday, October 27, 2014 01:55:45 PM Adam Lee wrote:
> The wireless hotkey of Dell Vostro 3546 does not work with Win8 OSI. Due
> to insufficient documentation for the driver implementation, blacklist
> it as a workaround.
> 
> Signed-off-by: Adam Lee <adam.lee@canonical.com>

Applied, thanks!

> ---
>  drivers/acpi/blacklist.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index ed122e1..7556e7c 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -290,6 +290,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3446"),
>  		},
>  	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Vostro 3546",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3546"),
> +		},
> +	},
>  
>  	/*
>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
