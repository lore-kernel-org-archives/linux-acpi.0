From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/15] ACPICA: Fix possible memory leak.
Date: Wed, 21 Nov 2012 18:07:42 +0800
Message-ID: <a733b5310f37a5660761e5561ffdb42ced61a36b.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29972 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058Ab2KUKHr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:07:47 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Jesper Juhl <jj@chaosbits.net>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Jesper Juhl <jj@chaosbits.net>

Ensure cleanup after a memory allocation failure in dsmethod.c.
Original Linux change from Jesper Juhl.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index f7a7cf3..4ce1d57 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -376,7 +376,8 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	 */
 	info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
 	if (!info) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto cleanup;
 	}
 
 	info->parameters = &this_walk_state->operands[0];
-- 
1.7.10

