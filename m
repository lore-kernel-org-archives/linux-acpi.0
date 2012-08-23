From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 13/13] Thermal: Platform layer changes to provide
 thermal data
Date: Thu, 23 Aug 2012 08:11:46 +0800
Message-ID: <1345680706.1682.984.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-14-git-send-email-durgadoss.r@intel.com>
	 <20120821053950.GC9833@besouro>
	 <4D68720C2E767A4AA6A8796D42C8EB591AA82F@BGSMSX101.gar.corp.intel.com>
	 <1345528555.1682.958.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591AA8AD@BGSMSX101.gar.corp.intel.com>
	 <1345531954.1682.965.camel@rui.sh.intel.com>
	 <20120821085137.GA2606@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1958 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab2HWAKr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Aug 2012 20:10:47 -0400
In-Reply-To: <20120821085137.GA2606@besouro>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On =E4=BA=8C, 2012-08-21 at 11:51 +0300, Eduardo Valentin wrote:
> Hello,
>=20
> On Tue, Aug 21, 2012 at 02:52:34PM +0800, Zhang Rui wrote:
> > On =E4=BA=8C, 2012-08-21 at 00:41 -0600, R, Durgadoss wrote:
> > > Hi Rui,
> > >=20
> > > > > > -----Original Message-----
> > > > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > > > owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> > > > > > Sent: Tuesday, August 21, 2012 11:10 AM
> > > > > > To: R, Durgadoss
> > > > > > Cc: lenb@kernel.org; Zhang, Rui; rjw@sisk.pl; linux-acpi@vg=
er.kernel.org;
> > > > > > linux-pm@vger.kernel.org; eduardo.valentin@ti.com;
> > > > > > amit.kachhap@linaro.org; wni@nvidia.com
> > > > > > Subject: Re: [PATCH 13/13] Thermal: Platform layer changes =
to provide
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
and also the
> > > > > > comment I made on this patch on your RFC series.
> > > > >
> > > > > Yes.. I don't know why/how I missed it.
> > > > > Also, saw the same comment on one of the other patches also.
> > > > >
> > > > > Will surely fix this thing in v2.
> > > > >
> > > > > BTW, any suggestion for the 'name' of that structure ? :-)
> > > >=20
> > > > hmmm,
> > > > do we still have thermal_zone_platforms in patch v2?
> > > > I do not think we need this if we only bind devices via .bind()
> > > > callback.
> > >=20
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
> >=20
> > and use thermal_zone_bind_cooling_device(tz, cdev, thermal_bind_par=
ams),
> > throttle_policy should be set when invoking
> > thermal_zone_device_register.
> >=20
> > is there any information in thermal_zone_params can not be convert =
to
> > thermal_bind_params?
>=20
> IMO, we need to think here carefully. Ideally, we should have a set o=
f data
> describing the thermal bindings. This way the code would look simpler=
 and cleaner.
> If we define a good way to describe the thermal bindings, I don't see=
 why
> we would need much complexity in the platform driver.
>=20
> Assuming a good data structure design, the task of a platform driver =
would then be
> to fetch the thermal info, either from bootloader, parameters, DT, et=
c, then
> translate that into our binding descriptors, and pushing that data se=
t forward
> to the FW.
>=20
> It think the above approach is much cleaner

agreed.

>  than writing for every platform
> driver a set of function calls with static definitions telling what c=
ooling
> to do for each thermal zone.
>=20
please define "a set of function calls".

thanks,
rui
> What do you think?
>=20
> >=20
> > thanks,
> > rui
> >=20
> > >  Say, when we obtain platform data from a thermal driver, it
> > > should know 'what format the platform data is' ..correct ?
> > >=20
> > > I theoretically agree with you that individual platform drivers c=
an
> > > have data in their own format, but that will be a heavy loss on
> > > standardization.
> > >=20
> > > So,
> > > I will remove the extra bind code I added to framework, and
> > > (keep it the old way it was) but still prefer to have the structu=
re
> > > put in thermal.h.
> > >=20
> > > Thanks,
> > > Durga
> >=20
> >=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
