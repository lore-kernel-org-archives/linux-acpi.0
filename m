From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 06/16] Thermal: set upper and lower limits
Date: Mon, 23 Jul 2012 21:15:56 +0200
Message-ID: <201207232115.56498.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <201207192255.43570.rjw@sisk.pl> <1343033135.1682.335.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53029 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754651Ab2GWTKM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jul 2012 15:10:12 -0400
In-Reply-To: <1343033135.1682.335.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Monday, July 23, 2012, Zhang Rui wrote:
> On =E5=9B=9B, 2012-07-19 at 22:55 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > set upper and lower limits when binding
> > > a thermal cooling device to a thermal zone device.
> > >=20
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  Documentation/thermal/sysfs-api.txt |    6 ++++-
> > >  drivers/acpi/thermal.c              |   49 +++++++++++++++++++++=
+-------------
> > >  drivers/platform/x86/acerhdf.c      |    2 +-
> > >  drivers/thermal/thermal_sys.c       |   20 +++++++++-----
> > >  include/linux/thermal.h             |    3 ++-
> > >  5 files changed, 53 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/=
thermal/sysfs-api.txt
> > > index b7b3609..f169821 100644
> > > --- a/Documentation/thermal/sysfs-api.txt
> > > +++ b/Documentation/thermal/sysfs-api.txt
> > > @@ -84,7 +84,7 @@ temperature) and throttle appropriate devices.
> > > =20
> > >  1.3 interface for binding a thermal zone device with a thermal c=
ooling device
> > >  1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_d=
evice *tz,
> > > -		int trip, struct thermal_cooling_device *cdev);
> > > +	int trip, struct thermal_cooling_device *cdev, long upper, long=
 lower);
> > > =20
> > >      This interface function bind a thermal cooling device to the=
 certain trip
> > >      point of a thermal zone device.
> > > @@ -93,6 +93,10 @@ temperature) and throttle appropriate devices.
> > >      cdev: thermal cooling device
> > >      trip: indicates which trip point the cooling devices is asso=
ciated with
> > >  	  in this thermal zone.
> > > +    upper:the Maximum cooling state for this trip point.
> > > +          -1 means no upper limit, and the cooling device can be=
 in max_state.
> > > +    lower:the Minimum cooling state can be used for this trip po=
int.
> > > +          -1 means no lower limit, and the cooling device can be=
 in cooling state 0.
> >=20
> > If we have to use -1 (or all ones for unsigned long), I'd suggest t=
o define a
> > constant called CS_NO_LIMIT or something like that and use it inste=
ad of the
> > plain numbers.
> >=20
> agreed.
>=20
> > And perhaps change the name of the above to
> > thermal_zone_bind_cooling_device_limits() and define
> > thermal_zone_bind_cooling_device() as a static inline that will not=
 take the
> > extra two arguments and make it call thermal_zone_bind_cooling_devi=
ce_limits()
> > with the CS_NO_LIMIT values in there.
> >=20
> then you mean there are two APIs for binding?
> users can invoke thermal_zone_bind_cooling_device if they do not care
> the limits?

Yes.

> Hmm, I do not think we need to do this. And further more, as there ar=
e
> and there will be more and more parameters for binding, say, maybe
> weight/influence in the near future,

The majority of existing users don't care, it appears (as follows from
the rest of your patch).

> I'm thinking of using a struct thermal_bind_params to pass the parame=
ters
> instead.

Yes, you can do that if you know already that more parameters will be
necessary.  Still, a wrapper passing NULL in there may be useful for so=
me
users.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
