From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Tue, 25 May 2004 19:31:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085506261.3440.9.camel@localhost>
References: <20040525044514.GC2217@smeagol>
	 <Pine.LNX.4.60.0405251112580.1337@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QHGm3xn+xdPUWxeFQIoH"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0405251112580.1337-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-QHGm3xn+xdPUWxeFQIoH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

L=C3=AC marted=C3=AC, 2004/05/25 alle 11:17, +0200, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org ha sc=
ritto:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut Emma,
> I also use a TM634. You probably have compiled your kernel with APIC=20
> support
>   CONFIG_X86_UP_APIC
> As the TM63x does not have an APIC, it is best, to make a kernel without=20
> that. Then it will power-off. I use a stock 2.6.6-kernel (as the=20
> ACPI-patches go into mainline so quickly...)

same problem here with sony vaio tr2: no power off unless apic is
removed. sorry for the dumb question but if the apic is not there why
does acpi say something like "apic found: re-enabling bios"?

federico

--=20
Federico Di Gregorio                         http://people.initd.org/fog
Debian GNU/Linux Developer                                fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
INIT.D Developer                                           fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
  We are all dust, Saqi, so play the lute
                    We are all wind, Saqi, so bring wine. -- Omar Khayam

--=-QHGm3xn+xdPUWxeFQIoH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAs4LVvcCgrgZGjesRApkhAJ9Lx569XI/vxTTIXu5OrVFa2rsHMwCguDUW
OO0h8bancyN8UnuWh9R9W4U=
=84qi
-----END PGP SIGNATURE-----

--=-QHGm3xn+xdPUWxeFQIoH--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
