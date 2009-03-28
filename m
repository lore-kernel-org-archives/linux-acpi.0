From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/98] ACPICA: Fix writes to optional PM1B registers
Date: Sat, 28 Mar 2009 00:30:58 -0400
Message-ID: <c520abadbc56a2740021910d2c6412f826a10059.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbZC1Ecv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7005W48MBEXZZ@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:36 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

On read, shift B register bits above the A bits. On write,
shift B bits down to zero before writing the B register. New:
acpi_hw_read_multiple, acpi_hw_write_multiple. These two functions now
transparently handle the (possible) split registers for PM1 Status,
Enable, and Control.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwregs.c |  205 ++++++++++++++++++++++++++++-------------
 1 files changed, 140 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 7ef0b8e..41f1173 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -51,6 +51,17 @@
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwregs")
 
+/* Local Prototypes */
+static acpi_status
+acpi_hw_read_multiple(u32 *value,
+		      struct acpi_generic_address *register_a,
+		      struct acpi_generic_address *register_b);
+
+static acpi_status
+acpi_hw_write_multiple(u32 value,
+		       struct acpi_generic_address *register_a,
+		       struct acpi_generic_address *register_b);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_hw_clear_acpi_status
@@ -63,6 +74,7 @@ ACPI_MODULE_NAME("hwregs")
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
+
 acpi_status acpi_hw_clear_acpi_status(void)
 {
 	acpi_status status;
@@ -143,64 +155,49 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
 acpi_status
 acpi_hw_register_read(u32 register_id, u32 * return_value)
 {
-	u32 value1 = 0;
-	u32 value2 = 0;
+	u32 value = 0;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(hw_register_read);
 
 	switch (register_id) {
-	case ACPI_REGISTER_PM1_STATUS:	/* 16-bit access */
+	case ACPI_REGISTER_PM1_STATUS:	/* PM1 A/B: 16-bit access each */
 
-		status = acpi_read(&value1, &acpi_gbl_xpm1a_status);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
-
-		/* PM1B is optional */
-
-		status = acpi_read(&value2, &acpi_gbl_xpm1b_status);
-		value1 |= value2;
+		status = acpi_hw_read_multiple(&value,
+					       &acpi_gbl_xpm1a_status,
+					       &acpi_gbl_xpm1b_status);
 		break;
 
-	case ACPI_REGISTER_PM1_ENABLE:	/* 16-bit access */
+	case ACPI_REGISTER_PM1_ENABLE:	/* PM1 A/B: 16-bit access each */
 
-		status = acpi_read(&value1, &acpi_gbl_xpm1a_enable);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
-
-		/* PM1B is optional */
-
-		status = acpi_read(&value2, &acpi_gbl_xpm1b_enable);
-		value1 |= value2;
+		status = acpi_hw_read_multiple(&value,
+					       &acpi_gbl_xpm1a_enable,
+					       &acpi_gbl_xpm1b_enable);
 		break;
 
-	case ACPI_REGISTER_PM1_CONTROL:	/* 16-bit access */
-
-		status = acpi_read(&value1, &acpi_gbl_FADT.xpm1a_control_block);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
+	case ACPI_REGISTER_PM1_CONTROL:	/* PM1 A/B: 16-bit access each */
 
-		status = acpi_read(&value2, &acpi_gbl_FADT.xpm1b_control_block);
-		value1 |= value2;
+		status = acpi_hw_read_multiple(&value,
+					       &acpi_gbl_FADT.
+					       xpm1a_control_block,
+					       &acpi_gbl_FADT.
+					       xpm1b_control_block);
 		break;
 
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
 
-		status = acpi_read(&value1, &acpi_gbl_FADT.xpm2_control_block);
+		status = acpi_read(&value, &acpi_gbl_FADT.xpm2_control_block);
 		break;
 
 	case ACPI_REGISTER_PM_TIMER:	/* 32-bit access */
 
-		status = acpi_read(&value1, &acpi_gbl_FADT.xpm_timer_block);
+		status = acpi_read(&value, &acpi_gbl_FADT.xpm_timer_block);
 		break;
 
 	case ACPI_REGISTER_SMI_COMMAND_BLOCK:	/* 8-bit access */
 
 		status =
-		    acpi_os_read_port(acpi_gbl_FADT.smi_command, &value1, 8);
+		    acpi_os_read_port(acpi_gbl_FADT.smi_command, &value, 8);
 		break;
 
 	default:
@@ -209,10 +206,8 @@ acpi_hw_register_read(u32 register_id, u32 * return_value)
 		break;
 	}
 
-      exit:
-
 	if (ACPI_SUCCESS(status)) {
-		*return_value = value1;
+		*return_value = value;
 	}
 
 	return_ACPI_STATUS(status);
@@ -252,12 +247,13 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 	ACPI_FUNCTION_TRACE(hw_register_write);
 
 	switch (register_id) {
-	case ACPI_REGISTER_PM1_STATUS:	/* 16-bit access */
+	case ACPI_REGISTER_PM1_STATUS:	/* PM1 A/B: 16-bit access each */
 
 		/* Perform a read first to preserve certain bits (per ACPI spec) */
 
-		status = acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS,
-					       &read_value);
+		status = acpi_hw_read_multiple(&read_value,
+					       &acpi_gbl_xpm1a_status,
+					       &acpi_gbl_xpm1b_status);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
@@ -269,35 +265,29 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 		/* Now we can write the data */
 
-		status = acpi_write(value, &acpi_gbl_xpm1a_status);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
-
-		/* PM1B is optional */
-
-		status = acpi_write(value, &acpi_gbl_xpm1b_status);
+		status = acpi_hw_write_multiple(value,
+						&acpi_gbl_xpm1a_status,
+						&acpi_gbl_xpm1b_status);
 		break;
 
-	case ACPI_REGISTER_PM1_ENABLE:	/* 16-bit access */
+	case ACPI_REGISTER_PM1_ENABLE:	/* PM1 A/B: 16-bit access */
 
-		status = acpi_write(value, &acpi_gbl_xpm1a_enable);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
-
-		/* PM1B is optional */
-
-		status = acpi_write(value, &acpi_gbl_xpm1b_enable);
+		status = acpi_hw_write_multiple(value,
+						&acpi_gbl_xpm1a_enable,
+						&acpi_gbl_xpm1b_enable);
 		break;
 
-	case ACPI_REGISTER_PM1_CONTROL:	/* 16-bit access */
+	case ACPI_REGISTER_PM1_CONTROL:	/* PM1 A/B: 16-bit access each */
 
 		/*
 		 * Perform a read first to preserve certain bits (per ACPI spec)
+		 * Note: This includes SCI_EN, we never want to change this bit
 		 */
-		status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
-					       &read_value);
+		status = acpi_hw_read_multiple(&read_value,
+					       &acpi_gbl_FADT.
+					       xpm1a_control_block,
+					       &acpi_gbl_FADT.
+					       xpm1b_control_block);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
@@ -309,12 +299,11 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 		/* Now we can write the data */
 
-		status = acpi_write(value, &acpi_gbl_FADT.xpm1a_control_block);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
-
-		status = acpi_write(value, &acpi_gbl_FADT.xpm1b_control_block);
+		status = acpi_hw_write_multiple(value,
+						&acpi_gbl_FADT.
+						xpm1a_control_block,
+						&acpi_gbl_FADT.
+						xpm1b_control_block);
 		break;
 
 	case ACPI_REGISTER_PM1A_CONTROL:	/* 16-bit access */
@@ -346,6 +335,7 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		break;
 
 	default:
+		ACPI_ERROR((AE_INFO, "Unknown Register ID: %X", register_id));
 		status = AE_BAD_PARAMETER;
 		break;
 	}
