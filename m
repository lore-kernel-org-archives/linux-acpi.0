From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 2.6] remove unnecessary check in acpi-cpufreq driver
Date: Mon, 19 Jan 2004 13:51:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040119125133.GB7163@dominikbrodowski.de>
References: <C386328088ED7F4E9F81AFBABDDF60DA03F9DB3C@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA03F9DB3C-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2004 at 06:03:01PM +0800, Ow Mun Heng wrote:
> > -----Original Message-----
> > From: Dominik Brodowski [mailto:linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org]
> > Sent: Tuesday, January 13, 2004 5:20 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] [PATCH 2.6] remove unnecessary check in acpi-cpufreq
> > driver
> >=20
> >=20
> > [re-sent as first try didn't reach the list]
> >=20
> > The acpi cpufreq driver includes a test at startup which=20
> > detects whether
> > ACPI P-States are supported on any CPU, and whether transitions work.
> > However, this test is faulty: it is only run _after_ the acpi=20
> > driver is
> > registered, causing race situations. Also, it doesn't save=20
> > anything _as_ the
> > driver is already registered. So, it can safely be removed.
>=20
> Which means that, for current users, there's no pending need to really=20
> change anything Right??

The test complicates matters in a way that doesn't justify its existence.

	Dominik

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAC9LUZ8MDCHJbN8YRAlZvAJ9hleJKD89eCcfnYS2vIYCyUBe7JwCgjCJz
lsKz+bs4B9gBExZGO4BlXLk=
=nmnA
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
