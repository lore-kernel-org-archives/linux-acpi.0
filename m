From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: problem dumping/fixing dsdt
Date: 24 Sep 2002 03:32:02 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032840851.1565.22.camel@darkstar.portugal>
References: <200209221029.g8MATCX10556@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ibFjxINhtoD462bsdt7S"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209221029.g8MATCX10556-pb599fR3TxVkExQqqHjIK3sFFmKitW5W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: joerg.beyer-htSm2yLGOjU@public.gmane.org
Cc: acpilist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-ibFjxINhtoD462bsdt7S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I had the same problem with acpidump
you can use pmtools from intel acpi site 

http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
and get last (binary) iasl from same location .

tar xzvf pmtools-20010730.tar.gz
cd pmtools-20010730
make
cd acpidmp
./acpidmp DSDT > dsdt           (as root!)
./iasl  -d dsdt
correct dsdt.dsl
./iasl -tc -i dsdt.dsl

LINUXDIR=linux-2.4.20-pre7
cp -a dsdt.hex /usr/src/$LINUXDIR/drivers/acpi/tables/acpi_dsdt.c

and apply this patch :

--=-ibFjxINhtoD462bsdt7S
Content-Disposition: attachment; filename=patchacpi_dsdt2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patchacpi_dsdt2; charset=ISO-8859-1

--- linux-2.4.20-pre5/drivers/acpi/osl.c.orig	Wed Sep  4 00:39:54 2002
+++ linux-2.4.20-pre5/drivers/acpi/osl.c	Fri Sep  6 02:21:22 2002
@@ -70,6 +70,7 @@
 static OSD_HANDLER acpi_irq_handler =3D NULL;
 static void *acpi_irq_context =3D NULL;
=20
+extern unsigned char AmlCode[];
=20
 acpi_status
 acpi_os_initialize(void)
@@ -221,7 +222,10 @@
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
=20
-	*new_table =3D NULL;
+	if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0)
+		*new_table =3D (acpi_table_header*)AmlCode;
+	else
+		*new_table =3D NULL;
 	return AE_OK;
 }
=20

--=-ibFjxINhtoD462bsdt7S--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
