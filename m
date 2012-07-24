From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 07/16] Thermal: Introduce .get_trend() callback.
Date: Tue, 24 Jul 2012 09:42:15 +0800
Message-ID: <1343094135.1682.348.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-8-git-send-email-rui.zhang@intel.com>
	 <201207192313.58318.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755062Ab2GXBk6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 21:40:58 -0400
In-Reply-To: <201207192313.58318.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On =E5=9B=9B, 2012-07-19 at 23:13 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 19, 2012, Zhang Rui wrote:
> > tc1 and tc2 are used by OSPM to anticipate the temperature trends.
> > But they are ACPI platform specific concepts.
> >=20
> > Introduce .get_trend() as a more general solution.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/thermal.c        |   30 +++++++++++++++++++++++++++++=
+
> >  drivers/thermal/thermal_sys.c |   19 +++++++++++++++++--
> >  include/linux/thermal.h       |    9 +++++++++
> >  3 files changed, 56 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index a7c97f5..b345646 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -704,6 +704,35 @@ static int thermal_get_crit_temp(struct therma=
l_zone_device *thermal,
> >  		return -EINVAL;
> >  }
> > =20
> > +static int thermal_get_trend(struct thermal_zone_device *thermal,
> > +				int trip, enum thermal_trend *trend)
> > +{
> > +	struct acpi_thermal *tz =3D thermal->devdata;
> > +	enum thermal_trip_type type;
> > +	unsigned long trip_temp;
> > +	int i;
> > +
> > +	if (thermal_get_trip_type(thermal, trip, &type))
> > +		return -EINVAL;
> > +
> > +	/* Only PASSIVE trip points need TREND */
> > +	if (type !=3D THERMAL_TRIP_PASSIVE)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * tz->temperature has already been updated by generic thermal la=
yer,
> > +	 * before this callback being invoked
> > +	 */
> > +	i =3D (tz->trips.passive.tc1 * (tz->temperature - tz->last_temper=
ature))
> > +		+ (tz->trips.passive.tc2
> > +		* (tz->temperature - tz->trips.passive.temperature));
> > +
> > +	*trend =3D i > 0 ? THERMAL_TREND_RAISING :
> > +		(i < 0 ? THERMAL_TREND_DROPPING : THERMAL_TREND_STABLE);
>=20
> I'd use if (...) / else if (...) / else here.  It would be _way_ more=
 readable.
>=20
agreed.

> > +	return 0;
> > +}
> > +
> > +
> >  static int thermal_notify(struct thermal_zone_device *thermal, int=
 trip,
> >  			   enum thermal_trip_type trip_type)
> >  {
> > @@ -832,6 +861,7 @@ static const struct thermal_zone_device_ops acp=
i_thermal_zone_ops =3D {
> >  	.get_trip_type =3D thermal_get_trip_type,
> >  	.get_trip_temp =3D thermal_get_trip_temp,
> >  	.get_crit_temp =3D thermal_get_crit_temp,
> > +	.get_trend =3D thermal_get_trend,
> >  	.notify =3D thermal_notify,
> >  };
> > =20
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therma=
l_sys.c
> > index db35300..29b6dba 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -698,6 +698,18 @@ thermal_remove_hwmon_sysfs(struct thermal_zone=
_device *tz)
> >  }
> >  #endif
> > =20
> > +static void thermal_get_trend(struct thermal_zone_device *tz,
> > +		int trip, enum thermal_trend *trend)
>=20
> The fact that this function has the same name as the ACPI one above i=
s kind of
> disturbing.  Any chance to call it differently?
>=20
> > +{
> > +	if (tz->ops->get_trend)
> > +		if (!tz->ops->get_trend(tz, trip, trend))
> > +			return;
>=20
> What about:
>=20
> +	if (tz->ops->get_trend && !tz->ops->get_trend(tz, trip, trend))
> +		return;
>=20
> And since the error code returned by .get_trend() apparently doesn't =
matter,
> shouldn't it return a bool?
>=20
agreed.
> > +
> > +	*trend =3D tz->temperature >=3D tz->last_temperature ?
> > +		 THERMAL_TREND_RAISING : THERMAL_TREND_DROPPING;
> > +	return;
> > +}
> > +
> >  static void thermal_zone_device_set_polling(struct thermal_zone_de=
vice *tz,
> >  					    int delay)
> >  {
> > @@ -732,6 +744,8 @@ static void thermal_zone_device_passive(struct =
thermal_zone_device *tz,
> >  	if (temp >=3D trip_temp) {
> >  		tz->passive =3D true;
> > =20
> > +		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
>=20
> What's wrong with the data type of 'trend' here?
>=20
this is no functional changes in this patch.
the trend value returned by thermal_get_trend first is overridden by
tc1/tc2 formula below, so trend is still an integer at this time.

But you remind me that I should redefine trend as enum thermal_trend in
the next patch.

> > +
> >  		trend =3D (tz->tc1 * (temp - tz->last_temperature)) +
> >  			(tz->tc2 * (temp - trip_temp));
> > =20

> > @@ -1090,6 +1104,9 @@ void thermal_zone_device_update(struct therma=
l_zone_device *tz)
> >  		goto leave;
> >  	}
> > =20
Say, when the temperature is changed from 60C to 65C,

without this patch, tz->last_temperature is 60C because it is updated i=
n
the previous thermal_zone_device_update() call.
with this patch, tz->temperature is 60C because it is the previous
"current" temperature.

> > +	tz->last_temperature =3D tz->temperature;
> > +	tz->temperature =3D temp;
> > +
we update here them to reflect the truth.

> >  	for (count =3D 0; count < tz->trips; count++) {
> >  		tz->ops->get_trip_type(tz, count, &trip_type);
> >  		tz->ops->get_trip_temp(tz, count, &trip_temp);
> > @@ -1149,8 +1166,6 @@ void thermal_zone_device_update(struct therma=
l_zone_device *tz)
> >  		thermal_zone_device_passive(tz, temp, tz->forced_passive,
> >  					    THERMAL_TRIPS_NONE);
> > =20
> > -	tz->last_temperature =3D temp;
> > -
without this patch, tz->last_temperature is updated to 65C
with this patch, tz->last_temperature is still 60C and tz->temperature
is 65C.
that's why we need to update them in the beginning of
thermal_zone_device_update().
>=20
> I'm not sure if this is correct.  It seems to change the behavior of
> thermal_zone_device_passive() in a subtle way, but I'm not sure that =
really
> matters.  Does it?
>=20
so I think this will not change the behavior of
thermal_zone_device_passive.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
