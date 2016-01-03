From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: Add a quirk to force acpi-video backlight on SAMSUNG 530U4E/540U4E
Date: Sun, 03 Jan 2016 01:36:32 +0100
Message-ID: <4180407.AiXzEtroEP@vostro.rjw.lan>
References: <5683677C.1030407@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45309 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751047AbcACAFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jan 2016 19:05:55 -0500
In-Reply-To: <5683677C.1030407@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, adam bk <adamdd55@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>

On Wednesday, December 30, 2015 01:11:24 PM Aaron Lu wrote:
> The native interface on SAMSUNG 530U4E/540U4E doesn't work even though
> the firmware claims Win8 compatible while the acpi_video interface
> works, add a quirk for this.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=108971
> Reported-and-tested-by: adam bk <adamdd55@gmail.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Applied, thanks!

> ---
>  drivers/acpi/video_detect.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index daaf1c4e1e0f..518f9cdc929d 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -250,6 +250,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
>  		},
>  	},
> +	{
> +	 /* https://bugzilla.kernel.org/show_bug.cgi?id=108971 */
> +	 .callback = video_detect_force_video,
> +	 .ident = "SAMSUNG 530U4E/540U4E",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
> +		},
> +	},
>  
>  	/* Non win8 machines which need native backlight nevertheless */
>  	{
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
