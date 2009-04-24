From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: dmi check for broken _BQC on Acer Aspire 5720
Date: Fri, 24 Apr 2009 02:15:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904240212540.15843@localhost.localdomain>
References: <1240550980.7661.544.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:20044 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757768AbZDXGQi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 02:16:38 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIL00HHWDEP5VGA@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 24 Apr 2009 01:16:01 -0500 (CDT)
In-reply-to: <1240550980.7661.544.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, maximlevitsky@gmail.com


On Fri, 24 Apr 2009, Zhang Rui wrote:

> 
> On Acer Aspire 5720, _BQC always returns a value 9 smaller than
> the actual brightness level.
> Add dmi quirk for this laptop.
> http://bugzilla.kernel.org/show_bug.cgi?id=13121
> 
> Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -87,6 +87,8 @@ static const struct acpi_device_id video
>  };
>  MODULE_DEVICE_TABLE(acpi, video_device_ids);
>  
> +static int bqc_offset;
> +

are there other machines with a similar bqc_offset AML bug?

If no, then I'd rather this simple workaround be simpler
rather than be ready for a general case that will never happen...

in any case, the code/comments should be clear that
this is a hideoous workaround rather than how things
are supposed to work.  eg call it bqc_offset_idiotic_aml_workaround or 
something..

thanks,
-Len Brown, Intel Open Source Technology Center

>  static struct acpi_driver acpi_video_bus = {
>  	.name = "video",
>  	.class = ACPI_VIDEO_CLASS,
> @@ -556,7 +558,8 @@ acpi_video_device_lcd_get_level_current(
>  								 - 3 - (*level);
>  				*level = device->brightness->levels[*level + 2];
>  
> -			}
> +			} else if (bqc_offset)
> +				*level += bqc_offset;
>  			device->brightness->curr = *level;
>  			return 0;
>  		} else {
> @@ -698,6 +701,29 @@ acpi_video_bus_DOS(struct acpi_video_bus
>  	return status;
>  }
>  
> +static int video_bqc_offset(const struct dmi_system_id *d)
> +{
> +	bqc_offset = 9;
> +	return 0;
> +}
> +
> +static struct dmi_system_id video_dmi_table[] __initdata = {
> +	/*
> +	 * Acer Aspire 5720 _BQC method is broken,
> +	 * it always returns a value smaller than the actual brightness level
> +	 * http://bugzilla.kernel.org/show_bug.cgi?id=13121
> +	 */
> +	{
> +	 .callback = video_bqc_offset,
> +	 .ident = "Acer Aspire 5720",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
> +		},
> +	},
> +	{}
> +};
> +
>  /*
>   * Simple comparison function used to sort backlight levels.
>   */
> @@ -2287,6 +2313,8 @@ EXPORT_SYMBOL(acpi_video_register);
>  
>  static int __init acpi_video_init(void)
>  {
> +	dmi_check_system(video_dmi_table);
> +
>  	if (intel_opregion_present())
>  		return 0;
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
