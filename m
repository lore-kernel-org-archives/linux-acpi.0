From: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
Subject: problems with display after resume with samsung x10
Date: Sun, 29 Aug 2004 00:02:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408290002.55490.christian.hesse@linuxob.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2160313.2KeUPyKdV1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--nextPart2160313.2KeUPyKdV1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!

The power button wakes up my notebook (Samsung X10 with GeForce4 440 Go!) f=
rom=20
suspend to RAM since ACPI 20040715. However, the display staied black.

Now I've found a way to reactivate it. Switching to virtual terminal two (c=
hvt=20
2) and using this program [1] the display is activated but still stays blac=
k.=20
Switching to vt 7 shows this [2], the upper half of kdm on the middle botto=
m=20
part of the display.
Switching to a virtual terminal results in funny colors or black. To get kd=
m=20
back you have to use boot-radeon again.

Any chance that this will work properly in future?

[1] http://www.doesi.gmxhome.de/linux/tm800s3/resources/boot-radeon.c
[2] http://linux.eworm.net/snap_after_resume.jpg

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart2160313.2KeUPyKdV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMQEPlZfG2c8gdSURAj5mAJwKB8MgMX+hfV0qk/ihdWcgoTdp5QCg5WCK
TMDnEUysgSsKkMz4aGadhUo=
=BZqA
-----END PGP SIGNATURE-----

--nextPart2160313.2KeUPyKdV1--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
