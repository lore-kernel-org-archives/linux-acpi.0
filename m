From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/16] Thermal: Introduce .get_trend() callback.
Date: Tue, 24 Jul 2012 11:22:17 +0200
Message-ID: <201207241122.17815.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <201207192313.58318.rjw@sisk.pl> <1343094135.1682.348.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53866 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab2GXJQc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jul 2012 05:16:32 -0400
In-Reply-To: <1343094135.1682.348.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Tuesday, July 24, 2012, Zhang Rui wrote:
> On =E5=9B=9B, 2012-07-19 at 23:13 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > tc1 and tc2 are used by OSPM to anticipate the temperature trends=
=2E
> > > But they are ACPI platform specific concepts.
> > >=20
> > > Introduce .get_trend() as a more general solution.
> > >=20
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/acpi/thermal.c        |   30 +++++++++++++++++++++++++++=
+++
> > >  drivers/thermal/thermal_sys.c |   19 +++++++++++++++++--
> > >  include/linux/thermal.h       |    9 +++++++++
> > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > > index a7c97f5..b345646 100644
> > > --- a/drivers/acpi/thermal.c
> > > +++ b/drivers/acpi/thermal.c
> > > @@ -704,6 +704,35 @@ static int thermal_get_crit_temp(struct ther=
mal_zone_device *thermal,
> > >  		return -EINVAL;
> > >  }
> > > =20
> > > +static int thermal_get_trend(struct thermal_zone_device *thermal=
,
> > > +				int trip, enum thermal_trend *trend)
> > > +{
> > > +	struct acpi_thermal *tz =3D thermal->devdata;
> > > +	enum thermal_trip_type type;
> > > +	unsigned long trip_temp;
> > > +	int i;
> > > +
> > > +	if (thermal_get_trip_type(thermal, trip, &type))
> > > +		return -EINVAL;
> > > +
> > > +	/* Only PASSIVE trip points need TREND */
> > > +	if (type !=3D THERMAL_TRIP_PASSIVE)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * tz->temperature has already been updated by generic thermal =
layer,
> > > +	 * before this callback being invoked
> > > +	 */
> > > +	i =3D (tz->trips.passive.tc1 * (tz->temperature - tz->last_temp=
erature))
> > > +		+ (tz->trips.passive.tc2
> > > +		* (tz->temperature - tz->trips.passive.temperature));
> > > +
> > > +	*trend =3D i > 0 ? THERMAL_TREND_RAISING :
> > > +		(i < 0 ? THERMAL_TREND_DROPPING : THERMAL_TREND_STABLE);
> >=20
> > I'd use if (...) / else if (...) / else here.  It would be _way_ mo=
re readable.
> >=20
> agreed.
>=20
> > > +	return 0;
> > > +}
> > > +
> > > +
> > >  static int thermal_notify(struct thermal_zone_device *thermal, i=
nt trip,
> > >  			   enum thermal_trip_type trip_type)
> > >  {
> > > @@ -832,6 +861,7 @@ static const struct thermal_zone_device_ops a=
cpi_thermal_zone_ops =3D {
> > >  	.get_trip_type =3D thermal_get_trip_type,
> > >  	.get_trip_temp =3D thermal_get_trip_temp,
> > >  	.get_crit_temp =3D thermal_get_crit_temp,
> > > +	.get_trend =3D thermal_get_trend,
> > >  	.notify =3D thermal_notify,
> > >  };
> > > =20
> > > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/ther=
mal_sys.c
> > > index db35300..29b6dba 100644
> > > --- a/drivers/thermal/thermal_sys.c
> > > +++ b/drivers/thermal/thermal_sys.c
> > > @@ -698,6 +698,18 @@ thermal_remove_hwmon_sysfs(struct thermal_zo=
ne_device *tz)
> > >  }
> > >  #endif
> > > =20
> > > +static void thermal_get_trend(struct thermal_zone_device *tz,
> > > +		int trip, enum thermal_trend *trend)
> >=20
> > The fact that this function has the same name as the ACPI one above=
 is kind of
> > disturbing.  Any chance to call it differently?
> >=20
> > > +{
> > > +	if (tz->ops->get_trend)
> > > +		if (!tz->ops->get_trend(tz, trip, trend))
> > > +			return;
> >=20
> > What about:
> >=20
> > +	if (tz->ops->get_trend && !tz->ops->get_trend(tz, trip, trend))
> > +		return;
> >=20
> > And since the error code returned by .get_trend() apparently doesn'=
t matter,
> > shouldn't it return a bool?
> >=20
> agreed.
> > > +
> > > +	*trend =3D tz->temperature >=3D tz->last_temperature ?
> > > +		 THERMAL_TREND_RAISING : THERMAL_TREND_DROPPING;
> > > +	return;
> > > +}
> > > +
> > >  static void thermal_zone_device_set_polling(struct thermal_zone_=
device *tz,
> > >  					    int delay)
> > >  {
> > > @@ -732,6 +744,8 @@ static void thermal_zone_device_passive(struc=
t thermal_zone_device *tz,
> > >  	if (temp >=3D trip_temp) {
> > >  		tz->passive =3D true;
> > > =20
> > > +		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
> >=20
> > What's wrong with the data type of 'trend' here?
> >=20
> this is no functional changes in this patch.

Sure.

I was wondering if the explicit cast could be avoided.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
