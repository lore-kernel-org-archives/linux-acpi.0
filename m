From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/27] ACPICA: Change exception code for LoadTable operator.
Date: Mon, 31 Dec 2012 08:05:09 +0800
Message-ID: <27eaac1cb6879efed18e954b1bcc013839dc0ea2.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19295 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAFW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:05:22 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

For the case where one of the input strings is too long,
change the returned exception code from AE_BAD_PARAMETER to
AE_AML_STRING_LIMIT.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index d0cc2a4..f214dbf 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -48,6 +48,7 @@
 #include "actables.h"
 #include "acdispat.h"
 #include "acevents.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exconfig")
@@ -166,7 +167,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 	if ((operand[0]->string.length > ACPI_NAME_SIZE) ||
 	    (operand[1]->string.length > ACPI_OEM_ID_SIZE) ||
 	    (operand[2]->string.length > ACPI_OEM_TABLE_ID_SIZE)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
 	}
 
 	/* Find the ACPI table in the RSDT/XSDT */
@@ -213,8 +214,8 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 	/* parameter_path (optional parameter) */
 
 	if (operand[4]->string.length > 0) {
-		if ((operand[4]->string.pointer[0] != '\\') &&
-		    (operand[4]->string.pointer[0] != '^')) {
+		if ((operand[4]->string.pointer[0] != AML_ROOT_PREFIX) &&
+		    (operand[4]->string.pointer[0] != AML_PARENT_PREFIX)) {
 			/*
 			 * Path is not absolute, so it will be relative to the node
 			 * referenced by the root_path_string (or the NS root if omitted)
-- 
1.7.10

