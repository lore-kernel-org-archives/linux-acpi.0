From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/21] ACPICA: Conditionally define a local variable that is used for debug only.
Date: Wed,  8 Jan 2014 13:44:32 +0800
Message-ID: <833272730897d4f008e33cc83851eb23fbb432ef.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25595 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbaAHFol (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:41 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This patch improves the relationship between the opcode debugging
information and CONFIG_ACPI_DEBUG enablement.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psopinfo.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index d7bba3c..b0c9787 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -71,7 +71,9 @@ static const u8 acpi_gbl_argument_count[] =
 
 const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 {
+#ifdef ACPI_DEBUG_OUTPUT
 	const char *opcode_name = "Unknown AML opcode";
+#endif
 
 	ACPI_FUNCTION_NAME(ps_get_opcode_info);
 
@@ -94,7 +96,7 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 		return (&acpi_gbl_aml_op_info
 			[acpi_gbl_long_op_index[(u8)opcode]]);
 	}
-#ifdef ACPI_ASL_COMPILER
+#if defined ACPI_ASL_COMPILER && defined ACPI_DEBUG_OUTPUT
 #include "asldefine.h"
 
 	switch (opcode) {
-- 
1.7.10

