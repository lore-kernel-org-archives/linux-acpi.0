From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Wed, 25 Jul 2012 13:07:56 +0200
Message-ID: <201207251307.57165.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <201207241127.43086.rjw@sisk.pl> <1343180282.1682.392.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:55907 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360Ab2GYLCL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jul 2012 07:02:11 -0400
In-Reply-To: <1343180282.1682.392.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Wednesday, July 25, 2012, Zhang Rui wrote:
> On =E4=BA=8C, 2012-07-24 at 11:27 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, July 24, 2012, Zhang Rui wrote:
> > > On =E5=9B=9B, 2012-07-19 at 23:19 +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > > > This function is used to update the cooling state of
> > > > > all the cooling devices that are binded to an active trip poi=
nt.
> > > >=20
> > > > s/binded/bound/
> > > >=20
> > > got it.
> > >=20
> > > > > This will be used for passive cooling as well, in the future =
patches.
> > > > > as both active and passive cooling can share the same algorit=
hm,
> > > > > which is
> > > > >=20
> > > > > 1. if the temperature is higher than a trip point,
> > > > >    a. if the trend is THERMAL_TREND_RAISING, use higher cooli=
ng
> > > > >       state for this trip point
> > > > >    b. if the trend is THERMAL_TREND_DROPPING, use lower cooli=
ng
> > > > >       state for this trip point
> > > > >=20
> > > > > 2. if the temperature is lower than a trip point, use lower
> > > > >    cooling state for this trip point.
> > > > >=20
> > > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > > ---
> > > > >  drivers/acpi/thermal.c        |    7 +++-
> > > > >  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++=
++++++------------
> > > > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > > > > index 73e335f..14c4879 100644
> > > > > --- a/drivers/acpi/thermal.c
> > > > > +++ b/drivers/acpi/thermal.c
> > > > > @@ -715,7 +715,12 @@ static int thermal_get_trend(struct ther=
mal_zone_device *thermal,
> > > > >  	if (thermal_get_trip_type(thermal, trip, &type))
> > > > >  		return -EINVAL;
> > > > > =20
> > > > > -	/* Only PASSIVE trip points need TREND */
> > > > > +	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > > > > +		/* aggressive active cooling */
> > > > > +		*trend =3D THERMAL_TREND_RAISING;
> > > > > +		return 0;
> > > >=20
> > > > Please move that into thermal_zone_trip_update() directly, unle=
ss you
> > > > need it elsewhere.
> > > >=20
> > > IMO, I can say that ACPI thermal wants aggressive active cooling,=
 as it
> > > will never spin down the fan when the temperature is higher than =
the
> > > trip point.
> >=20
> > I meant the code organization, not the functionality. :-)
> >=20
> sure.
>=20
> > Since thermal_get_trend() is static, it is not used outside of this=
 file,
> > so you can move the "if (type =3D=3D THERMAL_TRIP_ACTIVE)" conditio=
nal from it
> > directly into the caller (unless there are more callers, which I'm =
not sure
> > about without reading the whole code again).
> >=20
> sorry I still do not get it.
> the generic thermal layer is the caller of this callback.

I'm not talking about the callback, but of the static function with the
same name you've introduced into drivers/thermal/thermal_sys.c in the
previous patch. :-)

The only caller of this function seems to be thermal_zone_device_passiv=
e()
and my point is that it would be better to simply put the code from tha=
t
function into thermal_zone_device_passive() directly, unless there are
more callers added by the subsequent patches, which I'm not sure about.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
