From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/15] ACPICA: Update ANOBJ_IS_EXTERNAL flag.
Date: Thu, 31 Oct 2013 09:30:04 +0800
Message-ID: <45f3e2278a4f5f432fa4626a8e22a78edd326bd4.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34181 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab3JaBaj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:30:39 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 13 lines of divergences.

The ANOBJ_IS_EXTERNAL flag is only used by an ACPICA utilities - iASL.

There is no functional change for Linux kernel by applying this commit
except the above mentioned divergences reduction.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nssearch.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 5d43efc..47420fa 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -381,7 +381,8 @@ acpi_ns_search_and_enter(u32 target_name,
 
 	/* Node is an object defined by an External() statement */
 
-	if (flags & ACPI_NS_EXTERNAL) {
+	if (flags & ACPI_NS_EXTERNAL ||
+	    (walk_state && walk_state->opcode == AML_SCOPE_OP)) {
 		new_node->flags |= ANOBJ_IS_EXTERNAL;
 	}
 #endif
-- 
1.7.10

