From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: video: Ignore BIOS initial backlight value for
 HP 250 G1
Date: Mon, 28 Oct 2013 11:24:33 +0800
Message-ID: <526DD8F1.9040801@intel.com>
References: <100851382097404@web21g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36168 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754935Ab3J1DX5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Oct 2013 23:23:57 -0400
In-Reply-To: <100851382097404@web21g.yandex.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kirill Tkhai <tkhai@yandex.ru>, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, Jani Nikula <jani.nikula@linux.intel.com>

On 10/18/2013 07:56 PM, Kirill Tkhai wrote:
> On HP 250 G1 laptops, BIOS reports minimum backlight on boot and
> causes backlight to dim completely. This ignores the initial backlight
> values and set to max brightness.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=63111

According to the acpidump:

The ASL code initialize initial brightness level to 100, but only for OS
that is pre-vista. Don't know why it does this...

Method (_INI, 0, NotSerialized)  // _INI: Initialize
{
	If (LLess (OSYS, 0x07D6))
	{
		Store (0x64, BRTL)
	}
	... ...
}

Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
{
	Return (BRTL)
}

Since it is not initialized in _INI(as we report to firmware we are
'Windows 2012'), the video module was told by _BQC the initial brightness
level is 0 and then set backlight level to 0 and leads to a black screen
after boot up.

> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

The patch looks good to me.
Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 3270d3c..6456466 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -490,6 +490,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
>  		},
>  	},
> +	{
> +	 .callback = video_ignore_initial_backlight,
> +	 .ident = "HP 250 G1",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G1 Notebook PC"),
> +		},
> +	},
>  	{}
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

