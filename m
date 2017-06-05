From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 45/53] ACPICA: Disassembler: prevent external op's from opening a new scope
Date: Mon,  5 Jun 2017 16:41:43 +0800
Message-ID: <53cf38a20fdde106b46165a7122de111600b2190.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5896 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbdFEIlv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:51 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit c512c2bfcce65b8e8f37d549ac2fa4a1e0182e46

Since Externals could be of ACPI_TYPE_METHOD, there is a possibility
that the acpi_ns_lookup may cause a new scope to be opened. Therefore,
disable opening the scope for all acpi_ns_lookup invocations that deal
with externals.

Link: https://github.com/acpica/acpica/commit/c512c2bf
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dswload2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 8d510c7..ab5d318 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -310,6 +310,16 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 				flags |= ACPI_NS_TEMPORARY;
 			}
 		}
+#ifdef ACPI_ASL_COMPILER
+
+		/*
+		 * Do not open a scope. This could be an external method
+		 * and open a scope.
+		 */
+		if (walk_state->opcode == AML_EXTERNAL_OP) {
+			flags |= ACPI_NS_DONT_OPEN_SCOPE;
+		}
+#endif
 
 		/* Add new entry or lookup existing entry */
 
-- 
2.7.4

