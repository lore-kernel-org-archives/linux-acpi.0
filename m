From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/15] ACPICA: Tables: make default region accessible during the table load
Date: Fri, 19 Feb 2016 14:16:56 +0800
Message-ID: <40c173ec33aef07904819aa8bf101903b6bfbeb9.1455857583.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 016b2a0917cca9cf0d40c38a1541017d9cf569dd

It is proven that the default regions should be accessible during the
table loading in order to execute module level AML code.
This patch moves default region handler installation code earlier in
order to make this happen.
Note that by putting the code here, we actually allow OSPMs to override
default region handlers between acpi_initialize_subsystem() and
acpi_load_tables(), without the need to introduce region handler override
mechanism in acpi_install_address_space_handler(). OSPMs are also couraged
to check acpi_install_address_space_handler() return value to determine if
acpi_remove_address_space_handler() should be invoked before installing new
address space handler. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/016b2a09
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbxfload.c |   22 ++++++++++++++++++++++
 drivers/acpi/acpica/utxfinit.c |   12 +++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index c89943b..9496b84 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -47,6 +47,7 @@
 #include "accommon.h"
 #include "acnamesp.h"
 #include "actables.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbxfload")
@@ -68,6 +69,27 @@ acpi_status __init acpi_load_tables(void)
 
 	ACPI_FUNCTION_TRACE(acpi_load_tables);
 
+	/*
+	 * Install the default operation region handlers. These are the
+	 * handlers that are defined by the ACPI specification to be
+	 * "always accessible" -- namely, system_memory, system_IO, and
+	 * PCI_Config. This also means that no _REG methods need to be
+	 * run for these address spaces. We need to have these handlers
+	 * installed before any AML code can be executed, especially any
+	 * module-level code (11/2015).
+	 * Note that we allow OSPMs to install their own region handlers
+	 * between acpi_initialize_subsystem() and acpi_load_tables() to use
+	 * their customized default region handlers.
+	 */
+	if (acpi_gbl_group_module_level_code) {
+		status = acpi_ev_install_region_handlers();
+		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"During Region initialization"));
+			return_ACPI_STATUS(status);
+		}
+	}
+
 	/* Load the namespace from the tables */
 
 	status = acpi_tb_load_namespace();
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 721b87c..e1ffd7a 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -163,11 +163,13 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 	 * installed before any AML code can be executed, especially any
 	 * module-level code (11/2015).
 	 */
-	status = acpi_ev_install_region_handlers();
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"During Region initialization"));
-		return_ACPI_STATUS(status);
+	if (!acpi_gbl_group_module_level_code) {
+		status = acpi_ev_install_region_handlers();
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"During Region initialization"));
+			return_ACPI_STATUS(status);
+		}
 	}
 #if (!ACPI_REDUCED_HARDWARE)
 
-- 
1.7.10
