From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sat, 8 Nov 2008 09:30:08 +0300
Message-ID: <200811080930.21462.arvidjaar@mail.ru>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <20081107072536.GA19583@elte.hu> <alpine.LFD.2.00.0811072033300.9051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2850020.qKdAuoilPZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx34.mail.ru ([194.67.23.200]:6539 "EHLO mx34.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbYKHGad (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 01:30:33 -0500
In-Reply-To: <alpine.LFD.2.00.0811072033300.9051@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

--nextPart2850020.qKdAuoilPZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 08 November 2008, Len Brown wrote:
>=20
> > > -enum reboot_type reboot_type =3D BOOT_KBD;
> > > +enum reboot_type reboot_type =3D BOOT_ACPI;
>=20
> > NAK.
> >=20
> > Your point that the set of systems where KBD-reboot is broken is=20
> > larger (and growing) than the set of systems where ACPI-reboot is=20
> > broken (which set probably has a constant size) is true.
> >=20
> > But still this change caused non-trivial regressions in v28 _worse_=20
> > than the inability to reboot cleanly, so this patch does not fly as-is=
=20
> > as we reverted it upstream for a good reason.
>=20
> If you can direct me to the failures that ACPI reset caused
> in 28, that would be great.=20

http://marc.info/?l=3Dlinux-kernel&m=3D122547719810921&w=3D2

> Obviously they are not on=20
> the linux-acpi archives because the x86 tree enabled
> ACPI reset and then disabled it w/o telling us...
>=20
> thanks,
> -Len
>=20
>=20



--nextPart2850020.qKdAuoilPZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVMfQACgkQR6LMutpd94wcfwCaAxPcY8EfCZDiYNwhLxgbSdCP
SOYAn2rK5hwKiQdi2C/MHCokc6ELIp7m
=yOM2
-----END PGP SIGNATURE-----

--nextPart2850020.qKdAuoilPZ--
