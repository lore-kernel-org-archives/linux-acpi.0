From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Toshiba Dynabook S7 ACPI problems
Date: Sun, 13 Jul 2003 10:58:33 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2wuem8g1i.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

I have just tried running Linux w/ACPI-20030619 on a new Toshiba
Dynabook SS7/290LNKW. It's a Centrino-based laptop. There are a number
of problems:

1. Fan control via ACPI does not work. There is a fan entry, but I can
manipulate the fan only via the special Toshiba module.

2. Thermal management: trip points look rather bogus:

  critical (S5):           115 C
  passive:                 114 C: tc1=3D9 tc2=3D2 tsp=3D1800 devices=3D0xcf=
f1d908=20
  active[0]:               114 C: devices=3D0xcff22648=20
  active[1]:               114 C: devices=3D0xcff22648=20

... but it seems something inside the machine does turn on the fan, even
though it isn't Linux.

3. I get LID button events fine, but the power button doesn't seem to
generate any events, which seems strange. Also, I'm getting battery
events every couple of seconds, in spite of the battery being full -- is
this normal? Example: (this was taken over the course of about 15
seconds)

  button/lid LID 00000080 00000003
  button/lid LID 00000080 00000004
  battery BAT1 00000080 00000001
  ac_adapter ADP1 00000080 00000000
  processor CPU0 00000080 00000000
  ac_adapter ADP1 00000080 00000001
  processor CPU0 00000080 00000000
  battery BAT1 00000080 00000001
  battery BAT1 00000080 00000001


4. I don't know if this is ACPI's fault, but it seems all devices want to
sit on the same IRQ:

  ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
  ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)

5. Intel Wireless card does not work (hey, Intel folks! what's up with
this?!) and of course the Pentium-M speedstepping is not supported yet
(sigh...)

Perhaps some of the above are notebook problems, not ACPI problems, but
I thought a report was valuable anyway. DSDT and dmesg provided on
request, please let me know if you'd like to see them.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EZ3JLth4/7/QhDoRAttEAJ9wWRwJIBj47NYcNiXpxrElFUH3QACeNVC5
lcg3binNkdLTKDKcQse60Oc=
=14Sg
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
