From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: Why do I have a /sys/devices/system/cpu/cpuidle under kernel 2.6.24 with a Pentium M processor ?
Date: Tue, 5 Feb 2008 15:38:00 +0100
Message-ID: <200802051538.05956.toralf.foerster@gmx.de>
References: <200801311400.17811.toralf.foerster@gmx.de> <20080205021654.37286791.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1993314.Jrt3lSuqpE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbYBEOiJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 09:38:09 -0500
In-Reply-To: <20080205021654.37286791.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>, Sebastien Godard <sysstat@orange.fr>

--nextPart1993314.Jrt3lSuqpE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At Tuesday 05 February 2008 Andrew Morton wrote :
> On Thu, 31 Jan 2008 14:00:14 +0100 Toralf F=F6rster <toralf.foerster@gmx.=
de> wrote:
>=20
> (suitable cc's added)
>=20
> > I'm asking b/c this confuses the current sysstat up to version 8.0.4. An
>=20
> That would be bad.  Please define "confuses"?
>=20
> > $ ls -lR /sys/devices/system/cpu/
> >=20
> > gives :
> >=20
> > /sys/devices/system/cpu/:
> > total 0
> > drwxr-xr-x 4 root root 0 Jan 30 09:36 cpu0
> > drwxr-xr-x 2 root root 0 Jan 30 09:36 cpuidle
> >=20

The sysstat reports 2 CPUs : cpu0 contains the expected data, cpu1 has zero=
s.

I tested succesfulyl version 8.0.4.1 sent by Sebastien Godard which solved =
this
issue, but that version seems not to be released until today.


=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart1993314.Jrt3lSuqpE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHqHTNhyrlCH22naMRAnahAKCJM2keTm5m9t274OQxP37TAa98kACgu8ME
IgfVC4YdzxeOsGRtlS58nvY=
=DLkR
-----END PGP SIGNATURE-----

--nextPart1993314.Jrt3lSuqpE--
