From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 09/16] Thermal: Introduce
 thermal_zone_trip_update()
Date: Thu, 26 Jul 2012 10:25:03 +0800
Message-ID: <1343269503.1682.403.camel@rui.sh.intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
	 <1343182273-32096-10-git-send-email-rui.zhang@intel.com>
	 <201207252231.38781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51251 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab2GZCXw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 22:23:52 -0400
In-Reply-To: <201207252231.38781.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E4=B8=89, 2012-07-25 at 22:31 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 25, 2012, Zhang Rui wrote:
> > This function is used to update the cooling state of
> > all the cooling devices that are bound to an active trip point.
> >=20
> > This will be used for passive cooling as well, in the future patche=
s.
> > as both active and passive cooling can share the same algorithm,
> > which is
> >=20
> > 1. if the temperature is higher than a trip point,
> >    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> >       state for this trip point
> >    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> >       state for this trip point
> >=20
> > 2. if the temperature is lower than a trip point, use lower
> >    cooling state for this trip point.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/thermal.c        |    7 +++-
> >  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++++++++=
------------
> >  2 files changed, 71 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 5417362..8f8e695 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -714,7 +714,12 @@ static int thermal_get_trend(struct thermal_zo=
ne_device *thermal,
> >  	if (thermal_get_trip_type(thermal, trip, &type))
> >  		return -EINVAL;
> > =20
> > -	/* Only PASSIVE trip points need TREND */
> > +	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > +		/* aggressive active cooling */
> > +		*trend =3D THERMAL_TREND_RAISING;
> > +		return 0;
> > +	}
> > +
>=20
> Do we still need the check below?
>=20
No.
Although there are other trip types like HOT/CRIT, but only updating
PASSIVE/ACTIVE points will invoke this thermal_get_trend callback.

> >  	if (type !=3D THERMAL_TRIP_PASSIVE)
> >  		return -EINVAL;
> > =20

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
