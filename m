From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/20] ACPICA: Update info messages during ACPICA init.
Date: Tue, 25 Aug 2015 10:28:54 +0800
Message-ID: <b80d0f8df06d46ab085c762f8cd215eada720e9d.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 4ccf8a1cc499ec8f00345f662a5887483980e1dd

Small cleanup of messages.

Link: https://github.com/acpica/acpica/commit/4ccf8a1c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsinit.c   |    9 +++++++++
 drivers/acpi/acpica/tbxfload.c |    4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 95779e8..bbf52f0 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -237,6 +237,15 @@ acpi_ds_initialize_objects(u32 table_index,
 		return_ACPI_STATUS(status);
 	}
 
+	/* DSDT is always the first AML table */
+
+	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT)) {
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
+				      "\nInitializing Namespace objects:\n"));
+	}
+
+	/* Summary of objects initialized */
+
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
 			      "Table [%4.4s] (id %4.4X) - %4u Objects with %3u Devices, "
 			      "%3u Regions, %3u Methods (%u/%u/%u Serial/Non/Cvt)\n",
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 7862cf0..6cbb2f7 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -208,11 +208,11 @@ static acpi_status acpi_tb_load_namespace(void)
 
 	if (!tables_failed) {
 		ACPI_INFO((AE_INFO,
-			   "All (%u) ACPI AML tables successfully loaded",
+			   "%u ACPI AML tables successfully acquired and loaded",
 			   tables_loaded));
 	} else {
 		ACPI_ERROR((AE_INFO,
-			    "%u ACPI AML tables loaded, %u failed",
+			    "%u ACPI AML tables successfully acquired and loaded, %u failed",
 			    tables_loaded, tables_failed));
 	}
 
-- 
1.7.10
