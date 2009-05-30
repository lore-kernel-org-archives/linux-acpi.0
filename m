From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/65] ACPICA: Simplify internal operation region interface
Date: Fri, 29 May 2009 21:42:08 -0400
Message-ID: <f5407af3f271ed4cd6655cf30d419d77e0f8bfaa.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062AbZE3Bmx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:53 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00J97ORIXKM2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:54 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Changed address parameter to a simple offset. This removes the
need for the caller to access the region object to obtain the
physical address.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acevents.h |    2 +-
 drivers/acpi/acpica/evregion.c |   12 +++++++-----
 drivers/acpi/acpica/exconfig.c |    9 ++++-----
 drivers/acpi/acpica/exfldio.c  |   20 +++++++++++---------
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 07e2013..0bba148 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -139,7 +139,7 @@ acpi_status acpi_ev_initialize_op_regions(void);
 acpi_status
 acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			       u32 function,
-			       acpi_physical_address address,
+			       u32 region_offset,
 			       u32 bit_width, acpi_integer * value);
 
 acpi_status
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 538d632..98c7f9c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -275,7 +275,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
  *
  * PARAMETERS:  region_obj          - Internal region object
  *              Function            - Read or Write operation
- *              Address             - Where in the space to read or write
+ *              region_offset       - Where in the region to read or write
  *              bit_width           - Field width in bits (8, 16, 32, or 64)
  *              Value               - Pointer to in or out value, must be
  *                                    full 64-bit acpi_integer
@@ -290,7 +290,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 acpi_status
 acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			       u32 function,
-			       acpi_physical_address address,
+			       u32 region_offset,
 			       u32 bit_width, acpi_integer * value)
 {
 	acpi_status status;
@@ -396,7 +396,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
 			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
 			  &region_obj->region.handler->address_space, handler,
-			  ACPI_FORMAT_NATIVE_UINT(address),
+			  ACPI_FORMAT_NATIVE_UINT(region_obj->region.address +
+						  region_offset),
 			  acpi_ut_get_region_name(region_obj->region.
 						  space_id)));
 
@@ -412,8 +413,9 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 
 	/* Call the handler */
 
-	status = handler(function, address, bit_width, value,
-			 handler_desc->address_space.context,
+	status = handler(function,
+			 (region_obj->region.address + region_offset),
+			 bit_width, value, handler_desc->address_space.context,
 			 region_obj2->extra.region_context);
 
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index eca6f63..277fd60 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -280,23 +280,22 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
 {
 	acpi_status status;
 	acpi_integer value;
-	acpi_physical_address address;
+	u32 region_offset = 0;
 	u32 i;
 
-	address = obj_desc->region.address;
-
 	/* Bytewise reads */
 
 	for (i = 0; i < length; i++) {
 		status = acpi_ev_address_space_dispatch(obj_desc, ACPI_READ,
-							address, 8, &value);
+							region_offset, 8,
+							&value);
 		if (ACPI_FAILURE(status)) {
 			return status;
 		}
 
 		*buffer = (u8)value;
 		buffer++;
-		address++;
+		region_offset++;
 	}
 
 	return AE_OK;
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 99cee61..d4075b8 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -222,7 +222,7 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 {
 	acpi_status status;
 	union acpi_operand_object *rgn_desc;
-	acpi_physical_address address;
+	u32 region_offset;
 
 	ACPI_FUNCTION_TRACE(ex_access_region);
 
@@ -243,7 +243,7 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 	 * 3) The current offset into the field
 	 */
 	rgn_desc = obj_desc->common_field.region_obj;
-	address = rgn_desc->region.address +
+	region_offset =
 	    obj_desc->common_field.base_byte_offset + field_datum_byte_offset;
 
 	if ((function & ACPI_IO_MASK) == ACPI_READ) {
@@ -260,16 +260,18 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 			      obj_desc->common_field.access_byte_width,
 			      obj_desc->common_field.base_byte_offset,
 			      field_datum_byte_offset, ACPI_CAST_PTR(void,
-								     address)));
+								     (rgn_desc->
+								      region.
+								      address +
+								      region_offset))));
 
 	/* Invoke the appropriate address_space/op_region handler */
 
-	status = acpi_ev_address_space_dispatch(rgn_desc, function,
-						address,
-						ACPI_MUL_8(obj_desc->
-							   common_field.
-							   access_byte_width),
-						value);
+	status =
+	    acpi_ev_address_space_dispatch(rgn_desc, function, region_offset,
+					   ACPI_MUL_8(obj_desc->common_field.
+						      access_byte_width),
+					   value);
 
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_NOT_IMPLEMENTED) {
-- 
1.6.0.6

