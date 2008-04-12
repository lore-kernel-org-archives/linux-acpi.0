From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/73] ACPICA: Fixed a problem with Index Fields where the Index register was incorrectly limited to a maximum of 32 bits
Date: Sat, 12 Apr 2008 00:25:25 -0400
Message-ID: <7ee838ba663ff1e12298b2869f88b628f49ec9a9.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20142 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754015AbYDLE2M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:12 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Now any size may be used.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exfield.c |   37 -----------------------------------
 drivers/acpi/executer/exfldio.c |   41 ++++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/executer/exfield.c b/drivers/acpi/executer/exfield.c
index da772cb..aef8db8 100644
--- a/drivers/acpi/executer/exfield.c
+++ b/drivers/acpi/executer/exfield.c
@@ -210,9 +210,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 {
 	acpi_status status;
 	u32 length;
-	u32 required_length;
 	void *buffer;
-	void *new_buffer;
 	union acpi_operand_object *buffer_desc;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_write_data_to_field, obj_desc);
@@ -312,35 +310,6 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
-	/*
-	 * We must have a buffer that is at least as long as the field
-	 * we are writing to.  This is because individual fields are
-	 * indivisible and partial writes are not supported -- as per
-	 * the ACPI specification.
-	 */
-	new_buffer = NULL;
-	required_length =
-	    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.bit_length);
-
-	if (length < required_length) {
-
-		/* We need to create a new buffer */
-
-		new_buffer = ACPI_ALLOCATE_ZEROED(required_length);
-		if (!new_buffer) {
-			return_ACPI_STATUS(AE_NO_MEMORY);
-		}
-
-		/*
-		 * Copy the original data to the new buffer, starting
-		 * at Byte zero.  All unused (upper) bytes of the
-		 * buffer will be 0.
-		 */
-		ACPI_MEMCPY((char *)new_buffer, (char *)buffer, length);
-		buffer = new_buffer;
-		length = required_length;
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "FieldWrite [FROM]: Obj %p (%s:%X), Buf %p, ByteLen %X\n",
 			  source_desc,
@@ -366,11 +335,5 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 	status = acpi_ex_insert_into_field(obj_desc, buffer, length);
 	acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
-	/* Free temporary buffer if we used one */
-
-	if (new_buffer) {
-		ACPI_FREE(new_buffer);
-	}
-
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/executer/exfldio.c b/drivers/acpi/executer/exfldio.c
index 1ece1c3..ae40294 100644
--- a/drivers/acpi/executer/exfldio.c
+++ b/drivers/acpi/executer/exfldio.c
@@ -806,18 +806,39 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	u32 datum_count;
 	u32 field_datum_count;
 	u32 i;
+	u32 required_length;
+	void *new_buffer;
 
 	ACPI_FUNCTION_TRACE(ex_insert_into_field);
 
 	/* Validate input buffer */
 
-	if (buffer_length <
-	    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.bit_length)) {
-		ACPI_ERROR((AE_INFO,
-			    "Field size %X (bits) is too large for buffer (%X)",
-			    obj_desc->common_field.bit_length, buffer_length));
+	new_buffer = NULL;
+	required_length =
+	    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.bit_length);
+	/*
+	 * We must have a buffer that is at least as long as the field
+	 * we are writing to.  This is because individual fields are
+	 * indivisible and partial writes are not supported -- as per
+	 * the ACPI specification.
+	 */
+	if (buffer_length < required_length) {
 
-		return_ACPI_STATUS(AE_BUFFER_OVERFLOW);
+		/* We need to create a new buffer */
+
+		new_buffer = ACPI_ALLOCATE_ZEROED(required_length);
+		if (!new_buffer) {
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
+
+		/*
+		 * Copy the original data to the new buffer, starting
+		 * at Byte zero.  All unused (upper) bytes of the
+		 * buffer will be 0.
+		 */
+		ACPI_MEMCPY((char *)new_buffer, (char *)buffer, buffer_length);
+		buffer = new_buffer;
+		buffer_length = required_length;
 	}
 
 	/*
@@ -867,7 +888,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 							merged_datum,
 							field_offset);
 		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+			goto exit;
 		}
 
 		field_offset += obj_desc->common_field.access_byte_width;
@@ -925,5 +946,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 						mask, merged_datum,
 						field_offset);
 
+      exit:
+	/* Free temporary buffer if we used one */
+
+	if (new_buffer) {
+		ACPI_FREE(new_buffer);
+	}
 	return_ACPI_STATUS(status);
 }
-- 
1.5.5.29.g7134

