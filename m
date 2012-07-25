From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Wed, 25 Jul 2012 09:38:02 +0800
Message-ID: <1343180282.1682.392.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <201207192319.28882.rjw@sisk.pl>
	 <1343094471.1682.354.camel@rui.sh.intel.com>
	 <201207241127.43086.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46387 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab2GYBgp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 21:36:45 -0400
In-Reply-To: <201207241127.43086.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On =E4=BA=8C, 2012-07-24 at 11:27 +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 24, 2012, Zhang Rui wrote:
> > On =E5=9B=9B, 2012-07-19 at 23:19 +0200, Rafael J. Wysocki wrote:
> > > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > > This function is used to update the cooling state of
> > > > all the cooling devices that are binded to an active trip point=
=2E
> > >=20
> > > s/binded/bound/
> > >=20
> > got it.
> >=20
> > > > This will be used for passive cooling as well, in the future pa=
tches.
> > > > as both active and passive cooling can share the same algorithm=
,
> > > > which is
> > > >=20
> > > > 1. if the temperature is higher than a trip point,
> > > >    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> > > >       state for this trip point
> > > >    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> > > >       state for this trip point
> > > >=20
> > > > 2. if the temperature is lower than a trip point, use lower
> > > >    cooling state for this trip point.
> > > >=20
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > ---
> > > >  drivers/acpi/thermal.c        |    7 +++-
> > > >  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++++=
++++------------
> > > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > > >=20
> > > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > > > index 73e335f..14c4879 100644
> > > > --- a/drivers/acpi/thermal.c
> > > > +++ b/drivers/acpi/thermal.c
> > > > @@ -715,7 +715,12 @@ static int thermal_get_trend(struct therma=
l_zone_device *thermal,
> > > >  	if (thermal_get_trip_type(thermal, trip, &type))
> > > >  		return -EINVAL;
> > > > =20
> > > > -	/* Only PASSIVE trip points need TREND */
> > > > +	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > > > +		/* aggressive active cooling */
> > > > +		*trend =3D THERMAL_TREND_RAISING;
> > > > +		return 0;
> > >=20
> > > Please move that into thermal_zone_trip_update() directly, unless=
 you
> > > need it elsewhere.
> > >=20
> > IMO, I can say that ACPI thermal wants aggressive active cooling, a=
s it
> > will never spin down the fan when the temperature is higher than th=
e
> > trip point.
>=20
> I meant the code organization, not the functionality. :-)
>=20
sure.

> Since thermal_get_trend() is static, it is not used outside of this f=
ile,
> so you can move the "if (type =3D=3D THERMAL_TRIP_ACTIVE)" conditiona=
l from it
> directly into the caller (unless there are more callers, which I'm no=
t sure
> about without reading the whole code again).
>=20
sorry I still do not get it.
the generic thermal layer is the caller of this callback.
so you mean in thermal_zone_trip_update(),
when updating an active trip point, we set the trend to
THERMAL_TREND_RAISING explicitly?
in this way, all the platform thermal drivers will spin up the fan step
by step when the temperature is higher than the trip point, even if the
temperature is dropping. (Note that, this is not a problem for ACPI, as
there is only two state for ACPI FAN, on/off, it must be always on when
the temperature is higher than the active trip point. but other platfor=
m
may want to spin down the fan a little even if the system is still warm=
)

> That would make the code cleaner, because right now the condition is
> hidden in thermal_get_trend() and it may not be clear to the reader o=
f
> thermal_zone_trip_update() that it is actually checked.
>=20
why?
Readers should trust the value returned by
drivers/thermal/thermal_sys.c:thermal_get_trend().
And platform thermal drivers should provide the proper trend for active
trip points as well. If they don't, we will use the default trend by
comparing the current temperature and last temperature.

thanks,
rui

> Thanks,
> Rafael


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
