From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from
	linux-acpi-2.6/test
Date: Tue, 14 Dec 2010 09:21:36 +0800
Message-ID: <1292289696.3983.60.camel@localhost.localdomain>
References: <201012112339.53105.rjw@sisk.pl>
	 <1292229322.3983.29.camel@localhost.localdomain>
	 <201012132225.05149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2105 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758834Ab0LNB1e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Dec 2010 20:27:34 -0500
In-Reply-To: <201012132225.05149.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, 2010-12-14 at 05:25 +0800, Rafael J. Wysocki wrote:
> On Monday, December 13, 2010, ykzhao wrote:
> > On Sun, 2010-12-12 at 06:39 +0800, Rafael J. Wysocki wrote:
> > > Hi Len,
> > >=20
> > > The following three patches seem to have been dropped from your '=
test' branch.
> > >=20
> > > If that happened by accident, please reapply.  Otherwise, please =
let me know
> > > what's wrong with the patches so that I can fix them.
> > >=20
> > > [1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead o=
f
> > >         acpi_bus_get_power() which is unsafe.
> >=20
> > =EF=BB=BFIt seems that the function of acpi_bus_update_power not on=
ly obtains
> > the current power state, but also set the corresponding power state=
=2E
> > Right?
>=20
> Yes, it does.
>=20
> > If the device reports the bogus power state, maybe we will set the
> > incorrect power state for the corresponding device when using the
> > function of acpi_bus_update_power instead of acpi_bus_get_power.
>=20
> Please actually look at acpi_bus_get_power() (being removed by [2/3])=
 and note
> that it _also_ modifies device->power.state (it doesn't return the st=
ate, actually),
> so if the returned state is really bogus, we'll have a mismatch betwe=
en
> device->power.state and the real state of the device.  This cannot be=
 good.

The device->power.state is also updated in the function of
acpi_bus_get_power. But it won't try to call the _PSC or _ON/OFF method
to really change the corresponding power state. It only reports the
corresponding power state.=20

> In the case of acpi_bus_update_power() we at least _try_ to keep the =
two things
> in sync.

Yes. I agree that the acpi_bus_update_power can always assure that the
two things are in sync state. But =EF=BB=BFsome systems will report the=
 bogus
power state although we already set another power state(For example:
Maybe it reports that it is in D3 state because of bogus BIOS code). In
such case if we try to turn off the corresponding power resource by
using _PSC/_ON/_OFF method, maybe we will cut off the power supply for
these devices.


> Note, this is _essentially_ important for power resources (if
> acpi_bus_get_power() is used, the refcounts are _guaranteed_ not to b=
e in sync
> with device->power.state in some situations).
>=20
> > In such case maybe the device can't work well.=20
> >=20
> > The bogus power state is reported for some devices on some laptops.=
 For
> > example:=20
> >     http://bugzilla.kernel.org/show_bug.cgi?id=3D8049
> >     http://bugzilla.kernel.org/show_bug.cgi?id=3D11000
>=20
> These bugs are about acpi_bus_set_power() doing the acpi_bus_get_powe=
r()
> before setting the state, which is wrong and is being removed by my p=
revious
> patches (now in the Len's tree).

It seems that another point is missed in previous patch.=20
   Before the reworking patch of power resource, the force_power_state
flag is used when setting the corresponding power state for some ACPI
devices(For example: Fan). This flag will still force to call the
_PSC/_ON/_OFF method even when it is already the same as the target
state. Maybe this is to workaround the BIOS issue that the power state
is not reported correctly first time.

   Not sure whether my above understanding is reasonable.

Thanks.
    Yakui
  =20
>=20
> Thanks,
> Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
