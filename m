From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 03/10] Acer-WMI: fingers off backlight if video.ko is serving this functionality
Date: Fri, 1 Aug 2008 22:52:00 +0100
Message-ID: <200808012252.01602.carlos@strangeworlds.co.uk>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217605083-31003-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:33189 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYHAVwU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 17:52:20 -0400
In-Reply-To: <1217605083-31003-4-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Friday 01 August 2008 16:37:56 Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>

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
