From: Giuseppe Martino <denever-GaUfNO9RBHfsrOwW+9ziJQ@public.gmane.org>
Subject: powernow & ACPI & 2.6.9
Date: Fri, 19 Nov 2004 09:38:51 +0100
Message-ID: <20041119083851.GB2908@mithrandir.dakordnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi to All,

I'm trying to switching from 2.6.8 to 2.6.9.
But I have some problems with ACPI and powernow.

Output of Kernel 2.6.8:

powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: FSB: 132.713 MHz
powernow: Found PSB header at c00f06f0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 8 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:3 (@c00f0746)
powernow:  cpuid: 0x7a0	fsb: 133	maxFID: 0x1a	startvid: 0x7
powernow:    FID: 0x0 (11.0x [1459MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x1 (11.5x [1526MHz])	VID: 0xd (1.350V)
powernow:    FID: 0x2 (12.0x [1592MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x3 (12.5x [1658MHz])	VID: 0xb (1.450V)
powernow:    FID: 0x14 (13.0x [1725MHz])	VID: 0xa (1.500V)
powernow:    FID: 0x15 (13.5x [1791MHz])	VID: 0x9 (1.550V)
powernow:    FID: 0x18 (15.0x [1990MHz])	VID: 0x8 (1.600V)
powernow:    FID: 0x1a (16.0x [2123MHz])	VID: 0x7 (1.650V)
powernow: SGTC: 13333
powernow: Minimum speed 1459 MHz. Maximum speed 2123 MHz.

Output of Kernel 2.6.9:

powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: No PST tables match this cpuid (0x7a0)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 298 MHz. Maximum speed 796 MHz.

Output on Kernel 2.6.9 patched with acpi-20041105-26-latest-release.diff.bz2:

powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: No PST tables match this cpuid (0x7a0)
powernow: This is indicative of a broken BIOS.
powernow: Trying ACPI perflib
powernow: Minimum speed 298 MHz. Maximum speed 796 MHz.

The kernel 2.6.9 isn't able to catch my DSDT?

How could I fix it?

Thank you
Giuseppe

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnbEbxuD9vfcGfeARArTtAJ4sbrA/Ikeu6atyJqkkrrF4yNUnlgCgkLQ7
8nkijDN0kp37MtaZgaMKZ+Y=
=6srJ
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
