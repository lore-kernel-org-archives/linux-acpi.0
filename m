From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/18] ACPICA: Hardware: Add sleep register hooks
Date: Wed, 28 Dec 2016 15:28:49 +0800
Message-ID: <351c423c9eb15cf811ceff6f60d986ee02db19fa.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit ba665dc8e20d9f7730466a659564dd6c557a6cbc

In Linux, para-virtualization implmentation hooks critical register writes
to prevent real hardware operations. This increases divergences when the
sleep registers are cracked in Linux resident ACPICA. This patch tries to
introduce a single OSL to reduce the divergences. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/ba665dc8
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwesleep.c                     | 35 ++++++++++------------
 drivers/acpi/acpica/hwsleep.c                      | 11 +++----
 drivers/acpi/osl.c                                 | 27 +++++++++++++++--
 include/acpi/acexcep.h                             |  9 ++----
 include/acpi/acpiosxf.h                            |  4 +++
 .../acpi/os_specific/service_layers/osunixxf.c     | 22 ++++++++++++++
 6 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 3f2fb4b..9023a1b 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -43,7 +43,6 @@
  */
 
 #include <acpi/acpi.h>
-#include <linux/acpi.h>
 #include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -103,7 +102,7 @@ void acpi_hw_execute_sleep_method(char *method_pathname, u32 integer_argument)
 acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 {
 	acpi_status status;
-	u8 sleep_type_value;
+	u8 sleep_control;
 	u64 sleep_status;
 
 	ACPI_FUNCTION_TRACE(hw_extended_sleep);
@@ -125,18 +124,6 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 
 	acpi_gbl_system_awake_and_running = FALSE;
 
-	/* Flush caches, as per ACPI specification */
-
-	ACPI_FLUSH_CPU_CACHE();
-
-	status = acpi_os_prepare_extended_sleep(sleep_state,
-						acpi_gbl_sleep_type_a,
-						acpi_gbl_sleep_type_b);
-	if (ACPI_SKIP(status))
-		return_ACPI_STATUS(AE_OK);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
-
 	/*
 	 * Set the SLP_TYP and SLP_EN bits.
 	 *
@@ -146,12 +133,22 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
 			  "Entering sleep state [S%u]\n", sleep_state));
 
-	sleep_type_value =
-	    ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
-	     ACPI_X_SLEEP_TYPE_MASK);
+	sleep_control = ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
+			 ACPI_X_SLEEP_TYPE_MASK) | ACPI_X_SLEEP_ENABLE;
+
+	/* Flush caches, as per ACPI specification */
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	status = acpi_os_enter_sleep(sleep_state, sleep_control, 0);
+	if (status == AE_CTRL_TERMINATE) {
+		return_ACPI_STATUS(AE_OK);
+	}
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
-	status = acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),
-			    &acpi_gbl_FADT.sleep_control);
+	status = acpi_write((u64)sleep_control, &acpi_gbl_FADT.sleep_control);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index d00c981..563c5d9 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -43,7 +43,6 @@
  */
 
 #include <acpi/acpi.h>
-#include <linux/acpi.h>
 #include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -152,12 +151,14 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_os_prepare_sleep(sleep_state, pm1a_control,
-				       pm1b_control);
-	if (ACPI_SKIP(status))
+	status = acpi_os_enter_sleep(sleep_state, pm1a_control, pm1b_control);
+	if (status == AE_CTRL_TERMINATE) {
 		return_ACPI_STATUS(AE_OK);
-	if (ACPI_FAILURE(status))
+	}
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
+	}
+
 	/* Write #2: Write both SLP_TYP + SLP_EN */
 
 	status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a404ff4..82285c0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1686,7 +1686,7 @@ acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
 	if (rc < 0)
 		return AE_ERROR;
 	else if (rc > 0)
-		return AE_CTRL_SKIP;
+		return AE_CTRL_TERMINATE;
 
 	return AE_OK;
 }
@@ -1697,6 +1697,7 @@ void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
 	__acpi_os_prepare_sleep = func;
 }
 
