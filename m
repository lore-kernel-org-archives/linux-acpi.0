From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/60] ACPICA: Revert "Revert "Enable multi-byte EC transfers
Date: Mon, 25 Oct 2010 02:20:11 -0400
Message-ID: <09387b43153953006471dbb06ece6bf779d10937.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:45223 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab0JYGVh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 02:21:37 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00LQN1NM9JX3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 01:21:32 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This reverts commit f23b9c7(http://git.moblin.org/cgit.cgi/acpica/commit/?id=f23b9c7)
The problem with this change was determined to be a problem with
the FreeBSD host OSL (OS services layer), not with this patch
itself. Therefore, re-introducing this change into the main ACPICA
code. See ACPICA bugzilla 863.

http://www.acpica.org/bugzilla/show_bug.cgi?id=863

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/exfldio.c  |   75 ++++++++++++++++++++++++++-------------
 drivers/acpi/acpica/exprep.c   |   45 ++++++++++++------------
 3 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 54857fa..bdbfaf2 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -248,7 +248,7 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u32                             base_byte_offset;   /* Byte offset within containing object */\
 	u32                             value;              /* Value to store into the Bank or Index register */\
 	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
-	u8                              access_bit_width;	/* Read/Write size in bits (8-64) */
+
 
 struct acpi_object_field_common {	/* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 0472173..38293fd 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -119,8 +119,8 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	}
 
 	/*
-	 * Exit now for SMBus or IPMI address space, it has a non-linear address space
-	 * and the request cannot be directly validated
+	 * Exit now for SMBus or IPMI address space, it has a non-linear
+	 * address space and the request cannot be directly validated
 	 */
 	if (rgn_desc->region.space_id == ACPI_ADR_SPACE_SMBUS ||
 	    rgn_desc->region.space_id == ACPI_ADR_SPACE_IPMI) {
@@ -147,8 +147,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	 * (Region length is specified in bytes)
 	 */
 	if (rgn_desc->region.length <
-	    (obj_desc->common_field.base_byte_offset +
-	     field_datum_byte_offset +
+	    (obj_desc->common_field.base_byte_offset + field_datum_byte_offset +
 	     obj_desc->common_field.access_byte_width)) {
 		if (acpi_gbl_enable_interpreter_slack) {
 			/*
@@ -680,6 +679,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	u32 buffer_tail_bits;
 	u32 datum_count;
 	u32 field_datum_count;
+	u32 access_bit_width;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_extract_from_field);
@@ -694,16 +694,36 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 		return_ACPI_STATUS(AE_BUFFER_OVERFLOW);
 	}
+
 	ACPI_MEMSET(buffer, 0, buffer_length);
+	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
+
+	/* Handle the simple case here */
+
+	if ((obj_desc->common_field.start_field_bit_offset == 0) &&
+	    (obj_desc->common_field.bit_length == access_bit_width)) {
+		status = acpi_ex_field_datum_io(obj_desc, 0, buffer, ACPI_READ);
+		return_ACPI_STATUS(status);
+	}
+
+/* TBD: Move to common setup code */
+
+	/* Field algorithm is limited to sizeof(u64), truncate if needed */
+
+	if (obj_desc->common_field.access_byte_width > sizeof(u64)) {
+		obj_desc->common_field.access_byte_width = sizeof(u64);
+		access_bit_width = sizeof(u64) * 8;
+	}
 
 	/* Compute the number of datums (access width data items) */
 
-	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+	datum_count =
+	    ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
+			     access_bit_width);
+
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
-					     obj_desc->common_field.
 					     access_bit_width);
 
 	/* Priming read from the field */
@@ -738,12 +758,11 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
-		     obj_desc->common_field.start_field_bit_offset) <
+		if (access_bit_width -
+		    obj_desc->common_field.start_field_bit_offset <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum |=
-			    raw_datum << (obj_desc->common_field.
-					  access_bit_width -
+			    raw_datum << (access_bit_width -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		}
@@ -765,8 +784,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 	/* Mask off any extra bits in the last datum */
 
-	buffer_tail_bits = obj_desc->common_field.bit_length %
-	    obj_desc->common_field.access_bit_width;
+	buffer_tail_bits = obj_desc->common_field.bit_length % access_bit_width;
 	if (buffer_tail_bits) {
 		merged_datum &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
@@ -798,6 +816,7 @@ acpi_status
 acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 			  void *buffer, u32 buffer_length)
 {
+	void *new_buffer;
 	acpi_status status;
 	u64 mask;
 	u64 width_mask;
@@ -808,9 +827,9 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	u32 buffer_tail_bits;
 	u32 datum_count;
 	u32 field_datum_count;
-	u32 i;
+	u32 access_bit_width;
 	u32 required_length;
-	void *new_buffer;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_insert_into_field);
 
@@ -844,17 +863,24 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		buffer_length = required_length;
 	}
 
+/* TBD: Move to common setup code */
+
+	/* Algo is limited to sizeof(u64), so cut the access_byte_width */
+	if (obj_desc->common_field.access_byte_width > sizeof(u64)) {
+		obj_desc->common_field.access_byte_width = sizeof(u64);
+	}
+
+	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
+
 	/*
 	 * Create the bitmasks used for bit insertion.
 	 * Note: This if/else is used to bypass compiler differences with the
 	 * shift operator
 	 */
-	if (obj_desc->common_field.access_bit_width == ACPI_INTEGER_BIT_SIZE) {
+	if (access_bit_width == ACPI_INTEGER_BIT_SIZE) {
 		width_mask = ACPI_UINT64_MAX;
 	} else {
-		width_mask =
-		    ACPI_MASK_BITS_ABOVE(obj_desc->common_field.
-					 access_bit_width);
+		width_mask = ACPI_MASK_BITS_ABOVE(access_bit_width);
 	}
 
 	mask = width_mask &
@@ -863,12 +889,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	/* Compute the number of datums (access width data items) */
 
 	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+				       access_bit_width);
 
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
-					     obj_desc->common_field.
 					     access_bit_width);
 
 	/* Get initial Datum from the input buffer */
@@ -905,12 +930,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
+		if ((access_bit_width -
 		     obj_desc->common_field.start_field_bit_offset) <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum =
-			    raw_datum >> (obj_desc->common_field.
-					  access_bit_width -
+			    raw_datum >> (access_bit_width -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		} else {
@@ -929,6 +953,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		ACPI_MEMCPY(&raw_datum, ((char *)buffer) + buffer_offset,
 			    ACPI_MIN(obj_desc->common_field.access_byte_width,
 				     buffer_length - buffer_offset));
+
 		merged_datum |=
 		    raw_datum << obj_desc->common_field.start_field_bit_offset;
 	}
@@ -937,7 +962,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 	buffer_tail_bits = (obj_desc->common_field.bit_length +
 			    obj_desc->common_field.start_field_bit_offset) %
-	    obj_desc->common_field.access_bit_width;
+	    access_bit_width;
 	if (buffer_tail_bits) {
 		mask &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 98a331d..7aae29f 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -355,12 +355,10 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
-	/* Setup width (access granularity) fields */
+	/* Setup width (access granularity) fields (values are: 1, 2, 4, 8) */
 
 	obj_desc->common_field.access_byte_width = (u8)
-	    ACPI_DIV_8(access_bit_width);	/* 1,  2,  4,  8 */
-
-	obj_desc->common_field.access_bit_width = (u8) access_bit_width;
+	    ACPI_DIV_8(access_bit_width);
 
 	/*
 	 * base_byte_offset is the address of the start of the field within the
@@ -405,8 +403,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 {
 	union acpi_operand_object *obj_desc;
 	union acpi_operand_object *second_desc = NULL;
-	u32 type;
 	acpi_status status;
+	u32 access_byte_width;
+	u32 type;
 
 	ACPI_FUNCTION_TRACE(ex_prep_field_value);
 
@@ -421,8 +420,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		type = acpi_ns_get_type(info->region_node);
 		if (type != ACPI_TYPE_REGION) {
 			ACPI_ERROR((AE_INFO,
-				    "Needed Region, found type 0x%X (%s)",
-				    type, acpi_ut_get_type_name(type)));
+				    "Needed Region, found type 0x%X (%s)", type,
+				    acpi_ut_get_type_name(type)));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
@@ -438,7 +437,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 	/* Initialize areas of the object that are common to all fields */
 
 	obj_desc->common_field.node = info->field_node;
-	status = acpi_ex_prep_common_field_object(obj_desc, info->field_flags,
+	status = acpi_ex_prep_common_field_object(obj_desc,
+						  info->field_flags,
 						  info->attribute,
 						  info->field_bit_position,
 						  info->field_bit_length);
@@ -455,26 +455,25 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		obj_desc->field.region_obj =
 		    acpi_ns_get_attached_object(info->region_node);
 
-		/* An additional reference for the container */
+		/* Allow full data read from EC address space */
 
-		acpi_ut_add_reference(obj_desc->field.region_obj);
+		if ((obj_desc->field.region_obj->region.space_id ==
+		     ACPI_ADR_SPACE_EC)
+		    && (obj_desc->common_field.bit_length > 8)) {
+			access_byte_width =
+			    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.
+							bit_length);
+
+			/* Maximum byte width supported is 255 */
 
-		/* allow full data read from EC address space */
-		if (obj_desc->field.region_obj->region.space_id ==
-			ACPI_ADR_SPACE_EC) {
-			if (obj_desc->common_field.bit_length > 8) {
-				unsigned width =
-					ACPI_ROUND_BITS_UP_TO_BYTES(
-					obj_desc->common_field.bit_length);
-				// access_bit_width is u8, don't overflow it
-				if (width > 8)
-					width = 8;
+			if (access_byte_width < 256) {
 				obj_desc->common_field.access_byte_width =
-							width;
-				obj_desc->common_field.access_bit_width =
-							8 * width;
+				    (u8)access_byte_width;
 			}
 		}
+		/* An additional reference for the container */
+
+		acpi_ut_add_reference(obj_desc->field.region_obj);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "RegionField: BitOff %X, Off %X, Gran %X, Region %p\n",
-- 
1.7.3.2.90.gd4c43

