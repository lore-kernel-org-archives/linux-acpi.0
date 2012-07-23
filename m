From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 01/16] Thermal: Make Thermal trip points writeable
Date: Mon, 23 Jul 2012 16:22:25 +0800
Message-ID: <1343031745.1682.328.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-2-git-send-email-rui.zhang@intel.com>
	 <201207192227.13357.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41943 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab2GWIVH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 04:21:07 -0400
In-Reply-To: <201207192227.13357.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

On =E5=9B=9B, 2012-07-19 at 22:27 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 19, 2012, Zhang Rui wrote:
> > From: Durgadoss R <dugardoss.r@intel.com>
> >=20
> > Some of the thermal drivers using the Generic Thermal Framework
> > require (all/some) trip points to be writeable. This patch makes
> > the trip point temperatures writeable on a per-trip point basis,
> > and modifies the required function call in thermal.c. This patch
> > also updates the Documentation to reflect the new change.
> >=20
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt      |    4 +-
> >  drivers/acpi/thermal.c                   |    4 +-
> >  drivers/platform/x86/acerhdf.c           |    2 +-
> >  drivers/platform/x86/intel_mid_thermal.c |    2 +-
> >  drivers/thermal/spear_thermal.c          |    2 +-
> >  drivers/thermal/thermal_sys.c            |  147 ++++++++++++++++++=
+++---------
> >  include/linux/thermal.h                  |   15 ++-
> >  7 files changed, 125 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/th=
ermal/sysfs-api.txt
> > index 1733ab9..0c7c423 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -32,7 +32,8 @@ temperature) and throttle appropriate devices.
> > =20
> >  1.1 thermal zone device interface
> >  1.1.1 struct thermal_zone_device *thermal_zone_device_register(cha=
r *name,
> > -		int trips, void *devdata, struct thermal_zone_device_ops *ops)
> > +		int trips, int flag, void *devdata,
>=20
> The 'flags' argument should rather be called 'mask', or even 'writabl=
e_mask'.
>=20
Agreed.

> >  #define to_cooling_device(_dev)	\
> >  	container_of(_dev, struct thermal_cooling_device, device)
> > @@ -1089,9 +1084,83 @@ void thermal_zone_device_update(struct therm=
al_zone_device *tz)
> >  EXPORT_SYMBOL(thermal_zone_device_update);
> >  >  /**
> > + * create_trip_attrs - create attributes for trip points
> > + * @tz:		the thermal zone device
> > + * @flag:	Writeable trip point bitmap.
> > + */
> > +static int create_trip_attrs(struct thermal_zone_device *tz, int f=
lag)
> > +{
> > +	int indx;
> > +	int writeable;
> > +
> > +	tz->trip_type_attrs =3D
> > +		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
> > +	if (!tz->trip_type_attrs)
> > +		return -ENOMEM;
> > +
> > +	tz->trip_temp_attrs =3D
> > +		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
> > +	if (!tz->trip_temp_attrs) {
> > +		kfree(tz->trip_type_attrs);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (indx =3D 0; indx < tz->trips; indx++) {
> > +
> > +		/* create trip type attribute */
> > +		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
> > +			 "trip_point_%d_type", indx);
>=20
> If this really truncates the name, we'll run into problems in _show()=
 and _store().
> Is there any solution to that?
>=20
as THERMAL_MAX_TRIP is smaller than 100, so the answer is no.

> > +
> > +		sysfs_attr_init(&tz->trip_type_attrs[count].attr.attr);
> > +		tz->trip_type_attrs[indx].attr.attr.name =3D
> > +						tz->trip_type_attrs[indx].name;
> > +		tz->trip_type_attrs[indx].attr.attr.mode =3D S_IRUGO;
> > +		tz->trip_type_attrs[indx].attr.show =3D trip_point_type_show;
> > +
> > +		device_create_file(&tz->device,
> > +				   &tz->trip_type_attrs[indx].attr);
> > +
> > +		/* create trip temp attribute */
> > +		writeable =3D flag & (1 << indx);
> > +		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
> > +			 "trip_point_%d_temp", indx);
> > +
> > +		sysfs_attr_init(&tz->trip_temp_attrs[indx].attr.attr);
> > +		tz->trip_temp_attrs[indx].attr.attr.name =3D
> > +						tz->trip_temp_attrs[indx].name;
> > +		tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
> > +		tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_show;
> > +		if (writeable) {
>=20
> Why don't you put the "flag & (1 << indx)" here directly instead of '=
writable'?
>=20
agreed.

> > +			tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWUSR;
> > +			tz->trip_temp_attrs[indx].attr.store =3D
> > +							trip_point_temp_store;
> > +		}
> > +
> > +		device_create_file(&tz->device,
> > +				   &tz->trip_temp_attrs[indx].attr);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void remove_trip_attrs(struct thermal_zone_device *tz)
> > +{
> > +	int indx;
> > +
> > +	for (indx =3D 0; indx < tz->trips; indx++) {
> > +		device_remove_file(&tz->device,
> > +				   &tz->trip_type_attrs[indx].attr);
> > +		device_remove_file(&tz->device,
> > +				   &tz->trip_temp_attrs[indx].attr);
> > +	}
> > +	kfree(tz->trip_type_attrs);
> > +	kfree(tz->trip_temp_attrs);
> > +}
> > +
> > +/**
> >   * thermal_zone_device_register - register a new thermal zone devi=
ce
> >   * @type:	the thermal zone device type
> >   * @trips:	the number of trip points the thermal zone support
> > + * @flag:	a bit string indicating the writeablility of trip points
> >   * @devdata:	private device data
> >   * @ops:	standard thermal zone device callbacks
> >   * @tc1:	thermal coefficient 1 for passive calculations
> > @@ -1107,7 +1176,7 @@ EXPORT_SYMBOL(thermal_zone_device_update);
> >   * section 11.1.5.1 of the ACPI specification 3.0.
> >   */
> >  struct thermal_zone_device *thermal_zone_device_register(char *typ=
e,
> > -	int trips, void *devdata,
> > +	int trips, int flag, void *devdata,
> >  	const struct thermal_zone_device_ops *ops,
> >  	int tc1, int tc2, int passive_delay, int polling_delay)
> >  {
> > @@ -1124,6 +1193,9 @@ struct thermal_zone_device *thermal_zone_devi=
ce_register(char *type,
> >  	if (trips > THERMAL_MAX_TRIPS || trips < 0)
> >  		return ERR_PTR(-EINVAL);
> > =20
> > +	if (flag >> trips)
> > +		return ERR_PTR(-EINVAL);
>=20
> I'm not sure if this check is necessary.  Does it actually matter is =
someone
> passes ones in the unused bit positions?
>=20
I do not think we can trust this value if the caller even wants to set
writable mask for a non-exist trip point.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
