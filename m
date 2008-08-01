From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 10/10] thinkpad_acpi: fingers off backlight if video.ko
	is serving this functionality
Date: Fri, 1 Aug 2008 14:50:33 -0300
Message-ID: <20080801175033.GE14352@khazad-dum.debian.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217605083-31003-11-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52157 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757054AbYHARuj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 13:50:39 -0400
Content-Disposition: inline
In-Reply-To: <1217605083-31003-11-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Fri, 01 Aug 2008, Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/misc/thinkpad_acpi.c |   31 ++++++++++++++++++++-----------
>  1 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index d3eb790..a71ecd2 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -4922,17 +4922,26 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
>  	 */
>  	b = tpacpi_check_std_acpi_brightness_support();
>  	if (b > 0) {
> -		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
> -			printk(TPACPI_NOTICE
> -			       "Lenovo BIOS switched to ACPI backlight "
> -			       "control mode\n");
> -		}
> -		if (brightness_enable > 1) {
> -			printk(TPACPI_NOTICE
> -			       "standard ACPI backlight interface "
> -			       "available, not loading native one...\n");
> -			return 1;
> -		}
> +
> +		if (acpi_video_backlight_support()) {
> +			if (brightness_enable > 1) {
> +				printk(TPACPI_NOTICE
> +				       "Standard ACPI backlight interface "
> +				       "available, not loading native one.\n");
> +				return 1;
> +			} else if (brightness_enable == 1) {
> +				printk(TPACPI_NOTICE
> +				       "Backlight control force, even standard "
> +				       "ACPI backlight interface available\n");
> +			}

EPARSE.  "Backlight control force, even standard ACPI backlight interface
available" is no good.  Maybe you want to change that to "Backlight control
force enabled, even if standard ACPI backlight interface is available" ?

> +		} else {
> +			if (brightness_enable > 1) {
> +				printk(TPACPI_NOTICE
> +				       "Standard ACPI backlight interface not "
> +				       "available, thinkpad_acpi driver "
> +				       "will take over control\n");

"thinkpad-acpi native brightness control enabled", perhaps?

> +			}
> + 		}
>  	}
>  
>  	if (!brightness_enable) {

Provided that you clarify the printk I marked with EPARSE:
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
