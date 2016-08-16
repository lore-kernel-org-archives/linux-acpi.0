From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/5] ACPICA: Tables: Remove wrong table event macros
Date: Tue, 16 Aug 2016 16:52:55 +0800
Message-ID: <be6e8bc6cb869b341d2f051e9d6ac73badd5a241.1471337441.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There are wrong table event macros, this patch cleans them up.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
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
