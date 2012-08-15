From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 07/13] Thermal: Update binding logic based on platform
 data
Date: Wed, 15 Aug 2012 14:53:39 +0800
Message-ID: <1345013619.1682.826.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-8-git-send-email-durgadoss.r@intel.com>
	 <1344840062.1682.786.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB5919A6E0@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1446 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2HOGxA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2012 02:53:00 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5919A6E0@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On =E4=B8=80, 2012-08-13 at 09:41 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Monday, August 13, 2012 12:11 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; rjw@sisk.pl; linux-acpi@vger.kernel.org; linux=
-
> > pm@vger.kernel.org; eduardo.valentin@ti.com; amit.kachhap@linaro.or=
g;
> > wni@nvidia.com
> > Subject: Re: [PATCH 07/13] Thermal: Update binding logic based on p=
latform data
> >=20
> > On =E5=9B=9B, 2012-08-09 at 18:15 +0530, Durgadoss R wrote:
> > > This patch updates the binding logic in thermal_sys.c
> > > It uses the platform layer data to bind a thermal zone
> > > to a cdev for a particular trip point.
> > >
> > >  * If we do not have platform data and do not have
> > >    .bind defined, do not bind.
> > >  * If we do not have platform data but .bind is
> > >    defined, then use tz->ops->bind.
> > >  * If we have platform data, use it to create binding.
> > >
> > > The same logic sequence is followed for unbind also.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  drivers/thermal/thermal_sys.c |  170
> > ++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 144 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/ther=
mal_sys.c
> > > index 195e529..748b12f 100644
> > > --- a/drivers/thermal/thermal_sys.c
> > > +++ b/drivers/thermal/thermal_sys.c
> > > @@ -158,6 +158,107 @@ static void retrieve_zone_params(struct
> > thermal_zone_device *tz)
> > >  	}
> > >  }
> > >
> > > +static void print_bind_err_msg(struct thermal_zone_device *tz,
> > > +			struct thermal_cooling_device *cdev, int ret)
> > > +{
> > > +	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n"=
,
> > > +				tz->type, cdev->type, ret);
> > > +}
> > > +
> > > +static void __bind(struct thermal_zone_device *tz, int mask,
> > > +			struct thermal_cooling_device *cdev)
> > > +{
> > > +	int i, ret;
> > > +
> > > +	for (i =3D 0; i < tz->trips; i++) {
> > > +		if (mask & (1 << i)) {
> > > +			ret =3D thermal_zone_bind_cooling_device(tz, i, cdev,
> > > +					THERMAL_NO_LIMIT,
> > THERMAL_NO_LIMIT);
> > > +			if (ret)
> > > +				print_bind_err_msg(tz, cdev, ret);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static void __unbind(struct thermal_zone_device *tz, int mask,
> > > +			struct thermal_cooling_device *cdev)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < tz->trips; i++)
> > > +		if (mask & (1 << i))
> > > +			thermal_zone_unbind_cooling_device(tz, i, cdev);
> > > +}
> > > +
> > > +static void update_bind_info(struct thermal_cooling_device *cdev=
)
> > > +{
> > > +	int i, ret;
> > > +	struct thermal_zone_params *tzp;
> > > +	struct thermal_zone_device *pos =3D NULL;
> > > +
> > > +	mutex_lock(&thermal_list_lock);
> > > +
> > > +	list_for_each_entry(pos, &thermal_tz_list, node) {
> > > +		if (!pos->tzp && !pos->ops->bind)
> > > +			continue;
> > > +
> > > +		if (!pos->tzp && pos->ops->bind) {
> > > +			ret =3D pos->ops->bind(pos, cdev);
> > > +			if (ret)
> > > +				print_bind_err_msg(pos, cdev, ret);
> > > +		}
> > > +
> > > +		tzp =3D pos->tzp;
> > > +		for (i =3D 0; i < tzp->num_cdevs; i++) {
> > > +			if (!strcmp(tzp->cdevs_name[i], cdev->type)) {
> > > +				__bind(pos, tzp->trip_mask[i], cdev);
> > > +				break;
> > > +			}
> > > +		}
> > > +	}
> > > +	mutex_unlock(&thermal_list_lock);
> > > +}
> >=20
> > I still do not understand why we need this kind of bind.
> > Say, the platform thermal driver knows the platform data, i.e. it k=
nows
> > which cooling devices should be bound to which trip points.
> > why we can not move this kind of logic to the .bind() callback, off=
ered
> > by the platform thermal driver?
> > say, in .bind() callback,
> > the platform thermal driver has the pointer of the platform data, r=
ight?
> > the .cdev parameter can be used to find the cooling device name,
> > and we can make the comparison there. instead of introducing new bi=
nding
> > functions in the generic thermal layer.
>=20
> For once, I got little confused between the generic platform thermal =
sensor
> drivers (the chip drivers) and the platform level driver (not specifi=
c for chip,
> but for a platform). So, yes we can put this in the platform level dr=
iver.
>=20
Hmm,
I'm not clear about the difference between these two drivers.
what is supposed to be done in the platform thermal sensor drivers and
what is supposed to be done in the platform level driver?

At least for now, all the thermal drivers are both thermal sensor drive=
r
and platform level driver, right?

thanks,
rui
> On the other hand, I believe we will have more and more platform ther=
mal
> drivers, as new devices arrive. And in each of the drivers, we are go=
ing to
> do the 'looping, finding cdev and then binding' part. I was wondering=
 wouldn't
> it be better to move the common code to the framework, so that the sa=
me
> code does not get duplicated, over several places.
>=20
>=20
>=20
> So, please give a second thought on this and let me know your opinion=
=2E

> Thanks,
> Durga


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
