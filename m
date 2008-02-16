From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acer-wmi - Add DMI match for mail LED on Acer TravelMate 4200 series
Date: Sat, 16 Feb 2008 00:47:41 -0500
Message-ID: <200802160047.41801.lenb@kernel.org>
References: <20080216000256.1725.83948.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53664 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbYBPFr6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Feb 2008 00:47:58 -0500
In-Reply-To: <20080216000256.1725.83948.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

applied

thanks,
-len

On Friday 15 February 2008 19:02, Carlos Corbacho wrote:
> The TM4200 series use the same method as the TM2490 series to control the
> mail LED, so add a DMI based quirk for these laptops.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> CC: Len Brown <lenb@kernel.org>
> ---
> 
>  drivers/misc/acer-wmi.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
> index d7aea93..74d12b4 100644
> --- a/drivers/misc/acer-wmi.c
> +++ b/drivers/misc/acer-wmi.c
> @@ -273,6 +273,15 @@ static struct dmi_system_id acer_quirks[] = {
>  	},
>  	{
>  		.callback = dmi_matched,
> +		.ident = "Acer TravelMate 4200",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4200"),
> +		},
> +		.driver_data = &quirk_acer_travelmate_2490,
> +	},
> +	{
> +		.callback = dmi_matched,
>  		.ident = "Medion MD 98300",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
