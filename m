From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 13/13] Thermal: Platform layer changes to provide
 thermal data
Date: Tue, 21 Aug 2012 13:55:55 +0800
Message-ID: <1345528555.1682.958.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-14-git-send-email-durgadoss.r@intel.com>
	 <20120821053950.GC9833@besouro>
	 <4D68720C2E767A4AA6A8796D42C8EB591AA82F@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31614 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab2HUFyy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:54:54 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591AA82F@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On =E4=B8=80, 2012-08-20 at 23:52 -0600, R, Durgadoss wrote:
>=20
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> > Sent: Tuesday, August 21, 2012 11:10 AM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; Zhang, Rui; rjw@sisk.pl; linux-acpi@vger.kerne=
l.org;
> > linux-pm@vger.kernel.org; eduardo.valentin@ti.com;
> > amit.kachhap@linaro.org; wni@nvidia.com
> > Subject: Re: [PATCH 13/13] Thermal: Platform layer changes to provi=
de
> > thermal data
> >=20
> > Hello,
> >=20
> > On Thu, Aug 09, 2012 at 06:16:05PM +0530, Durgadoss R wrote:
> > > This patch shows how can we add platform specific thermal data
> > > required by the thermal framework. This is just an example
> > > patch, and _not_ for merge.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  arch/x86/platform/mrst/mrst.c |   42
> > +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/arch/x86/platform/mrst/mrst.c
> > b/arch/x86/platform/mrst/mrst.c
> > > index fd41a92..0440db5 100644
> > > --- a/arch/x86/platform/mrst/mrst.c
> > > +++ b/arch/x86/platform/mrst/mrst.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/mfd/intel_msic.h>
> > >  #include <linux/gpio.h>
> > >  #include <linux/i2c/tc35876x.h>
> > > +#include <linux/thermal.h>
> > >
> > >  #include <asm/setup.h>
> > >  #include <asm/mpspec_def.h>
> > > @@ -78,6 +79,30 @@ struct sfi_rtc_table_entry
> > sfi_mrtc_array[SFI_MRTC_MAX];
> > >  EXPORT_SYMBOL_GPL(sfi_mrtc_array);
> > >  int sfi_mrtc_num;
> > >
> > > +#define MRST_THERMAL_ZONES	3
> > > +struct thermal_zone_params tzp[MRST_THERMAL_ZONES] =3D {
> > > +	{ .thermal_zone_name =3D "CPU",
> > > +	.throttle_policy =3D THERMAL_FAIR_SHARE,
> > > +	.num_cdevs =3D 2,
> > > +	.cdevs_name =3D {"CPU", "Battery"},
> > > +	.trip_mask =3D {0x0F, 0x08},
> > > +	.weights =3D {80, 20}, },
> > > +
> > > +	{ .thermal_zone_name =3D "Battery",
> > > +	.throttle_policy =3D THERMAL_FAIR_SHARE,
> > > +	.num_cdevs =3D 1,
> > > +	.cdevs_name =3D {"Battery"},
> > > +	.trip_mask =3D {0x0F},
> > > +	.weights =3D {100}, },
> > > +
> > > +	{ .thermal_zone_name =3D "Skin",
> > > +	.throttle_policy =3D THERMAL_FAIR_SHARE,
> > > +	.num_cdevs =3D 2,
> > > +	.cdevs_name =3D {"Display", "Battery"},
> > > +	.trip_mask =3D {0x0F, 0x0F},
> > > +	.weights =3D {50, 50}, }
> >=20
> > Please consider the comment I sent on your data definition and also=
 the
> > comment I made on this patch on your RFC series.
>=20
> Yes.. I don't know why/how I missed it.
> Also, saw the same comment on one of the other patches also.
>=20
> Will surely fix this thing in v2.
>=20
> BTW, any suggestion for the 'name' of that structure ? :-)

hmmm,
do we still have thermal_zone_platforms in patch v2?
I do not think we need this if we only bind devices via .bind()
callback.

> Thanks,
> Durga
>=20
> >=20
> > > +};
> > > +
> > >  static void mrst_power_off(void)
> > >  {
> > >  }
> > > @@ -983,10 +1008,27 @@ static int __init sfi_parse_devs(struct
> > sfi_table_header *table)
> > >  	return 0;
> > >  }
> > >
> > > +static int mrst_get_thermal_params(struct thermal_zone_device *t=
z)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < MRST_THERMAL_ZONES; i++) {
> > > +		if (!strcmp(tzp[i].thermal_zone_name, tz->type)) {
> > > +			tz->tzp =3D &tzp[i];
> > > +			return 0;
> > > +		}
> > > +	}
> > > +	return -ENODEV;
> > > +}
> > > +
> > >  static int __init mrst_platform_init(void)
> > >  {
> > >  	sfi_table_parse(SFI_SIG_GPIO, NULL, NULL, sfi_parse_gpio);
> > >  	sfi_table_parse(SFI_SIG_DEVS, NULL, NULL, sfi_parse_devs);
> > > +
> > > +	/* Set platform thermal data pointer */
> > > +	get_platform_thermal_params =3D mrst_get_thermal_params;
> > > +
> > >  	return 0;
> > >  }
> > >  arch_initcall(mrst_platform_init);
> > > --
> > > 1.7.9.5
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
