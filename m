From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/94] ACPICA: Update FACS waking vector interfaces
Date: Fri, 09 Jan 2009 04:26:22 -0500
Message-ID: <d85988fa0205b18459071e4bd709e48e695b952d.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbZAIJ15 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:57 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700HR2688X1F2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:33 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split AcpiSetFirmwareWakingVector into two: one for the 32-bit
vector, another for the 64-bit vector. This is required because the
host OS must setup the wake much differently for each vector (real
vs. protected mode, etc.) and the interface should not be deciding
which vector to use.  Also eliminate the GetFirmwareWakingVector
interface, as it served no purpose (only the firmware reads the
vector, OS only writes the vector.)  ACPICA BZ 731.

http://www.acpica.org/bugzilla/show_bug.cgi?id=731

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   54 +++++++++++++++++++++++----------------
 include/acpi/acpixf.h           |    6 +---
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 25dccdf..6a30c80 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -52,16 +52,16 @@ ACPI_MODULE_NAME("hwsleep")
  *
  * FUNCTION:    acpi_set_firmware_waking_vector
  *
- * PARAMETERS:  physical_address    - Physical address of ACPI real mode
+ * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
  *                                    entry point.
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
+ * DESCRIPTION: Sets the 32-bit firmware_waking_vector field of the FACS
  *
  ******************************************************************************/
 acpi_status
-acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
+acpi_set_firmware_waking_vector(u32 physical_address)
 {
 	struct acpi_table_facs *facs;
 	acpi_status status;
@@ -85,10 +85,16 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
 	 * Protected Mode.  Some systems (for example HP dv5-1004nr) are known
 	 * to fail to resume if the 64-bit vector is used.
 	 */
-	if (facs->version >= 1)
-		facs->xfirmware_waking_vector = 0;
 
-	facs->firmware_waking_vector = (u32)physical_address;
+	/* Set the 32-bit vector */
+
+	facs->firmware_waking_vector = physical_address;
+
+	/* Clear the 64-bit vector if it exists */
+
+	if ((facs->length > 32) && (facs->version >= 1)) {
+		facs->xfirmware_waking_vector = 0;
+	}
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -97,29 +103,25 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_firmware_waking_vector
+ * FUNCTION:    acpi_set_firmware_waking_vector64
  *
- * PARAMETERS:  *physical_address   - Where the contents of
- *                                    the firmware_waking_vector field of
- *                                    the FACS will be returned.
+ * PARAMETERS:  physical_address    - 64-bit physical address of ACPI protected
+ *                                    mode entry point.
  *
- * RETURN:      Status, vector
+ * RETURN:      Status
  *
- * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
+ * DESCRIPTION: Sets the 64-bit X_firmware_waking_vector field of the FACS, if
+ *              it exists in the table.
  *
  ******************************************************************************/
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
+acpi_set_firmware_waking_vector64(u64 physical_address)
 {
 	struct acpi_table_facs *facs;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(acpi_get_firmware_waking_vector);
+	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
 
-	if (!physical_address) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
 
 	/* Get the FACS */
 
@@ -131,14 +133,22 @@ acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Get the vector */
-	*physical_address = (acpi_physical_address)facs->firmware_waking_vector;
+	/* Determine if the 64-bit vector actually exists */
+
+	if ((facs->length <= 32) || (facs->version < 1)) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	/* Clear 32-bit vector, set the 64-bit X_ vector */
+
+	facs->firmware_waking_vector = 0;
+	facs->xfirmware_waking_vector = physical_address;
 
 	return_ACPI_STATUS(AE_OK);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_get_firmware_waking_vector)
-#endif
+ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_prep
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 33bc0e3..c9b903f 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -320,12 +320,10 @@ acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
 acpi_status acpi_set_register(u32 register_id, u32 value);
 
 acpi_status
-acpi_set_firmware_waking_vector(acpi_physical_address physical_address);
+acpi_set_firmware_waking_vector(u32 physical_address);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_get_firmware_waking_vector(acpi_physical_address * physical_address);
-#endif
+acpi_set_firmware_waking_vector64(u64 physical_address);
 
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
-- 
1.5.6.6

