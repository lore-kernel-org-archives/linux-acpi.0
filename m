From: Andreas Leppert <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: Re: About DSDT fixing and debugging
Date: Thu, 23 Sep 2004 16:59:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040923145905.GA14360@laptop>
References: <I4HK00$27530FB661DF79A95160CDA9EDFBAE18@libero.it> <20040923125525.GA19982@laptop> <4152B880.6050001@pca.it> <20040923123751.GA29424@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040923123751.GA29424-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2004 at 02:37:51PM +0200, Bruno Ducrot wrote:
> > Hello,
> >=20
> > on 09/23/04 14:55, Andreas Leppert wrote:
> > > just want to say that these are exactly the same problems i have with=
 my fujitsu amilo D 7830!
> > > no throttling (always C1 =3D 12%), no cooling (always 75=B0 C). i hav=
e already disassembled with a few=20
> > > errors, but couldn't fix it correctly.
> > about the C1 states: does your DSDT have a PBLK_lenght !=3D [0|6]? Plea=
se
> > see post [1] on ACPI-devel (sorry, I don't know how you can see the
> > whole thread with gmane.com) and the first integration _CST method [2].
didn't find PBLK_length in my dsdt.dsl because...

> >=20
>=20
> I think OP meant s/C1/T1 ;)
>=20
yes, i've really meant T1 =3D 12%... i was talking about the throttling=20
state.

question: does a pentium 4 (not mobile) in a laptop support C2/C3? (i=20
mean the processor states  when the cpu doesn't have much work!)

thank you guys


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUuS56EeWSkhF85cRAsOeAJ9pCHusGjC1wAkJc2o8bpwDFthPJACgq6Gr
/peibmPIIrxYm7tF3CiGV0w=
=bvQv
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
