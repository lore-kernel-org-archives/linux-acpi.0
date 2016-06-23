From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Patch Thinkpad X201T backlight
Date: Thu, 23 Jun 2016 02:31:39 +0200
Message-ID: <8297817.bTGtEBi67U@vostro.rjw.lan>
References: <8737p8aq7k.fsf@quengel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55076 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750876AbcFWA1U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 20:27:20 -0400
In-Reply-To: <8737p8aq7k.fsf@quengel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ralf Gerbig <rge@quengel.org>
Cc: linux-acpi@vger.kernel.org

On Sunday, May 22, 2016 07:23:59 PM Ralf Gerbig wrote:
> Hi,
> 
> the X201 Tablet needs the same treatmant as the X201s,
> otherwise you can't change levels.
> 
> The patch is against 4.5.5 stable, but should apply to all recent
> kernels.
> 
> Please be gentle, I am neither a programmer nor a developer.
> 
> If you have questions, feel free to ask, but don't expect an answer in
> the next 10 to 20 days (going to hospital).
> 
> Regards,
> 
> Ralf Gerbig
> 
> ---
> commit a10b5a05eae1a990682ce238b8e0ac6ad791a8a9
> Author: Ralf Gerbig <rge@quengel.org>
> Date:   Sun May 22 18:56:22 2016 +0200
> 
>     The Thinkpad X201 Tablet also needs video_detect_force_video
>     
>     Signed-off-by: Ralf Gerbig <rge@quengel.org>
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 1316ddd..d8d7bd3 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -167,6 +167,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
>  		},
>  	},
> +        {
> +         .callback = video_detect_force_video,
> +         .ident = "ThinkPad X201T",
> +         .matches = {
> +                DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
> +                },
> +        },
>  
>  	/* The native backlight controls do not work on some older machines */
>  	{

Patch applied, thanks!

