From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/14] ACPICA: Tables: Remove wrong table event macros
Date: Wed,  7 Sep 2016 14:06:24 +0800
Message-ID: <7e6bfc0c99703f9f680d118d634895b8fc1b9f32.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7496 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbcIGGGq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:06:46 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit fcc129d04f865161f308d3b8743496cc3f4d233e

There are wrong table event macros, this patch cleans them up.

Link: https://bugs.acpica.org/show_bug.cgi?id=1321
Link: https://github.com/acpica/acpica/commit/fcc129d0
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actypes.h |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index e96907b..892595f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1034,12 +1034,6 @@ struct acpi_statistics {
 	u32 method_count;
 };
 
-/* Table Event Types */
-
-#define ACPI_TABLE_EVENT_LOAD           0x0
-#define ACPI_TABLE_EVENT_UNLOAD         0x1
-#define ACPI_NUM_TABLE_EVENTS           2
-
 /*
  * Types specific to the OS service interfaces
  */
@@ -1091,9 +1085,11 @@ acpi_status (*acpi_exception_handler) (acpi_status aml_status,
 typedef
 acpi_status (*acpi_table_handler) (u32 event, void *table, void *context);
 
-#define ACPI_TABLE_LOAD             0x0
-#define ACPI_TABLE_UNLOAD           0x1
-#define ACPI_NUM_TABLE_EVENTS       2
+/* Table Event Types */
+
+#define ACPI_TABLE_EVENT_LOAD           0x0
+#define ACPI_TABLE_EVENT_UNLOAD         0x1
+#define ACPI_NUM_TABLE_EVENTS           2
 
 /* Address Spaces (For Operation Regions) */
 
-- 
1.7.10

