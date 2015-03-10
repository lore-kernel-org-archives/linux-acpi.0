From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for HP Pavilion dv6
Date: Tue, 10 Mar 2015 23:20:13 +0100
Message-ID: <1941299.sLe76u91Cr@vostro.rjw.lan>
References: <1425364754-31900-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52258 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751467AbbCJV4a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 17:56:30 -0400
In-Reply-To: <1425364754-31900-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday, March 03, 2015 02:39:14 PM Alex Hung wrote:
> The brightness hotkeys of HP Pavilion dv6 does not work with Win8 OSI. Due
> to insufficient documentation for the driver implementation, blacklist
> it as a workaround.

I gather that the native backlight interface doesn't work on those systems too,
is that correct?

> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/blacklist.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 9b693d5..98aa360 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -300,6 +300,18 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	},
>  
>  	/*
> +	 * The brightness hotkeys do not work on those machines when
> +	 * returning true for _OSI("Windows 2012")
> +	 */
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "HP Pavilion dv6",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
> +		},
> +	},
> +	/*
>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>  	 * Linux ignores it, except for the machines enumerated below.
>  	 */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
