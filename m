From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 13 Nov 2008 07:58:09 +0300
Message-ID: <200811130758.13420.arvidjaar@mail.ru>
References: <200811081637.45099.arvidjaar@mail.ru> <200811121741.36296.trenn@suse.de> <20081113013259.GA24790@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11155954.Oi1pxkzapN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx38.mail.ru ([194.67.23.16]:49153 "EHLO mx38.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbYKME6T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 23:58:19 -0500
In-Reply-To: <20081113013259.GA24790@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

--nextPart11155954.Oi1pxkzapN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 13 November 2008, Matthew Garrett wrote:
> On Wed, Nov 12, 2008 at 05:41:35PM -0600, Thomas Renninger wrote:
> > On Tuesday 11 November 2008 02:04:15 pm Len Brown wrote:
> > > so when i apply this patch, i get fewer brightness levels.
> > > I prefer to have all 8 brightness levels.
> >=20
> > The patch from Andrey is correct.
> > Looks like all, the ordinary user needs, and probably the way it works =
on a =20
> > plain Vista OS is there: off, battery, full level.
> > You can still use the boot param for your specific needs:
> > acpi_display_output=3Dvendor
>=20
> The Toshiba BIOSes I've looked at all implement the ACPI code on top of=20
> the legacy interface. Do you have examples where that's not the case? If=
=20
> not, I don't see the harm in exposing both.
>=20

See http://marc.info/?l=3Dlinux-acpi&m=3D122068736714509&w=3D2 and related =
thread.

Basically situation is as follows:

=2D since some time both video and toshiba_acpi attempt to drive brightness

=2D on some (many? most?) Toshiba laptops standard-conform ACPI implementat=
ion
is inferior in that it is less fine grained than HCI one

=2D exposing two knobs for the *same* thing confuses user level tools; you =
never
know which one is used and they compete behind your back

=2D so effectively on Toshiba you *must* use acpi_brightness=3Dvendor or use
similar default in video_detect.c

=2D in which case we may just as well play it consistent and add support for
video/vendor switch to toshiba_acpi in case someone does want to use ACPI k=
nob
(be it even only for testing).

So the actual question is - how we detect Toshiba and default to vendor
brightness control?

--nextPart11155954.Oi1pxkzapN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkbs+IACgkQR6LMutpd94zFWQCfcQ//7Up/d3W1sNKO+18Qdyiy
x3YAn0zyli9RQZgl3bD/XtWFvT+NHvUX
=rO3e
-----END PGP SIGNATURE-----

--nextPart11155954.Oi1pxkzapN--
