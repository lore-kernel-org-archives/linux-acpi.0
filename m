From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/27] ACPICA: Add root node optimization to internal get namespace node function.
Date: Mon, 31 Dec 2012 08:05:33 +0800
Message-ID: <d0f65ab011ac0307c61c5c8121b54a526fb35020.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7279 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAFn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:05:43 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Detect a request for the root node (a lone backslash) up front
before invoking a full namespace lookup.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsutils.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index d2dfe61..596d4cc 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -671,6 +671,8 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 
 	ACPI_FUNCTION_TRACE_PTR(ns_get_node, ACPI_CAST_PTR(char, pathname));
 
+	/* Simplest case is a null pathname */
+
 	if (!pathname) {
 		*return_node = prefix_node;
 		if (!prefix_node) {
@@ -679,6 +681,13 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	/* Quick check for a reference to the root */
+
+	if (ACPI_IS_ROOT_PREFIX(pathname[0]) && (!pathname[1])) {
+		*return_node = acpi_gbl_root_node;
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Convert path to internal representation */
 
 	status = acpi_ns_internalize_name(pathname, &internal_path);
-- 
1.7.10

