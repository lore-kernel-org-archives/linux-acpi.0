From: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] IO port space translation attributes
Date: Tue, 4 Feb 2003 12:18:47 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302041218.47101.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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

This patch against 2.5.59+acpi-20030123-2.5.59.diff.gz
lets me extract the translation attributes of I/O resources
so I can support multiple I/O port spaces.

Please consider applying this.

Bjorn



diff -u -ur linux-2.5.59/drivers/acpi/resources/rsaddr.c linux-2.5.59-a/drivers/acpi/resources/rsaddr.c
--- linux-2.5.59/drivers/acpi/resources/rsaddr.c	2003-01-16 19:22:14.000000000 -0700
+++ linux-2.5.59-a/drivers/acpi/resources/rsaddr.c	2003-02-04 11:41:35.000000000 -0700
@@ -130,6 +130,8 @@
 		if (ACPI_IO_RANGE == output_struct->data.address16.resource_type) {
 			output_struct->data.address16.attribute.io.range_attribute =
 				(u16) (temp8 & 0x03);
+			output_struct->data.address16.attribute.io.translation_attribute =
+				(u16) ((temp8 >> 4) & 0x03);
 		}
 		else {
 			/* BUS_NUMBER_RANGE == Address16.Data->resource_type */
@@ -328,6 +330,9 @@
 		temp8 = (u8)
 			(linked_list->data.address16.attribute.io.range_attribute &
 			 0x03);
+		temp8 |=
+			(linked_list->data.address16.attribute.io.translation_attribute &
+			 0x03) << 4;
 	}
 
 	*buffer = temp8;
@@ -516,6 +521,8 @@
 		if (ACPI_IO_RANGE == output_struct->data.address32.resource_type) {
 			output_struct->data.address32.attribute.io.range_attribute =
 				(u16) (temp8 & 0x03);
+			output_struct->data.address32.attribute.io.translation_attribute =
+				(u16) ((temp8 >> 4) & 0x03);
 		}
 		else {
 			/* BUS_NUMBER_RANGE == output_struct->Data.Address32.resource_type */
@@ -712,6 +719,9 @@
 		temp8 = (u8)
 			(linked_list->data.address32.attribute.io.range_attribute &
 			 0x03);
+		temp8 |=
+			(linked_list->data.address32.attribute.io.translation_attribute &
+			 0x03) << 4;
 	}
 
 	*buffer = temp8;
@@ -899,6 +909,8 @@
 		if (ACPI_IO_RANGE == output_struct->data.address64.resource_type) {
 			output_struct->data.address64.attribute.io.range_attribute =
 				(u16) (temp8 & 0x03);
+			output_struct->data.address64.attribute.io.translation_attribute =
+				(u16) ((temp8 >> 4) & 0x03);
 		}
 		else {
 			/* BUS_NUMBER_RANGE == output_struct->Data.Address64.resource_type */
@@ -1099,6 +1111,9 @@
 		temp8 = (u8)
 			(linked_list->data.address64.attribute.io.range_attribute &
 			 0x03);
+		temp8 |=
+			(linked_list->data.address64.attribute.io.translation_attribute &
+			 0x03) << 4;
 	}
 
 	*buffer = temp8;
diff -u -ur linux-2.5.59/drivers/acpi/resources/rsdump.c linux-2.5.59-a/drivers/acpi/resources/rsdump.c
--- linux-2.5.59/drivers/acpi/resources/rsdump.c	2003-01-16 19:22:16.000000000 -0700
+++ linux-2.5.59-a/drivers/acpi/resources/rsdump.c	2003-02-04 12:02:23.000000000 -0700
@@ -551,6 +551,11 @@
 					  "Invalid range attribute\n");
 			break;
 		}
+
+		acpi_os_printf ("  Type Specific: %s Translation\n",
+			ACPI_SPARSE_TRANSLATION ==
+			address16_data->attribute.io.translation_attribute ?
+			"Sparse" : "Dense");
 		break;
 
 	case ACPI_BUS_NUMBER_RANGE:
@@ -693,6 +698,11 @@
 						  "Invalid Range attribute");
 				break;
 			}
+
+		acpi_os_printf ("  Type Specific: %s Translation\n",
+			ACPI_SPARSE_TRANSLATION ==
+			address32_data->attribute.io.translation_attribute ?
+			"Sparse" : "Dense");
 		break;
 
 	case ACPI_BUS_NUMBER_RANGE:
@@ -835,6 +845,11 @@
 						  "Invalid Range attribute");
 				break;
 			}
+
+		acpi_os_printf ("  Type Specific: %s Translation\n",
+			ACPI_SPARSE_TRANSLATION ==
+			address64_data->attribute.io.translation_attribute ?
+			"Sparse" : "Dense");
 		break;
 
 	case ACPI_BUS_NUMBER_RANGE:
diff -u -ur linux-2.5.59/include/acpi/actypes.h linux-2.5.59-a/include/acpi/actypes.h
--- linux-2.5.59/include/acpi/actypes.h	2003-01-31 12:34:30.000000000 -0700
+++ linux-2.5.59-a/include/acpi/actypes.h	2003-02-04 11:40:47.000000000 -0700
@@ -877,6 +877,8 @@
 #define ACPI_ISA_ONLY_RANGES            (u8) 0x02
 #define ACPI_ENTIRE_RANGE               (ACPI_NON_ISA_ONLY_RANGES | ACPI_ISA_ONLY_RANGES)
 
+#define ACPI_SPARSE_TRANSLATION         (u8) 0x03
+
 /*
  *  IO Port Descriptor Decode
  */
@@ -1026,7 +1028,7 @@
 struct acpi_io_attribute
 {
 	u16                                 range_attribute;
-	u16                                 reserved;
+	u16                                 translation_attribute;
 };
 
 struct acpi_bus_attribute



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
