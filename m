From: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: RE: [BK PATCH] acpismp=force fix
Date: 23 Jun 2003 10:01:42 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1056355301.1699.6.camel@laptop.fenrus.com>
References: <F760B14C9561B941B89469F59BA3A84725A302@orsmsx401.jf.intel.com>
Reply-To: arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UAQQOzRDpOTAF7MiKZ5d"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A302-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-UAQQOzRDpOTAF7MiKZ5d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 at 09:43, Grover, Andrew wrote:
> > From: Andrew Morton [mailto:akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org]=20
> > >    ACPI: make it so acpismp=3Dforce works (reported by Andrew Morton)
>=20
> > But prior to 2.5.72, CPU enumeration worked fine without=20
> > acpismp=3Dforce.=20
> > Now it is required.  How come?
>=20
> (I'm taking the liberty to update the subject, which I accidentally left
> blank)
>=20
> Because 2.4 has that behavior. One objection that people raised to
> applying the 2.4 ACPI patch was that it changed that behavior. So I made
> an effort to keep it there.

in 2.4 it is absolutely not mantadory; it's default actually if the cpu
advertises the "ht" flag.....

--=-UAQQOzRDpOTAF7MiKZ5d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9rPlxULwo51rQBIRAmSHAKCDUsXRO2DOFNGf38nO5sBgkcFkuQCZAcv2
HNtXVEwyuU1xFkOH5fihIHU=
=jskh
-----END PGP SIGNATURE-----

--=-UAQQOzRDpOTAF7MiKZ5d--
