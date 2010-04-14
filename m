From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [RFC][PATCH] ACPI: EC: Allow limited large burst reads
Date: Thu, 15 Apr 2010 01:11:40 +0400
Message-ID: <20100414211140.23405.21979.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:58056 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755749Ab0DNVLl (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 14 Apr 2010 17:11:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

access_bit_width field is u8 in ACPICA, thus 256 value written to it
becomes 0, causing divide by zero later.
Proper fix would be to remove access_bit_width at all, just because
we already have access_byte_width, which is access_bit_width / 8.
Limit access width to 64 bit for in general, but allow larger reads
if they are aligned with access_byte_width.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/acpica/acobject.h |    3 +--
 drivers/acpi/acpica/exfldio.c  |   24 ++++++++++++------------
 drivers/acpi/acpica/exprep.c   |   16 +++++-----------
 3 files changed, 18 insertions(+), 25 deletions(-)


diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index cde18ea..8ef1a08 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -243,12 +243,11 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u8                              field_flags;        /* Access, update, and lock bits */\
 	u8                              attribute;          /* From access_as keyword */\
 	u8                              access_byte_width;  /* Read/Write size in bytes */\
+	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
 	struct acpi_namespace_node      *node;              /* Link back to parent node */\
 	u32                             bit_length;         /* Length of field in bits */\
 	u32                             base_byte_offset;   /* Byte offset within containing object */\
 	u32                             value;              /* Value to store into the Bank or Index register */\
-	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
-	u8                              access_bit_width;	/* Read/Write size in bits (8-64) */
 
 struct acpi_object_field_common {	/* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index f68a216..a05cef5 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -699,12 +699,12 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	/* Compute the number of datums (access width data items) */
 
 	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+				       obj_desc->common_field.access_byte_width * 8);
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
 					     obj_desc->common_field.
-					     access_bit_width);
+					     access_byte_width * 8);
 
 	/* Priming read from the field */
 
@@ -738,12 +738,12 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
+		if ((obj_desc->common_field.access_byte_width * 8 -
 		     obj_desc->common_field.start_field_bit_offset) <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum |=
 			    raw_datum << (obj_desc->common_field.
-					  access_bit_width -
+					  access_byte_width * 8 -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		}
@@ -766,7 +766,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	/* Mask off any extra bits in the last datum */
 
 	buffer_tail_bits = obj_desc->common_field.bit_length %
-	    obj_desc->common_field.access_bit_width;
+	    (obj_desc->common_field.access_byte_width * 8);
 	if (buffer_tail_bits) {
 		merged_datum &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
@@ -849,12 +849,12 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	 * Note: This if/else is used to bypass compiler differences with the
 	 * shift operator
 	 */
-	if (obj_desc->common_field.access_bit_width == ACPI_INTEGER_BIT_SIZE) {
+	if (obj_desc->common_field.access_byte_width * 8 == ACPI_INTEGER_BIT_SIZE) {
 		width_mask = ACPI_UINT64_MAX;
 	} else {
 		width_mask =
 		    ACPI_MASK_BITS_ABOVE(obj_desc->common_field.
-					 access_bit_width);
+					 access_byte_width * 8);
 	}
 
 	mask = width_mask &
@@ -863,13 +863,13 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	/* Compute the number of datums (access width data items) */
 
 	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+				       obj_desc->common_field.access_byte_width * 8);
 
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
 					     obj_desc->common_field.
-					     access_bit_width);
+					     access_byte_width * 8);
 
 	/* Get initial Datum from the input buffer */
 
@@ -905,12 +905,12 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
+		if ((obj_desc->common_field.access_byte_width * 8 -
 		     obj_desc->common_field.start_field_bit_offset) <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum =
 			    raw_datum >> (obj_desc->common_field.
-					  access_bit_width -
+					  access_byte_width * 8 -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		} else {
@@ -937,7 +937,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 	buffer_tail_bits = (obj_desc->common_field.bit_length +
 			    obj_desc->common_field.start_field_bit_offset) %
-	    obj_desc->common_field.access_bit_width;
+	    (obj_desc->common_field.access_byte_width * 8);
 	if (buffer_tail_bits) {
 		mask &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index a610ebe..b401c50 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -360,8 +360,6 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 	obj_desc->common_field.access_byte_width = (u8)
 	    ACPI_DIV_8(access_bit_width);	/* 1,  2,  4,  8 */
 
-	obj_desc->common_field.access_bit_width = (u8) access_bit_width;
-
 	/*
 	 * base_byte_offset is the address of the start of the field within the
 	 * region.  It is the byte address of the first *datum* (field-width data
@@ -470,15 +468,11 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 
 		/* allow full data read from EC address space */
 		if (obj_desc->field.region_obj->region.space_id ==
-			ACPI_ADR_SPACE_EC) {
-			if (obj_desc->common_field.bit_length > 8)
-				obj_desc->common_field.access_bit_width =
-				ACPI_ROUND_UP(obj_desc->common_field.
-							bit_length, 8);
-				obj_desc->common_field.access_byte_width =
-				ACPI_DIV_8(obj_desc->common_field.
-							access_bit_width);
-		}
+			ACPI_ADR_SPACE_EC &&
+		    obj_desc->common_field.bit_length > 8)
+			obj_desc->common_field.access_byte_width =
+				ACPI_ROUND_BITS_UP_TO_BYTES(
+				    obj_desc->common_field.bit_length);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "RegionField: BitOff %X, Off %X, Gran %X, Region %p\n",

