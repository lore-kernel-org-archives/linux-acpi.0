From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Bank screen after resume on Dell XPS M1330
Date: Wed, 6 May 2009 19:55:10 +0400
Message-ID: <200905061955.13161.arvidjaar@mail.ru>
References: <200905031111.50789.arvidjaar@mail.ru> <200905040627.36297.arvidjaar@mail.ru> <20090505194902.GC1379@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1906020.MeLp7MIPMC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx48.mail.ru ([94.100.176.62]:1808 "EHLO mx48.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbZEFPzQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 May 2009 11:55:16 -0400
In-Reply-To: <20090505194902.GC1379@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1906020.MeLp7MIPMC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 of May 2009 23:49:02 Pavel Machek wrote:
> On Mon 2009-05-04 06:27:35, Andrey Borzenkov wrote:
> > On Sunday 03 of May 2009 15:56:03 Matthew Garrett wrote:
> > > On Sun, May 03, 2009 at 03:43:28PM +0400, Andrey Borzenkov wrote:
> > > > On Sunday 03 of May 2009 14:59:32 Matthew Garrett wrote:
> > > > > On Sun, May 03, 2009 at 11:11:47AM +0400, Andrey Borzenkov=20
wrote:
> > > > > > 01:00.0 VGA compatible controller: nVidia Corporation
> > > > > > GeForce 8400M GS (rev a1)
> > > > >
> > > > > We don't know how to reinitialise nvidia graphics hardware.
> > > >
> > > > Just in case - same issue also after resume from hibernation. I
> > > > was under impression, that hibernation does not have these
> > > > issues as card goes via normal POST routine.
> > >
> > > Hm. That sounds a bit weirder.
> >
> > Is it worth further debugging? Anything I can provide?
>
> Try it with minimum config, init=3D/bin/bash? Switch to plain vga
> console?

As stated in my first mail, that is exactly what I started with :)

--nextPart1906020.MeLp7MIPMC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoBst4ACgkQR6LMutpd94zOlwCcCrgT0JnVmxd4H7WjV4aEeYp6
xsAAn0NnXVmg+s2+9X/Ea1isIZMs687y
=Ej9i
-----END PGP SIGNATURE-----

--nextPart1906020.MeLp7MIPMC--
