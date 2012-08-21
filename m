From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 11/13] Thermal: Add a notification API
Date: Tue, 21 Aug 2012 08:17:57 +0300
Message-ID: <20120821051757.GV9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-12-git-send-email-durgadoss.r@intel.com>
 <1344841364.1682.796.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB5919A440@BGSMSX101.gar.corp.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:59080 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752011Ab2HUFSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:18:08 -0400
Received: by wicr5 with SMTP id r5so4521929wic.7
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:18:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5919A440@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hello,

On Mon, Aug 13, 2012 at 07:46:20AM +0000, R, Durgadoss wrote:
> Hi Rui,
>=20
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Monday, August 13, 2012 12:33 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; rjw@sisk.pl; linux-acpi@vger.kernel.org; linux=
-
> > pm@vger.kernel.org; eduardo.valentin@ti.com; amit.kachhap@linaro.or=
g;
> > wni@nvidia.com
> > Subject: Re: [PATCH 11/13] Thermal: Add a notification API
> >=20
> > On =E5=9B=9B, 2012-08-09 at 18:16 +0530, Durgadoss R wrote:
> > > This patch adds a notification API which the sensor drivers'
> > > can use to notify the framework. The framework then takes
> > > care of the throttling according to the configured policy.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
> > >  include/linux/thermal.h       |    1 +
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/ther=
mal_sys.c
> > > index 193d071..6931d81 100644
> > > --- a/drivers/thermal/thermal_sys.c
> > > +++ b/drivers/thermal/thermal_sys.c
> > > @@ -1309,6 +1309,24 @@ void thermal_cooling_device_unregister(str=
uct
> > thermal_cooling_device *cdev)
> > >  }
> > >  EXPORT_SYMBOL(thermal_cooling_device_unregister);
> > >
> > > +/**
> > > + * notify_thermal_framework - Sensor drivers use this API to not=
ify
> > framework
> > > + * @tz:		thermal zone device
> > > + * @trip:	indicates which trip point has been crossed
> > > + *
> > > + * This function handles the trip events from sensor drivers. It=
 starts
> > > + * throttling the cooling devices according to the policy config=
ured.
> > > + * For CRITICAL and HOT trip points, this notifies the respectiv=
e drivers,
> > > + * and does actual throttling for other trip points i.e ACTIVE a=
nd PASSIVE.
> > > + * The throttling policy is based on the configured platform dat=
a; if no
> > > + * platform data is provided, this uses the step_wise throttling=
 policy.
> > > + */
> > > +void notify_thermal_framework(struct thermal_zone_device *tz, in=
t trip)
> > > +{
> > > +	handle_thermal_trip(tz, trip);
> > > +}
> > > +EXPORT_SYMBOL(notify_thermal_framework);
> > > +
> > why thermal_zone_device_update() can not work here?
>=20
> It can work. But thermal_zone_device_update() goes over the
> list of all trip points whereas here we know 'trip' is the trip point
> that we have to handle now. So, why do we need to iterate over all tr=
ip
> points again ?
> That=E2=80=99s why it is implemented this way.

I see. But there is no example of usage of this API on this series?

>=20
> Thanks,
> Durga
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
