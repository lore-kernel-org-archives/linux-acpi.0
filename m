From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V4 04/13] Thermal: Introduce .get_trend() callback.
Date: Wed, 01 Aug 2012 10:42:33 +0800
Message-ID: <1343788953.1682.491.camel@rui.sh.intel.com>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
	 <1343292083-2047-5-git-send-email-rui.zhang@intel.com>
	 <201207262211.06597.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8650 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676Ab2HAClU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jul 2012 22:41:20 -0400
In-Reply-To: <201207262211.06597.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E5=9B=9B, 2012-07-26 at 22:11 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 26, 2012, Zhang Rui wrote:
> > According to ACPI spec, tc1 and tc2 are used by OSPM
> > to anticipate the temperature trends.
> > We introduced the same concept to the generic thermal layer
> > for passive cooling, but now it seems that these values
> > are hard to be used on other platforms.
> >=20
> > So We introduce .get_trend() as a more general solution.
> >=20
> > For the platform thermal drivers that have their own way to
> > anticipate the temperature trends, they should provide
> > their own .get_trend() callback.
> > Or else, we will calculate the temperature trends by simply
> > comparing the current temperature and the cached previous
> > temperature reading.
>=20
> As far as the code is concerned:
>=20
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> I wonder, though, if there are any users of the thermal core currentl=
y in the
> tree who should introduce their own .get_trend() callbacks?
>=20
No, for now.
But there will be soon. :)

thanks,
rui
> Rafael
>=20
>=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/thermal.c        |   33 +++++++++++++++++++++++++++++=
++++
> >  drivers/thermal/thermal_sys.c |   19 +++++++++++++++++--
> >  include/linux/thermal.h       |    9 +++++++++
> >  3 files changed, 59 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index b48ec3e..0c49e42 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -704,6 +704,38 @@ static int thermal_get_crit_temp(struct therma=
l_zone_device *thermal,
> >  		return -EINVAL;
> >  }
> > =20
> > +static int thermal_get_trend(struct thermal_zone_device *thermal,
> > +				int trip, enum thermal_trend *trend)
> > +{
> > +	struct acpi_thermal *tz =3D thermal->devdata;
> > +	enum thermal_trip_type type;
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
> > +	if (i > 0)
> > +		*trend =3D THERMAL_TREND_RAISING;
> > +	else if (i < 0)
> > +		*trend =3D THERMAL_TREND_DROPPING;
> > +	else
> > +		*trend =3D THERMAL_TREND_STABLE;
> > +	return 0;
> > +}
> > +
> > +
> >  static int thermal_notify(struct thermal_zone_device *thermal, int=
 trip,
> >  			   enum thermal_trip_type trip_type)
> >  {
> > @@ -836,6 +868,7 @@ static const struct thermal_zone_device_ops acp=
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
> > index 62b4279..68c93d4 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -723,6 +723,20 @@ static void thermal_zone_device_passive(struct=
 thermal_zone_device *tz,
> >  	struct thermal_cooling_device *cdev;
> >  	long state, max_state;
> > =20
> > +	if (!tz->ops->get_trend ||
> > +	    tz->ops->get_trend(tz, trip, (enum thermal_trend *)&trend)) {
> > +		/*
> > +		 * compare the current temperature and previous temperature
> > +		 * to get the thermal trend, if no special requirement
> > +		 */
> > +		if (tz->temperature > tz->last_temperature)
> > +			trend =3D THERMAL_TREND_RAISING;
> > +		else if (tz->temperature < tz->last_temperature)
> > +			trend =3D THERMAL_TREND_DROPPING;
> > +		else
> > +			trend =3D THERMAL_TREND_STABLE;
> > +	}
> > +
> >  	/*
> >  	 * Above Trip?
> >  	 * -----------
> > @@ -1091,6 +1105,9 @@ void thermal_zone_device_update(struct therma=
l_zone_device *tz)
> >  		goto leave;
> >  	}
> > =20
> > +	tz->last_temperature =3D tz->temperature;
> > +	tz->temperature =3D temp;
> > +
> >  	for (count =3D 0; count < tz->trips; count++) {
> >  		tz->ops->get_trip_type(tz, count, &trip_type);
> >  		tz->ops->get_trip_temp(tz, count, &trip_temp);
> > @@ -1150,8 +1167,6 @@ void thermal_zone_device_update(struct therma=
l_zone_device *tz)
> >  		thermal_zone_device_passive(tz, temp, tz->forced_passive,
> >  					    THERMAL_TRIPS_NONE);
> > =20
> > -	tz->last_temperature =3D temp;
> > -
> >  leave:
> >  	if (tz->passive)
> >  		thermal_zone_device_set_polling(tz, tz->passive_delay);
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index a43b12c..a01e3e6 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -44,6 +44,12 @@ enum thermal_trip_type {
> >  	THERMAL_TRIP_CRITICAL,
> >  };
> > =20
> > +enum thermal_trend {
> > +	THERMAL_TREND_STABLE, /* temperature is stable */
> > +	THERMAL_TREND_RAISING, /* temperature is raising */
> > +	THERMAL_TREND_DROPPING, /* temperature is dropping */
> > +};
> > +
> >  struct thermal_zone_device_ops {
> >  	int (*bind) (struct thermal_zone_device *,
> >  		     struct thermal_cooling_device *);
> > @@ -65,6 +71,8 @@ struct thermal_zone_device_ops {
> >  	int (*set_trip_hyst) (struct thermal_zone_device *, int,
> >  			      unsigned long);
> >  	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long=
 *);
> > +	int (*get_trend) (struct thermal_zone_device *, int,
> > +			  enum thermal_trend *);
> >  	int (*notify) (struct thermal_zone_device *, int,
> >  		       enum thermal_trip_type);
> >  };
> > @@ -111,6 +119,7 @@ struct thermal_zone_device {
> >  	int tc2;
> >  	int passive_delay;
> >  	int polling_delay;
> > +	int temperature;
> >  	int last_temperature;
> >  	bool passive;
> >  	unsigned int forced_passive;
> >=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
