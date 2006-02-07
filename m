From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: fix memory hotplug range length handling
Date: Tue, 7 Feb 2006 16:24:55 -0700
Message-ID: <200602071624.55628.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:64660 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030256AbWBGXYz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2006 18:24:55 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Naveen B S <naveen.b.s@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

Address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and
_MAX are the bounds within which the region can be moved (this
is clarified in Table 6-38 of the ACPI 3.0 spec).  We should use
_LEN to determine the size of the region, not _MAX - _MIN + 1.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/acpi_memhotplug.c
===================================================================
--- work-mm4.orig/drivers/acpi/acpi_memhotplug.c	2006-02-07 15:03:17.000000000 -0700
+++ work-mm4/drivers/acpi/acpi_memhotplug.c	2006-02-07 15:19:18.000000000 -0700
@@ -74,7 +74,7 @@
 	unsigned short caching;	/* memory cache attribute */
 	unsigned short write_protect;	/* memory read/write attribute */
 	u64 start_addr;		/* Memory Range start physical addr */
-	u64 end_addr;		/* Memory Range end physical addr */
+	u64 length;		/* Memory Range length */
 };
 
 static int
@@ -97,12 +97,11 @@
 	if (ACPI_SUCCESS(status)) {
 		if (address64.resource_type == ACPI_MEMORY_RANGE) {
 			/* Populate the structure */
-			mem_device->caching =
-			    address64.info.mem.caching;
+			mem_device->caching = address64.info.mem.caching;
 			mem_device->write_protect =
 			    address64.info.mem.write_protect;
 			mem_device->start_addr = address64.minimum;
-			mem_device->end_addr = address64.maximum;
+			mem_device->length = address64.address_length;
 		}
 	}
 
@@ -199,8 +198,7 @@
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
 	 */
-	result = add_memory(mem_device->start_addr,
-			    (mem_device->end_addr - mem_device->start_addr) + 1);
+	result = add_memory(mem_device->start_addr, mem_device->length);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
 		mem_device->state = MEMORY_INVALID_STATE;
@@ -249,7 +247,7 @@
 {
 	int result;
 	u64 start = mem_device->start_addr;
-	u64 len = mem_device->end_addr - start + 1;
+	u64 len = mem_device->length;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
 
