From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: fix memhotplug memory range length handling
Date: Fri, 23 Sep 2005 11:27:41 -0600
Message-ID: <200509231127.41874.bjorn.helgaas@hp.com>
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
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and
_MAX are the bounds within which the region can be moved (this
is clarified in Table 6-38 of the 3.0 ACPI spec).  We should use
_LEN to determine the size of the region, not _MAX - _MIN + 1.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- work3.orig/drivers/acpi/acpi_memhotplug.c	2005-09-23 11:22:11.000000000 -0600
+++ work3/drivers/acpi/acpi_memhotplug.c	2005-09-23 11:23:44.000000000 -0600
@@ -74,7 +74,7 @@
 	unsigned short cache_attribute;	/* memory cache attribute */
 	unsigned short read_write_attribute;	/* memory read/write attribute */
 	u64 start_addr;		/* Memory Range start physical addr */
-	u64 end_addr;		/* Memory Range end physical addr */
+	u64 length;		/* Memory Range length */
 };
 
 static int
@@ -102,7 +102,7 @@
 			mem_device->read_write_attribute =
 			    address64.attribute.memory.read_write_attribute;
 			mem_device->start_addr = address64.min_address_range;
-			mem_device->end_addr = address64.max_address_range;
+			mem_device->length = address64.address_length;
 		}
 	}
 
@@ -199,8 +199,7 @@
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
 	 */
-	result = add_memory(mem_device->start_addr,
-			    (mem_device->end_addr - mem_device->start_addr) + 1,
+	result = add_memory(mem_device->start_addr, mem_device->length,
 			    mem_device->read_write_attribute);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
@@ -250,7 +249,7 @@
 {
 	int result;
 	u64 start = mem_device->start_addr;
-	u64 len = mem_device->end_addr - start + 1;
+	u64 len = mem_device->length;
 	unsigned long attr = mem_device->read_write_attribute;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
