From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / video: Disable native backlight on Samsung Series 9 laptops
Date: Wed, 18 Feb 2015 07:17:38 +0100
Message-ID: <1668253.lH3vbgZ7Zy@vostro.rjw.lan>
References: <20150216052443.GA11266@aaronlu.sh.intel.com> <1424196449-21813-1-git-send-email-jens.reyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63258 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751137AbbBRFyZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Feb 2015 00:54:25 -0500
In-Reply-To: <1424196449-21813-1-git-send-email-jens.reyer@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Reyer <jens.reyer@gmail.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Tuesday, February 17, 2015 07:07:29 PM Jens Reyer wrote:
> Add video_disable_native_backlight quirk for SAMSUNG 900X3C/900X3D/
> 900X3E/900X4C/900X4D laptops.
> 
> The native intel backlight controls do not work correctly on SAMSUNG
> Series 9 (900X3C/900X3D/900X3E/900X4C/900X4D) laptops:
> One machine has an completely dimmed (= black) display after boot at the
> GDM login screen and brightness controls work only between 0 and 5%
> (= no effect).
> Another machine has the same brightness control issues if an external
> HDMI monitor is or gets connected, although the initial brightness is
> ok.
> After login to Gnome both machines always work fine.
> 
> Tested on both machines.
> 
> Bug-Link: https://bugs.freedesktop.org/show_bug.cgi?id=87286
> Bug-Link: https://bugs.debian.org/772440
> Signed-off-by: Jens Reyer <jens.reyer@gmail.com>

Applied, thanks!

> ---
>  drivers/acpi/video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 88a4f99..debd309 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -540,6 +540,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
>  		},
>  	},
> +	{
> +	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "900X3C/900X3D/900X3E/900X4C/900X4D"),
> +		},
> +	},
>  
>  	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
