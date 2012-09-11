From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCHv3 13/15] Thermal: Remove throttling logic out of
 thermal_sys.c
Date: Tue, 11 Sep 2012 11:20:51 +0800
Message-ID: <1347333651.1682.1143.camel@rui.sh.intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
	 <1346500296-25200-14-git-send-email-durgadoss.r@intel.com>
	 <1347266657.1682.1086.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591B54AA@BGSMSX101.gar.corp.intel.com>
	 <1347323058.1682.1093.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591B6D84@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28305 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171Ab2IKDUC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Sep 2012 23:20:02 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591B6D84@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

On =E4=B8=80, 2012-09-10 at 21:05 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > On =E4=B8=80, 2012-09-10 at 02:56 -0600, R, Durgadoss wrote:
> > > Hi Rui,
> > >
> > > > -----Original Message-----
> > > > From: Zhang, Rui
> > > > Sent: Monday, September 10, 2012 2:14 PM
> > > > To: R, Durgadoss
> > > > Cc: lenb@kernel.org; linux-acpi@vger.kernel.org;
> > eduardo.valentin@ti.com
> > > > Subject: Re: [PATCHv3 13/15] Thermal: Remove throttling logic o=
ut of
> > > > thermal_sys.c
> > > [cut.]
> > >
> > > > > +
> > > > > +static void handle_non_critical_trips(struct thermal_zone_de=
vice *tz,
> > > > > +			int trip, enum thermal_trip_type trip_type)
> > > > > +{
> > > > > +	tz->governor->throttle(tz, trip);
> > > > > +}
> > > > here is the problem, we must make sure every registered thermal=
 zone
> > > > have a governor when it is running, right?
> > >
> > > Yes, agree with you. Had some thoughts here, but wanted to get yo=
ur
> > opinion
> > > before I implemented them.
> > >
> > > 1. We can make the default governor as 'user space', and make it =
load
> > inside
> > > thermal_sys.c (so that every zone will always have a default gove=
rnor)
> > >
> > No, the default governor should be step wise so that it behaves the=
 same
> > as before. if we use userspace as default governor, most of the the=
rmal
> > driver will stop working with this patch set.
>=20
> yes, I understand. Shall make step_wise default, and always loaded.
>=20
we can always make step-wise default, or we can ask users to select one
as default and load it.

> For user space, should we move it to a new .c file, and make it like
> other governors or can we keep it as it is ?
>=20
a new .c file for userspace governor.

> Thanks,
> Durga
>=20
> >=20
> > IMO, we should make all of the governors configurable, but at least=
 one
> > of them must be selected as the default governor, that's why we nee=
d
> > something below.
> >=20
> > choice
> >         prompt "Default thermal governor"
> >         default THERMAL_DEFAULT_GOV_STEP_WISE
> >         help
> >           This option sets which thermal governor shall be loaded a=
t
> >           startup.
> >=20
> > thanks,
> > rui
> >=20
> > > 2. All other governors, that are implemented in a separate .c fil=
e can be
> > > optional i.e. left to the user to select/deselect.
> > >
> > > IMO, this will make our implementation easier and cleaner.
> > > What do you think ?
> > >
> > > Thanks,
> > > Durga
> > >
> > > >
> > > > then the default governor must always be built in.
> > > > We can have a Kconfig option for step_wise, but we should not m=
ake it
> > > > configurable by users.
> > > > or we can use prompt to get the default governor at build time.=
 say
> > > >
> > > > choice
> > > >         prompt "Default thermal governor"
> > > >         default THERMAL_DEFAULT_GOV_STEP_WISE
> > > >         help
> > > >           This option sets which thermal governor shall be load=
ed at
> > > >           startup.
> > > >
> > > > config THERMAL_DEFAULT_GOV_STEP_WISE
> > > >         bool "step-wise"
> > > >         select THERMAL_GOV_STEP_WISE
> > > >         help
> > > >           Use the thermal governor 'step-wise' as default.blabl=
a
> > > >
> > > >
> > > > thanks,
> > > > rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