@@ -353,3 +343,88 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
       exit:
 	return_ACPI_STATUS(status);
 }
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_read_multiple
+ *
+ * PARAMETERS:  Value               - Where the register value is returned
+ *              register_a           - First ACPI register (required)
+ *              register_b           - Second ACPI register (optional)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Read from the specified two-part ACPI register (such as PM1 A/B)
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_read_multiple(u32 *value,
+		      struct acpi_generic_address *register_a,
+		      struct acpi_generic_address *register_b)
+{
+	u32 value_a = 0;
+	u32 value_b = 0;
+	acpi_status status;
+
+	/* The first register is always required */
+
+	status = acpi_read(&value_a, register_a);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Second register is optional */
+
+	if (register_b->address) {
+		status = acpi_read(&value_b, register_b);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	}
+
+	/* Shift the B bits above the A bits */
+
+	*value = value_a | (value_b << register_a->bit_width);
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_write_multiple
+ *
+ * PARAMETERS:  Value               - The value to write
+ *              register_a           - First ACPI register (required)
+ *              register_b           - Second ACPI register (optional)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Write to the specified two-part ACPI register (such as PM1 A/B)
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_write_multiple(u32 value,
+		       struct acpi_generic_address *register_a,
+		       struct acpi_generic_address *register_b)
+{
+	acpi_status status;
+
+	/* The first register is always required */
+
+	status = acpi_write(value, register_a);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Second register is optional */
+
+	if (register_b->address) {
+
+		/* Normalize the B bits before write */
+
+		status = acpi_write(value >> register_a->bit_width, register_b);
+	}
+
+	return (status);
+}
-- 
1.6.0.6

