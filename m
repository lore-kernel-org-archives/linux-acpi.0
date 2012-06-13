From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 0/4] Thermal Framework Enhancements
Date: Wed, 13 Jun 2012 08:50:15 +0800
Message-ID: <1339548615.1973.58.camel@rui.sh.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
	 <1339487081.1973.13.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB59135DE1@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19403 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab2FMAsh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 20:48:37 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59135DE1@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>

On =E4=BA=8C, 2012-06-12 at 02:59 -0600, R, Durgadoss wrote:
> Thanks Rui for taking a Quick Look.
> I am not replying to all your comments, because most of them look fin=
e to me.
>=20
> [A big cut]
>=20
> > > 	   1. Introduces the get_trend callback
> > seems duplicate work of my patch set. :(
>=20
> Yes I agree. I was in the middle of testing yesterday,
> so could not change it before today.
> I will review your 12 patches, and pull in here the needed ones.
> So, my next patch set will have those changes, and they don=E2=80=99t=
 conflict.
>=20
> >=20
> > > 	   2. Introduces the notify_thermal_framework() API
> >=20
> > > 	   3. Exposes sysfs to show/store the throttle_policy
> > >
> > yes, I think we need this.
> >=20
> > > Patch 2/4: Introduce fair_share governor
> > > 	   This throttles the cooling_devices according to their
> > > 	   weights (and hence the name; Suggestion are welcome :-).
> > > 	   The weights in turn describe the effectiveness of a
> > > 	   particular cooling device in cooling a thermal zone.
> > >
> >=20
> > > Patch 3/4: Introduce step_wise governor
> > > 	   This throttles/de-throttles the cooling devices one
> > > 	   step at a time. This is exactly similar to the code
> > > 	   we have in thermal_zone_device_update function. The
> > > 	   intention is to move all 'throttling logic' related
> > > 	   code outside thermal_sys.c and keep them separate.
> >=20
> > totally agree.
>=20
> Oh that=E2=80=99s nice. Will incorporate this change in my next patch=
 set.
> Thank you for this.
>=20
> > > * Add more protection and tidy up the existing ones
> > > * Expose the weights and cooling devices through sysfs (Read-Only=
)
> >=20
> > what do you mean "cooling devices"?
>=20
> I meant for a thermal zone, we should expose:
> one Sysfs: that will list the weights of all cooling devices associat=
ed with this
> other Sysfs: that will list the names of cooling devices (in the same=
 order as
> weights)
> This is just to let user land know of the binding
> I should have put 'names of cooling devices'.
>=20
so I have two questions,
1. should kernel thermal manager handle these weights?
2. if yes, IMO, we can add one field in thermal_instance to describe
this weight. and then, the problem to me is that, we should easily
introduce an attribute for each cooling device instance, say,
/sys/class/thermal/thermal_zone0/cdev0_trip_point
                                /cdev0_weight
=2E..

> >=20
> > Yep, I think this is handled in my arbitrator patch. :p
>=20
> ok...I have not looked at it yet.
> Will have a look and incorporate the change in next patch set.
>=20
> >=20
> > >   (To do this, we have to loop through the thermal_tz_list and
> > >   thermal_cdev_list inside fair_share.c. Need to see how good it =
is
> > >   to make this lists public)
> >=20
> > IMO, these governors should just update the thermal_instance, and t=
hen
> > invokes thermal_zone_do_update(). They should not change the coolin=
g
> > state directly.
> >=20
>=20
> Give me some time to think about this one, will come back to you :-)
>=20
> > > * Make all _throttle methods have same signature. This way we can=
 make use
> > >   of function pointers and make the code a bit simpler.
> >=20
> > what does signature mean?
>=20
> Oh I meant they are all same 'taking similar arguments and same retur=
n type'.
> This way we can use an arr[function ptrs] that will be populated in e=
ach governor's
> init. This way inside the notify_framework method we don=E2=80=99t so=
 many case statements.
> We could just do arr[throttle_policy](...)
>=20
okay.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
