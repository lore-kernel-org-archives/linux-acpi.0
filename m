From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/7] device core: add BUS_NOTIFY_BIND_DRIVER_ERROR notification
Date: Fri, 27 Nov 2015 00:09:09 +0100
Message-ID: <10826039.DB5kcb9LL1@vostro.rjw.lan>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com> <1448551153-84719-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56726 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752893AbbKZWj1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2015 17:39:27 -0500
In-Reply-To: <1448551153-84719-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thursday, November 26, 2015 05:19:07 PM Andy Shevchenko wrote:
> In case ->probe() fails the notifier does not inform a subscriber about this.
> In the result it might happend that some resources that had been allocated will
> stay allocated and therefore lead to resource leak.
> 
> Introduce a new notification to inform the subscriber that ->probe() failed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'd rather say the problem is that the users of BUS_NOTIFY_BIND_DRIVER have no
chance to do any cleanup in case of a probe failure (there may be problems even
if resources aren't leaked).

> ---
>  drivers/base/dd.c      | 8 ++++++--
>  include/linux/device.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a641cf3..ac071a5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -290,7 +290,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	/* If using pinctrl, bind pins now before probing */
>  	ret = pinctrl_bind_pins(dev);
>  	if (ret)
> -		goto probe_failed;
> +		goto pinctrl_bind_failed;
>  
>  	if (driver_sysfs_add(dev)) {
>  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> @@ -334,6 +334,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	goto done;
>  
>  probe_failed:
> +	if (dev->bus)
> +		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> +					     BUS_NOTIFY_BIND_DRIVER_ERROR,
> +					     dev);

Well, if we do that, device_bind_driver() needs to send that notification too
in case it doesn't call driver_bound().

> +pinctrl_bind_failed:
>  	devres_release_all(dev);
>  	driver_sysfs_remove(dev);
>  	dev->driver = NULL;
> @@ -701,7 +706,6 @@ static void __device_release_driver(struct device *dev)
>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  						     BUS_NOTIFY_UNBOUND_DRIVER,
>  						     dev);
> -
>  	}
>  }
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b8f411b..87cf423 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -191,6 +191,7 @@ extern int bus_unregister_notifier(struct bus_type *bus,
>  						      unbound */
>  #define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
>  						      from the device */
> +#define BUS_NOTIFY_BIND_DRIVER_ERROR	0x80000004 /* driver fails to be bound */

I'd call it BUS_NOTIFY_DRIVER_NOT_BOUND.

>  
>  extern struct kset *bus_get_kset(struct bus_type *bus);
>  extern struct klist *bus_get_device_klist(struct bus_type *bus);
> 

Thanks,
Rafael

