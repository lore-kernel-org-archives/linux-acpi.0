From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/42] ACPICA: Namespace: Fix wrong error log
Date: Tue, 29 Dec 2015 13:52:51 +0800
Message-ID: <349aab91318420980f47b81c1397ec81ec99d431.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 20228e39e125d92f9d80c6e07d3767b225d0536e

The Info->Node in acpi_ns_init_one_device() may not be initialized. Even it is
initialized, the redundant "._INI" can be seen for this log entry. This
patch fixes this issue by using device_node instead. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/20228e39
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsinit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index b744a53..656eacf 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -582,7 +582,7 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 
 		/* Ignore error and move on to next device */
 
-		char *scope_name = acpi_ns_get_external_pathname(info->node);
+		char *scope_name = acpi_ns_get_external_pathname(device_node);
 
 		ACPI_EXCEPTION((AE_INFO, status, "during %s._INI execution",
 				scope_name));
-- 
1.7.10
