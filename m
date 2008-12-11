From: Tony Vroon <tony@linx.net>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Thu, 11 Dec 2008 01:31:41 +0000
Message-ID: <1228959101.4045.19.camel@localhost>
References: <200812110120.mBB1KU9u027511@turbo.physics.adelaide.edu.au>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-vJ5E25gP1byMhXSbNaFO"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:34476 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756099AbYLKBcW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 20:32:22 -0500
In-Reply-To: <200812110120.mBB1KU9u027511@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org


--=-vJ5E25gP1byMhXSbNaFO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-12-11 at 11:50 +1030, Jonathan Woithe wrote:
> Do the laptops in question allow you to control each radio individually o=
r
> is it just a single global kill switch?

S6410, S6420 & E8410 all have the one global kill switch on the front.
It seems only the BIOS allows disabling individual radios.

> The only DSDT I have access to is the one from my box - an S7020.  This h=
as
> a hardware rfkill switch which AFAIK doesn't have a software interface.=20

I do believe the S7020 is similar in this respect. It has a global
all-or-nothing switch with no software override. I need to see the DSDT
to be sure, but I'm quite certain I can get an on/off status from it
like on mine.

> There are a few owners of more recent Fujitsu laptops on the list though;
> perhaps they can help out (although at first glance they may not have any
> models additional to those you've already got).

Alright. S6410 testing might still be useful once the code is out there
though. Most of my colleagues prefer to stay on a stable kernel and
don't have a C toolchain to hand.

> Despite this I'll get a DSDT for the S7020 for you in the next few days i=
f
> you like.

Yes please. That one is new to me :)

> Regards
>   jonathan

Regards,
Tony V.

--=-vJ5E25gP1byMhXSbNaFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAbX0ACgkQp5vW4rUFj5pY1gCgsUEb9G2V8QwNGCPJyO2+ier2
lUUAoLAhBMKAjz9no/MHb4dc3MDRJjYE
=huNx
-----END PGP SIGNATURE-----

--=-vJ5E25gP1byMhXSbNaFO--

