From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/30] ACPICA: Tables: Fix wrong MLC condition for dynamic table loading
Date: Thu, 24 Mar 2016 09:41:39 +0800
Message-ID: <c97c41e19087ea5ccbda4653da6845d44d2e1396.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 5798cd6171ea38bcf4594d0ccc78870784776ba5

The patch corrects wrong condition before group MLC is disabled.

Link: https://github.com/acpica/acpica/commit/5798cd61
Link: https://bugs.acpica.org/show_bug.cgi?id=1262
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index f741613..a1d177d 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -118,7 +118,9 @@ acpi_ex_add_table(u32 table_index,
 	/* Execute any module-level code that was found in the table */
 
 	acpi_ex_exit_interpreter();
-	acpi_ns_exec_module_code_list();
+	if (acpi_gbl_group_module_level_code) {
+		acpi_ns_exec_module_code_list();
+	}
 	acpi_ex_enter_interpreter();
 
 	/*
-- 
1.7.10
