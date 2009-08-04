From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V2 2/4] introduce the device async action mechanism
Date: Tue, 04 Aug 2009 11:52:31 +0800
Message-ID: <1249357951.2670.350.camel@rzhang-dt>
References: <1248404524.2670.110.camel@rzhang-dt>
	 <200908032326.03731.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14026 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbZHDDwy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Aug 2009 23:52:54 -0400
In-Reply-To: <200908032326.03731.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, "dtor@mail.ru" <dtor@mail.ru>


On Tue, 2009-08-04 at 05:26 +0800, Rafael J. Wysocki wrote:
> On Friday 24 July 2009, Zhang Rui wrote:
> > Introduce Device Async Action Mechanism
> >=20
> > In order to speed up Linux suspend/resume/shutdown process,
> > we introduce the device async action mechanism that allow devices
> > to suspend/resume/shutdown asynchronously.
> >=20
> > The basic idea is that,
> > if the suspend/resume/shutdown process of a device group,
> > including a root device and its child devices, are independent of
> > other devices, we create an async domain for this device group,
> > and make them suspend/resume/shutdown asynchronously.   =20
> >=20
> > Note that DEV_ASYNC_RESUME is different from DEV_ASYNC_SUSPEND and
> > DEV_ASYNC_SHUTDOWN.
> > In resume case, all the parents are resumed first.
> > deferred resuming of the child devices won't break anything.
> > So it's easy to find out a device group that supports DEV_ASYNC_RES=
UME.
> >=20
> > In suspend/shutdown case, child devices should be suspended/shutdow=
n
> > before the parents. But deferred suspend/shutdown may break this ru=
le.
> > so for a device groups that supports DEV_ASYNC_SUSPEND&DEV_ASYNC_SH=
UTDOWN,
> > the root device of this device async group must NOT depend on its p=
arents.
> > i.e. it's fully functional without its parents.
> > e.g. I create a device async group for i8042 controller in patch 4,
> > and the parent of i8042 controller device is the "platform" device =
under
> > sysfs root device.
>=20
> For general comments, please refer to my reply to the [0/4] message. =
 Some
> coding-related remarks are below.
>=20
=EF=BB=BFHi, Rafael,

thanks for your comments. :)

> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/base/Makefile     |    3=20
> >  drivers/base/async_dev.c  |  199 +++++++++++++++++++++++++++++++++=
+++++++++++++
> >  drivers/base/core.c       |   35 ++++++--
> >  drivers/base/power/main.c |   24 +++++
> >  include/linux/async_dev.h |   47 ++++++++++
> >  include/linux/device.h    |    2=20
> >  6 files changed, 298 insertions(+), 12 deletions(-)
> >=20
> > Index: linux-2.6/drivers/base/Makefile
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/base/Makefile
> > +++ linux-2.6/drivers/base/Makefile
> > @@ -3,7 +3,8 @@
> >  obj-y			:=3D core.o sys.o bus.o dd.o \
> >  			   driver.o class.o platform.o \
> >  			   cpu.o firmware.o init.o map.o devres.o \
> > -			   attribute_container.o transport_class.o
> > +			   attribute_container.o transport_class.o \
> > +			   async_dev.o
> >  obj-y			+=3D power/
> >  obj-$(CONFIG_HAS_DMA)	+=3D dma-mapping.o
> >  obj-$(CONFIG_ISA)	+=3D isa.o
> > Index: linux-2.6/drivers/base/async_dev.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ linux-2.6/drivers/base/async_dev.c
> > @@ -0,0 +1,199 @@
> > +/*
> > + * async_dev.c: Device asynchronous functions
> > + *
> > + * (C) Copyright 2009 Intel Corporation
> > + * Author: Zhang Rui <rui.zhang@intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2
> > + * of the License.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/async.h>
> > +#include <linux/async_dev.h>
> > +
> > +static LIST_HEAD(dev_async_list);
> > +static int dev_async_enabled;
> > +
> > +struct dev_async_context {
> > +	struct device *dev;
> > +	void *data;
> > +	void *func;
> > +};
>=20
> Please, _please_ don't use (void * ) for passing function pointers.  =
IMO doing
> that is fundamentally wrong.
>=20
hah,
I already use dev_async_func instead but I forgot to change it here.
sorry for the mistake.

> > +static int dev_action(struct device *dev, dev_async_func func,
> > +			void *data)
> > +{
> > +	int error =3D 0;
> > +
> > +	if (!func || !dev)
> > +		return -EINVAL;
> > +
> > +	error =3D func(dev, data);
> > +
> > +	return error;
> > +}
>=20
> Hmm, what about:
>=20
> +		return func && dev ? func(dev, data) : -EINVAL;
>=20
> That gives you a one-liner, doesn't it?
>=20
cool.
I'll do it in patch v3.

> > +static void dev_async_action(void *data, async_cookie_t cookie)
> > +{
> > +	int error;
> > +	struct dev_async_context *context =3D data;
> > +
> > +	context->dev->dev_async->cookie =3D cookie;
> > +	async_synchronize_cookie_domain(cookie,
> > +					 &context->dev->dev_async->domain);
> > +
> > +	error =3D	dev_action(context->dev, context->func, context->data);
> > +	if (error)
> > +		printk(KERN_ERR "PM: Device %s async action failed: error %d\n",
> > +			dev_name(context->dev), error);
> > +
> > +	kfree(context);
> > +}
> > +
> > +/**
> > + * dev_async_schedule - async execution of device actions.
> > + * @dev: Device.
> > + * @func: device callback function.
> > + * @data: data.
> > + * @type: the type of device async actions.
> > + */
> > +int dev_async_schedule(struct device *dev, dev_async_func func,
> > +			void *data, int type)
> > +{
> > +	struct dev_async_context *context;
> > +
> > +	if (!func || !dev)
> > +		return -EINVAL;
> > +
> > +	if (!(type & DEV_ASYNC_ACTIONS_ALL))
> > +		return -EINVAL;
> > +
> > +	if (!dev_async_enabled || !dev->dev_async)
> > +		return dev_action(dev, func, data);
> > +
> > +	/* device doesn't support the current async action */
> > +	if (!(dev->dev_async->type & type))
> > +		return dev_action(dev, func, data);
> > +
> > +	context =3D kzalloc(sizeof(struct dev_async_context), GFP_KERNEL)=
;
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	context->dev =3D dev;
> > +	context->data =3D data;
> > +	context->func =3D func;
> > +	async_schedule_domain(dev_async_action, context,
> > +			       &dev->dev_async->domain);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * device_async_synchronization - sync point for all the async act=
ions
> > + * @dev: Device.
> > + *
> > + * wait until all the async actions are done.
> > + */
> > +void dev_async_synchronization(void)
> > +{
> > +	struct dev_async_struct *pos;
> > +
> > +	list_for_each_entry(pos, &dev_async_list, node)
> > +	    async_synchronize_full_domain(&pos->domain);
> > +
> > +	return;
>=20
> What the return statement is for?
>=20
> > +}
> > +
> > +static int dev_match(struct device *dev, void *data)
> > +{
> > +	dev_err(dev->parent, "Child device %s is registered before "
> > +		"dev->dev_async being initialized", dev_name(dev));
> > +	return 1;
> > +}
> > +
> > +/**
> > + * device_async_register - register a device that supports async a=
ctions
> > + * @dev: Device.
> > + * @type: the kind of dev async actions that supported
> > + *
> > + * Register a device that supports a certain kind of dev async act=
ions.
> > + * Create a synchrolization Domain for this device and share with =
all its
> > + * child devices.
> > + */
> > +int dev_async_register(struct device *dev, int type)
> > +{
> > +	if (!dev_async_enabled)
> > +		return 0;
> > +
> > +	if (!dev)
> > +		return -EINVAL;
> > +
> > +	if (dev->dev_async) {
> > +		/* multiple async domains for a single device not supported */
> > +		dev_err(dev, "async domain already registered\n");
> > +		return -EEXIST;
> > +	}
> > +
> > +	/*
> > +	 * dev_async_register must be called before any of its child devi=
ces
> > +	 * being registered to the driver model.
> > +	 */
> > +	if (dev->p)
> > +		if (device_find_child(dev, NULL, dev_match)) {
> > +			dev_err(dev, "Can not register device async domain\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	/* check for unsupported async actions */
> > +	if (!(type & DEV_ASYNC_ACTIONS_ALL)) {
> > +		dev_err(dev, "unsupported async action %x registered\n", type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev->dev_async =3D kzalloc(sizeof(struct dev_async_struct), GFP_K=
ERNEL);
> > +	if (!dev->dev_async)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&dev->dev_async->domain);
> > +	dev->dev_async->dev =3D dev;
> > +	dev->dev_async->type =3D type;
> > +	list_add_tail(&dev->dev_async->node, &dev_async_list);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_async_register);
> > +
> > +/**
> > + * device_async_unregister - unregister a device that supports asy=
nc actions
> > + * @dev: Device.
> > + *
> > + * Unregister a device that supports async actions.
> > + * And delete async action Domain at the same time.
> > + */
> > +void dev_async_unregister(struct device *dev)
> > +{
> > +	if (!dev_async_enabled)
> > +		return;
> > +
> > +	if (!dev->dev_async)
> > +		return;
> > +
> > +	if (dev->dev_async->dev !=3D dev)
> > +		return;
> > +
> > +	list_del(&dev->dev_async->node);
> > +	kfree(dev->dev_async);
> > +	dev->dev_async =3D NULL;
> > +	return;
>=20
> And here?
>=20
> Well, it looks like my comments to the previous version of the patch =
were
> silently ignored. :-(
>=20

> =EF=BB=BFThere are more things like that in this patch, not to mentio=
n
> excessive return statements

I misunderstood this, sorry.

> and passing function pointers as (void *).

I changed it to dev_async_func.

I'll make the above changes in patch v3.
And I'd rather like to getting some comments about this approach. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
