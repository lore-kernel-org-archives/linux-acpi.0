From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Thu, 26 Jul 2012 08:49:17 +0800
Message-ID: <1343263757.1682.397.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <201207241127.43086.rjw@sisk.pl>
	 <1343180282.1682.392.camel@rui.sh.intel.com>
	 <201207251307.57165.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59760 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2GZAsA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 20:48:00 -0400
In-Reply-To: <201207251307.57165.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On =E4=B8=89, 2012-07-25 at 13:07 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 25, 2012, Zhang Rui wrote:
> > On =E4=BA=8C, 2012-07-24 at 11:27 +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, July 24, 2012, Zhang Rui wrote:
> > > > On =E5=9B=9B, 2012-07-19 at 23:19 +0200, Rafael J. Wysocki wrot=
e:
> > > > > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > > > > This function is used to update the cooling state of
> > > > > > all the cooling devices that are binded to an active trip p=
oint.
> > > > >=20
> > > > > s/binded/bound/
> > > > >=20
> > > > got it.
> > > >=20
> > > > > > This will be used for passive cooling as well, in the futur=
e patches.
> > > > > > as both active and passive cooling can share the same algor=
ithm,
> > > > > > which is
> > > > > >=20
> > > > > > 1. if the temperature is higher than a trip point,
> > > > > >    a. if the trend is THERMAL_TREND_RAISING, use higher coo=
ling
> > > > > >       state for this trip point
> > > > > >    b. if the trend is THERMAL_TREND_DROPPING, use lower coo=
ling
> > > > > >       state for this trip point
> > > > > >=20
> > > > > > 2. if the temperature is lower than a trip point, use lower
> > > > > >    cooling state for this trip point.
> > > > > >=20
> > > > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > > > ---
> > > > > >  drivers/acpi/thermal.c        |    7 +++-
> > > > > >  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++=
++++++++------------
> > > > > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.=
c
> > > > > > index 73e335f..14c4879 100644
> > > > > > --- a/drivers/acpi/thermal.c
> > > > > > +++ b/drivers/acpi/thermal.c
> > > > > > @@ -715,7 +715,12 @@ static int thermal_get_trend(struct th=
ermal_zone_device *thermal,
> > > > > >  	if (thermal_get_trip_type(thermal, trip, &type))
> > > > > >  		return -EINVAL;
> > > > > > =20
> > > > > > -	/* Only PASSIVE trip points need TREND */
> > > > > > +	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > > > > > +		/* aggressive active cooling */
> > > > > > +		*trend =3D THERMAL_TREND_RAISING;
> > > > > > +		return 0;
> > > > >=20
> > > > > Please move that into thermal_zone_trip_update() directly, un=
less you
> > > > > need it elsewhere.
> > > > >=20
> > > > IMO, I can say that ACPI thermal wants aggressive active coolin=
g, as it
> > > > will never spin down the fan when the temperature is higher tha=
n the
> > > > trip point.
> > >=20
> > > I meant the code organization, not the functionality. :-)
> > >=20
> > sure.
> >=20
> > > Since thermal_get_trend() is static, it is not used outside of th=
is file,
> > > so you can move the "if (type =3D=3D THERMAL_TRIP_ACTIVE)" condit=
ional from it
> > > directly into the caller (unless there are more callers, which I'=
m not sure
> > > about without reading the whole code again).
> > >=20
> > sorry I still do not get it.
> > the generic thermal layer is the caller of this callback.
>=20
> I'm not talking about the callback, but of the static function with t=
he
> same name you've introduced into drivers/thermal/thermal_sys.c in the
> previous patch. :-)
>=20
> The only caller of this function seems to be thermal_zone_device_pass=
ive()
> and my point is that it would be better to simply put the code from t=
hat
> function into thermal_zone_device_passive() directly, unless there ar=
e
> more callers added by the subsequent patches, which I'm not sure abou=
t.

hah, I understand.
yes, I can move thermal_sys.c thermal_get_trend() in to
thermal_trip_update.
and there will be no such confusion (two functions share the same name)
any more. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
