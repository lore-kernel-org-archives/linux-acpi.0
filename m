From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/22] ACPICA: Debugger: Reduce structure size for debugger.
Date: Thu, 23 Jul 2015 12:54:11 +0800
Message-ID: <53939d93c37ee3cde41ccd20d4bfc7ae9a1696ae.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41346 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754019AbbGWEyY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:54:24 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 310e0ae1c4730f4dadc80125125099ab76851499

arg_types in struct acpi_db_method_info is only referenced by ACPI_DEBUGGER.

This patch only affects ACPICA debugger which is only used by a non-kernel
tool - acpiexec, so Linux kernel is currently not affected by this patch.

Link: https://github.com/acpica/acpica/commit/310e0ae1
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 4758185..a6b6887 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1107,6 +1107,9 @@ struct acpi_db_method_info {
 	 *   Index of current thread inside all them created.
 	 */
 	char init_args;
+#ifdef ACPI_DEBUGGER
+	acpi_object_type arg_types[4];
+#endif
 	char *arguments[4];
 	char num_threads_str[11];
 	char id_of_thread_str[11];
-- 
1.7.10

