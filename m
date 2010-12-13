From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from linux-acpi-2.6/test
Date: Mon, 13 Dec 2010 22:25:04 +0100
Message-ID: <201012132225.05149.rjw@sisk.pl>
References: <201012112339.53105.rjw@sisk.pl> <1292229322.3983.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52228 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756572Ab0LMVZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Dec 2010 16:25:53 -0500
In-Reply-To: <1292229322.3983.29.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Monday, December 13, 2010, ykzhao wrote:
> On Sun, 2010-12-12 at 06:39 +0800, Rafael J. Wysocki wrote:
> > Hi Len,
> >=20
> > The following three patches seem to have been dropped from your 'te=
st' branch.
> >=20
> > If that happened by accident, please reapply.  Otherwise, please le=
t me know
> > what's wrong with the patches so that I can fix them.
> >=20
> > [1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead of
> >         acpi_bus_get_power() which is unsafe.
>=20
> =EF=BB=BFIt seems that the function of acpi_bus_update_power not only=
 obtains
> the current power state, but also set the corresponding power state.
> Right?

Yes, it does.

> If the device reports the bogus power state, maybe we will set the
> incorrect power state for the corresponding device when using the
> function of acpi_bus_update_power instead of acpi_bus_get_power.

Please actually look at acpi_bus_get_power() (being removed by [2/3]) a=
nd note
that it _also_ modifies device->power.state (it doesn't return the stat=
e, actually),
so if the returned state is really bogus, we'll have a mismatch between
device->power.state and the real state of the device.  This cannot be g=
ood.

In the case of acpi_bus_update_power() we at least _try_ to keep the tw=
o things
in sync.

Note, this is _essentially_ important for power resources (if
acpi_bus_get_power() is used, the refcounts are _guaranteed_ not to be =
in sync
with device->power.state in some situations).

> In such case maybe the device can't work well.=20
>=20
> The bogus power state is reported for some devices on some laptops. F=
or
> example:=20
>     http://bugzilla.kernel.org/show_bug.cgi?id=3D8049
>     http://bugzilla.kernel.org/show_bug.cgi?id=3D11000

These bugs are about acpi_bus_set_power() doing the acpi_bus_get_power(=
)
before setting the state, which is wrong and is being removed by my pre=
vious
patches (now in the Len's tree).

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
