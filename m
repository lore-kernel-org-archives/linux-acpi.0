From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 06/16] Thermal: set upper and lower limits
Date: Mon, 23 Jul 2012 16:45:35 +0800
Message-ID: <1343033135.1682.335.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-7-git-send-email-rui.zhang@intel.com>
	 <201207192255.43570.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57697 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab2GWIoR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 04:44:17 -0400
In-Reply-To: <201207192255.43570.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On =E5=9B=9B, 2012-07-19 at 22:55 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 19, 2012, Zhang Rui wrote:
> > set upper and lower limits when binding
> > a thermal cooling device to a thermal zone device.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt |    6 ++++-
> >  drivers/acpi/thermal.c              |   49 ++++++++++++++++++++++-=
------------
> >  drivers/platform/x86/acerhdf.c      |    2 +-
> >  drivers/thermal/thermal_sys.c       |   20 +++++++++-----
> >  include/linux/thermal.h             |    3 ++-
> >  5 files changed, 53 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/th=
ermal/sysfs-api.txt
> > index b7b3609..f169821 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -84,7 +84,7 @@ temperature) and throttle appropriate devices.
> > =20
> >  1.3 interface for binding a thermal zone device with a thermal coo=
ling device
> >  1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_dev=
ice *tz,
> > -		int trip, struct thermal_cooling_device *cdev);
> > +	int trip, struct thermal_cooling_device *cdev, long upper, long l=
ower);
> > =20
> >      This interface function bind a thermal cooling device to the c=
ertain trip
> >      point of a thermal zone device.
> > @@ -93,6 +93,10 @@ temperature) and throttle appropriate devices.
> >      cdev: thermal cooling device
> >      trip: indicates which trip point the cooling devices is associ=
ated with
> >  	  in this thermal zone.
> > +    upper:the Maximum cooling state for this trip point.
> > +          -1 means no upper limit, and the cooling device can be i=
n max_state.
> > +    lower:the Minimum cooling state can be used for this trip poin=
t.
> > +          -1 means no lower limit, and the cooling device can be i=
n cooling state 0.
>=20
> If we have to use -1 (or all ones for unsigned long), I'd suggest to =
define a
> constant called CS_NO_LIMIT or something like that and use it instead=
 of the
> plain numbers.
>=20
agreed.

> And perhaps change the name of the above to
> thermal_zone_bind_cooling_device_limits() and define
> thermal_zone_bind_cooling_device() as a static inline that will not t=
ake the
> extra two arguments and make it call thermal_zone_bind_cooling_device=
_limits()
> with the CS_NO_LIMIT values in there.
>=20
then you mean there are two APIs for binding?
users can invoke thermal_zone_bind_cooling_device if they do not care
the limits?
Hmm, I do not think we need to do this. And further more, as there are
and there will be more and more parameters for binding, say, maybe
weight/influence in the near future, I'm thinking of using a struct
thermal_bind_params to pass the parameters instead.

> >  1.3.2 int thermal_zone_unbind_cooling_device(struct thermal_zone_d=
evice *tz,
> >  		int trip, struct thermal_cooling_device *cdev);
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 8275e7b..a7c97f5 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -727,11 +727,9 @@ static int thermal_notify(struct thermal_zone_=
device *thermal, int trip,
> >  	return 0;
> >  }
> > =20
> > -typedef int (*cb)(struct thermal_zone_device *, int,
> > -		  struct thermal_cooling_device *);
> >  static int acpi_thermal_cooling_device_cb(struct thermal_zone_devi=
ce *thermal,
> >  					struct thermal_cooling_device *cdev,
> > -					cb action)
> > +					int bind)
>=20
> Should 'bind' be a bool?
>=20
yep.

