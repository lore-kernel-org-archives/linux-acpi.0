From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/22] ACPICA: iASL: Add new warnings for method local_x and arg_x variables.
Date: Thu, 23 Jul 2015 12:53:35 +0800
Message-ID: <ff9ae809237964320577367b8e0ea304f35699f4.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61456 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202AbbGWExm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:53:42 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit eb9f8cb9fd65f1149dd335d05944c31cbca41af3

1) Warn if a Local is set but never used
2) Warn if a arg_x is never used (for non-predefined method names)
3) Warn if a arg_x that is used as a local is never used

This patch only affects iASL which is not in the kernel source tree.

Link: https://github.com/acpica/acpica/commit/eb9f8cb9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 610d001..4758185 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -174,8 +174,12 @@ struct acpi_namespace_node {
 	 */
 #ifdef ACPI_LARGE_NAMESPACE_NODE
 	union acpi_parse_object *op;
+	void *method_locals;
+	void *method_args;
 	u32 value;
 	u32 length;
+	u8 arg_count;
+
 #endif
 };
 
-- 
1.7.10

