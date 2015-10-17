From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 13/20] usb: phy: Probe phy devices on demand
Date: Fri, 16 Oct 2015 23:55:52 -0700
Message-ID: <20151017065552.GC18329@kroah.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443517859-30376-14-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33017 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbJQGzx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Oct 2015 02:55:53 -0400
Content-Disposition: inline
In-Reply-To: <1443517859-30376-14-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, Sep 29, 2015 at 11:10:51AM +0200, Tomeu Vizoso wrote:
> When looking up a phy through its OF node, probe it if it hasn't
> already.
> 
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> 
>  drivers/usb/phy/phy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> index 98f75d2842b7..fb0b650bb494 100644
> --- a/drivers/usb/phy/phy.c
> +++ b/drivers/usb/phy/phy.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/usb/phy.h>
>  
> @@ -196,6 +197,8 @@ struct  usb_phy *devm_usb_get_phy_by_node(struct device *dev,
>  		goto err0;
>  	}
>  
> +	of_device_probe(node);

Ugh, this "sprinkling" of calls all over different subsystems like this
isn't ok.  Why is of just so broken that it has to do crap like this?

I really don't like this solution / series at all, sorry.  We have
deferred probing, if you need stuff like that (where the dependancy tree
isn't in order), how slow is that really?  What is taking your hardware
so long to init that warrents this being spread all across the tree?

thanks,

greg k-h