> >  {
> >  	struct acpi_device *device =3D cdev->devdata;
> >  	struct acpi_thermal *tz =3D thermal->devdata;
> > @@ -755,11 +753,18 @@ static int acpi_thermal_cooling_device_cb(str=
uct thermal_zone_device *thermal,
> >  		    i++) {
> >  			handle =3D tz->trips.passive.devices.handles[i];
> >  			status =3D acpi_bus_get_device(handle, &dev);
> > -			if (ACPI_SUCCESS(status) && (dev =3D=3D device)) {
> > -				result =3D action(thermal, trip, cdev);
> > -				if (result)
> > -					goto failed;
> > -			}
> > +			if (ACPI_FAILURE(status) || dev !=3D device)
> > +				continue;
> > +			if (bind)
> > +				result =3D
> > +					thermal_zone_bind_cooling_device
> > +					(thermal, trip, cdev, -1, -1);
> > +			else
> > +				result =3D
> > +					thermal_zone_unbind_cooling_device
> > +					(thermal, trip, cdev);
> > +			if (result)
> > +				goto failed;
> >  		}
> >  	}
> > =20
> > @@ -772,11 +777,16 @@ static int acpi_thermal_cooling_device_cb(str=
uct thermal_zone_device *thermal,
> >  		    j++) {
> >  			handle =3D tz->trips.active[i].devices.handles[j];
> >  			status =3D acpi_bus_get_device(handle, &dev);
> > -			if (ACPI_SUCCESS(status) && (dev =3D=3D device)) {
> > -				result =3D action(thermal, trip, cdev);
> > -				if (result)
> > -					goto failed;
> > -			}
> > +			if (ACPI_FAILURE(status) || dev !=3D device)
> > +				continue;
> > +			if (bind)
> > +				result =3D thermal_zone_bind_cooling_device
> > +					(thermal, trip, cdev, -1, -1);
> > +			else
> > +				result =3D thermal_zone_unbind_cooling_device
> > +					(thermal, trip, cdev);
> > +			if (result)
> > +				goto failed;
> >  		}
> >  	}
> > =20
> > @@ -784,7 +794,12 @@ static int acpi_thermal_cooling_device_cb(stru=
ct thermal_zone_device *thermal,
> >  		handle =3D tz->devices.handles[i];
> >  		status =3D acpi_bus_get_device(handle, &dev);
> >  		if (ACPI_SUCCESS(status) && (dev =3D=3D device)) {
> > -			result =3D action(thermal, -1, cdev);
> > +			if (bind)
> > +				result =3D thermal_zone_bind_cooling_device
> > +						(thermal, -1, cdev, -1, -1);
> > +			else
> > +				result =3D thermal_zone_unbind_cooling_device
> > +						(thermal, -1, cdev);
> >  			if (result)
> >  				goto failed;
> >  		}
> > @@ -798,16 +813,14 @@ static int
> >  acpi_thermal_bind_cooling_device(struct thermal_zone_device *therm=
al,
> >  					struct thermal_cooling_device *cdev)
> >  {
> > -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> > -				thermal_zone_bind_cooling_device);
> > +	return acpi_thermal_cooling_device_cb(thermal, cdev, 1);
> >  }
> > =20
> >  static int
> >  acpi_thermal_unbind_cooling_device(struct thermal_zone_device *the=
rmal,
> >  					struct thermal_cooling_device *cdev)
> >  {
> > -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> > -				thermal_zone_unbind_cooling_device);
> > +	return acpi_thermal_cooling_device_cb(thermal, cdev, 0);
> >  }
> > =20
> >  static const struct thermal_zone_device_ops acpi_thermal_zone_ops =
=3D {
> > diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/=
acerhdf.c
> > index 39abb15..278aa0e 100644
> > --- a/drivers/platform/x86/acerhdf.c
> > +++ b/drivers/platform/x86/acerhdf.c
> > @@ -329,7 +329,7 @@ static int acerhdf_bind(struct thermal_zone_dev=
ice *thermal,
> >  	if (cdev !=3D cl_dev)
> >  		return 0;
> > =20
> > -	if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
> > +	if (thermal_zone_bind_cooling_device(thermal, 0, cdev, -1, -1)) {
> >  		pr_err("error binding cooling dev\n");
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therma=
l_sys.c
> > index 4267a49..db35300 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -316,7 +316,7 @@ passive_store(struct device *dev, struct device=
_attribute *attr,
> >  				     sizeof("Processor")))
> >  				thermal_zone_bind_cooling_device(tz,
> >  								 THERMAL_TRIPS_NONE,
> > -								 cdev);
> > +								 cdev, -1, -1);
> >  		}
> >  		mutex_unlock(&thermal_list_lock);
> >  		if (!tz->passive_delay)
> > @@ -801,7 +801,8 @@ static void thermal_zone_device_check(struct wo=
rk_struct *work)
> >   */
> >  int thermal_zone_bind_cooling_device(struct thermal_zone_device *t=
z,
> >  				     int trip,
> > -				     struct thermal_cooling_device *cdev)
> > +				     struct thermal_cooling_device *cdev,
> > +				     long upper, long lower)
>=20
> upper and lower were unsigned long in the previous patch.  Can we ple=
ase
> use the same data type for them everywhere?
>=20
yep.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
