From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT table help
Date: Mon, 29 Sep 2003 14:55:37 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3D9E@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Martin List-Petersen <martin-4su4RWpjsplNbBYsakfBHQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The _OSI method requires one argument
Add "External (Z00Q)" statement to resolve the not found.


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of S=E9rgio =
Monteiro Basto
Sent: Monday, September 29, 2003 2:39 PM
To: Martin List-Petersen
Cc: acpi-devel
Subject: Re: [ACPI] DSDT table help

Hi=20
I think this errors are already corrected in early versions of ASL
Optimizing Compiler / AML Disassembler.
Please try acpica-20030918

thanks

On Mon, 2003-09-29 at 22:10, Martin List-Petersen wrote:
> Hi,
> i would like to have some help with some DSDT table errors, if anybody
> cares:
>=20
> --------------------------------
> This is the first machine:
> ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
> 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
>=20
> dsdt.asl   379:             If(\_OSI) {
> Error    1028 -  Too few arguments ^  (\_OSI requires 1)
> =20
> dsdt.asl   380:                 "Windows 2001"
> Error    1037 -                              ^ parse error, unexpected
> PARSEOP_STRING_LITERAL
> =20
> dsdt.asl   738:             Method(_S5D) {
> Warning  2033 - Unknown reserved name ^  (_S5D)
> =20
> ASL Input:  dsdt.asl - 1733 lines, 52667 bytes, 976 keywords
> Compilation complete. 2 Errors, 1 Warnings, 0 Remarks, 209 =
Optimizations
>=20
> --------------------------------
> And the other:
> ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
> 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
>=20
> dsdt.asl  1035:                         Store(Z00Q, Local0)
> Error    1022 -            Object does not exist ^  (Z00Q)
> =20
> dsdt.asl  1107:                         Store(Z00Q, Local0)
> Error    1022 -            Object does not exist ^  (Z00Q)
> =20
> dsdt.asl  1222:                         Store(Z00Q, Local0)
> Error    1022 -            Object does not exist ^  (Z00Q)
> =20
> dsdt.asl  1587: Method(_WAK, 1) {
> Warning  2026 -           ^ Reserved method must return a value (_WAK)
> =20
> ASL Input:  dsdt.asl - 1604 lines, 54452 bytes, 827 keywords
> Compilation complete. 3 Errors, 1 Warnings, 0 Remarks, 329 =
Optimizations
> --------------------------------
>=20
> Regards,
> Martin List-Petersen
> martin at list-petersen dot se
> --
> Somehow I reached excess without ever noticing when I was passing
> through satisfaction.
> -- Ashleigh Brilliant
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
