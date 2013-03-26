From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI video: ignore BIOS backlight value for HP dm4
Date: Tue, 26 Mar 2013 14:09:42 +0100
Message-ID: <5078928.eqOt3FVRJ4@vostro.rjw.lan>
References: <1362410617.2761.30.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42918 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757947Ab3CZNCQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:02:16 -0400
In-Reply-To: <1362410617.2761.30.camel@oberon.sagui.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday, March 04, 2013 12:23:37 PM Gustavo Maciel Dias Vieira wrote:
> 
> On a HP Pavilion dm4 laptop the BIOS sets minimum backlight on boot,
> completely dimming the screen. Ignore this initial value for this
> machine.
> 
> Signed-off-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
> ---
> 
> This is the same situation as with the HP Folio
> (http://www.spinics.net/lists/linux-acpi/msg40401.html).
> 
> Without this patch, the only way to get a correct display is with the
> video.use_bios_initial_backlight=0 command line switch. With it the
> display works out of the box.

Applied to linux-pm.git/linux-next.

Thanks,
Rafael


>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index ac9a69c..d7329bc 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -447,6 +447,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13 - 2000 Notebook PC"),
>  		},
>  	},
> +	{
> +	 .callback = video_ignore_initial_backlight,
> +	 .ident = "HP Pavilion dm4",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
> +		},
> +	},
>  	{}
>  };
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
