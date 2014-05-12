From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi-video: Add use native backlight quirk for the ThinkPad
 W530
Date: Mon, 12 May 2014 16:16:58 +0800
Message-ID: <5370837A.5070708@intel.com>
References: <1399881432-26124-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61649 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbaELIRD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 May 2014 04:17:03 -0400
In-Reply-To: <1399881432-26124-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org

On 05/12/2014 03:57 PM, Hans de Goede wrote:
> Like all of the other *30 ThinkPad models, the W530 has a broken acpi-video
> backlight control. Note in order for this to actually fix things on the
> ThinkPad W530 the commit titled:
> "nouveau: Don't check acpi_video_backlight_support() before registering backlight"
> is also needed.

Note that the backlight_device_registered(raw) may return false as when
acpi_video_verify_backlight_support is called, the nouveau driver may
not run yet.

Previously, we don't know anything about how laptops with nvidia graphics
card alone control backlight in Win8, so the existing solution doesn't
consider this case. If nvidia graphics system also should favour native
backlight control interface in Win8, the current solution needs
modifications.

Thanks,
Aaron

> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1093171
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 34198b2..6a2099d 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -520,6 +520,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		},
>  	},
>  	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "ThinkPad W530",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
> +		},
> +	},
> +	{
>  	.callback = video_set_use_native_backlight,
>  	.ident = "ThinkPad X1 Carbon",
>  	.matches = {
> 

