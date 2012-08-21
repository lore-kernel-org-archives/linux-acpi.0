From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 10/13] Thermal: Remove throttling logic out of
 thermal_sys.c
Date: Tue, 21 Aug 2012 08:36:58 +0300
Message-ID: <20120821053658.GA9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-11-git-send-email-durgadoss.r@intel.com>
 <1344841200.1682.794.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB5919A46B@BGSMSX101.gar.corp.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:33505 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752143Ab2HUFhI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:37:08 -0400
Received: by wgbfm10 with SMTP id fm10so7682925wgb.34
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:37:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5919A46B@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hello,

On Mon, Aug 13, 2012 at 08:04:03AM +0000, R, Durgadoss wrote:
> Hi Rui,
>=20
> [cut.]
> > > +static void notify_user_space(struct thermal_zone_device *tz, in=
t trip)
> > > +{
> > > +	mutex_lock(&tz->lock);
> > > +
> > > +	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
> > > +
> > > +	mutex_unlock(&tz->lock);
> > > +}
> > > +
> > > +static void handle_non_critical_trips(struct thermal_zone_device=
 *tz,
> > > +			int trip, enum thermal_trip_type trip_type)
> > > +{
> > > +	int throttle_policy =3D THERMAL_STEP_WISE;
> > > +
> > > +	if (tz->tzp)
> > > +		throttle_policy =3D tz->tzp->throttle_policy;
> > > +
> > > +	switch (throttle_policy) {
> > > +	case THERMAL_FAIR_SHARE:
> > > +		fair_share_throttle(tz, trip);
> > > +		break;
> > > +	case THERMAL_STEP_WISE:
> > > +		step_wise_throttle(tz, trip);
> > > +		break;
> > > +	case THERMAL_USER_SPACE:
> > > +		notify_user_space(tz, trip);
> > > +		break;
> > > +	}
> >=20
> > this is a little different from what I thought.
> > IMO, each policy should register its pointer to the thermal framewo=
rk.
> > and tz->tzp points to the pointer of the policy using.
> > and then, in handle_non_critical_trips(), the code would be like th=
is:
> > if(tz->tzp)
> > 	tz->tzp->throttle(tz, trip);
> >=20
> > But this is also okay for now, because we have only one callback fo=
r
> > each policy.
>=20
> I completely agree with you here. When I was doing my initial develop=
ment,
> I found that some policies need two arguments/ some need three etc..
> That=E2=80=99s why could not do a function pointer implementation.
>=20
> Will try to fix it up in the next version of the patches.

Cool! I'd also prefer to use the ->ops type of design, if possible.

>=20
> Thank you,
> Durga
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
