From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] fix _MEM handling in Type Specific Flags
Date: Tue, 20 Jan 2004 17:20:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401201720.09609.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is against 2.6.1.

ACPI: Fix _MEM handling (it's only two bits, not four).

The memory attributes (_MEM) in Type Specific Flags are only two bits,
not four.  See ACPI spec 2.0c, Table 6-28.

===== drivers/acpi/resources/rsaddr.c 1.15 vs edited =====
--- 1.15/drivers/acpi/resources/rsaddr.c	Mon Oct  6 10:15:00 2003
+++ edited/drivers/acpi/resources/rsaddr.c	Tue Nov 18 12:43:44 2003
@@ -149,7 +149,7 @@
 		output_struct->data.address16.attribute.memory.read_write_attribute =
 				(u16) (temp8 & 0x01);
 		output_struct->data.address16.attribute.memory.cache_attribute =
-				(u16) ((temp8 >> 1) & 0x0F);
+				(u16) ((temp8 >> 1) & 0x03);
 	}
 	else {
 		if (ACPI_IO_RANGE == output_struct->data.address16.resource_type) {
@@ -347,7 +347,7 @@
 
 		temp8 |=
 			(linked_list->data.address16.attribute.memory.cache_attribute &
-			 0x0F) << 1;
+			 0x03) << 1;
 	}
 	else if (ACPI_IO_RANGE == linked_list->data.address16.resource_type) {
 		temp8 = (u8)
@@ -539,7 +539,7 @@
 				(u16) (temp8 & 0x01);
 
 		output_struct->data.address32.attribute.memory.cache_attribute =
-				(u16) ((temp8 >> 1) & 0x0F);
+				(u16) ((temp8 >> 1) & 0x03);
 	}
 	else {
 		if (ACPI_IO_RANGE == output_struct->data.address32.resource_type) {
@@ -735,7 +735,7 @@
 
 		temp8 |=
 			(linked_list->data.address32.attribute.memory.cache_attribute &
-			 0x0F) << 1;
+			 0x03) << 1;
 	}
 	else if (ACPI_IO_RANGE == linked_list->data.address32.resource_type) {
 		temp8 = (u8)
@@ -926,7 +926,7 @@
 				(u16) (temp8 & 0x01);
 
 		output_struct->data.address64.attribute.memory.cache_attribute =
-				(u16) ((temp8 >> 1) & 0x0F);
+				(u16) ((temp8 >> 1) & 0x03);
 	}
 	else {
 		if (ACPI_IO_RANGE == output_struct->data.address64.resource_type) {
@@ -1124,7 +1124,7 @@
 
 		temp8 |=
 			(linked_list->data.address64.attribute.memory.cache_attribute &
-			 0x0F) << 1;
+			 0x03) << 1;
 	}
 	else if (ACPI_IO_RANGE == linked_list->data.address64.resource_type) {
 		temp8 = (u8)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
