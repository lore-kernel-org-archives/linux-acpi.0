From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix _MEM handling in Type Specific Flags (resend)
Date: Fri, 19 Mar 2004 12:56:01 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CFF522B18982EA4481D3A3E23B83141C01F405F0@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <willy-+nN6oZZ19oAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I've integrated this into ACPI CA for the next release.

Thanks.
Bob


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Bjorn
Helgaas
Sent: Friday, March 19, 2004 11:37 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Brown, Len; Matthew Wilcox
Subject: [ACPI] [PATCH] fix _MEM handling in Type Specific Flags
(resend)

I sent this earlier (Jan 20!), but I don't think I saw any response.
Just wanted to make sure it's not dropped.  I checked, and it
still applies cleanly to 2.6.5-rc1.

It looks like cache_attribute is currently used by hot-plug.
The current code sets cache_attribute incorrectly (it extracts
(_MTP | _MEM) when it should extract only _MEM).


ACPI: Fix _MEM handling (it's only two bits, not four).

The memory attributes (_MEM) in Type Specific Flags are only two bits,
not four.  See ACPI spec 2.0c, Table 6-28.

=3D=3D=3D=3D=3D drivers/acpi/resources/rsaddr.c 1.15 vs edited =
=3D=3D=3D=3D=3D
--- 1.15/drivers/acpi/resources/rsaddr.c	Mon Oct  6 10:15:00 2003
+++ edited/drivers/acpi/resources/rsaddr.c	Tue Nov 18 12:43:44 2003
@@ -149,7 +149,7 @@
=20
output_struct->data.address16.attribute.memory.read_write_attribute =3D
 				(u16) (temp8 & 0x01);
=20
output_struct->data.address16.attribute.memory.cache_attribute =3D
-				(u16) ((temp8 >> 1) & 0x0F);
+				(u16) ((temp8 >> 1) & 0x03);
 	}
 	else {
 		if (ACPI_IO_RANGE =3D=3D
output_struct->data.address16.resource_type) {
@@ -347,7 +347,7 @@
=20
 		temp8 |=3D
=20
(linked_list->data.address16.attribute.memory.cache_attribute &
-			 0x0F) << 1;
+			 0x03) << 1;
 	}
 	else if (ACPI_IO_RANGE =3D=3D
linked_list->data.address16.resource_type) {
 		temp8 =3D (u8)
@@ -539,7 +539,7 @@
 				(u16) (temp8 & 0x01);
=20
=20
output_struct->data.address32.attribute.memory.cache_attribute =3D
-				(u16) ((temp8 >> 1) & 0x0F);
+				(u16) ((temp8 >> 1) & 0x03);
 	}
 	else {
 		if (ACPI_IO_RANGE =3D=3D
output_struct->data.address32.resource_type) {
@@ -735,7 +735,7 @@
=20
 		temp8 |=3D
=20
(linked_list->data.address32.attribute.memory.cache_attribute &
-			 0x0F) << 1;
+			 0x03) << 1;
 	}
 	else if (ACPI_IO_RANGE =3D=3D
linked_list->data.address32.resource_type) {
 		temp8 =3D (u8)
@@ -926,7 +926,7 @@
 				(u16) (temp8 & 0x01);
=20
=20
output_struct->data.address64.attribute.memory.cache_attribute =3D
-				(u16) ((temp8 >> 1) & 0x0F);
+				(u16) ((temp8 >> 1) & 0x03);
 	}
 	else {
 		if (ACPI_IO_RANGE =3D=3D
output_struct->data.address64.resource_type) {
@@ -1124,7 +1124,7 @@
=20
 		temp8 |=3D
=20
(linked_list->data.address64.attribute.memory.cache_attribute &
-			 0x0F) << 1;
+			 0x03) << 1;
 	}
 	else if (ACPI_IO_RANGE =3D=3D
linked_list->data.address64.resource_type) {
 		temp8 =3D (u8)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
