From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi/video: lcd_get_level_current doen't return current level
Date: Sun, 31 Mar 2013 03:56:50 +0200
Message-ID: <5996696.NNHVTCA6T8@vostro.rjw.lan>
References: <1364648501-5127-1-git-send-email-artem.savkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48245 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab3CaBtS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Mar 2013 21:49:18 -0400
In-Reply-To: <1364648501-5127-1-git-send-email-artem.savkov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artem Savkov <artem.savkov@gmail.com>
Cc: dannybaumann@web.de, aaron.lu@intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, March 30, 2013 05:01:41 PM Artem Savkov wrote:
> acpi_video_device_lcd_get_level_current() called acpi_video_bqc_value_to_level()
> with "*level" as a second argument, resulting in level being returned based on
> initial input, not current brightness, breaking backlight controls.

This looks like a valid fix, but (1) is the problem being fixed a regression
and if so, which was the last working kernel and (2) do you have any pointers
to bug reports/BZ entries related to that?

Also, do I assume correctly that you've tested it?

Rafael


> Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
> ---
>  drivers/acpi/video.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 3cdd047..68a777b 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -505,7 +505,8 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>  				return 0;
>  			}
>  
> -			*level = acpi_video_bqc_value_to_level(device, *level);
> +			*level = acpi_video_bqc_value_to_level(device,
> +					device->brightness->curr);
>  
>  			for (i = 2; i < device->brightness->count; i++)
>  				if (device->brightness->levels[i] == *level) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
