From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/21] ACPICA: Interpreter: Add additional debug info for an error case.
Date: Wed,  8 Jan 2014 13:44:51 +0800
Message-ID: <e005b715158545b00a09b40dccf261434a52660a.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36155 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbaAHFo7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:59 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Emit the name of the namespace node for the error case when
there is no subobject attached to the node.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exresnte.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index acd34f5..7ca6925 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -124,7 +124,8 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 	}
 
 	if (!source_desc) {
-		ACPI_ERROR((AE_INFO, "No object attached to node %p", node));
+		ACPI_ERROR((AE_INFO, "No object attached to node [%4.4s] %p",
+			    node->name.ascii, node));
 		return_ACPI_STATUS(AE_AML_NO_OPERAND);
 	}
 
-- 
1.7.10

