From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 07/13] Thermal: Update binding logic based on platform
 data
Date: Mon, 20 Aug 2012 21:11:17 +0300
Message-ID: <20120820181117.GP9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-8-git-send-email-durgadoss.r@intel.com>
 <1344840062.1682.786.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB5919A6E0@BGSMSX101.gar.corp.intel.com>
 <1345013619.1682.826.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591A2B97@BGSMSX101.gar.corp.intel.com>
 <1345087808.1682.833.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591A4FB1@BGSMSX101.gar.corp.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44691 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751296Ab2HTSL0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 14:11:26 -0400
Received: by weyu54 with SMTP id u54so4707423wey.31
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 11:11:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591A4FB1@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hello,

On Thu, Aug 16, 2012 at 03:31:55AM +0000, R, Durgadoss wrote:
> Hi Rui,
>=20
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Thursday, August 16, 2012 9:00 AM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; rjw@sisk.pl; linux-acpi@vger.kernel.org; linux=
-
> > pm@vger.kernel.org; eduardo.valentin@ti.com; amit.kachhap@linaro.or=
g;
> > wni@nvidia.com
> > Subject: RE: [PATCH 07/13] Thermal: Update binding logic based on p=
latform
> > data
> >=20
> > On =E4=B8=89, 2012-08-15 at 03:17 -0600, R, Durgadoss wrote:
> > > Hi Rui,
> > >
> > > > > > > +static void update_bind_info(struct thermal_cooling_devi=
ce
> > *cdev)
> > > > > > > +{
> > > > > > > +	int i, ret;
> > > > > > > +	struct thermal_zone_params *tzp;
> > > > > > > +	struct thermal_zone_device *pos =3D NULL;
> > > > > > > +
> > > > > > > +	mutex_lock(&thermal_list_lock);
> > > > > > > +
> > > > > > > +	list_for_each_entry(pos, &thermal_tz_list, node) {
> > > > > > > +		if (!pos->tzp && !pos->ops->bind)
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		if (!pos->tzp && pos->ops->bind) {
> > > > > > > +			ret =3D pos->ops->bind(pos, cdev);
> > > > > > > +			if (ret)
> > > > > > > +				print_bind_err_msg(pos, cdev, ret);
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		tzp =3D pos->tzp;
> > > > > > > +		for (i =3D 0; i < tzp->num_cdevs; i++) {
> > > > > > > +			if (!strcmp(tzp->cdevs_name[i], cdev->type))
> > {
> > > > > > > +				__bind(pos, tzp->trip_mask[i], cdev);
> > > > > > > +				break;
> > > > > > > +			}
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +	mutex_unlock(&thermal_list_lock);
> > > > > > > +}
> > > > > >
> > > > > > I still do not understand why we need this kind of bind.
> > > > > > Say, the platform thermal driver knows the platform data, i=
=2Ee. it
> > knows
> > > > > > which cooling devices should be bound to which trip points.
> > > > > > why we can not move this kind of logic to the .bind() callb=
ack, offered
> > > > > > by the platform thermal driver?
> > > > > > say, in .bind() callback,
> > > > > > the platform thermal driver has the pointer of the platform=
 data,
> > right?
> > > > > > the .cdev parameter can be used to find the cooling device =
name,
> > > > > > and we can make the comparison there. instead of introducin=
g new
> > binding
> > > > > > functions in the generic thermal layer.
> > > > >
> > > > > For once, I got little confused between the generic platform =
thermal
> > sensor
> > > > > drivers (the chip drivers) and the platform level driver (not=
 specific for
> > chip,
> > > > > but for a platform). So, yes we can put this in the platform =
level driver.
> > > > >
> > > > Hmm,
> > > > I'm not clear about the difference between these two drivers.
> > > > what is supposed to be done in the platform thermal sensor driv=
ers and
> > > > what is supposed to be done in the platform level driver?
> > >
> > > A sensor driver can be a generic chip driver like emc1403 (this i=
s the one
> > > that I have worked on..) or coretemp (the CPU DTS driver for x86)=
=2E They sit
> > > in different sub systems (these two in hwmon). We might not be al=
lowed
> > to
> > > add any thermal framework specific code in these drivers. The sam=
e driver
> > > works on all platforms.
> >=20
> > does the sensor know anything about the "policy"?
> > Say, does it have any trip points? does it know which device can be
> > throttled to cool itself?
> > I think the answer is "no", right?
>=20
> Yes. You are right :-)
> The answer is 'No'.
>=20
> > >
> > > A platform level thermal driver knows information about the therm=
al
> > sensors,
> > > and their zones on the platform; and is specific to the platform.
> > > For x86, this will be in drivers/x86/platform/ whereas might be i=
n some
> > other
> > > place for other architectures. An example is intel_mid_thermal.c =
which sits
> > > in drivers/x86/platform. We can add our thermal framework specifi=
c code
> > > to this driver.
> > >
> > but I think intel_mide_thermal driver is also a platform thermal se=
nsor
> > driver at the same time.
>=20
> Yes today it is both..

So, what is the conclusion from above? I think we need to have a call h=
ere as
it will drive how driver code is going to look like. So far, the way I =
am
designing the OMAP thermal support is that the temp sensor drivers woul=
d
know about how to cool the zones, at SoC level. But the cooling of a pl=
atform/end-product
level would require another driver, which would require knowledge of av=
ailability
of sensors and cooling devices, in order to define the board policy.

>=20
> > > >
> > > > At least for now, all the thermal drivers are both thermal sens=
or driver
> > > > and platform level driver, right?
> > >
> > > Not all the times, although there are some instances where both a=
re same.
> > > We use coretemp.c and intel_mid_thermal.c (which are different), =
for the
> > > x86 mid platforms.
> > >
> > so you want to use coretemp.c as a temperature sensor, and then bin=
d
> > your own cooling devices to it in your platform level thermal drive=
r?
>=20
> Yes, coretemp is one fine example.
> At least I would like to get the same thing done for emc1403.c
> (and few hwmon drivers)..
>=20
> Thanks,
> Durga
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
