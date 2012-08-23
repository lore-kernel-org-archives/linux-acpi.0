From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 13/13] Thermal: Platform layer changes to provide
 thermal data
Date: Thu, 23 Aug 2012 08:23:36 +0800
Message-ID: <1345681416.1682.995.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-14-git-send-email-durgadoss.r@intel.com>
	 <20120821053950.GC9833@besouro>
	 <4D68720C2E767A4AA6A8796D42C8EB591AA82F@BGSMSX101.gar.corp.intel.com>
	 <1345528555.1682.958.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591AA8AD@BGSMSX101.gar.corp.intel.com>
	 <1345531954.1682.965.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591AAB2A@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30487 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749Ab2HWAWl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Aug 2012 20:22:41 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591AAB2A@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On =E4=BA=8C, 2012-08-21 at 03:28 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> >=20
> > On =E4=BA=8C, 2012-08-21 at 00:41 -0600, R, Durgadoss wrote:
> > > Hi Rui,
> > >
> > > > > > -----Original Message-----
> > > > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > > > owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> > > > > > Sent: Tuesday, August 21, 2012 11:10 AM
> > > > > > To: R, Durgadoss
> > > > > > Cc: lenb@kernel.org; Zhang, Rui; rjw@sisk.pl; linux-
> > acpi@vger.kernel.org;
> > > > > > linux-pm@vger.kernel.org; eduardo.valentin@ti.com;
> > > > > > amit.kachhap@linaro.org; wni@nvidia.com
> > > > > > Subject: Re: [PATCH 13/13] Thermal: Platform layer changes =
to
> > provide
> > > > > > thermal data
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Thu, Aug 09, 2012 at 06:16:05PM +0530, Durgadoss R wrote=
:
> > > > > > > This patch shows how can we add platform specific thermal=
 data
> > > > > > > required by the thermal framework. This is just an exampl=
e
> > > > > > > patch, and _not_ for merge.
> > > > > > >
> > > > > > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > > > > > ---
> > > > > > >  arch/x86/platform/mrst/mrst.c |   42
> > > > > > +++++++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 42 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/x86/platform/mrst/mrst.c
> > > > > > b/arch/x86/platform/mrst/mrst.c
> > > > > > > index fd41a92..0440db5 100644
> > > > > > > --- a/arch/x86/platform/mrst/mrst.c
> > > > > > > +++ b/arch/x86/platform/mrst/mrst.c
> > > > > > > @@ -30,6 +30,7 @@
> > > > > > >  #include <linux/mfd/intel_msic.h>
> > > > > > >  #include <linux/gpio.h>
> > > > > > >  #include <linux/i2c/tc35876x.h>
> > > > > > > +#include <linux/thermal.h>
> > > > > > >
> > > > > > >  #include <asm/setup.h>
> > > > > > >  #include <asm/mpspec_def.h>
> > > > > > > @@ -78,6 +79,30 @@ struct sfi_rtc_table_entry
> > > > > > sfi_mrtc_array[SFI_MRTC_MAX];
> > > > > > >  EXPORT_SYMBOL_GPL(sfi_mrtc_array);
> > > > > > >  int sfi_mrtc_num;
> > > > > > >
> > > > > > > +#define MRST_THERMAL_ZONES	3
> > > > > > > +struct thermal_zone_params tzp[MRST_THERMAL_ZONES] =3D {
> > > > > > > +	{ .thermal_zone_name =3D "CPU",
> > > > > > > +	.throttle_policy =3D THERMAL_FAIR_SHARE,
> > > > > > > +	.num_cdevs =3D 2,
> > > > > > > +	.cdevs_name =3D {"CPU", "Battery"},
> > > > > > > +	.trip_mask =3D {0x0F, 0x08},
> > > > > > > +	.weights =3D {80, 20}, },
> > > > > > > +
> > > > > > > +	{ .thermal_zone_name =3D "Battery",
> > > > > > > +	.throttle_policy =3D THERMAL_FAIR_SHARE,
> > > > > > > +	.num_cdevs =3D 1,
> > > > > > > +	.cdevs_name =3D {"Battery"},
> > > > > > > +	.trip_mask =3D {0x0F},
> > > > > > > +	.weights =3D {100}, },
> > > > > > > +
> > > > > > > +	{ .thermal_zone_name =3D "Skin",
> > > > > > > +	.throttle_policy =3D THERMAL_FAIR_SHARE,
> > > > > > > +	.num_cdevs =3D 2,
> > > > > > > +	.cdevs_name =3D {"Display", "Battery"},
> > > > > > > +	.trip_mask =3D {0x0F, 0x0F},
> > > > > > > +	.weights =3D {50, 50}, }
> > > > > >
> > > > > > Please consider the comment I sent on your data definition =
and also
> > the
> > > > > > comment I made on this patch on your RFC series.
> > > > >
> > > > > Yes.. I don't know why/how I missed it.
> > > > > Also, saw the same comment on one of the other patches also.
> > > > >
> > > > > Will surely fix this thing in v2.
> > > > >
> > > > > BTW, any suggestion for the 'name' of that structure ? :-)
> > > >
> > > > hmmm,
> > > > do we still have thermal_zone_platforms in patch v2?
> > > > I do not think we need this if we only bind devices via .bind()
> > > > callback.
> > >
> > > We can bind devices via .bind call back, and that will take some =
load
> > > off the framework code. But even then, we would need this structu=
re
> > > right ?
> > why?
> > I'd prefer introduce something like this,
> > struct thermal_bind_params {
> > 	int trip;
> > 	unsigned long upper;
> > 	unsinged long lower;
> > 	int weight;
> > 	int sample_period;
> > }
>=20
> Yes, this can work with little bit change like below:
>=20
> struct thermal_zone_params {
> 	const char *zone_name;
> 	int num_cdevs;
> 	struct thermal_bind_params[num_cdevs];
no, not num_cdevs.

Say CPU is used for both passive trip point 1 and passive trip point 2,
it has different lower/upper limit and weight.
and we need two thermal_bind_params here.

> };=20
>=20
> Where struct thermal_bind_params will be like this:
> 	{
> 	.cdev_name =3D "CPU"
and the cooling device name must be unique in this case, which I do not
think it is reasonable.
because cooling devices are registered from different drivers, we do no=
t
have a rule that followed by all these drivers.
> 	.trip_mask =3D 0x0F
> 	.weight =3D 70
> 	.lower =3D 2
> 	.upper =3D 4
> 	.sample_period =3D 1000 (1 ms)
> 	};
>=20
if we want a way to register a couple of binding information to thermal
framework together with the thermal zone, I'd prefer something like
this,

struct thermal_zone_params {
 	struct thermal_zone_device *tz;
	int count;
 	struct thermal_bind_params *bindings;
}
struct thermal_bind_params {
	.id =3D 1;
	.match =3D platform_match_callback();
	.cdev =3D NULL;
	.weight =3D 70
	...
}

and in thermal_zone_device_register, we can have the code like this:

list_for_each_entry(cdev, &thermal_cdev_list, node) {
	for (i =3D 0; i < tz->params->count, i++) {
		if (tz->params->bindings[i].cdev)
			continue;
		/* check if this is the binding for this device */
		if (tz->params->bindings[i].match(tz, cdev, i))
			continue;
		tz->params->bindings[i]->cdev =3D cdev;
		thermal_zone_bind_cooling_device(tz, cdev, &tz->params->binding[i]);
	}
}

and we can have similar code in thermal_cdev_register().

you can do whatever in your platform_match_callback(), either strcmp or
checking devdata, or anything else.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
