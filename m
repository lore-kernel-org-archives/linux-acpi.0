From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Tue, 05 Aug 2008 07:55:53 +0200
Message-ID: <1217915753.8381.9.camel@hidalgo>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
	 <1217812580.2969.184.camel@rzhang-dt> <1217830192.4580.8.camel@hidalgo>
	 <200808041220.29892.trenn@suse.de>
	 <20080805000151.GJ24927@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M6jpvUjbuctEiXHoSLSs"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3-g19.free.fr ([212.27.42.29]:60327 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165AbYHEF5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Aug 2008 01:57:25 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 86C0517B562
	for <linux-acpi@vger.kernel.org>; Tue,  5 Aug 2008 07:57:23 +0200 (CEST)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5569517B54B
	for <linux-acpi@vger.kernel.org>; Tue,  5 Aug 2008 07:57:23 +0200 (CEST)
In-Reply-To: <20080805000151.GJ24927@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org


--=-M6jpvUjbuctEiXHoSLSs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On lun, 2008-08-04 at 21:01 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 04 Aug 2008, Thomas Renninger wrote:
> > On Monday 04 August 2008 08:09:52 Yves-Alexis Perez wrote:
> > > When booting to single user with acpi_backlight=3Dvendor, thinkpad-ac=
pi
> > > takes over backlight:
> > >
> > > Aug  4 07:54:38 hidalgo kernel:
> > > thinkpad_acpi: Disabling thinkpad-acpi brightness events by default..=
.
>=20
> See that one?

Hmhm yeah but then I have:
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: Standard ACPI backlight inte=
rface not available, thinkpad_acpi driver will take over control


> > > But when in user mode, brightness keys doesn't do anything either.
> > > Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
> > > to /sys/class/backlight/thinkpad_screen/brightness works.
> > That /proc/acpi/ibm/brightness does not and
> > /sys/class/backlight/thinkpad_screen/brightness=20
> > works is strange, this should be a bug?
>=20
> No.  It is just that the driver expects ACPI video to be sending the even=
ts,
> and it isn't, so you need to change some code in hotkey_init to stop
> disabling brightness events in the (ACPI video support in DSDT, ACPI vide=
o
> disabled and thinkpad-acpi is to handle the backlight) case.

Hmhm ok, so the thinkpad-acpi related patch miss some case handling
anyway?


> > Attached patch might help you (with acpi_backlight=3Dvendor)?
> > You should be able to apply this on my latest patchset, but use this pa=
tch
> > instead of the thinkpad_acpi one.
>=20
> HEAVY NAK on the thinkpad-acpi hunks in this one.  It is good for testing=
,
> but I don't want any automated handling of the brightness hotkeys in
> thinkpad-acpi unless we absolutely HAVE to emulate the older non-Vista
> firmware for some weird reason.  More on this at the end of this post.

Anyway I'd prefer going the =E2=80=9Cnormal=E2=80=9D way and use video.ko.

>=20
> Please check if updating hotkey_init doesn't solve the issue.  I am sorry=
 I
> didn't recall that detail to remind you about it when I looked your patch=
es
> over.

How should I update hotkey_init? Check for acpi_backlight=3Dvendor and not
disable brightness event?

> > > Cat'ing /proc/acpi/events still gives:
> > > video LCD0 00000086 00000000
> > > video LCD0 00000087 00000000
> > >
> > > At one time I get the 750ms delay, but I don't have the
> > > ibm/hotkey HKEY 00000080 00005010 at all.
>=20
> This is caused by EC+ACPI DSDT access.  Switch thinkpad-acpi brightness_m=
ode
> to use only ACPI DSDT ("CMOS" mode), and it should go away.  This should =
be
> the default on all Lenovo, though.

Hmmh, that's weird because I don't think I'm messing with the
brightness_mode options. But I can force it to use only CMOS mode and
test.

Anyway, I wasn't yet able to test Matthew's patches, they're not yet in
drm-2.6/master.

Cheers,
--=20
Yves-Alexis

--=-M6jpvUjbuctEiXHoSLSs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiX62QACgkQTUTAIMXAW65uawCfXD+oA4XsJWwTZzdCg1mRMgFq
nC0AoL0VhodXPzx7KUc09BK9rrN1XfR2
=oRVk
-----END PGP SIGNATURE-----

--=-M6jpvUjbuctEiXHoSLSs--
