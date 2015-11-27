From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/7] device core: add BUS_NOTIFY_BIND_DRIVER_ERROR
 notification
Date: Fri, 27 Nov 2015 11:46:20 +0200
Message-ID: <1448617580.15393.99.camel@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1448551153-84719-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <10826039.DB5kcb9LL1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40995 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbbK0JqM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Nov 2015 04:46:12 -0500
In-Reply-To: <10826039.DB5kcb9LL1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, 2015-11-27 at 00:09 +0100, Rafael J. Wysocki wrote:
> On Thursday, November 26, 2015 05:19:07 PM Andy Shevchenko wrote:
> > In case ->probe() fails the notifier does not inform a subscriber
> > about this.
> > In the result it might happend that some resources that had been
> > allocated will
> > stay allocated and therefore lead to resource leak.
> >=20
> > Introduce a new notification to inform the subscriber that
> > ->probe() failed.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> I'd rather say the problem is that the users of
> BUS_NOTIFY_BIND_DRIVER have no
> chance to do any cleanup in case of a probe failure (there may be
> problems even
> if resources aren't leaked).

Thanks, Rafael, all of your comments sound reasonable for me. Will be
taken into consideration in next version.

>=20
> > ---
> > =C2=A0drivers/base/dd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 8 ++++=
++--
> > =C2=A0include/linux/device.h | 1 +
> > =C2=A02 files changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index a641cf3..ac071a5 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -290,7 +290,7 @@ static int really_probe(struct device *dev,
> > struct device_driver *drv)
> > =C2=A0	/* If using pinctrl, bind pins now before probing */
> > =C2=A0	ret =3D pinctrl_bind_pins(dev);
> > =C2=A0	if (ret)
> > -		goto probe_failed;
> > +		goto pinctrl_bind_failed;
> > =C2=A0
> > =C2=A0	if (driver_sysfs_add(dev)) {
> > =C2=A0		printk(KERN_ERR "%s: driver_sysfs_add(%s)
> > failed\n",
> > @@ -334,6 +334,11 @@ static int really_probe(struct device *dev,
> > struct device_driver *drv)
> > =C2=A0	goto done;
> > =C2=A0
> > =C2=A0probe_failed:
> > +	if (dev->bus)
> > +		blocking_notifier_call_chain(&dev->bus->p-
> > >bus_notifier,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUS_NOTIFY_BIND_DRIVE
> > R_ERROR,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev);
>=20
> Well, if we do that, device_bind_driver() needs to send that
> notification too
> in case it doesn't call driver_bound().
>=20
> > +pinctrl_bind_failed:
> > =C2=A0	devres_release_all(dev);
> > =C2=A0	driver_sysfs_remove(dev);
> > =C2=A0	dev->driver =3D NULL;
> > @@ -701,7 +706,6 @@ static void __device_release_driver(struct
> > device *dev)
> > =C2=A0			blocking_notifier_call_chain(&dev->bus->p-
> > >bus_notifier,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUS_NOTIFY_UN
> > BOUND_DRIVER,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev);
> > -
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index b8f411b..87cf423 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -191,6 +191,7 @@ extern int bus_unregister_notifier(struct
> > bus_type *bus,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unbound */
> > =C2=A0#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is
> > unbound
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from the
> > device */
> > +#define BUS_NOTIFY_BIND_DRIVER_ERROR	0x80000004 /* driver
> > fails to be bound */
>=20
> I'd call it BUS_NOTIFY_DRIVER_NOT_BOUND.
>=20
> > =C2=A0
> > =C2=A0extern struct kset *bus_get_kset(struct bus_type *bus);
> > =C2=A0extern struct klist *bus_get_device_klist(struct bus_type *bu=
s);
> >=20
>=20
> Thanks,
> Rafael
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
