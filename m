From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w==@public.gmane.org>
Subject: Re: RV: differences between acpidump and disassembling
Date: Mon, 19 Apr 2004 22:16:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1082409395.11663.63.camel@darkstar>
References: <000701c425f8$6157aef0$0301a8c0@portatil>
	 <200404191309.45870.emejia@ieee.org>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w==@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404191309.45870.emejia-EkmVulN54Sk=@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA==@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg==@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: emejia-EkmVulN54Sk=@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-04-19 at 12:09, Emilio Mejia Fernandez de Velasco wrote:

you should work with pmtools that have acpidump
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
and=20
http://developer.intel.com/technology/iapc/acpi/downloads.htm
get last ACPI CA - Unix Build Environment - .TAR.GZ file, 530k
after untar cd complier ; make


> > grep -i ACPI
>=20
> I guess you mean grep -i acpi, with lower-case. don't you?

grep -i , is for ignore lower or uppercases .


> > cat /proc/acpi/dsdt > acpi_dsdt.dat
> > ./iasl  -d acpi_dsdt.dat
> > ./iasl -on -tc acpi_dsdt.dsl
>=20
> Attached is the file acpi_dsdt.dsl which gives no errors and no warnings.=
=20
> Anyway, in this case, the WAK function includes the modification that I=20
> added, returning a package with two zeros. This is different when I get t=
he=20
> asl file from acpidump. Do you think this can be the cause of the blockin=
gs?

No,

> >
> > don't need Looking for DSDT in initrd ... found customized DSDT with
> > 15240 byte
> I don't know what you mean by this. I thought that it finds the customize=
d=20
> DSDT because I applied a patch from http://gaugusch.at/kernel.shtml
> in order to get the the customized dsdt from initrd. Otherwise it would u=
se=20
> the default one.

you can override your DSDT without this customize dsdt from initrd,

http://acpi.sourceforge.net/wiki/index.php/HowToOverrideTable
with this patch=20
--- linux/drivers/acpi/osl.c.orig
+++ linux/drivers/acpi/osl.c
@@ -215,13 +215,18 @@
       return AE_OK;
 }

+/**/static const
+#include "/tmp/dsdt.hex"
+
 acpi_status
 acpi_os_table_override (acpi_table_header *existing_table,
       acpi_table_header **new_table)
 {
       if (!existing_table || !new_table)
               return AE_BAD_PARAMETER;

+/**/if (strncmp(existing_table->signature,"DSDT",4))
       *new_table =3D NULL;
+/**/else *new_table =3D (struct acpi_table_header *)AmlCode;
       return AE_OK;
}

let me know what computer we are talking about ?
and send me the binary in a gz (acpidmp DSDT )

regards,
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
