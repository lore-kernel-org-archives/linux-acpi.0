From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 14/16] Thermal: Introduce simple arbitrator for setting
 device cooling state
Date: Tue, 24 Jul 2012 09:49:52 +0800
Message-ID: <1343094592.1682.357.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-15-git-send-email-rui.zhang@intel.com>
	 <201207192339.22108.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:47408 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101Ab2GXBse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 21:48:34 -0400
In-Reply-To: <201207192339.22108.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

On =E5=9B=9B, 2012-07-19 at 23:39 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 19, 2012, Zhang Rui wrote:
> > This fixes the problem that a cooling device may be referenced by
> > by multiple trip points in multiple thermal zones.
> >=20
> > With this patch, we have two stages for updating a thermal zone,
> > 1. check if a thermal_instance needs to be updated or not
> > 2. update the cooling device, based on the target cooling state
> >    of all its instances.
> >=20
> > Note that, currently, the cooling device is set to the deepest
> > cooling state required.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_sys.c |   41 +++++++++++++++++++++++++++++=
+++++++++---
> >  include/linux/thermal.h       |    1 +
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therma=
l_sys.c
> > index 48b2668..803ce94 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -54,6 +54,7 @@ struct thermal_instance {
> >  	int trip;
> >  	unsigned long upper;	/* Highest cooling state for this trip point=
 */
> >  	unsigned long lower;	/* Lowest cooling state for this trip point =
*/
> > +	unsigned long target;	/* expected cooling state */
> >  	char attr_name[THERMAL_NAME_LENGTH];
> >  	struct device_attribute attr;
> >  	struct list_head tz_node; /* node in tz->instances */
> > @@ -853,6 +854,7 @@ int thermal_zone_bind_cooling_device(struct the=
rmal_zone_device *tz,
> >  	dev->trip =3D trip;
> >  	dev->upper =3D upper;
> >  	dev->lower =3D lower;
> > +	dev->target =3D -1;
>=20
> Please define THERMAL_NO_TARGET and use that instead of plain -1.
>=20
agreed.

> > =20
> >  	result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
> >  	if (result)
> > @@ -990,6 +992,7 @@ thermal_cooling_device_register(char *type, voi=
d *devdata,
> >  	strcpy(cdev->type, type);
> >  	INIT_LIST_HEAD(&cdev->instances);
> >  	cdev->ops =3D ops;
> > +	cdev->updated =3D 1;
> >  	cdev->device.class =3D &thermal_class;
> >  	cdev->devdata =3D devdata;
> >  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> > @@ -1081,6 +1084,32 @@ void thermal_cooling_device_unregister(struc=
t
> >  }
> >  EXPORT_SYMBOL(thermal_cooling_device_unregister);
> > =20
> > +static void thermal_zone_do_update(struct thermal_zone_device *tz)
> > +{
> > +	struct thermal_instance *instance1, *instance2;
> > +	struct thermal_cooling_device *cdev;
> > +	int target;
>=20
> The 'target' field in the structure is unsigned long.  It'd be better=
 to use
> the same data type here.
>=20
> It would be good to use 'true' and 'false' as the values of 'updated'=
 too.
>=20
agreed.

> > +
> > +	list_for_each_entry(instance1, &tz->instances, tz_node) {
> > +		cdev =3D instance1->cdev;
> > +
> > +		/* cooling device has already been updated*/
> > +		if (cdev->updated)
> > +			continue;
> > +
> > +		target =3D 0;
> > +		/* Make sure cdev enters the deepest cooling state */
> > +		list_for_each_entry(instance2, &cdev->instances, cdev_node) {
> > +			if (instance2->target =3D=3D -1)
> > +				continue;
> > +			if (instance2->target > target)
> > +				target =3D instance2->target;
> > +		}
> > +		cdev->ops->set_cur_state(cdev, target);
> > +		cdev->updated =3D 1;
> > +	}
> > +}
>=20
> I would split the function above into two, one that would walk all
> instances of the thermal zone and the other, that would walk the
> instances for a given device.  It would look much cleaner, then.
>=20
agreed.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
