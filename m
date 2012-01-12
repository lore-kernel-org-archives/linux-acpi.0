From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC] ARM: imx: Add imx6q thermal
Date: Thu, 12 Jan 2012 10:36:18 +0100
Message-ID: <20120112093618.GB5446@pengutronix.de>
References: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33484 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2ALJgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jan 2012 04:36:35 -0500
Content-Disposition: inline
In-Reply-To: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: linux@arm.linux.org.uk, shawn.guo@freescale.com, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, Jan 11, 2012 at 01:18:05AM -0600, Robert Lee wrote:
> Add thermal support for i.MX6Q.  Uses recently submitted common
> cpu_cooling functionality shown here:
> 
> http://www.spinics.net/lists/linux-pm/msg26500.html
> 
> Have some todo items but basic implementation is done and I'd like to
> get any helpful feedback on it.

Generally shouldn't this be a regular driver?


> +
> +/* register define of anatop */
> +#define HW_ANADIG_ANA_MISC0	(0x00000150)
> +#define HW_ANADIG_ANA_MISC0_SET	(0x00000154)
> +#define HW_ANADIG_ANA_MISC0_CLR	(0x00000158)
> +#define HW_ANADIG_ANA_MISC0_TOG	(0x0000015c)

unnecessary braces. Please remove.

> +
> +#if IMX6Q_THERMAL_DEBUG
> +	pr_info("Temperature is %lu C\n", *temp);
> +#endif

Please don't add your own debug defines which then issue
messages with pr_info. Use pr_debug in the first place.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
