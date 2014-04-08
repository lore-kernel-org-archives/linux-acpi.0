From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] Favor native backlight interface for ThinkPad Helix
Date: Tue, 08 Apr 2014 10:49:17 +0800
Message-ID: <534363AD.9070401@intel.com>
References: <1396622686-6373-1-git-send-email-thatslyude@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37222 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbaDHCsp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 22:48:45 -0400
In-Reply-To: <1396622686-6373-1-git-send-email-thatslyude@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Chandler Paul <thatslyude@gmail.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shawn Rutledge <shawn.t.rutledge@gmail.com>

On 04/04/2014 10:44 PM, Stephen Chandler Paul wrote:
> Like many other Windows 8 laptops the ThinkPad Helix's backlight has a
> broken ACPI interface and can only be properly adjusted by using the
> video card's native backlight control. This adds the ThinkPad Helix to
> the list of laptops affected with this issue so that
> video.use_native_backlight is enabled by default.

It would be good to attach your acpidump so that we know for sure and if
one day we need to remove this entry, we can verify its table.

Bug 51231 is tracking this problem and mostly are thinkpad laptops, so
please attach your acpidump and dmi there, thanks.
https://bugzilla.kernel.org/show_bug.cgi?id=51231

-Aaron

> 
> Signed-off-by: Stephen Chandler Paul <thatslyude@gmail.com>
> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 48c7e8a..8b6990e 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -488,6 +488,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		},
>  	},
>  	{
> +	.callback = video_set_use_native_backlight,
> +	.ident = "Thinkpad Helix",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_Vhttps://bugzilla.kernel.org/show_bug.cgi?id=51231ENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Helix"),
> +		},
> +	},
> +	{
>  	 .callback = video_set_use_native_backlight,
>  	 .ident = "Dell Inspiron 7520",
>  	 .matches = {
> 

