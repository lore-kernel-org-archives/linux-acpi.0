From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: ACPI video.c brightness handler conflicts with toshiba_acpi
Date: Mon, 8 Sep 2008 21:24:29 +0400
Message-ID: <200809082124.34805.arvidjaar@mail.ru>
References: <200809061108.34877.arvidjaar@mail.ru> <200809061120.00224.arvidjaar@mail.ru> <200809080301.24907.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1283805.LSlVP7ShxU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx34.mail.ru ([194.67.23.200]:20938 "EHLO mx34.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbYIHRYj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Sep 2008 13:24:39 -0400
In-Reply-To: <200809080301.24907.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>
Cc: toshiba_acpi@memebeam.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

--nextPart1283805.LSlVP7ShxU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 08 September 2008, Thomas Renninger wrote:
> On Saturday 06 September 2008 09:19:59 am Andrey Borzenkov wrote:
> > On Saturday 06 September 2008, Andrey Borzenkov wrote:
> > > I have now two different devices that refer to the same hardware:
> > >
> > > lrwxrwxrwx 1 root root 0 2008-09-06 11:04 acpi_video0 ->
> > > ../../devices/virtual/backlight/acpi_video0/ lrwxrwxrwx 1 root root 0
> > > 2008-09-06 11:04 toshiba -> ../../devices/virtual/backlight/toshiba/
> > >
> > > Unfortunately, due to ACPI implementation the acpi_video0 one is much
> > > inferior (as it provides only effectively two levels instead of 8);
> > > and user level tools are apparently quite confused which one to selec=
t.
> > >
> > > Is there any mechanism that would allow tochiba_acpi to claim brightn=
ess
> > > for internal LCD screen that video would not attempt to grab it too?
> > >
> > > Of course manually disabling brightness handling in video is always
> > > possible,
> >
> > Actually it is not. brightness_switch_enabled only disables event handl=
ing;
> > it still resets actual brightness on loading and creates sysfs files to
> > confuse user space.
> >
> > > still is nice for this to be handled automatically.
> It is in latest ACPI test branch queued for 2.6.28.
> The problem in bug:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D9614
> is another. But the patchset pointed to in comment #43 should fix several=
,=20
> also your problem.
>=20
> If not, please tell me and open a new bug.
>=20

It was exactly the right one. I'll get a look at adding proper detection
for Toshiba HCI systems. Thank you!

--nextPart1283805.LSlVP7ShxU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjFX88ACgkQR6LMutpd94wDPgCfQuCdbTvk7Zbs1O+/5oQnpoML
dPAAn2bZtB2vmuRE6pDuprmwtishEtZX
=1wwW
-----END PGP SIGNATURE-----

--nextPart1283805.LSlVP7ShxU--
