From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: fix vendor-defined resource infinite loops
Date: Wed, 26 Oct 2005 16:18:04 -0600
Message-ID: <200510261618.04481.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Loop index type not large enough to represent loop termination value ==>
badness.  I've tripped over the first infinite loop and verified that
this patch fixes it.  The second problem was found by inspection.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work4/drivers/acpi/resources/rsmisc.c
===================================================================
--- work4.orig/drivers/acpi/resources/rsmisc.c	2005-10-26 15:23:51.000000000 -0600
+++ work4/drivers/acpi/resources/rsmisc.c	2005-10-26 15:56:18.000000000 -0600
@@ -168,9 +168,8 @@
 {
 	u8 *buffer = byte_stream_buffer;
 	struct acpi_resource *output_struct = (void *)*output_buffer;
-	u16 temp16 = 0;
+	u16 temp16 = 0, index;
 	u8 temp8 = 0;
-	u8 index;
 	acpi_size struct_size =
 	    ACPI_SIZEOF_RESOURCE(struct acpi_resource_vendor);
 
@@ -256,9 +255,8 @@
 		      u8 ** output_buffer, acpi_size * bytes_consumed)
 {
 	u8 *buffer = *output_buffer;
-	u16 temp16 = 0;
+	u16 temp16 = 0, index;
 	u8 temp8 = 0;
-	u8 index;
 
 	ACPI_FUNCTION_TRACE("rs_vendor_stream");
 
@@ -286,7 +284,7 @@
 
 	/* Loop through all of the Vendor Specific fields */
 
-	for (index = 0; index < linked_list->data.vendor_specific.length;
+	for (index = 0; index < (u16) linked_list->data.vendor_specific.length;
 	     index++) {
 		temp8 = linked_list->data.vendor_specific.reserved[index];
 


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
