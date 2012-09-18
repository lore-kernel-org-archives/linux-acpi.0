From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCHv4 11/15] Thermal: Introduce a step_wise thermal governor
Date: Tue, 18 Sep 2012 16:22:00 +0800
Message-ID: <1347956520.1682.1231.camel@rui.sh.intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
	 <1347946506-18449-12-git-send-email-durgadoss.r@intel.com>
	 <1347952410.1682.1227.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591BD338@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5986 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab2IRIVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2012 04:21:47 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591BD338@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

On =E4=BA=8C, 2012-09-18 at 02:11 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
>=20
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Zhang Rui
> > Sent: Tuesday, September 18, 2012 12:44 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; eduardo.valentin@t=
i.com
> > Subject: Re: [PATCHv4 11/15] Thermal: Introduce a step_wise thermal
> > governor
> >=20
> > On =E4=BA=8C, 2012-09-18 at 11:05 +0530, Durgadoss R wrote:
> > > This patch adds a simple step_wise governor to the
> > > generic thermal layer. This algorithm throttles the
> > > cooling devices in a linear fashion. If the 'trend'
> > > is heating, it throttles by one step. And if the
> > > thermal trend is cooling it de-throttles by one step.
> > >
> > > This actually moves the throttling logic from thermal_sys.c
> > > and puts inside step_wise.c, without any change. This is
> > > always selected as the default governor.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  drivers/thermal/Kconfig     |    7 ++
> > >  drivers/thermal/Makefile    |    1 +
> > >  drivers/thermal/step_wise.c |  194
> > +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 202 insertions(+)
> > >  create mode 100644 drivers/thermal/step_wise.c
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 2200912..9f6a3aa 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -4,6 +4,7 @@
> > >
> > >  menuconfig THERMAL
> > >  	tristate "Generic Thermal sysfs driver"
> > > +	select STEP_WISE
> > >  	help
> > >  	  Generic Thermal Sysfs driver offers a generic mechanism for
> > >  	  thermal management. Usually it's made up of one or more therm=
al
> > > @@ -59,3 +60,9 @@ config FAIR_SHARE
> > >  	depends on THERMAL
> > >  	help
> > >  	  Enable this to manage platform thermals using fair-share gove=
rnor.
> > > +
> > > +config STEP_WISE
> > > +	bool "Step_wise thermal governor"
> > > +	depends on THERMAL
> > > +	help
> > > +	  Enable this to manage platform thermals using a simple linear
> >=20
> > if we always wants CONFIG_STEP_WISE built in, why bother to export =
this
> > config option to users?
> >=20
> > IMO, something like
> >  menuconfig THERMAL
> >   	tristate "Generic Thermal sysfs driver"
> > 	select STEP_WISE
> >=20
> >  config STEP_WISE
> > 	bool
> > 	depends on THERMAL
> >=20
> > is enough, SETP_WISE will always be selected.
> >=20
> > further more, we even do not need a config option for this governor=
,
> > just "obj-y +=3D step_wise.o" in Makefile.
>=20
> Yes, Thought through this. But I thought it would be good to align th=
is
> with the rest of the governors.
>=20

we'd better follow cpufreq governor to allow users to select the defaul=
t
governor, or else this configure option is needless because we never
want it to be cleared with CONFIG_THERMAL=3Dy.

> >=20
> > another question would be,
> > as this governor registration function is fs_initcall(),
> > what if a platform thermal driver is registered and gets a thermal =
event
> > before this governor being registered?
>=20
> Wonder if this can happen with the current code, since the
> thermal_sys.c also loads with fs_initcall.
>=20
you're right. this is not a problem.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
