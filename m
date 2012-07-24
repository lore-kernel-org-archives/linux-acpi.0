From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Tue, 24 Jul 2012 11:27:42 +0200
Message-ID: <201207241127.43086.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <201207192319.28882.rjw@sisk.pl> <1343094471.1682.354.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53883 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab2GXJV5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jul 2012 05:21:57 -0400
In-Reply-To: <1343094471.1682.354.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Tuesday, July 24, 2012, Zhang Rui wrote:
> On =E5=9B=9B, 2012-07-19 at 23:19 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > This function is used to update the cooling state of
> > > all the cooling devices that are binded to an active trip point.
> >=20
> > s/binded/bound/
> >=20
> got it.
>=20
> > > This will be used for passive cooling as well, in the future patc=
hes.
> > > as both active and passive cooling can share the same algorithm,
> > > which is
> > >=20
> > > 1. if the temperature is higher than a trip point,
> > >    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> > >       state for this trip point
> > >    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> > >       state for this trip point
> > >=20
> > > 2. if the temperature is lower than a trip point, use lower
> > >    cooling state for this trip point.
> > >=20
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/acpi/thermal.c        |    7 +++-
> > >  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++++++=
++------------
> > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > > index 73e335f..14c4879 100644
> > > --- a/drivers/acpi/thermal.c
> > > +++ b/drivers/acpi/thermal.c
> > > @@ -715,7 +715,12 @@ static int thermal_get_trend(struct thermal_=
zone_device *thermal,
> > >  	if (thermal_get_trip_type(thermal, trip, &type))
> > >  		return -EINVAL;
> > > =20
> > > -	/* Only PASSIVE trip points need TREND */
> > > +	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > > +		/* aggressive active cooling */
> > > +		*trend =3D THERMAL_TREND_RAISING;
> > > +		return 0;
> >=20
> > Please move that into thermal_zone_trip_update() directly, unless y=
ou
> > need it elsewhere.
> >=20
> IMO, I can say that ACPI thermal wants aggressive active cooling, as =
it
> will never spin down the fan when the temperature is higher than the
> trip point.

I meant the code organization, not the functionality. :-)

Since thermal_get_trend() is static, it is not used outside of this fil=
e,
so you can move the "if (type =3D=3D THERMAL_TRIP_ACTIVE)" conditional =
from it
directly into the caller (unless there are more callers, which I'm not =
sure
about without reading the whole code again).

That would make the code cleaner, because right now the condition is
hidden in thermal_get_trend() and it may not be clear to the reader of
thermal_zone_trip_update() that it is actually checked.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
