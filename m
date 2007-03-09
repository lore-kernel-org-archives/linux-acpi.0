From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: ibm-acpi: improve backlight power handling
Date: Thu, 8 Mar 2007 20:25:26 -0500
Message-ID: <200703082025.26957.lenb@kernel.org>
References: <11733424952501-git-send-email-hmh@hmh.eng.br> <11733424953358-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41909 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965131AbXCIB0o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Mar 2007 20:26:44 -0500
In-Reply-To: <11733424953358-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Thursday 08 March 2007 03:28, Henrique de Moraes Holschuh wrote:
> Improve the backlight code to emulate as much as possible the power
> management events, as we are unable to really power on or power off the
> backlight.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Acked-by: Richard Purdie <rpurdie@rpsys.net>
> ---
>  drivers/acpi/ibm_acpi.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
> index 7c1b418..63d7a85 100644
> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -86,6 +86,7 @@
>  
>  #include <linux/proc_fs.h>
>  #include <linux/backlight.h>
> +#include <linux/fb.h>
>  #include <asm/uaccess.h>
>  
>  #include <linux/dmi.h>
> @@ -1701,7 +1702,10 @@ static int brightness_write(char *buf)
>  
>  static int brightness_update_status(struct backlight_device *bd)
>  {
> -	return brightness_set(bd->props.brightness);
> +	return brightness_set(
> +		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
> +		 bd->props.power == FB_BLANK_UNBLANK) ?
> +				bd->props.brightness : 0);
>  }
>  
>  static struct backlight_ops ibm_backlight_data = {
