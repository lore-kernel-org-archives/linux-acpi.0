From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/27] ACPICA: Utilities: Deploy ACPI_DEBUGGER_EXEC for ACPI_DEBUGGER enabled code in utglobal.c.
Date: Wed, 30 Apr 2014 10:03:39 +0800
Message-ID: <53dbe352c16de24ea99d00af21eb01750af90074.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch deploys ACPI_DEBUGGER_EXEC usage to utglobal.c to reduce "ifdef"
of ACPI_DEBUGGER.  No functional changes.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utglobal.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index f3abeae..825b064 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -377,9 +377,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_disable_mem_tracking = FALSE;
 #endif
 
-#ifdef ACPI_DEBUGGER
-	acpi_gbl_db_terminate_threads = FALSE;
-#endif
+	ACPI_DEBUGGER_EXEC(acpi_gbl_db_terminate_threads = FALSE);
 
 	return_ACPI_STATUS(AE_OK);
 }
-- 
1.7.10
