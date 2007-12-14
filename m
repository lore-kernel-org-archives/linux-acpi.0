From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] ACPI: thinkpad-acpi: fix lenovo keymap for brightness
Date: Thu, 13 Dec 2007 22:04:17 -0500
Message-ID: <200712132204.17820.lenb@kernel.org>
References: <1197555249-8520-1-git-send-email-hmh@hmh.eng.br> <1197555249-8520-2-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47209 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755905AbXLNDEe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 22:04:34 -0500
In-Reply-To: <1197555249-8520-2-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Applied.

thanks,
-Len

On Thursday 13 December 2007 09:14, Henrique de Moraes Holschuh wrote:
> Several reports from X60 users complained that the default Lenovo keymap
> issuing EV_KEY KEY_BRIGHTNESS_UP/DOWN input events caused major issues when
> the proper brightness support through ACPI video.c was loaded.
> 
> Therefore, remove the generation of these events by default, which is the
> right thing for T60, X60, R60, T61, X61 and R61 with their latest BIOSes.
> 
> Distros that want to misuse these events into OSD reporting (which requires
> an ugly hack from hell in HAL) are welcome to set up the key map they need
> through HAL.  That way, we don't break everyone else's systems.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/misc/thinkpad_acpi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index ab23a32..cf56647 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -987,9 +987,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
>  		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
>  		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
> -		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
> +		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
>  		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> -		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
> +		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
>  		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
>  		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
>  		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
