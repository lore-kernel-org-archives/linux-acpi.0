From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Problems with AMD Athlon XP mobile, ALi 1533 Chipset, ATI IGP 320M Northbridge?
Date: Fri, 16 Jan 2004 23:41:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040116224105.GA4868@dominikbrodowski.de>
References: <25593.1074286212@www41.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <25593.1074286212-WTkpkIMATaBmcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lukas Schrangl <schrangl-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2004 at 09:50:12PM +0100, Lukas Schrangl wrote:
> I will send my dmidecode- output as soon as possible (rem: from other sit=
es
> I know that my laptop is very similar to the eMachines - e.g. the same bi=
os-
> updates work with both).
>=20
> I decided to send my request to acpi-devel, because after some research I
> found out that there are P- States in my SSDT and cpufreq and powernow-k7=
 do
> not work.
>=20
> I really wonder why acpi doesn't work either although the acpi- tables se=
em
> to be correct.

Probably because the P-States mentioned in the SSDT use the "FFixedHW"
resource type, and the ACPI processor module cannot know what this means in
real life. However, the info in the SSDT/DSDT can and will be used by the
powernow-k7 module in future.

	Dominik

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFACGiBZ8MDCHJbN8YRAhOWAKCOK0we320MUjM9H2/rTu9pO1ip4QCgg7Vs
LCUG8ExP/13bXeF7Od/vCJA=
=9sq4
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
