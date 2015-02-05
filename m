From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/10] ACPICA: Events: Fix uninitialized variable
Date: Thu,  5 Feb 2015 15:20:07 +0800
Message-ID: <19cfc65addc650a540164e13b31409c9f191ea1a.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 8e21180050270897499652e922c6a41b8eb388b6

Recent changes to acpi_ev_asynch_execute_gpe_method left Status
variable uninitialized before use. Initialize to AE_OK.

Link: https://github.com/acpica/acpica/commit/8e211800
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evgpe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index ddee967..d8b919a 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -473,7 +473,7 @@ unlock_and_exit:
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info = context;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	struct acpi_evaluate_info *info;
 	struct acpi_gpe_notify_info *notify;
 
-- 
1.7.10
