From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 26/41] ACPI: video: Fix null pointer in appledisplay driver
Date: Tue, 13 Feb 2007 01:53:37 -0500
Message-ID: <200702130153.37770.lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47173 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbXBMGxw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 01:53:52 -0500
In-Reply-To: <11713458163685-git-send-email-lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>

On Tuesday 13 February 2007 00:49, Len Brown wrote:
> From: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> commit "ACPI: video: Add dev argument for backlight_device_register"
> 519ab5f2be65b72cf12ae99c89752bbe79b44df6
> broke the apple display driver.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/usb/misc/appledisplay.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
> index a7932a7..31ab83c 100644
> --- a/drivers/usb/misc/appledisplay.c
> +++ b/drivers/usb/misc/appledisplay.c
> @@ -281,7 +281,7 @@ static int appledisplay_probe(struct usb_interface *iface,
>  	/* Register backlight device */
>  	snprintf(bl_name, sizeof(bl_name), "appledisplay%d",
>  		atomic_inc_return(&count_displays) - 1);
> -	pdata->bd = backlight_device_register(bl_name, NULL, NULL,
> +	pdata->bd = backlight_device_register(bl_name, NULL, pdata
>  						&appledisplay_bl_data);
>  	if (IS_ERR(pdata->bd)) {
>  		err("appledisplay: Backlight registration failed");

huh, this version of the patch is missing a comma.
anyway, it is fixed now.

cheers,
-Len
