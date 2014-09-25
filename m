From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: blacklist Win8 OSI for some Dell laptop models
Date: Fri, 26 Sep 2014 01:47:23 +0200
Message-ID: <2514282.oiYJkEh4jk@vostro.rjw.lan>
References: <1410753372-10912-1-git-send-email-yidi.lin@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58527 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751875AbaIYX1d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2014 19:27:33 -0400
In-Reply-To: <1410753372-10912-1-git-send-email-yidi.lin@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Edward Lin <yidi.lin@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, yk@canonical.com

On Monday, September 15, 2014 11:56:12 AM Edward Lin wrote:
> The wireless hotkey of those machines does not work with Win8 OSI.
> Due to insufficient documentation for the driver implementation,
> blacklist those machines as a workaround.
> 
> "audo wake on after shutdown" bug on Dell Inspiron 7737 is fixed by BIOS[1].
> But this machine still suffers the hotkey issue. So keep the quirk for the
> wireless hotkey issue.
> 
> [1]:
> http://www.dell.com/support/home/us/en/19/Drivers/DriversDetails?driverId=MJWNX
> 
> Signed-off-by: Edward Lin <yidi.lin@canonical.com>

Queued up for 3.18, thanks!

> ---
>  drivers/acpi/blacklist.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 36eb42e..ed122e1 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -247,8 +247,8 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	},
>  
>  	/*
> -	 * These machines will power on immediately after shutdown when
> -	 * reporting the Windows 2012 OSI.
> +	 * The wireless hotkey does not work on those machines when
> +	 * returning true for _OSI("Windows 2012")
>  	 */
>  	{
>  	.callback = dmi_disable_osi_win8,
> @@ -258,6 +258,38 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
>  		},
>  	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Inspiron 7537",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7537"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Inspiron 5437",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5437"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Inspiron 3437",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 3437"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Vostro 3446",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3446"),
> +		},
> +	},
>  
>  	/*
>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
