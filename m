From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: ibm-acpi: fix initial status of backlight device
Date: Thu, 8 Mar 2007 20:23:31 -0500
Message-ID: <200703082023.31839.lenb@kernel.org>
References: <11733424952501-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48012 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965030AbXCIBXi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Mar 2007 20:23:38 -0500
In-Reply-To: <11733424952501-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

we checked this in already back on 2/22
it is on the ibm branch that i'll included in the next 2.6.21 pull request.

thanks,
-Len

On Thursday 08 March 2007 03:28, Henrique de Moraes Holschuh wrote:
> The brightness class core does not update the initial status of the
> device's brightness at register time.  Do it by ourselves.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Acked-by: Richard Purdie <rpurdie@rpsys.net>
> ---
>  drivers/acpi/ibm_acpi.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
> index 4cc534e..7c1b418 100644
> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -1711,6 +1711,12 @@ static struct backlight_ops ibm_backlight_data = {
>  
>  static int brightness_init(void)
>  {
> +	int b;
> +
> +	b = brightness_get(NULL);
> +	if (b < 0)
> +		return b;
> +
>  	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
>  							 &ibm_backlight_data);
>  	if (IS_ERR(ibm_backlight_device)) {
> @@ -1718,7 +1724,9 @@ static int brightness_init(void)
>  		return PTR_ERR(ibm_backlight_device);
>  	}
>  
> -        ibm_backlight_device->props.max_brightness = 7;
> +	ibm_backlight_device->props.max_brightness = 7;
> +	ibm_backlight_device->props.brightness = b;
> +	backlight_update_status(ibm_backlight_device);
>  
>  	return 0;
>  }
