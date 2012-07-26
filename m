From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 07/16] Thermal: Introduce .get_trend() callback.
Date: Thu, 26 Jul 2012 10:21:39 +0800
Message-ID: <1343269299.1682.399.camel@rui.sh.intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
	 <1343182273-32096-8-git-send-email-rui.zhang@intel.com>
	 <201207252219.55650.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45949 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab2GZCUX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 22:20:23 -0400
In-Reply-To: <201207252219.55650.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E4=B8=89, 2012-07-25 at 22:19 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 25, 2012, Zhang Rui wrote:
> > tc1 and tc2 are used by OSPM to anticipate the temperature trends.
> > But they are ACPI platform specific concepts.
> >=20
> > Introduce .get_trend() as a more general solution.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/thermal.c        |   33 +++++++++++++++++++++++++++++=
++++
> >  drivers/thermal/thermal_sys.c |   22 ++++++++++++++++++++--
> >  include/linux/thermal.h       |    9 +++++++++
> >  3 files changed, 62 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 0154eac..01c92fd 100644
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
> > index 62b4279..d406524 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -699,6 +699,21 @@ thermal_remove_hwmon_sysfs(struct thermal_zone=
_device *tz)
> >  }
> >  #endif
> > =20
> > +static void thermal_get_trend(struct thermal_zone_device *tz,
> > +		int trip, enum thermal_trend *trend)
> > +{
> > +	if (tz->ops->get_trend && !tz->ops->get_trend(tz, trip, trend))
> > +			return;
> > +
> > +	if (tz->temperature > tz->last_temperature)
> > +		*trend =3D THERMAL_TREND_RAISING;
> > +	else if (tz->temperature < tz->last_temperature)
> > +		*trend =3D THERMAL_TREND_DROPPING;
> > +	else
> > +		*trend =3D THERMAL_TREND_STABLE;
> > +	return;
> > +}
> > +
>=20
> As I said in the review of the previous version of this patch series,=
 I think
> that the code from the function above should go directly into
> thermal_zone_device_passive().  The ugly pointer manipulations would =
be
> avoidable in that case and the code would be cleaner overall in my op=
inion.
>=20
agreed.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
