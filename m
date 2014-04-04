From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/28] ACPICA: Unload operator: Emit a warning if and when it is ever used.
Date: Fri,  4 Apr 2014 12:37:26 +0800
Message-ID: <83aca8466faa7ada04965d13690aa0f687f8b8fe.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11859 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaDDEhb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:31 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

We would like to see the ASL for any machine that uses this operator,
so emit at least a warning to hopefully draw some attention.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 8ba1464..1b734eb 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -576,6 +576,13 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	ACPI_FUNCTION_TRACE(ex_unload_table);
 
 	/*
+	 * Temporarily emit a warning so that the ASL for the machine can be
+	 * hopefully obtained. This is to say that the Unload() operator is
+	 * extremely rare if not completely unused.
+	 */
+	ACPI_WARNING((AE_INFO, "Received request to unload an ACPI table"));
+
+	/*
 	 * Validate the handle
 	 * Although the handle is partially validated in acpi_ex_reconfiguration()
 	 * when it calls acpi_ex_resolve_operands(), the handle is more completely
-- 
1.7.10

