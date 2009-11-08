From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/12] ACPICA: avoid
 "Info: mapping multiple BARs. Your kernel is fine."
Date: Sat, 07 Nov 2009 21:57:08 -0500
Message-ID: <d410ee5109a1633a686a5663c6743a92e1181f9b.1257648659.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:29845 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbZKHC5Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:25 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR00ASVS7LW4OK@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:22 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Ensure that memory mappings created for operation regions
do not cross page boundaries.  Crossing a page boundary
while mapping regions can cause warnings if the pages have different attributes.

Such regions are probably BIOS bugs, and this is the workaround.

http://bugzilla.kernel.org/show_bug.cgi?id=14445

[Kernel summit hacking hour]

Signed-off-by: Bob Moore <robert.moore@intel.com>
Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    4 ++--
 drivers/acpi/acpica/exregion.c |   35 +++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index 8e679ef..a4471e3 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -103,9 +103,9 @@
 
 #define ACPI_MAX_REFERENCE_COUNT        0x1000
 
-/* Size of cached memory mapping for system memory operation region */
+/* Default page size for use in mapping memory for operation regions */
 
-#define ACPI_SYSMEM_REGION_WINDOW_SIZE  4096
+#define ACPI_DEFAULT_PAGE_SIZE          4096	/* Must be power of 2 */
 
 /* owner_id tracking. 8 entries allows for 255 owner_ids */
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 3a54b73..2bd83ac 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -77,7 +77,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 	void *logical_addr_ptr = NULL;
 	struct acpi_mem_space_context *mem_info = region_context;
 	u32 length;
-	acpi_size window_size;
+	acpi_size map_length;
+	acpi_size page_boundary_map_length;
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -144,25 +145,39 @@ acpi_ex_system_memory_space_handler(u32 function,
 		}
 
 		/*
-		 * Don't attempt to map memory beyond the end of the region, and
-		 * constrain the maximum mapping size to something reasonable.
+		 * Attempt to map from the requested address to the end of the region.
+		 * However, we will never map more than one page, nor will we cross
+		 * a page boundary.
 		 */
-		window_size = (acpi_size)
+		map_length = (acpi_size)
 		    ((mem_info->address + mem_info->length) - address);
 
-		if (window_size > ACPI_SYSMEM_REGION_WINDOW_SIZE) {
-			window_size = ACPI_SYSMEM_REGION_WINDOW_SIZE;
+		/*
+		 * If mapping the entire remaining portion of the region will cross
+		 * a page boundary, just map up to the page boundary, do not cross.
+		 * On some systems, crossing a page boundary while mapping regions
+		 * can cause warnings if the pages have different attributes
+		 * due to resource management
+		 */
+		page_boundary_map_length =
+		    ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address;
+
+		if (!page_boundary_map_length) {
+			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
+		}
+
+		if (map_length > page_boundary_map_length) {
+			map_length = page_boundary_map_length;
 		}
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address =
-			acpi_os_map_memory((acpi_physical_address) address, window_size);
+		mem_info->mapped_logical_address = acpi_os_map_memory((acpi_physical_address) address, map_length);
 		if (!mem_info->mapped_logical_address) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at %8.8X%8.8X, size %X",
 				    ACPI_FORMAT_NATIVE_UINT(address),
-				    (u32) window_size));
+				    (u32) map_length));
 			mem_info->mapped_length = 0;
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
@@ -170,7 +185,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 		/* Save the physical address and mapping size */
 
 		mem_info->mapped_physical_address = address;
-		mem_info->mapped_length = window_size;
+		mem_info->mapped_length = map_length;
 	}
 
 	/*
-- 
1.6.0.6

