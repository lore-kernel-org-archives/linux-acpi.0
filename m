From: Martin Loschwitz <madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org>
Subject: ACPI related problems with Linux 2.6.1-rc1-mm1
Date: Thu, 1 Jan 2004 23:09:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040101220933.GB1804@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

I'm writing this mail as I'm discovering ACPI related problems on my Acer=
=20
TravelMate 800LCi notebook with Linux 2.6.1-rc1-mm1.

While the system boots up fine with Linux 2.6.1-rc1, with 2.6.1-rc1-mm1 it
hangs while booting. The last message printed to screen is "ACPI: IRQ 9=20
was Edge Triggered, setting to Level Triggerd". This is fully reproducable=
=20
with a Linux 2.6.0 kernel which has the ACPI20031203 patch applied.

Just for the records, with 2.6.1-rc1, the message that comes right after
the "ACPI: IRQ 9 ..." message is:

evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul

Is this a known problem and if so is a fix available?

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9JqdHPo+jNcUXjARAsbrAJ9y2a1ajnvgbyvK6lHpYnODeY95XACgoXkd
A1Tz2rnfBVd2n1VW1Ps2vJc=
=xvt9
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
