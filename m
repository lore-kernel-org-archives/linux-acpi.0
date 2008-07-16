From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 03/11] Acer-WMI: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 18:42:48 +0100
Message-ID: <200807161842.50160.carlos@strangeworlds.co.uk>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:54637 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYGPSLP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 14:11:15 -0400
In-Reply-To: <1216205553-8486-4-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, malattia@linux.it

On Wednesday 16 July 2008 11:52:25 Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

> ---
>  drivers/misc/acer-wmi.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
> index e7a3fe5..a843ac2 100644
> --- a/drivers/misc/acer-wmi.c
> +++ b/drivers/misc/acer-wmi.c
> @@ -1218,6 +1218,12 @@ static int __init acer_wmi_init(void)
>  		return -ENODEV;
>  	}
>
> +	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
> +		interface->capability &= ~ACER_CAP_BRIGHTNESS;
> +		printk(ACER_INFO "Brightness must be controlled by "
> +		       "generic video driver\n");
> +	}
> +
>  	if (platform_driver_register(&acer_platform_driver)) {
>  		printk(ACER_ERR "Unable to register platform driver.\n");
>  		goto error_platform_register;



-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
