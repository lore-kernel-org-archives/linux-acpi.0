From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sat, 8 Nov 2008 10:50:20 +0300
Message-ID: <200811081050.25477.arvidjaar@mail.ru>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4292351.UGMdQQufGr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx40.mail.ru ([194.67.23.36]:60636 "EHLO mx40.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbYKHHue (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 02:50:34 -0500
In-Reply-To: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

--nextPart4292351.UGMdQQufGr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 08 November 2008, Len Brown wrote:
>=20
> > > If you can direct me to the failures that ACPI reset caused
> > > in 28, that would be great.=20
> >=20
> > http://marc.info/?l=3Dlinux-kernel&m=3D122547719810921&w=3D2
>=20
> Andrey,
> Thanks for the quick reply.
>=20
> Hmm, google on Toshiba Portege 4000 suggests it shipped with Windows 2000,
> does it have a windows 2000 or a Windows XP sticker on it?
>=20

Designed for Microsoft=AE Windows=AE 2000 Profesional (I am surprised stick=
er
still sticks after all thee years :)

> Please open up a bug report
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> and attach the dmesg, plus the output from acpidump and dmidecode.
>=20

there is already bug report to track this regression; I added files there
but I am not able to change product (bug was opened by Rafael):

http://bugzilla.kernel.org/show_bug.cgi?id=3D11895

--nextPart4292351.UGMdQQufGr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVRMAACgkQR6LMutpd94zIGwCgyLVbtw5yd+VFOa7GLtwGX7IA
iY0An16IfLLuGom9zi4bD+9CEBk6mc/J
=fj7A
-----END PGP SIGNATURE-----

--nextPart4292351.UGMdQQufGr--
