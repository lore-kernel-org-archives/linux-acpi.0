From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v2 2/3] ACPICA: Dispatcher: Fix an unbalanced lock exit path in acpi_ds_auto_serialize_method()
Date: Wed, 26 Oct 2016 15:40:20 +0800
Message-ID: <56eca17f372ccd8585bd855bff0e0d0680f658c7.1477465173.git.lv.zheng@intel.com>
References: <cover.1477372449.git.lv.zheng@intel.com> <cover.1477465173.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34817 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754755AbcJZHkZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2016 03:40:25 -0400
In-Reply-To: <cover.1477465173.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

There is a lock unbalanced exit path in acpi_ds_initialize_method(),
this patch corrects it. Lv Zheng.

Fixes: 441ad11d078f ("ACPICA: Dispatcher: Fix a mutex issue for method auto serialization")
Tested-by: Imre Deak <imre.deak@intel.com>
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

