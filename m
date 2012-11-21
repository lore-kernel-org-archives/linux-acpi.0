From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/15] ACPICA: Add macros to extract flag bits from resource descriptors.
Date: Wed, 21 Nov 2012 18:08:24 +0800
Message-ID: <497683a2feb4c4f9afb701b8e1ce72ca87769b1c.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40439 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412Ab2KUKId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:08:33 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Improves readability and maintainability of the code.  Fixes a
problem with the UART serial bus descriptor for the number of
data bits flags (was incorrectly 2 bits, should be 3).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 5efad99..1fa91f1 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -293,6 +293,20 @@
 #define ACPI_16BIT_MASK     0x0000FFFF
 #define ACPI_24BIT_MASK     0x00FFFFFF
 
+/* Macros to extract flag bits from position zero */
+
+#define ACPI_GET_1BIT_FLAG(value)                   ((value) & ACPI_1BIT_MASK)
+#define ACPI_GET_2BIT_FLAG(value)                   ((value) & ACPI_2BIT_MASK)
+#define ACPI_GET_3BIT_FLAG(value)                   ((value) & ACPI_3BIT_MASK)
+#define ACPI_GET_4BIT_FLAG(value)                   ((value) & ACPI_4BIT_MASK)
+
+/* Macros to extract flag bits from position one and above */
+
+#define ACPI_EXTRACT_1BIT_FLAG(field, position)     (ACPI_GET_1BIT_FLAG ((field) >> position))
+#define ACPI_EXTRACT_2BIT_FLAG(field, position)     (ACPI_GET_2BIT_FLAG ((field) >> position))
+#define ACPI_EXTRACT_3BIT_FLAG(field, position)     (ACPI_GET_3BIT_FLAG ((field) >> position))
+#define ACPI_EXTRACT_4BIT_FLAG(field, position)     (ACPI_GET_4BIT_FLAG ((field) >> position))
+
 /*
  * An object of type struct acpi_namespace_node can appear in some contexts
  * where a pointer to an object of type union acpi_operand_object can also
-- 
1.7.10

