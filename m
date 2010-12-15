From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from
	linux-acpi-2.6/test
Date: Wed, 15 Dec 2010 10:17:35 +0800
Message-ID: <1292379455.3983.129.camel@localhost.localdomain>
References: <201012112339.53105.rjw@sisk.pl>
	 <201012132225.05149.rjw@sisk.pl>
	 <1292289696.3983.60.camel@localhost.localdomain>
	 <201012142124.37270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3001 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab0LOCXo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 21:23:44 -0500
In-Reply-To: <201012142124.37270.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Wed, 2010-12-15 at 04:24 +0800, Rafael J. Wysocki wrote:
> On Tuesday, December 14, 2010, ykzhao wrote:
> > On Tue, 2010-12-14 at 05:25 +0800, Rafael J. Wysocki wrote:
> > > On Monday, December 13, 2010, ykzhao wrote:
> > > > On Sun, 2010-12-12 at 06:39 +0800, Rafael J. Wysocki wrote:
> > > > > Hi Len,
> > > > >=20
> > > > > The following three patches seem to have been dropped from yo=
ur 'test' branch.
> > > > >=20
> > > > > If that happened by accident, please reapply.  Otherwise, ple=
ase let me know
> > > > > what's wrong with the patches so that I can fix them.
> > > > >=20
> > > > > [1/3] - Make fujitsu_laptop use acpi_bus_update_power() inste=
ad of
> > > > >         acpi_bus_get_power() which is unsafe.
> > > >=20
> > > > =EF=BB=BFIt seems that the function of acpi_bus_update_power no=
t only obtains
> > > > the current power state, but also set the corresponding power s=
tate.
> > > > Right?
> > >=20
> > > Yes, it does.
> > >=20
> > > > If the device reports the bogus power state, maybe we will set =
the
> > > > incorrect power state for the corresponding device when using t=
he
> > > > function of acpi_bus_update_power instead of acpi_bus_get_power=
=2E
> > >=20
> > > Please actually look at acpi_bus_get_power() (being removed by [2=
/3]) and note
> > > that it _also_ modifies device->power.state (it doesn't return th=
e state, actually),
> > > so if the returned state is really bogus, we'll have a mismatch b=
etween
> > > device->power.state and the real state of the device.  This canno=
t be good.
> >=20
> > The device->power.state is also updated in the function of
> > acpi_bus_get_power. But it won't try to call the _PSC or _ON/OFF me=
thod
> > to really change the corresponding power state. It only reports the
> > corresponding power state.=20
> >=20
> > > In the case of acpi_bus_update_power() we at least _try_ to keep =
the two things
> > > in sync.
> >=20
> > Yes. I agree that the acpi_bus_update_power can always assure that =
the
> > two things are in sync state. But =EF=BB=BFsome systems will report=
 the bogus
> > power state although we already set another power state(For example=
:
> > Maybe it reports that it is in D3 state because of bogus BIOS code)=
=2E In
> > such case if we try to turn off the corresponding power resource by
> > using _PSC/_ON/_OFF method, maybe we will cut off the power supply =
for
> > these devices.
>=20
> If you put a device into D0 and __acpi_bus_get_power() sees it in D3,=
 you never
> know why that is so.  Either the device refused to change the state, =
in which
> case the reported value is valid, or it reports a wrong value, but th=
ere's no
> way to tell which the case really is.  Assuming that the reported val=
ue is
> possibly wrong, we mishandle the case when it's actually correct.  As=
suming
> that the reported value is correct we may end up putting the device i=
nto the
> state corresponding to the reported value, which effectively prevents=
 it from
> going into D0.  In this case, though, our knowledge of the device sta=
te is
> consistent with the reported state, which I think is better.
>=20
> Anyway, IMO the only place where acpi_bus_update_power() may possibly=
 cause
> problems to happen on broken hardware is fan_get_cur_state(), but I'l=
l only
> change that if anyone reports a problem with it.  The other usage cas=
es are (a)
> initialization and (b) resume where we have no real choice but to act=
ually
> trust the state reported ACPI control methods (because we don't know =
what
> it is in the first place).

Agree.  Maybe the matter is the broken BIOS/hardware.

> > > Note, this is _essentially_ important for power resources (if
> > > acpi_bus_get_power() is used, the refcounts are _guaranteed_ not =
to be in sync
> > > with device->power.state in some situations).
> > >=20
> > > > In such case maybe the device can't work well.=20
> > > >=20
> > > > The bogus power state is reported for some devices on some lapt=
ops. For
> > > > example:=20
> > > >     http://bugzilla.kernel.org/show_bug.cgi?id=3D8049
> > > >     http://bugzilla.kernel.org/show_bug.cgi?id=3D11000
> > >=20
> > > These bugs are about acpi_bus_set_power() doing the acpi_bus_get_=
power()
> > > before setting the state, which is wrong and is being removed by =
my previous
> > > patches (now in the Len's tree).
> >=20
> > It seems that another point is missed in previous patch.=20
> >    Before the reworking patch of power resource, the force_power_st=
ate
> > flag is used when setting the corresponding power state for some AC=
PI
> > devices(For example: Fan). This flag will still force to call the
> > _PSC/_ON/_OFF method even when it is already the same as the target
> > state. Maybe this is to workaround the BIOS issue that the power st=
ate
> > is not reported correctly first time.
> >=20
> >    Not sure whether my above understanding is reasonable.
>=20
> The force_power_state was _only_ a workaround for the case when
> acpi_bus_set_power() called acpi_bus_get_power() and apparently recei=
ved
> a wrong value from it on some systems (two of them had been identifie=
d, one was
> blacklisted in the end).  However, after my changes acpi_bus_set_powe=
r()
> doesn't call acpi_bus_get_power() (or any equivalent) any more, so th=
is
> workaround isn't necessary any more either.

The flag of force_power_state will force it to do the transition of
power state even when the target state is already the same as the
current power state. Without this flag, it will skip the power
transition if the two states are consistent. This is useful under the
following cases: (The FAN device is used as an example)
    1. The initial state is reported as D0 state (But we don't know
whether the FAN device is really turned on)
    2. If we expect to turn on the corresponding FAN device for the
first time(put it into D0 state),  it will skip the power transition as
the check of "state =3D=3D device->power.state". In such case it will b=
e
better that the power transition is forced in order to assure that the
=46AN device is turned on by calling the _PSC/_ON object.=20

Thanks.
    Yakui=20

>=20
> Thanks,
> Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
