From: Zhaogang Gong <gongzhaogang@inspur.com>
Subject: [PATCH] acpica: modify a commit error in file drivers/acpi/acpica/nsxfeval.c
Date: Mon, 13 Apr 2015 17:05:07 +0800
Message-ID: <1428915907-14302-1-git-send-email-gongzhaogang@inspur.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yanxiaofeng@inspur.com, Zhaogang Gong <gongzhaogang@inspur.com>
List-Id: linux-acpi@vger.kernel.org

Change "iff" in function acpi_evaluate_object() to "if".

Signed-off-by: Zhaogang Gong <gongzhaogang@inspur.com>
---
 drivers/acpi/acpica/nsxfeval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index b6030a2..9571429 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -214,7 +214,7 @@ acpi_evaluate_object(acpi_handle handle,
 		info->prefix_node = NULL;
 	} else if (!handle) {
 		/*
-		 * A handle is optional iff a fully qualified pathname is specified.
+		 * A handle is optional if a fully qualified pathname is specified.
 		 * Since we've already handled fully qualified names above, this is
 		 * an error.
 		 */
-- 
1.9.1
