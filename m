From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / video: Fix initial level validity test
Date: Wed, 06 Nov 2013 23:03:40 +0100
Message-ID: <3791074.PzqEb6VMU7@vostro.rjw.lan>
References: <52799553.7020406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54056 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756411Ab3KFVvV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2013 16:51:21 -0500
In-Reply-To: <52799553.7020406@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Danny Baumann <dannybaumann@web.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Wednesday, November 06, 2013 09:03:15 AM Aaron Lu wrote:
> When testing if the firmware's initial value is valid, we should use
> the corrected level value instead of the raw value returned from
> firmware.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Cc: Danny Baumann <dannybaumann@web.de>
> Cc: stable <stable@kernel.org>

Any pointers to bug reports, BZ entries, etc?

> ---
>  drivers/acpi/video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 38c3a28d6392..bf521b36c2f9 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -856,7 +856,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  		 * or an index). Set the backlight to max_level in this case.
>  		 */
>  		for (i = 2; i < br->count; i++)
> -			if (level_old == br->levels[i])
> +			if (level == br->levels[i])
>  				break;
>  		if (i == br->count)
>  			level = max_level;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
