From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/15] ACPICA: ACPICA: Tune _REG evaluations order in the initialization steps
Date: Fri, 19 Feb 2016 14:17:05 +0800
Message-ID: <ad226aa20fb8e3f4391c0c5ecea0258063be32ea.1455857583.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 77e0c7a482ac30ef857cf3c33d075e5fe5b5e449

This patch tunes _REG evaluations to be later than all table loading
facilities:
1. acpi_load_tables(): _REG is currently invoked after this function.
2. acpi_ns_exec_module_code_list(): this executes module level code, the
   execution should be a part of the table loading while we currently
   support this in a deferred way.
3. acpi_ns_initialize_objects(): this parses Region/Field/Buffer/Package where
   pkg_length primitive can be seen in the grammar, the parsing should be a
   part of the table loading while we currently support this in a deferred
   way.
Control method evaluation should happen after loading the tables. So this
patch changes the order of _REG evaluation when
acpi_gbl_group_module_level_code experiment is enabled. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/77e0c7a4
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utxfinit.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index e1ffd7a..9415830 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -262,23 +262,6 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_initialize_objects);
 
-	/*
-	 * Run all _REG methods
-	 *
-	 * Note: Any objects accessed by the _REG methods will be automatically
-	 * initialized, even if they contain executable AML (see the call to
-	 * acpi_ns_initialize_objects below).
-	 */
-	acpi_gbl_reg_methods_enabled = TRUE;
-	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Executing _REG OpRegion methods\n"));
-
-		status = acpi_ev_initialize_op_regions();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
 #ifdef ACPI_EXEC_APP
 	/*
 	 * This call implements the "initialization file" option for acpi_exec.
@@ -319,6 +302,24 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 	}
 
 	/*
+	 * Run all _REG methods
+	 *
+	 * Note: Any objects accessed by the _REG methods will be automatically
+	 * initialized, even if they contain executable AML (see the call to
+	 * acpi_ns_initialize_objects below).
+	 */
+	acpi_gbl_reg_methods_enabled = TRUE;
+	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "[Init] Executing _REG OpRegion methods\n"));
+
+		status = acpi_ev_initialize_op_regions();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	}
+
+	/*
 	 * Initialize all device objects in the namespace. This runs the device
 	 * _STA and _INI methods.
 	 */
-- 
1.7.10
