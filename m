From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Bank screen after resume on Dell XPS M1330
Date: Sun, 3 May 2009 15:43:28 +0400
Message-ID: <200905031543.28977.arvidjaar@mail.ru>
References: <200905031111.50789.arvidjaar@mail.ru> <20090503105932.GA18170@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2381646.lJrR1rxrCr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx48.mail.ru ([94.100.176.62]:22616 "EHLO mx48.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbZECLng (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 May 2009 07:43:36 -0400
In-Reply-To: <20090503105932.GA18170@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2381646.lJrR1rxrCr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Sunday 03 of May 2009 14:59:32 Matthew Garrett wrote:
> On Sun, May 03, 2009 at 11:11:47AM +0400, Andrey Borzenkov wrote:
> > 01:00.0 VGA compatible controller: nVidia Corporation GeForce 8400M
> > GS (rev a1)
>
> We don't know how to reinitialise nvidia graphics hardware.

Just in case - same issue also after resume from hibernation. I was=20
under impression, that hibernation does not have these issues as card=20
goes via normal POST routine.

Hmm ... this implies users of nVidia are locked to proprietary driver if=20
suspend is required?

--nextPart2381646.lJrR1rxrCr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn9g2AACgkQR6LMutpd94y6jQCdGMVHYtRHvMklQLz3QUAmNRAf
NNcAoL4CaNHMD7EmO7NCZN39G4uSM4vC
=UwEg
-----END PGP SIGNATURE-----

--nextPart2381646.lJrR1rxrCr--
