From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next] fujitsu-laptop: depends on INPUT
Date: Fri, 27 Jun 2008 00:22:28 +1000
Message-ID: <20080627002228.6e1e2368.sfr@canb.auug.org.au>
References: <20080623093449.b4f19f85.randy.dunlap@oracle.com>
	<200806260435.m5Q4ZadJ009415@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__27_Jun_2008_00_22_28_+1000_r8JNWxS4gEsvHl8/"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:34881 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbYFZOWg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 10:22:36 -0400
In-Reply-To: <200806260435.m5Q4ZadJ009415@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, akpm <akpm@linux-foundation.org>

--Signature=_Fri__27_Jun_2008_00_22_28_+1000_r8JNWxS4gEsvHl8/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2008 14:05:36 +0930 (CST) Jonathan Woithe <jwoithe@physics.a=
delaide.edu.au> wrote:
>
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> >=20
> > fujitsu-laptop uses input_* functions, so it should depend
> > on INPUT.
> :
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > ---
> >  drivers/misc/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > --- linux-next-20080623.orig/drivers/misc/Kconfig
> > +++ linux-next-20080623/drivers/misc/Kconfig
> > @@ -179,6 +179,7 @@ config FUJITSU_LAPTOP
> >          tristate "Fujitsu Laptop Extras"
> >          depends on X86
> >          depends on ACPI
> > +        depends on INPUT
> >          depends on BACKLIGHT_CLASS_DEVICE
> >          ---help---
> >  	  This is a driver for laptops built by Fujitsu:
>=20
> Ack.

I have added this to today's linux-next tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Jun_2008_00_22_28_+1000_r8JNWxS4gEsvHl8/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhjpiQACgkQTgG2atn1QN9BtQCeKBpIeIhEdFxEMSA9fVR/0PSX
OggAn30OigqqqeC/Nu13flm3DLJsSd7A
=ss9x
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Jun_2008_00_22_28_+1000_r8JNWxS4gEsvHl8/--
