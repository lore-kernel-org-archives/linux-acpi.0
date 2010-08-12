From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: Add Toshiba Satellite C650D to DMI blacklist for
 corrupting DSDT
Date: Thu, 12 Aug 2010 08:29:59 +0800
Message-ID: <1281572999.2372.23.camel@minggr.sh.intel.com>
References: <1281112818-19388-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15235 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759336Ab0HLAaE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Aug 2010 20:30:04 -0400
In-Reply-To: <1281112818-19388-1-git-send-email-anisse@astier.eu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sat, 2010-08-07 at 00:40 +0800, Anisse Astier wrote:
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

Acked-by: Lin Ming <ming.m.lin@intel.com>

Len, could you please apply this patch?

Thanks,
Lin Ming

