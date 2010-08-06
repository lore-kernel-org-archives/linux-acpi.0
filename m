From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] ACPI: Add Toshiba Satellite C650D to DMI blacklist for
 corrupting DSDT
Date: Fri, 6 Aug 2010 19:06:18 +0200
Message-ID: <20100806190618.78d061bd@destiny.ordissimo>
References: <1281112818-19388-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62803 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934892Ab0HFRGs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2010 13:06:48 -0400
Received: by ewy23 with SMTP id 23so2879406ewy.19
        for <linux-acpi@vger.kernel.org>; Fri, 06 Aug 2010 10:06:47 -0700 (PDT)
In-Reply-To: <1281112818-19388-1-git-send-email-anisse@astier.eu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, stable@kernel.org

On Fri,  6 Aug 2010 18:40:18 +0200, Anisse Astier <anisse@astier.eu>
wrote :

> This machine has a BIOS that corrupts the DSDT, and adding
> acpi=copy_dsdt on cmdline fixes it. This feature and the corresponding
> blacklist was added in commit aa2110cb1a7510f9b834adfb39b05d4843a35d35
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/bus.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c1d23cd..fe7d7b9 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -99,6 +99,14 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
>  		},
>  	},
> +	{
> +	 .callback = set_copy_dsdt,
> +	 .ident = "TOSHIBA Satellite C650D",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite C650D"),
> +		},
> +	},
>  	{}
>  };
>  #else

Other users experiencing problems as reference:
https://bugs.launchpad.net/ubuntu/+bug/612341

Also, I'm cc-ing stable as it might interest Greg for 35.1 (not earlier
versions since the feature was added by Lin Ming in .35).

Regards,

--
Anisse
