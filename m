From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/31] ACPICA: Utilities: Cleanup to convert physical address printing formats.
Date: Mon, 13 Apr 2015 11:48:46 +0800
Message-ID: <146b41bcedf54656337c5ca22ce7ad69ef3e0e61.1428893936.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39125 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbbDMDst (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:48:49 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 7f06739db43a85083a70371c14141008f20b2198

For physical addresses, since the address may exceed 32-bit address range
after calculation, we should use %8.8X%8.8X (see ACPI_FORMAT_UINT64()) to
convert the %p formats.

This is a preparation to switch acpi_physical_address to 64-bit on 32-bit
kernel builds.

Link: https://github.com/acpica/acpica/commit/7f06739d
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exfldio.c   |   10 ++++------
 drivers/acpi/acpica/hwvalid.c   |   16 ++++++++--------
 drivers/acpi/acpica/nsdump.c    |    7 +++----
 drivers/acpi/acpica/tbinstal.c  |   15 +++++++++------
 drivers/acpi/acpica/utaddress.c |   34 +++++++++++++++-------------------
 5 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 4947992..725a374 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -263,17 +263,15 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_BFIELD,
-			      " Region [%s:%X], Width %X, ByteBase %X, Offset %X at %p\n",
+			      " Region [%s:%X], Width %X, ByteBase %X, Offset %X at %8.8X%8.8X\n",
 			      acpi_ut_get_region_name(rgn_desc->region.
 						      space_id),
 			      rgn_desc->region.space_id,
 			      obj_desc->common_field.access_byte_width,
 			      obj_desc->common_field.base_byte_offset,
-			      field_datum_byte_offset, ACPI_CAST_PTR(void,
-								     (rgn_desc->
-								      region.
-								      address +
-								      region_offset))));
+			      field_datum_byte_offset,
+			      ACPI_FORMAT_UINT64(rgn_desc->region.address +
+						 region_offset)));
 
 	/* Invoke the appropriate address_space/op_region handler */
 
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 2bd33fe..29033d7 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -142,17 +142,17 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	byte_width = ACPI_DIV_8(bit_width);
 	last_address = address + byte_width - 1;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X",
-			  ACPI_CAST_PTR(void, address), ACPI_CAST_PTR(void,
-								      last_address),
-			  byte_width));
+	ACPI_DEBUG_PRINT((ACPI_DB_IO,
+			  "Address %8.8X%8.8X LastAddress %8.8X%8.8X Length %X",
+			  ACPI_FORMAT_UINT64(address),
+			  ACPI_FORMAT_UINT64(last_address), byte_width));
 
 	/* Maximum 16-bit address in I/O space */
 
 	if (last_address > ACPI_UINT16_MAX) {
 		ACPI_ERROR((AE_INFO,
-			    "Illegal I/O port address/length above 64K: %p/0x%X",
-			    ACPI_CAST_PTR(void, address), byte_width));
+			    "Illegal I/O port address/length above 64K: %8.8X%8.8X/0x%X",
+			    ACPI_FORMAT_UINT64(address), byte_width));
 		return_ACPI_STATUS(AE_LIMIT);
 	}
 
@@ -181,8 +181,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 
 			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
 				ACPI_DEBUG_PRINT((ACPI_DB_IO,
-						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)",
-						  ACPI_CAST_PTR(void, address),
+						  "Denied AML access to port 0x%8.8X%8.8X/%X (%s 0x%.4X-0x%.4X)",
+						  ACPI_FORMAT_UINT64(address),
 						  byte_width, port_info->name,
 						  port_info->start,
 						  port_info->end));
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 80f097e..e76d8fd 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -271,12 +271,11 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		switch (type) {
 		case ACPI_TYPE_PROCESSOR:
 
-			acpi_os_printf("ID %02X Len %02X Addr %p\n",
+			acpi_os_printf("ID %02X Len %02X Addr %8.8X%8.8X\n",
 				       obj_desc->processor.proc_id,
 				       obj_desc->processor.length,
-				       ACPI_CAST_PTR(void,
-						     obj_desc->processor.
-						     address));
+				       ACPI_FORMAT_UINT64(obj_desc->processor.
+							  address));
 			break;
 
 		case ACPI_TYPE_DEVICE:
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 201332a..65da4c0 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -187,8 +187,9 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 	status = acpi_tb_acquire_temp_table(&new_table_desc, address,
 					    ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
-			    ACPI_PHYSADDR_TO_PTR(address)));
+		ACPI_ERROR((AE_INFO,
+			    "Could not acquire table length at %8.8X%8.8X",
+			    ACPI_FORMAT_UINT64(address)));
 		return_ACPI_STATUS(status);
 	}
 
