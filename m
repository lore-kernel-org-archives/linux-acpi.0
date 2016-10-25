From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 2/6] ACPICA: Dispatcher: Fix an unbalanced lock exit path in acpi_ds_auto_serialize_method()
Date: Tue, 25 Oct 2016 13:21:16 +0800
Message-ID: <21f8099f4e08fce02e82128e489429fccf9bd4b6.1477372449.git.lv.zheng@intel.com>
References: <cover.1477372449.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32848 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754787AbcJYFWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2016 01:22:00 -0400
In-Reply-To: <cover.1477372449.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

There is a lock unbalanced exit path in acpi_ds_initialize_method(),
this patch corrects it. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsmethod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index c4028a8..5997e59 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -128,7 +128,7 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		acpi_ps_free_op(op);
-		return_ACPI_STATUS(status);
+		goto unlock;
 	}
 
 	walk_state->descending_callback = acpi_ds_detect_named_opcodes;
-- 
2.7.4

