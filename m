From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCHv4 04/15] Thermal: Add platform level information to
 thermal.h
Date: Mon, 24 Sep 2012 13:43:34 +0800
Message-ID: <1348465414.10877.150.camel@rui.sh.intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
	 <1347946506-18449-5-git-send-email-durgadoss.r@intel.com>
	 <1348211569.10877.125.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591C038E@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64392 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab2IXFmw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 01:42:52 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591C038E@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

On =E4=BA=94, 2012-09-21 at 02:07 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Friday, September 21, 2012 12:43 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; eduardo.valentin@t=
i.com
> > Subject: Re: [PATCHv4 04/15] Thermal: Add platform level informatio=
n to
> > thermal.h
> >=20
> > On =E4=BA=8C, 2012-09-18 at 11:04 +0530, Durgadoss R wrote:
> > > This patch adds platform level information to thermal.h
> > > by introducing two structures to hold:
> > >  * bind parameters for a thermal zone,
> > >  * zone level platform parameters
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  include/linux/thermal.h |   29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 32af124..4caa32e 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -157,6 +157,7 @@ struct thermal_zone_device {
> > >  	int passive;
> > >  	unsigned int forced_passive;
> > >  	const struct thermal_zone_device_ops *ops;
> > > +	const struct thermal_zone_params *tzp;
> > >  	struct list_head thermal_instances;
> > >  	struct idr idr;
> > >  	struct mutex lock; /* protect thermal_instances list */
> > > @@ -164,6 +165,34 @@ struct thermal_zone_device {
> > >  	struct delayed_work poll_queue;
> > >  };
> > >
> > > +/* Structure that holds binding parameters for a zone */
> > > +struct thermal_bind_params {
> > > +	struct thermal_cooling_device *cdev;
> > > +
> > > +	/*
> > > +	 * This is a measure of 'how effectively these devices can
> > > +	 * cool 'this' thermal zone. The shall be determined by platfor=
m
> > > +	 * characterization. This is on a 'percentage' scale.
> > > +	 * See Documentation/thermal/sysfs-api.txt for more information=
=2E
> > > +	 */
> > > +	int weight;
> > > +
> > > +	/*
> > > +	 * This is a bit mask that gives the binding relation between t=
his
> > > +	 * thermal zone and cdev, for a particular trip point.
> > > +	 * See Documentation/thermal/sysfs-api.txt for more information=
=2E
> > > +	 */
> > > +	int trip_mask;
> > > +	int (*match) (struct thermal_zone_device *tz,
> > > +			struct thermal_cooling_device *cdev);
> > > +};
> >=20
> > we do not have field to describe the upper and lower limit?
>=20
> Looks like I missed it here :-(
> But, IMO, we need an array of 'upper' and 'lower' limits here .. corr=
ect ?

either is ok.
if we are using two integers, we need different bind params for trip
points that have different upper and lower limit.
we can still use one bind params to describe multiple trip points if
they do not have any upper and lower limit.

> Let me know how you would want to address it ?
> a separate patch or fix here ?
>=20
we can have an incremental patch for it.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
