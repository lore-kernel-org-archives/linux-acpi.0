From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 07/13] Thermal: Update binding logic based on platform
 data
Date: Thu, 16 Aug 2012 11:30:08 +0800
Message-ID: <1345087808.1682.833.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-8-git-send-email-durgadoss.r@intel.com>
	 <1344840062.1682.786.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB5919A6E0@BGSMSX101.gar.corp.intel.com>
	 <1345013619.1682.826.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591A2B97@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5335 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab2HPD3E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2012 23:29:04 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591A2B97@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On =E4=B8=89, 2012-08-15 at 03:17 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > > > > +static void update_bind_info(struct thermal_cooling_device *=
cdev)
> > > > > +{
> > > > > +	int i, ret;
> > > > > +	struct thermal_zone_params *tzp;
> > > > > +	struct thermal_zone_device *pos =3D NULL;
> > > > > +
> > > > > +	mutex_lock(&thermal_list_lock);
> > > > > +
> > > > > +	list_for_each_entry(pos, &thermal_tz_list, node) {
> > > > > +		if (!pos->tzp && !pos->ops->bind)
> > > > > +			continue;
> > > > > +
> > > > > +		if (!pos->tzp && pos->ops->bind) {
> > > > > +			ret =3D pos->ops->bind(pos, cdev);
> > > > > +			if (ret)
> > > > > +				print_bind_err_msg(pos, cdev, ret);
> > > > > +		}
> > > > > +
> > > > > +		tzp =3D pos->tzp;
> > > > > +		for (i =3D 0; i < tzp->num_cdevs; i++) {
> > > > > +			if (!strcmp(tzp->cdevs_name[i], cdev->type)) {
> > > > > +				__bind(pos, tzp->trip_mask[i], cdev);
> > > > > +				break;
> > > > > +			}
> > > > > +		}
> > > > > +	}
> > > > > +	mutex_unlock(&thermal_list_lock);
> > > > > +}
> > > >
> > > > I still do not understand why we need this kind of bind.
> > > > Say, the platform thermal driver knows the platform data, i.e. =
it knows
> > > > which cooling devices should be bound to which trip points.
> > > > why we can not move this kind of logic to the .bind() callback,=
 offered
> > > > by the platform thermal driver?
> > > > say, in .bind() callback,
> > > > the platform thermal driver has the pointer of the platform dat=
a, right?
> > > > the .cdev parameter can be used to find the cooling device name=
,
> > > > and we can make the comparison there. instead of introducing ne=
w binding
> > > > functions in the generic thermal layer.
> > >
> > > For once, I got little confused between the generic platform ther=
mal sensor
> > > drivers (the chip drivers) and the platform level driver (not spe=
cific for chip,
> > > but for a platform). So, yes we can put this in the platform leve=
l driver.
> > >
> > Hmm,
> > I'm not clear about the difference between these two drivers.
> > what is supposed to be done in the platform thermal sensor drivers =
and
> > what is supposed to be done in the platform level driver?
>=20
> A sensor driver can be a generic chip driver like emc1403 (this is th=
e one
> that I have worked on..) or coretemp (the CPU DTS driver for x86). Th=
ey sit
> in different sub systems (these two in hwmon). We might not be allowe=
d to
> add any thermal framework specific code in these drivers. The same dr=
iver
> works on all platforms.

does the sensor know anything about the "policy"?
Say, does it have any trip points? does it know which device can be
throttled to cool itself?
I think the answer is "no", right?

>=20
> A platform level thermal driver knows information about the thermal s=
ensors,
> and their zones on the platform; and is specific to the platform.
> For x86, this will be in drivers/x86/platform/ whereas might be in so=
me other
> place for other architectures. An example is intel_mid_thermal.c whic=
h sits
> in drivers/x86/platform. We can add our thermal framework specific co=
de
> to this driver.
>=20
but I think intel_mide_thermal driver is also a platform thermal sensor
driver at the same time.

> >=20
> > At least for now, all the thermal drivers are both thermal sensor d=
river
> > and platform level driver, right?
> =20
> Not all the times, although there are some instances where both are s=
ame.
> We use coretemp.c and intel_mid_thermal.c (which are different), for =
the
> x86 mid platforms.
>=20
so you want to use coretemp.c as a temperature sensor, and then bind
your own cooling devices to it in your platform level thermal driver?

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
