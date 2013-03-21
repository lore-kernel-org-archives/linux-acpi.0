From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH] dummy-irq: introduce a dummy IRQ handler driver (was Re:
 gm45 intel gfx can generate non-MSI irq# in MSI mode (was Re: [PATCH]
 drm/i915: stop using GMBUS IRQs on Gen4 chips (was Re: [3.9-rc1] irq 16:
 nobody cared (was [3.9-rc1] very poor interrupt respo))
Date: Thu, 21 Mar 2013 15:45:26 +0100
Message-ID: <20130321144526.GR9021@phenom.ffwll.local>
References: <Pine.LNX.4.44L0.1303201319190.1208-100000@iolanthe.rowland.org>
 <alpine.LNX.2.00.1303210018430.16237@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1303210018430.16237-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Harald Arnesen <skogtun.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Arkadiusz Miskiewicz <a.miskiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 21, 2013 at 12:21:21AM +0100, Jiri Kosina wrote:
> On Wed, 20 Mar 2013, Alan Stern wrote:
> 
> > > Ok, so how about this?
> > > Daniel, is it enough to make the problem appear on your system (by 
> > > building this into the kernel and booting with dummy-irq.irq=16)?
> > > 
> > > Thanks.
> > > 
> > > From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> > > Subject: [PATCH] dummy-irq: introduce a dummy IRQ handler driver
> > > 
> > > This module accepts a single 'irq' parameter, which it should register for.
> > > 
> > > Its sole purpose is to help with debugging of IRQ sharing problems, by
> > > force-enabling IRQ that would otherwise be disabled.
> > > 
> > > Suggested-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> > > Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> > 
> > This is just what I was thinking of.  Three extremely minor 
> > suggestions...
> 
> Thanks Alan. Updated version below.
> 
> Greg, willing to merge this simple debugging facility?
> 
> 
> From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> Subject: [PATCH] dummy-irq: introduce a dummy IRQ handler driver
> 
> This module accepts a single 'irq' parameter, which it should register for.
> 
> Its sole purpose is to help with debugging of IRQ sharing problems, by
> force-enabling IRQ that would otherwise be disabled.
> 
> Suggested-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

Indeed, this is pretty useful and allowed me to quickly reproduce that
phantom irq on my gm45. Thanks to module reloading we can even reset the
kernel's irq disabling logic and so test different tricks quickly without
rebooting. Really useful.

Acked-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>

Thanks, Daniel

> ---
>  drivers/misc/Kconfig     |    8 ++++++
>  drivers/misc/Makefile    |    1 +
>  drivers/misc/dummy-irq.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/dummy-irq.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e83fdfe..69bb79d 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -93,6 +93,14 @@ config ATMEL_TCB_CLKSRC_BLOCK
>  	  TC can be used for other purposes, such as PWM generation and
>  	  interval timing.
>  
> +config DUMMY_IRQ
> +	tristate "Dummy IRQ handler"
> +	default n
> +	---help---
> +	  This module accepts a single 'irq' parameter, which it should register for.
> +	  The sole purpose of this module is to help with debugging of systems on
> +	  which spurious IRQs would happen on disabled IRQ vector.
> +
>  config IBM_ASM
>  	tristate "Device driver for IBM RSA service processor"
>  	depends on X86 && PCI && INPUT
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 35a1463..28ff261 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
>  obj-$(CONFIG_BMP085)		+= bmp085.o
>  obj-$(CONFIG_BMP085_I2C)	+= bmp085-i2c.o
>  obj-$(CONFIG_BMP085_SPI)	+= bmp085-spi.o
> +obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
>  obj-$(CONFIG_ICS932S401)	+= ics932s401.o
>  obj-$(CONFIG_LKDTM)		+= lkdtm.o
>  obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
> diff --git a/drivers/misc/dummy-irq.c b/drivers/misc/dummy-irq.c
> new file mode 100644
> index 0000000..7014167
> --- /dev/null
> +++ b/drivers/misc/dummy-irq.c
> @@ -0,0 +1,59 @@
> +/*
> + * Dummy IRQ handler driver.
> + *
> + * This module only registers itself as a handler that is specified to it
> + * by the 'irq' parameter.
> + *
> + * The sole purpose of this module is to help with debugging of systems on
> + * which spurious IRQs would happen on disabled IRQ vector.
> + *
> + * Copyright (C) 2013 Jiri Kosina
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +static int irq;
> +
> +static irqreturn_t dummy_interrupt(int irq, void *dev_id)
> +{
> +	static int count = 0;
> +
> +	if (count == 0) {
> +		printk(KERN_INFO "dummy-irq: interrupt occured on IRQ %d\n",
> +				irq);
> +		count++;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int __init dummy_irq_init(void)
> +{
> +	if (request_irq(irq, &dummy_interrupt, IRQF_SHARED, "dummy_irq", &irq)) {
> +		printk(KERN_ERR "dummy-irq: cannot register IRQ %d\n", irq);
> +		return -EIO;
> +	}
> +	printk(KERN_INFO "dummy-irq: registered for IRQ %d\n", irq);
> +	return 0;
> +}
> +
> +static void __exit dummy_irq_exit(void)
> +{
> +	printk(KERN_INFO "dummy-irq unloaded\n");
> +	free_irq(irq, &irq);
> +}
> +
> +module_init(dummy_irq_init);
> +module_exit(dummy_irq_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Jiri Kosina");
> +module_param(irq, uint, 0444);
> +MODULE_PARM_DESC(irq, "The IRQ to register for");
> 
> -- 
> Jiri Kosina
> SUSE Labs

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