@@ -246,8 +247,9 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	status = acpi_tb_acquire_temp_table(&new_table_desc, address, flags);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
-			    ACPI_PHYSADDR_TO_PTR(address)));
+		ACPI_ERROR((AE_INFO,
+			    "Could not acquire table length at %8.8X%8.8X",
+			    ACPI_FORMAT_UINT64(address)));
 		return_ACPI_STATUS(status);
 	}
 
@@ -258,9 +260,10 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	if (!reload &&
 	    acpi_gbl_disable_ssdt_table_install &&
 	    ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG_SSDT)) {
-		ACPI_INFO((AE_INFO, "Ignoring installation of %4.4s at %p",
+		ACPI_INFO((AE_INFO,
+			   "Ignoring installation of %4.4s at %8.8X%8.8X",
 			   new_table_desc.signature.ascii,
-			   ACPI_PHYSADDR_TO_PTR(address)));
+			   ACPI_FORMAT_UINT64(address)));
 		goto release_and_exit;
 	}
 
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 1279f50..911ea8e 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -107,10 +107,10 @@ acpi_ut_add_address_range(acpi_adr_space_type space_id,
 	acpi_gbl_address_range_list[space_id] = range_info;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-			  "\nAdded [%4.4s] address range: 0x%p-0x%p\n",
+			  "\nAdded [%4.4s] address range: 0x%8.8X%8.8X-0x%8.8X%8.8X\n",
 			  acpi_ut_get_node_name(range_info->region_node),
-			  ACPI_CAST_PTR(void, address),
-			  ACPI_CAST_PTR(void, range_info->end_address)));
+			  ACPI_FORMAT_UINT64(address),
+			  ACPI_FORMAT_UINT64(range_info->end_address)));
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(AE_OK);
@@ -160,15 +160,13 @@ acpi_ut_remove_address_range(acpi_adr_space_type space_id,
 			}
 
 			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-					  "\nRemoved [%4.4s] address range: 0x%p-0x%p\n",
+					  "\nRemoved [%4.4s] address range: 0x%8.8X%8.8X-0x%8.8X%8.8X\n",
 					  acpi_ut_get_node_name(range_info->
 								region_node),
-					  ACPI_CAST_PTR(void,
-							range_info->
-							start_address),
-					  ACPI_CAST_PTR(void,
-							range_info->
-							end_address)));
+					  ACPI_FORMAT_UINT64(range_info->
+							     start_address),
+					  ACPI_FORMAT_UINT64(range_info->
+							     end_address)));
 
 			ACPI_FREE(range_info);
 			return_VOID;
@@ -245,16 +243,14 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 								  region_node);
 
 				ACPI_WARNING((AE_INFO,
-					      "%s range 0x%p-0x%p conflicts with OpRegion 0x%p-0x%p (%s)",
+					      "%s range 0x%8.8X%8.8X-0x%8.8X%8.8X conflicts with OpRegion 0x%8.8X%8.8X-0x%8.8X%8.8X (%s)",
 					      acpi_ut_get_region_name(space_id),
-					      ACPI_CAST_PTR(void, address),
-					      ACPI_CAST_PTR(void, end_address),
-					      ACPI_CAST_PTR(void,
-							    range_info->
-							    start_address),
-					      ACPI_CAST_PTR(void,
-							    range_info->
-							    end_address),
+					      ACPI_FORMAT_UINT64(address),
+					      ACPI_FORMAT_UINT64(end_address),
+					      ACPI_FORMAT_UINT64(range_info->
+								 start_address),
+					      ACPI_FORMAT_UINT64(range_info->
+								 end_address),
 					      pathname));
 				ACPI_FREE(pathname);
 			}
-- 
1.7.10

