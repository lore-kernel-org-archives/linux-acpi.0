From: akpm@osdl.org
Subject: [patch 14/23] ACPI: fix memory hotplug range length handling
Date: Tue, 21 Mar 2006 22:30:38 -0800
Message-ID: <200603220633.k2M6Xp6G019567@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:18620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbWCVGdz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:33:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX are
the bounds within which the region can be moved (this is clarified in Table
6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size of
the region, not _MAX - _MIN + 1.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/acpi_memhotplug.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/acpi_memhotplug.c~acpi-fix-memory-hotplug-range-length-handling drivers/acpi/acpi_memhotplug.c
--- devel/drivers/acpi/acpi_memhotplug.c~acpi-fix-memory-hotplug-range-length-handling	2006-03-21 22:30:06.000000000 -0800
+++ devel-akpm/drivers/acpi/acpi_memhotplug.c	2006-03-21 22:30:06.000000000 -0800
@@ -74,7 +74,7 @@ struct acpi_memory_device {
 	unsigned short caching;	/* memory cache attribute */
 	unsigned short write_protect;	/* memory read/write attribute */
 	u64 start_addr;		/* Memory Range start physical addr */
-	u64 end_addr;		/* Memory Range end physical addr */
+	u64 length;		/* Memory Range length */
 };
 
 static int
@@ -97,12 +97,11 @@ acpi_memory_get_device_resources(struct 
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
 
@@ -197,8 +196,7 @@ static int acpi_memory_enable_device(str
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
 	 */
-	result = add_memory(mem_device->start_addr,
-			    (mem_device->end_addr - mem_device->start_addr) + 1);
+	result = add_memory(mem_device->start_addr, mem_device->length);
 	if (result) {
 		ACPI_ERROR((AE_INFO, "add_memory failed"));
 		mem_device->state = MEMORY_INVALID_STATE;
@@ -247,7 +245,7 @@ static int acpi_memory_disable_device(st
 {
 	int result;
 	u64 start = mem_device->start_addr;
-	u64 len = mem_device->end_addr - start + 1;
+	u64 len = mem_device->length;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
 
_
