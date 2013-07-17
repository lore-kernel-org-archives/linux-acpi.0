From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Fix PATCH] ACPI / video: ignore BIOS initial backlight value for Fujitsu E753
Date: Thu, 18 Jul 2013 00:35 +0200
Message-ID: <5965989.OyGfl3xY1D@vostro.rjw.lan>
References: <1373940441-21875-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47726 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995Ab3GQWZF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jul 2013 18:25:05 -0400
In-Reply-To: <1373940441-21875-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 16, 2013 10:07:21 AM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> The BIOS of FUjitsu E753 reports an incorrect initial backlight value
> for WIN8 compatible OS, causing backlight dark during startup. This
> patch ignores the incorrect initial value from BIOS.
> 
> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=60161
> Reported-and-tested-by: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Queued up as a fix for 3.11.

What's the oldest mainline kernel release this patch is applicable to?

Rafael


> ---
>  drivers/acpi/video.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 5d7075d..e441876 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -450,6 +450,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	 .callback = video_ignore_initial_backlight,
> +	 .ident = "Fujitsu E753",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "FUJITSU"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E753"),
> +		},
> +	},
> +	{
> +	 .callback = video_ignore_initial_backlight,
>  	 .ident = "HP Pavilion dm4",
>  	 .matches = {
>  		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
