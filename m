From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: SSDT Disassemble AML to ASL errors
Date: 20 Jul 2003 20:42:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058730137.2290.4.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

To loading tables in right order.
Table [DSDT](id F005)
Table [SSDT](id F003)

I remember test in namespace/nsload.c
put this function=20
    (void) acpi_ns_load_table_by_type (ACPI_TABLE_SSDT);
    (void) acpi_ns_load_table_by_type (ACPI_TABLE_PSDT);
before=20
status =3D acpi_ns_load_table_by_type (ACPI_TABLE_DSDT);

and this errors appears in dmesg:
dswload-0183: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
psparse-0588 [10] ps_parse_loop         : During name lookup/catalog, AE_NO=
T_FOUND
psparse-1120: *** Error: , AE_NOT_FOUND

For me, look as a bug this errors appears, only if I put the functions read=
 SSDT first.
but the most interesting is :
I dump SSDT with:
 acpidmp SSDT > SSDT.bin
and try Disassemble AML to ASL with:
iasl -d SSDT.bin
and the file SSDT.dsl have this:

 dswload-0264: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUN=
D
 psparse-1283: *** Error: , AE_NOT_FOUND
Could not parse ACPI tables, AE_NOT_FOUND


thanks=20
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
