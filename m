From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 03/26] ACPICA: Hardware: Enable 64-bit firmware waking vector for selected FACS.
Date: Wed,  1 Jul 2015 14:43:04 +0800
Message-ID: <9faf7d9dc7a69f5e1911c31dbea959a259fad027.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 7aa598d711644ab0de5f70ad88f1e2de253115e4

The following commit is reported to have broken s2ram on some platforms:
 Commit: 0249ed2444d65d65fc3f3f64f398f1ad0b7e54cd
 ACPICA: Add option to favor 32-bit FADT addresses.
The platform reports 2 FACS tables (which is not allowed by ACPI
specification) and the new 32-bit address favor rule forces OSPMs to use
the FACS table reported via FADT's X_FIRMWARE_CTRL field.

The root cause of the reported bug might be one of the followings:
1. BIOS may favor the 64-bit firmware waking vector address when the
   version of the FACS is greater than 0 and Linux currently only supports
   resuming from the real mode, so the 64-bit firmware waking vector has
   never been set and might be invalid to BIOS while the commit enables
   higher version FACS.
2. BIOS may favor the FACS reported via the "FIRMWARE_CTRL" field in the
   FADT while the commit doesn't set the firmware waking vector address of
   the FACS reported by "FIRMWARE_CTRL", it only sets the firware waking
   vector address of the FACS reported by "X_FIRMWARE_CTRL".

This patch excludes the cases that can trigger the bugs caused by the root
cause 1.

ACPI specification says:
A. 32-bit FACS address (FIRMWARE_CTRL field in FADT):
   Physical memory address of the FACS, where OSPM and firmware exchange
   control information.
   If the X_FIRMWARE_CTRL field contains a non zero value then this field
   must be zero.
   A zero value indicates that no FACS is specified by this field.
B. 64-bit FACS address (X_FIRMWARE_CTRL field in FADT):
   64bit physical memory address of the FACS.
   This field is used when the physical address of the FACS is above 4GB.
   If the FIRMWARE_CTRL field contains a non zero value then this field
   must be zero.
   A zero value indicates that no FACS is specified by this field.
Thus the 32bit and 64bit firmware waking vector should indicate completely
different resuming environment - real mode (1MB addressable) and non real
mode (4GB+ addressable) and currently Linux only supports resuming from
real mode.

This patch enables 64-bit firmware waking vector for selected FACS via new
acpi_set_firmware_waking_vectors() API so that it's up to OSPMs to
determine which resuming mode should be used by BIOS and ACPICA changes
won't trigger the bugs caused by the root cause 1. Lv Zheng.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=74021
Link: https://github.com/acpica/acpica/commit/7aa598d7
Reported-and-tested-by: Oswald Buddenhagen <ossi@kde.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c |   71 +++++++++++++++++++++++++++++----------
 include/acpi/acpixf.h           |    8 +++--
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 6f171c2..510bd326 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -72,6 +72,7 @@ static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
 
 /*
  * These functions are removed for the ACPI_REDUCED_HARDWARE case:
+ *      acpi_set_firmware_waking_vectors
  *      acpi_set_firmware_waking_vector
  *      acpi_set_firmware_waking_vector64
  *      acpi_enter_sleep_state_s4bios
@@ -80,21 +81,25 @@ static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
- * FUNCTION:    acpi_set_firmware_waking_vector
+ * FUNCTION:    acpi_set_firmware_waking_vectors
  *
  * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
  *                                    entry point.
+ *              physical_address64  - 64-bit physical address of ACPI protected
+ *                                    mode entry point.
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Sets the 32-bit firmware_waking_vector field of the FACS
+ * DESCRIPTION: Sets the firmware_waking_vector fields of the FACS
  *
  ******************************************************************************/
 
-acpi_status acpi_set_firmware_waking_vector(u32 physical_address)
+acpi_status
+acpi_set_firmware_waking_vectors(acpi_physical_address physical_address,
+				 acpi_physical_address physical_address64)
 {
 
-	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
+	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vectors);
 
 
 	/*
@@ -107,17 +112,51 @@ acpi_status acpi_set_firmware_waking_vector(u32 physical_address)
 
 	/* Set the 32-bit vector */
 
-	acpi_gbl_FACS->firmware_waking_vector = physical_address;
+	acpi_gbl_FACS->firmware_waking_vector = (u32)physical_address;
 
-	/* Clear the 64-bit vector if it exists */
+	if (acpi_gbl_FACS->length > 32) {
+		if (acpi_gbl_FACS->version >= 1) {
 
-	if ((acpi_gbl_FACS->length > 32) && (acpi_gbl_FACS->version >= 1)) {
-		acpi_gbl_FACS->xfirmware_waking_vector = 0;
+			/* Set the 64-bit vector */
+
+			acpi_gbl_FACS->xfirmware_waking_vector =
+			    physical_address64;
+		} else {
+			/* Clear the 64-bit vector if it exists */
+
+			acpi_gbl_FACS->xfirmware_waking_vector = 0;
+		}
 	}
 
 	return_ACPI_STATUS(AE_OK);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vectors)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_set_firmware_waking_vector
+ *
+ * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
+ *                                    entry point.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Sets the 32-bit firmware_waking_vector field of the FACS
+ *
+ ******************************************************************************/
+acpi_status acpi_set_firmware_waking_vector(u32 physical_address)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
+
+	status = acpi_set_firmware_waking_vectors((acpi_physical_address)
+						  physical_address, 0);
+
+	return_ACPI_STATUS(status);
+}
+
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 
 #if ACPI_MACHINE_WIDTH == 64
@@ -137,19 +176,15 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
  ******************************************************************************/
 acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
 {
-	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
-
-	/* Determine if the 64-bit vector actually exists */
+	acpi_status status;
 
-	if ((acpi_gbl_FACS->length <= 32) || (acpi_gbl_FACS->version < 1)) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
+	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
 
-	/* Clear 32-bit vector, set the 64-bit X_ vector */
+	status = acpi_set_firmware_waking_vectors(0,
+						  (acpi_physical_address)
+						  physical_address);
 
-	acpi_gbl_FACS->firmware_waking_vector = 0;
-	acpi_gbl_FACS->xfirmware_waking_vector = physical_address;
-	return_ACPI_STATUS(AE_OK);
+	return_ACPI_STATUS(status);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d68f1cd..821095c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -814,8 +814,12 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status acpi_leave_sleep_state(u8 sleep_state))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_set_firmware_waking_vector(u32
-								physical_address))
+				acpi_set_firmware_waking_vectors
+				(acpi_physical_address physical_address,
+				 acpi_physical_address physical_address64))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_set_firmware_waking_vector(u32
+								 physical_address))
 #if ACPI_MACHINE_WIDTH == 64
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_set_firmware_waking_vector64(u64
-- 
1.7.10
