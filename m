From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Compaq Presario and Overriding Bios's DSDT
Date: 02 Aug 2002 01:24:02 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028265844.2394.8.camel@darkstar.portugal>
References: <Pine.LNX.4.44.0207292308330.1067-100000@nagada.raceme.loc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Ok6YRhyY+dQeaRbTO/4o"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0207292308330.1067-100000-ebPZwV3Hi81W4s3OGYaEKcXXUOn6P5/W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Christophe Boyanique <tof-I4ScXmxXXsAdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-Ok6YRhyY+dQeaRbTO/4o
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


First of all correct me if i am wrong, nothing in this email is for
sure.

thank you, for the introduction on overriding Bios's DSDT=20

btw today I upgrade the bios with rompaqs released in 15 of July 2002.=20

first I try with iasl-linux-20020611.tar.gz (wrong!)=20

get: iasl-linux-20020725.tar.gz

cat /proc/acpi/dsdt > dsdt1.dat


./iasl  -d dsdt1.dat

Intel ACPI Component Architecture=20
ASL Compiler / AML Disassembler version 20020725 [Jul 25 2002]=20
Copyright (C) 2000 - 2002 Intel Corporation=20
Supports ACPI Specification Revision 2.0a=20

Loading Acpi table from file dsdt1.dat=20
Acpi table [DSDT] successfully installed and loaded=20
Pass 1 parse=20
Pass 2 parse=20
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)=20
...........................................................................=
...........................................................................=
........................=20
Parsing completed=20
Disassembly completed, written to "dsdt1.dsl"=20

./iasl -tc -i dsdt1.dsl

Intel ACPI Component Architecture=20
ASL Compiler / AML Disassembler version 20020725 [Jul 25 2002]=20
Copyright (C) 2000 - 2002 Intel Corporation=20
Supports ACPI Specification Revision 2.0a=20

dsdt1.dsl   549:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   550:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   551:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   552:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   553:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   554:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   555:                     Zero=20
Error   1037 -              parse error ^=20

dsdt1.dsl   672:                 If (CondRefOf (_OSI, Local0))=20
Error   1022 -               Object does not exist ^  (_OSI)=20

dsdt1.dsl   674:                     If (\_OSI)=20
Error   1022 -         Object does not exist ^  (\_OSI)=20

dsdt1.dsl   676:                         "Windows 2001"=20
Error   1037 -                            parse error ^=20

dsdt1.dsl  2077:                     Field (ERAM, AnyAcc, NoLock,
Preserve)=20
Error   1048 -                                 ^ Host Operation Region
requires ByteAcc access=20

dsdt1.dsl  2777:                     PWST,   2,=20
Error   1051 -                          ^ Access width of Field Unit
extends beyond region limit=20

dsdt1.dsl  2780:                     PMST,   1=20
Error   1051 -                          ^ Access width of Field Unit
extends beyond region limit=20

ASL Input: dsdt1.dsl - 2807 lines, 96013 bytes, 1378 keywords=20
AML Output: DSDT.aml - 14196 bytes 385 named objects 993 executable
opcodes=20

Compilation complete. 13 Errors 0 Warnings=20

Now what ? :-)=20
Can anyone help me to fix the errors.=20
thanks in advance=20

S=E9rgioMB


P.S. I try the patch for override dsdt but it is worst then normal way.

is this the complete patch for overriding DSDT


--=-Ok6YRhyY+dQeaRbTO/4o
Content-Disposition: attachment; filename=patchacpi_overridedsdt.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patchacpi_overridedsdt.txt; charset=ISO-8859-1

--- linux-2.4.19/drivers/acpi/osl.c.orig	Sun Jul 28 18:08:29 2002
+++ linux-2.4.19/drivers/acpi/osl.c	Thu Aug  1 03:02:19 2002
@@ -71,6 +71,9 @@
 static void *acpi_irq_context =3D NULL;
=20
=20
+#include "dsdt.h"
+acpi_table_header *myDST =3D (acpi_table_header *) AmlCode;
+
 acpi_status
 acpi_os_initialize(void)
 {
@@ -221,7 +224,11 @@
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
=20
-	*new_table =3D NULL;
+	if (!strncmp(existing_table->signature, DSDT_SIG, 4))
+		*new_table =3D myDST;
+	else
+		*new_table =3D NULL;
+
 	return AE_OK;
 }
=20

--=-Ok6YRhyY+dQeaRbTO/4o--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
