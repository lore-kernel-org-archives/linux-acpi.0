From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Reading battery consumes a lot of CPU
Date: Sat, 28 Feb 2004 11:35:14 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m27jy7f159.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--=-=-=

I've reported this a number of times (using various hardware, in fact)
over the last year or so. Thought I'd resend.

Reading the battery status seems to consume a disproportionate amount of
CPU time, such that running battery applets (wmacpi, etc) becomes
impractical. If I use them in their normal mode, the CPU rarely slows
down for me using cpudynd.

To give you an example, my wmacpi that updates the information every 30
seconds (!) has consumed 8 minutes and 10 seconds of CPU time over the
last 12 or so hours of laptop use.

jwr       6826  2.6  0.1  2668  436 ?        S    05:58   8:10 wmacpi

This makes it impractical to run battery monitors.

I'm using Linux-2.4.25 on a Sharp Mebius PC-MT2-H1 (and previously over
the last year all kinds of kernels and patches on this laptop and on a
Sharp Mebius PC-MT1-H5).

--J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAQO1zLth4/7/QhDoRArySAJ9CegRHl662jsagka3wC97KWxIPXQCg3Rjx
RPBZ8SCsgJtBdfPp7NNP6bU=
=i3u0
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
