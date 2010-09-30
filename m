From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] ACPI: invoke DSDT corruption workaround on all Toshiba
 Satellite
Date: Thu, 30 Sep 2010 15:27:45 +0200
Message-ID: <20100930152745.6468ae8c@destiny.ordissimo>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
	<b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
	<20100929115108.1c596067@destiny.ordissimo>
	<alpine.LFD.2.00.1009291429090.21034@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59170 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab0I3N2u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Sep 2010 09:28:50 -0400
Received: by wwi14 with SMTP id 14so288218wwi.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2010 06:28:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009291429090.21034@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Frank <frank@61924.nl>, joe@neoturbine.net, linux-acpi@vger.kernel.org

On Wed, 29 Sep 2010 14:32:29 -0400 (EDT), Len Brown <lenb@kernel.org>
wrote :

> From: Len Brown <len.brown@intel.com>
> 
> Our list of Toshiba Satellite models that require this workaround
> is growing -- so invoke the workaround for the entire product line.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=14679
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> 
> Please test this patch.
> thanks,
> -Len
> 
>  drivers/acpi/bus.c |   14 +++-----------
>  1 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 5c221ab..a70ca8e 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -80,23 +80,15 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>  
>  static struct dmi_system_id dsdt_dmi_table[] __initdata = {
>  	/*
> -	 * Insyde BIOS on some TOSHIBA machines corrupt the DSDT.
> +	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
>  	 */
>  	{
>  	 .callback = set_copy_dsdt,
> -	 .ident = "TOSHIBA Satellite A505",
> +	 .ident = "TOSHIBA Satellite",
>  	 .matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A505"),
> -		},
> -	},
> -	{
> -	 .callback = set_copy_dsdt,
> -	 .ident = "TOSHIBA Satellite L505D",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
Isn't that a bit too broad? Maybe we should keep "TOSHIBA" in case
another vendor decides to add "Satellite" in its DMI product name.

> -		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite"),
>  		},
>  	},
>  	{}

Anyway, this works well on Toshiba Satellite C650D.

Tested-by: Anisse Astier <anisse@astier.eu>
