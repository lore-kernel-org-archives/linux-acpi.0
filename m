From: Marc Franquesa <mark-KaoEA2pfkXWsTnJN9+BGXg@public.gmane.org>
Subject: Re: Suspend 2 disk
Date: Sat, 15 Nov 2003 14:44:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068903849.940.45.camel@nexus.l3jane.net>
References: <1068895745.944.9.camel@nexus.l3jane.net>
	 <20031115130211.GA12062@server.by>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7GUp2jgeKzx9nOR5+0KF"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031115130211.GA12062-skno0aUYb0LHCqZ3qdFy9g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-7GUp2jgeKzx9nOR5+0KF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On ds, 2003-11-15 at 14:02, Alex Yustasov wrote:

> > I know what says the docs, that I need to patch the kernel and use
> > additional software, but if in the past my Laptop made it without any
> > special software, I belive that it can make it now also without any
>=20
> and without any special hardware?

No, without any special hardware. Only the standard BIOS of the Dell
Inspiron Laptop.

Actually I can start my system using 2 kernels: the standard 2.4.20
non-patched (Red Hat) and the 2.4.22 vanilla kernel patched with the
ACPI patch.

In the first kernel (2.4.20-8 with apm) if i do a 'apm -s' it suspends
to disk (on a suspend partition on /dev/hda1) and resumes OK. In the
second kernel (2.4.22 acpi-patched) I can't (and I don't know how)
suspend to disk.


Thanks.


--=-7GUp2jgeKzx9nOR5+0KF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/ti2o4CVRFTc6wP8RAmpwAKCGn4IIpy7bYRk3omwJldIpoEvNtgCgtBsC
XHR/VNB7N3SHGZ6yGyiaMnM=
=oxQw
-----END PGP SIGNATURE-----

--=-7GUp2jgeKzx9nOR5+0KF--



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
