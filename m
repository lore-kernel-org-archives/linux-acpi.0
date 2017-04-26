From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/15] ACPICA: Debugger: Add interpreter blocking mark for single-step mode
Date: Wed, 26 Apr 2017 16:18:33 +0800
Message-ID: <c463aed1ea66e50b7b4821de7a06b0f9e069a75e.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50258 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952799AbdDZISh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:37 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

ACPICA commit 91af5d18cd40b35f9d5568fb95fc403ff12474e5

When the single-step mode is used, evaluation is actually split by the
single-step command prompts, so this patch correctly marks the evaluation
segment with interpreter lock release/acquire.
This in return fixes an issue that in the single-step command prompt,
commands requiring to hold the namespace lock (ex. namespace) cannot be
executed. ACPICA BZ 1362, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/91af5d18
Link: https://bugs.acpica.org/show_bug.cgi?id=1362
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbxface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 205b8e0..9b91cea 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "amlcode.h"
 #include "acdebug.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_CA_DEBUGGER
 ACPI_MODULE_NAME("dbxface")
@@ -368,7 +369,9 @@ acpi_db_single_step(struct acpi_walk_state *walk_state,
 		walk_state->method_breakpoint = 1;	/* Must be non-zero! */
 	}
 
+	acpi_ex_exit_interpreter();
 	status = acpi_db_start_command(walk_state, op);
+	acpi_ex_enter_interpreter();
 
 	/* User commands complete, continue execution of the interrupted method */
 
-- 
2.7.4

