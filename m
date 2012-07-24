From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Tue, 24 Jul 2012 09:47:51 +0800
Message-ID: <1343094471.1682.354.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-10-git-send-email-rui.zhang@intel.com>
	 <201207192319.28882.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15026 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127Ab2GXBqd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 21:46:33 -0400
In-Reply-To: <201207192319.28882.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On =E5=9B=9B, 2012-07-19 at 23:19 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 19, 2012, Zhang Rui wrote:
> > This function is used to update the cooling state of
> > all the cooling devices that are binded to an active trip point.
>=20
> s/binded/bound/
>=20
got it.

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
> > index 73e335f..14c4879 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -715,7 +715,12 @@ static int thermal_get_trend(struct thermal_zo=
ne_device *thermal,
> >  	if (thermal_get_trip_type(thermal, trip, &type))
> >  		return -EINVAL;
> > =20
> > -	/* Only PASSIVE trip points need TREND */
> > +	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > +		/* aggressive active cooling */
> > +		*trend =3D THERMAL_TREND_RAISING;
> > +		return 0;
>=20
> Please move that into thermal_zone_trip_update() directly, unless you
> need it elsewhere.
>=20
IMO, I can say that ACPI thermal wants aggressive active cooling, as it
will never spin down the fan when the temperature is higher than the
trip point.

But I'm not sure if this is true for other platforms.
say if a fan have 5 speeds.
it may want to run at the maximum speed when the temperature is raising=
,
but if the temperature begins to drop, it may want to spin down the fan
a little for some reason, say, power, noise, etc.

so I want the platform thermal drivers to have the maximum flexibility.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
