From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: [PATCH] blacklist
Date: 28 Sep 2002 13:53:33 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033235615.2448.16.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-fuI0MXnHZBreHyS4YZ0s"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-fuI0MXnHZBreHyS4YZ0s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

so this very simple patch, is send to your appreciation,

I think:
if acpi_get_table_header_early can read the table_header without errors
so it should past to other tests to see if it in blacklist,
if acpi_get_table_header_early can't read the table_header or have
errors, should past this line and try other line of blacklist. 



--=-fuI0MXnHZBreHyS4YZ0s
Content-Disposition: attachment; filename=acpi_blacklist
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=acpi_blacklist; charset=ISO-8859-1

--- linux-2.4.19acpi/drivers/acpi/blacklist.c.orig	Sat Sep 21 15:16:51 2002
+++ linux-2.4.19acpi/drivers/acpi/blacklist.c	Sat Sep 21 15:17:04 2002
@@ -97,7 +97,7 @@
=20
 	while (acpi_blacklist[i].oem_id[0] !=3D '\0')
 	{
-		if (!acpi_get_table_header_early(acpi_blacklist[i].table, &table_header)=
) {
+		if (acpi_get_table_header_early(acpi_blacklist[i].table, &table_header))=
 {
 			i++;
 			continue;
 		}

--=-fuI0MXnHZBreHyS4YZ0s--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
