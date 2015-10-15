From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/13] ACPICA: Debugger: Fix dead lock issue ocurred in single stepping mode
Date: Thu, 15 Oct 2015 10:09:00 +0800
Message-ID: <53c0c65557f362e9e886bfc2ea262b3e8fab0993.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 35273add90da19cd8790fdb5735f52e3c9861684

When single step execution is not ended, executing another control methods
leads to dead locks around interpreter lock/namespace lock/method
serialization lock. So we should only allow one execution from the debugger
at same time. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/35273add
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbexec.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index 8eef298..9da2daa 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -370,7 +370,17 @@ acpi_db_execute(char *name, char **args, acpi_object_type * types, u32 flags)
 #ifdef ACPI_DEBUG_OUTPUT
 	u32 previous_allocations;
 	u32 allocations;
+#endif
 
+	/*
+	 * Allow one execution to be performed by debugger or single step
+	 * execution will be dead locked by the interpreter mutexes.
+	 */
+	if (acpi_gbl_method_executing) {
+		acpi_os_printf("Only one debugger execution is allowed.\n");
+		return;
+	}
+#ifdef ACPI_DEBUG_OUTPUT
 	/* Memory allocation tracking */
 
 	previous_allocations = acpi_db_get_outstanding_allocations();
-- 
1.7.10
