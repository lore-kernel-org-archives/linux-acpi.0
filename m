From: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: RE: [ACPI] _PDC method in DSDT
Date: 23 Jun 2003 09:59:11 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <1056355150.1699.4.camel@laptop.fenrus.com>
References: <F760B14C9561B941B89469F59BA3A84725A301@orsmsx401.jf.intel.com>
Reply-To: arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t3Vw/yBdGAmYjQE0u6IG"
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A301-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Moore <dcm-HInyCGIudOg@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-t3Vw/yBdGAmYjQE0u6IG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 at 09:11, Grover, Andrew wrote:

> However, since the recently added non-vendor-supported Pentium M cpufreq
> driver uses hardcoded tables and cpuid instead of relying on ACPI for
> this information anyways, adding _PDC support to processor.c would not
> affect its behavior. If that driver were changed to use ACPI for
> determining platform capabilities, like Windows and our released binary
> driver do, then yes, adding _PDC support would be important.

Intel is more than welcome to release the linux driver under the GPL :)

--=-t3Vw/yBdGAmYjQE0u6IG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9rNOxULwo51rQBIRAgAmAJ9lrfozcJujl2Vf385qBaAy6Fi+vQCfZ17h
3JW6y8JhL+1PY8oPAFlYwvA=
=uU7I
-----END PGP SIGNATURE-----

--=-t3Vw/yBdGAmYjQE0u6IG--
