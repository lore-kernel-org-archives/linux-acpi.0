From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: pmtools - acpiexec
Date: Tue, 6 Sep 2005 21:54:57 +0200
Message-ID: <20050906195457.GB27572@fuchi>
References: <6694B22B6436BC43B429958787E454984CF9E2@mssmsx402nb> <431C8454.5080408@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <431C8454.5080408-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello Thomas and others...

* Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> [2005-09-05 20:59 +0200]:
> Starikovskiy, Alexey Y wrote:
> >
> >Actually, acpiexec should work on Linux without any changes to source.
> >Besides, last version is 20050902.
> Very funny...,
> http://developer.intel.com/technology/iapc/acpi/downloads.htm
> still points to:
> http://developer.intel.com/technology/iapc/acpi/downloads/acpica-unix-200=
50624.tar.gz
>=20
> Is there another site to download latest changes?

i also know of
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
where the latest pmtools (e.g. acpidump) are to be found; 20050823 atm.

> An official read-only CVS (with mail notification on changes or similar)=
=20
> would really be appreciated.

or a single place for downloading acpica-unix and pmtools, for instance
the ftp-site on kernel.org. although some mail notification would be
superior and would enable me to keep acpi.sf.net better in sync.

cheers,
 Sebastian


> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas
> >Renninger
> >Sent: Monday, September 05, 2005 8:31 PM
> >To: ML ACPI-devel
> >Subject: [ACPI] pmtools - acpiexec
> >
> >I recently played with acpiexec to debug a DSDT.
> >
> >This seems to be a very useful tool to debug/execute DSDTs outside the
> >kernel?
> >Is it supposed to work?
> >
> >The first Hunk of this patch makes it compile/link again.
> >
> >It came out that the AcpiGbl_RootNode was not allocated.
> >I tried it with the second Hunk, but it seems as if this Node has
> >to be created in some special way, as parsing of the DSDT segfaults
> >when it tries to find the parent of the (global root?) node.

--=20
Oo.....................
Wer nicht fuer uns ist, ist fuer uns.
OpenPGP key ID: 0x7A62F9B4 Geekcode: GCSd-s:a-C++ULB+++W++M+PS+++
                                                ..................oO

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHfQRreHfL3pi+bQRAthhAJ9zizfwI0COICMVmg2FIo9/Y4g1fACfd9o0
s75q1cMJ91zAh53kMV6qMhg=
=k1mw
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
