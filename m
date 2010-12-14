From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from linux-acpi-2.6/test
Date: Tue, 14 Dec 2010 21:24:37 +0100
Message-ID: <201012142124.37270.rjw@sisk.pl>
References: <201012112339.53105.rjw@sisk.pl> <201012132225.05149.rjw@sisk.pl> <1292289696.3983.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55776 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759883Ab0LNUZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 15:25:31 -0500
In-Reply-To: <1292289696.3983.60.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday, December 14, 2010, ykzhao wrote:
> On Tue, 2010-12-14 at 05:25 +0800, Rafael J. Wysocki wrote:
> > On Monday, December 13, 2010, ykzhao wrote:
> > > On Sun, 2010-12-12 at 06:39 +0800, Rafael J. Wysocki wrote:
> > > > Hi Len,
> > > >=20
> > > > The following three patches seem to have been dropped from your=
 'test' branch.
> > > >=20
> > > > If that happened by accident, please reapply.  Otherwise, pleas=
e let me know
> > > > what's wrong with the patches so that I can fix them.
> > > >=20
> > > > [1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead=
 of
> > > >         acpi_bus_get_power() which is unsafe.
> > >=20
> > > =EF=BB=BFIt seems that the function of acpi_bus_update_power not =
only obtains
> > > the current power state, but also set the corresponding power sta=
te.
> > > Right?
> >=20
> > Yes, it does.
> >=20
> > > If the device reports the bogus power state, maybe we will set th=
e
> > > incorrect power state for the corresponding device when using the
> > > function of acpi_bus_update_power instead of acpi_bus_get_power.
> >=20
> > Please actually look at acpi_bus_get_power() (being removed by [2/3=
]) and note
> > that it _also_ modifies device->power.state (it doesn't return the =
state, actually),
> > so if the returned state is really bogus, we'll have a mismatch bet=
ween
> > device->power.state and the real state of the device.  This cannot =
be good.
>=20
> The device->power.state is also updated in the function of
> acpi_bus_get_power. But it won't try to call the _PSC or _ON/OFF meth=
od
> to really change the corresponding power state. It only reports the
> corresponding power state.=20
>=20
> > In the case of acpi_bus_update_power() we at least _try_ to keep th=
e two things
> > in sync.
>=20
> Yes. I agree that the acpi_bus_update_power can always assure that th=
e
> two things are in sync state. But =EF=BB=BFsome systems will report t=
he bogus
> power state although we already set another power state(For example:
> Maybe it reports that it is in D3 state because of bogus BIOS code). =
In
> such case if we try to turn off the corresponding power resource by
> using _PSC/_ON/_OFF method, maybe we will cut off the power supply fo=
r
> these devices.

If you put a device into D0 and __acpi_bus_get_power() sees it in D3, y=
ou never
know why that is so.  Either the device refused to change the state, in=
 which
case the reported value is valid, or it reports a wrong value, but ther=
e's no
way to tell which the case really is.  Assuming that the reported value=
 is
possibly wrong, we mishandle the case when it's actually correct.  Assu=
ming
that the reported value is correct we may end up putting the device int=
o the
state corresponding to the reported value, which effectively prevents i=
t from
going into D0.  In this case, though, our knowledge of the device state=
 is
consistent with the reported state, which I think is better.

Anyway, IMO the only place where acpi_bus_update_power() may possibly c=
ause
problems to happen on broken hardware is fan_get_cur_state(), but I'll =
only
change that if anyone reports a problem with it.  The other usage cases=
 are (a)
initialization and (b) resume where we have no real choice but to actua=
lly
trust the state reported ACPI control methods (because we don't know wh=
at
it is in the first place).

> > Note, this is _essentially_ important for power resources (if
> > acpi_bus_get_power() is used, the refcounts are _guaranteed_ not to=
 be in sync
> > with device->power.state in some situations).
> >=20
> > > In such case maybe the device can't work well.=20
> > >=20
> > > The bogus power state is reported for some devices on some laptop=
s. For
> > > example:=20
> > >     http://bugzilla.kernel.org/show_bug.cgi?id=3D8049
> > >     http://bugzilla.kernel.org/show_bug.cgi?id=3D11000
> >=20
> > These bugs are about acpi_bus_set_power() doing the acpi_bus_get_po=
wer()
> > before setting the state, which is wrong and is being removed by my=
 previous
> > patches (now in the Len's tree).
>=20
> It seems that another point is missed in previous patch.=20
>    Before the reworking patch of power resource, the force_power_stat=
e
> flag is used when setting the corresponding power state for some ACPI
> devices(For example: Fan). This flag will still force to call the
> _PSC/_ON/_OFF method even when it is already the same as the target
> state. Maybe this is to workaround the BIOS issue that the power stat=
e
> is not reported correctly first time.
>=20
>    Not sure whether my above understanding is reasonable.

The force_power_state was _only_ a workaround for the case when
acpi_bus_set_power() called acpi_bus_get_power() and apparently receive=
d
a wrong value from it on some systems (two of them had been identified,=
 one was
blacklisted in the end).  However, after my changes acpi_bus_set_power(=
)
doesn't call acpi_bus_get_power() (or any equivalent) any more, so this
workaround isn't necessary any more either.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
