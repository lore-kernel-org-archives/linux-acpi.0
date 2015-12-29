From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 35/42] ACPICA: Utilities: Reorder initialization code
Date: Tue, 29 Dec 2015 14:02:18 +0800
Message-ID: <e37cdfb3c1ae7ae79ad85f93172e8cb4d34ee078.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 3894fa9d071343e6ebc7ea480255fa4f27a290be

This patch re-orders initialization code in acpi_enable_subsystem()
so that all hardware reduced stuffs can be collected together.

Note this patch contains code from the following 2 ACPICA upstream commits
so that the changes can be made clearer for the reviewers:
 https://github.com/acpica/acpica/commit/071eff73
 https://github.com/acpica/acpica/commit/3894fa9d
And additional change to remove the global variable and unused code
fragments due to the test result. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/3894fa9d
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utxfinit.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 8586260..7d8eb60 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -154,6 +154,21 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 	 */
 	acpi_gbl_early_initialization = FALSE;
 
+	/*
+	 * Install the default operation region handlers. These are the
+	 * handlers that are defined by the ACPI specification to be
+	 * "always accessible" -- namely, system_memory, system_IO, and
+	 * PCI_Config. This also means that no _REG methods need to be
+	 * run for these address spaces. We need to have these handlers
+	 * installed before any AML code can be executed, especially any
+	 * module-level code (11/2015).
+	 */
+	status = acpi_ev_install_region_handlers();
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During Region initialization"));
+		return_ACPI_STATUS(status);
+	}
 #if (!ACPI_REDUCED_HARDWARE)
 
 	/* Enable ACPI mode */
@@ -182,24 +197,8 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 			return_ACPI_STATUS(status);
 		}
 	}
-#endif				/* !ACPI_REDUCED_HARDWARE */
 
 	/*
-	 * Install the default op_region handlers. These are installed unless
-	 * other handlers have already been installed via the
-	 * install_address_space_handler interface.
-	 */
-	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Installing default address space handlers\n"));
-
-		status = acpi_ev_install_region_handlers();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-#if (!ACPI_REDUCED_HARDWARE)
-	/*
 	 * Initialize ACPI Event handling (Fixed and General Purpose)
 	 *
 	 * Note1: We must have the hardware and events initialized before we can
-- 
1.7.10
