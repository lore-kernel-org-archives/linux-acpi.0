From: Len Brown <lenb@kernel.org>
Subject: [PATCH 105/122] ACPICA: Update comments - no functional changes
Date: Thu, 23 Oct 2008 02:39:19 -0400
Message-ID: <2425a0967f29b196fad5d4f726c9502679284656.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbYJWGoN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:13 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:10 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some formatting and spelling fixes.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconvrt.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/executer/exconvrt.c b/drivers/acpi/executer/exconvrt.c
index 261d975..890378e 100644
--- a/drivers/acpi/executer/exconvrt.c
+++ b/drivers/acpi/executer/exconvrt.c
@@ -57,7 +57,7 @@ acpi_ex_convert_to_ascii(acpi_integer integer,
  *
  * FUNCTION:    acpi_ex_convert_to_integer
  *
- * PARAMETERS:  obj_desc        - Object to be converted.  Must be an
+ * PARAMETERS:  obj_desc        - Object to be converted. Must be an
  *                                Integer, Buffer, or String
  *              result_desc     - Where the new Integer object is returned
  *              Flags           - Used for string conversion
@@ -103,7 +103,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 	}
 
 	/*
-	 * Convert the buffer/string to an integer.  Note that both buffers and
+	 * Convert the buffer/string to an integer. Note that both buffers and
 	 * strings are treated as raw data - we don't convert ascii to hex for
 	 * strings.
 	 *
@@ -120,7 +120,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 		/*
 		 * Convert string to an integer - for most cases, the string must be
-		 * hexadecimal as per the ACPI specification.  The only exception (as
+		 * hexadecimal as per the ACPI specification. The only exception (as
 		 * of ACPI 3.0) is that the to_integer() operator allows both decimal
 		 * and hexadecimal strings (hex prefixed with "0x").
 		 */
@@ -159,6 +159,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 		break;
 
 	default:
+
 		/* No other types can get here */
 		break;
 	}
@@ -185,7 +186,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
  *
  * FUNCTION:    acpi_ex_convert_to_buffer
  *
- * PARAMETERS:  obj_desc        - Object to be converted.  Must be an
+ * PARAMETERS:  obj_desc        - Object to be converted. Must be an
  *                                Integer, Buffer, or String
  *              result_desc     - Where the new buffer object is returned
  *
@@ -365,7 +366,7 @@ acpi_ex_convert_to_ascii(acpi_integer integer,
 	}
 
 	/*
-	 * Since leading zeros are supressed, we must check for the case where
+	 * Since leading zeros are suppressed, we must check for the case where
 	 * the integer equals 0
 	 *
 	 * Finally, null terminate the string and return the length
@@ -383,7 +384,7 @@ acpi_ex_convert_to_ascii(acpi_integer integer,
  *
  * FUNCTION:    acpi_ex_convert_to_string
  *
- * PARAMETERS:  obj_desc        - Object to be converted.  Must be an
+ * PARAMETERS:  obj_desc        - Object to be converted. Must be an
  *                                Integer, Buffer, or String
  *              result_desc     - Where the string object is returned
  *              Type            - String flags (base and conversion type)
@@ -472,7 +473,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			base = 10;
 
 			/*
-			 * Calculate the final string length.  Individual string values
+			 * Calculate the final string length. Individual string values
 			 * are variable length (include separator for each)
 			 */
 			for (i = 0; i < obj_desc->buffer.length; i++) {
@@ -617,7 +618,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 		case ACPI_TYPE_LOCAL_BANK_FIELD:
 		case ACPI_TYPE_LOCAL_INDEX_FIELD:
 			/*
-			 * These types require an Integer operand.  We can convert
+			 * These types require an Integer operand. We can convert
 			 * a Buffer or a String to an Integer if necessary.
 			 */
 			status =
@@ -627,7 +628,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 
 		case ACPI_TYPE_STRING:
 			/*
-			 * The operand must be a String.  We can convert an
+			 * The operand must be a String. We can convert an
 			 * Integer or Buffer if necessary
 			 */
 			status =
@@ -637,7 +638,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 
 		case ACPI_TYPE_BUFFER:
 			/*
-			 * The operand must be a Buffer.  We can convert an
+			 * The operand must be a Buffer. We can convert an
 			 * Integer or String if necessary
 			 */
 			status =
-- 
1.5.5.1

