From: Martin List-Petersen <martin-4su4RWpjsplNbBYsakfBHQ@public.gmane.org>
Subject: DSDT table help
Date: Mon, 29 Sep 2003 23:10:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064869815.28949.45.camel@loke>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ExhFm40UDCebLZL0Nldg"
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


--=-ExhFm40UDCebLZL0Nldg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
i would like to have some help with some DSDT table errors, if anybody
cares:

--------------------------------
This is the first machine:
ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.asl   379:             If(\_OSI) {
Error    1028 -  Too few arguments ^  (\_OSI requires 1)
=20
dsdt.asl   380:                 "Windows 2001"
Error    1037 -                              ^ parse error, unexpected
PARSEOP_STRING_LITERAL
=20
dsdt.asl   738:             Method(_S5D) {
Warning  2033 - Unknown reserved name ^  (_S5D)
=20
ASL Input:  dsdt.asl - 1733 lines, 52667 bytes, 976 keywords
Compilation complete. 2 Errors, 1 Warnings, 0 Remarks, 209 Optimizations

--------------------------------
And the other:
ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.asl  1035:                         Store(Z00Q, Local0)
Error    1022 -            Object does not exist ^  (Z00Q)
=20
dsdt.asl  1107:                         Store(Z00Q, Local0)
Error    1022 -            Object does not exist ^  (Z00Q)
=20
dsdt.asl  1222:                         Store(Z00Q, Local0)
Error    1022 -            Object does not exist ^  (Z00Q)
=20
dsdt.asl  1587: Method(_WAK, 1) {
Warning  2026 -           ^ Reserved method must return a value (_WAK)
=20
ASL Input:  dsdt.asl - 1604 lines, 54452 bytes, 827 keywords
Compilation complete. 3 Errors, 1 Warnings, 0 Remarks, 329 Optimizations
--------------------------------

Regards,
Martin List-Petersen
martin at list-petersen dot se
--
Somehow I reached excess without ever noticing when I was passing
through satisfaction.
-- Ashleigh Brilliant

--=-ExhFm40UDCebLZL0Nldg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/eJ+2zAGaxP8W1ugRAvOgAKDjGwSf+BA2aA6+4G+2C4q0WL59nwCdGX+n
eLiV49LNC9NgqAkS0t09qYM=
=KmAT
-----END PGP SIGNATURE-----

--=-ExhFm40UDCebLZL0Nldg--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