+#if (ACPI_REDUCED_HARDWARE)
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state, u32 val_a,
 				  u32 val_b)
 {
@@ -1707,13 +1708,35 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state, u32 val_a,
 	if (rc < 0)
 		return AE_ERROR;
 	else if (rc > 0)
-		return AE_CTRL_SKIP;
+		return AE_CTRL_TERMINATE;
 
 	return AE_OK;
 }
+#else
+acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state, u32 val_a,
+				  u32 val_b)
+{
+	return AE_OK;
+}
+#endif
 
 void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 			       u32 val_a, u32 val_b))
 {
 	__acpi_os_prepare_extended_sleep = func;
 }
+
+acpi_status acpi_os_enter_sleep(u8 sleep_state,
+				u32 reg_a_value, u32 reg_b_value)
+{
+	acpi_status status;
+
+	if (acpi_gbl_reduced_hardware)
+		status = acpi_os_prepare_extended_sleep(sleep_state,
+							reg_a_value,
+							reg_b_value);
+	else
+		status = acpi_os_prepare_sleep(sleep_state,
+					       reg_a_value, reg_b_value);
+	return status;
+}
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 2c39634..1155002 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -91,7 +91,6 @@ struct acpi_exception_info {
 #define ACPI_SUCCESS(a)                 (!(a))
 #define ACPI_FAILURE(a)                 (a)
 
-#define ACPI_SKIP(a)                    (a == AE_CTRL_SKIP)
 #define AE_OK                           (acpi_status) 0x0000
 
 /*
@@ -211,11 +210,10 @@ struct acpi_exception_info {
 #define AE_CTRL_TRANSFER                EXCEP_CTL (0x0008)
 #define AE_CTRL_BREAK                   EXCEP_CTL (0x0009)
 #define AE_CTRL_CONTINUE                EXCEP_CTL (0x000A)
-#define AE_CTRL_SKIP                    EXCEP_CTL (0x000B)
-#define AE_CTRL_PARSE_CONTINUE          EXCEP_CTL (0x000C)
-#define AE_CTRL_PARSE_PENDING           EXCEP_CTL (0x000D)
+#define AE_CTRL_PARSE_CONTINUE          EXCEP_CTL (0x000B)
+#define AE_CTRL_PARSE_PENDING           EXCEP_CTL (0x000C)
 
-#define AE_CODE_CTRL_MAX                0x000D
+#define AE_CODE_CTRL_MAX                0x000C
 
 /* Exception strings for acpi_format_exception */
 
@@ -378,7 +376,6 @@ static const struct acpi_exception_info acpi_gbl_exception_names_ctrl[] = {
 	EXCEP_TXT("AE_CTRL_TRANSFER", "Transfer control to called method"),
 	EXCEP_TXT("AE_CTRL_BREAK", "A Break has been executed"),
 	EXCEP_TXT("AE_CTRL_CONTINUE", "A Continue has been executed"),
-	EXCEP_TXT("AE_CTRL_SKIP", "Not currently used"),
 	EXCEP_TXT("AE_CTRL_PARSE_CONTINUE", "Used to skip over bad opcodes"),
 	EXCEP_TXT("AE_CTRL_PARSE_PENDING", "Used to implement AML While loops")
 };
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 42ab9b3..e166013 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -333,6 +333,10 @@ u64 acpi_os_get_timer(void);
 acpi_status acpi_os_signal(u32 function, void *info);
 #endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_enter_sleep
+acpi_status acpi_os_enter_sleep(u8 sleep_state, u32 rega_value, u32 regb_value);
+#endif
+
 /*
  * Debug print routines
  */
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 10648aa..e41c264 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -318,6 +318,28 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_os_enter_sleep
+ *
+ * PARAMETERS:  sleep_state         - Which sleep state to enter
+ *              rega_value          - Register A value
+ *              regb_value          - Register B value
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: A hook before writing sleep registers to enter the sleep
+ *              state. Return AE_CTRL_TERMINATE to skip further sleep register
+ *              writes.
+ *
+ *****************************************************************************/
+
+acpi_status acpi_os_enter_sleep(u8 sleep_state, u32 rega_value, u32 regb_value)
+{
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_os_redirect_output
  *
  * PARAMETERS:  destination         - An open file handle/pointer
-- 
2.7.4
