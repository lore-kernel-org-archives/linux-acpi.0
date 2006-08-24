From: Len Brown <len.brown@intel.com>
Subject: Re: Fwd: [patch 01/14] asus_acpi: W3000 support
Date: Thu, 24 Aug 2006 01:05:53 -0400
Message-ID: <200608240105.53689.len.brown@intel.com>
References: <200608152311.30989.len.brown@intel.com> <20060820162507.GC7469@hell.org.pl>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51634 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030341AbWHXGlU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 02:41:20 -0400
In-Reply-To: <20060820162507.GC7469@hell.org.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, marekw1977@yahoo.com.au

Applied to acpi-test.

thanks,
-Len

On Sunday 20 August 2006 12:25, Karol Kozimor wrote:
> Thus wrote Len Brown:
> > Karol,
> > What shall we do with this?
> > 
> > If you want it applied, you can simply reply-all to akpm's e-mail and say "please apply".
> > If you want me to put it in the batch for 2.6.19, i can do that too.
> 
> 
> Hi,
> Sorry for the delay, I've been traveling for 2 weeks and will be for 2
> more. The patch *looks* OK, but I can't verify all the method nodes here.
> Please put it in the test tree, but don't apply to mainline yet, I'll try
> to verify this ASAP.
> 
> -- 
> Karol 'sziwan' Kozimor
> sziwan@hell.org.pl
> 
> --------------
> From: Marek W <marekw1977@yahoo.com.au>
> 
> Add support for W3000 (W3V) and indirectly fixes an issue with kmilo under KDE
> (it was triggering excessive LCD read error messages by querying asus_acpi
> module) allowing people (I am probably the only one who tested this) with
> W3000 to run kmilo.
> 
> Cc: Karol Kozimor <sziwan@hell.org.pl>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/asus_acpi.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/asus_acpi.c~asus_acpi-w3000-support drivers/acpi/asus_acpi.c
> --- a/drivers/acpi/asus_acpi.c~asus_acpi-w3000-support
> +++ a/drivers/acpi/asus_acpi.c
> @@ -138,6 +138,7 @@ struct asus_hotk {
>  		S2x,		//S200 (J1 reported), Victor MP-XP7210
>  		W1N,		//W1000N
>  		W5A,		//W5A
> +		W3V,            //W3030V
>  		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
>  		//(Centrino)
>  		END_MODEL
> @@ -376,6 +377,17 @@ static struct model_data model_conf[END_
>  	 .display_get = "\\ADVG"},
>  
>  	{
> +	 .name = "W3V",
> +	 .mt_mled = "MLED",
> +	 .mt_wled = "WLED",
> +	 .mt_lcd_switch = xxN_PREFIX "_Q10",
> +	 .lcd_status = "\\BKLT",
> +	 .brightness_set = "SPLV",
> +	 .brightness_get = "GPLV",
> +	 .display_set = "SDSP",
> +	 .display_get = "\\INFB"},
> +
> +       {
>  	 .name = "xxN",
>  	 .mt_mled = "MLED",
>  /* WLED present, but not controlled by ACPI */
> @@ -1097,6 +1109,8 @@ static int asus_model_match(char *model)
>  		return A4G;
>  	else if (strncmp(model, "W1N", 3) == 0)
>  		return W1N;
> +	else if (strncmp(model, "W3V", 3) == 0)
> +		return W3V;
>  	else if (strncmp(model, "W5A", 3) == 0)
>  		return W5A;
>  	else
> @@ -1200,9 +1214,10 @@ static int asus_hotk_get_info(void)
>  		hotk->methods->mt_wled = NULL;
>  	/* L5D's WLED is not controlled by ACPI */
>  	else if (strncmp(string, "M2N", 3) == 0 ||
> +		 strncmp(string, "W3V", 3) == 0 ||
>  		 strncmp(string, "S1N", 3) == 0)
>  		hotk->methods->mt_wled = "WLED";
> -	/* M2N and S1N have a usable WLED */
> +	/* M2N, S1N and W3V have a usable WLED */
>  	else if (asus_info) {
>  		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
>  			hotk->methods->mled_status = NULL;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
