From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 16/28] ACPICA: Namespace: Add support of OSDT table.
Date: Wed, 24 Jun 2015 11:04:33 +0800
Message-ID: <ef85374dcb02bbfebc81131d7a83f227b0f21a62.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 27415c82fcecf467446f66d1007a0691cc5f3709

This patch adds OSDT (Override System Definition Table) support.
When OSDT is loaded, conflict namespace objects will be overridden
by the AML interpreter. Bob Moore, Lv Zheng.

Link: https://github.com/acpica/acpica/commit/27415c82
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsparse.c  |    7 +++++++
 drivers/acpi/acpica/tbxfload.c |    6 +++++-
 drivers/acpi/acpica/utmisc.c   |    3 ++-
 include/acpi/actbl.h           |    1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index c95a119..57a4cfe 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -117,6 +117,13 @@ acpi_ns_one_complete_parse(u32 pass_number,
 					       (u8) pass_number);
 	}
 
+	/* Found OSDT table, enable the namespace override feature */
+
+	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT) &&
+	    pass_number == ACPI_IMODE_LOAD_PASS1) {
+		walk_state->namespace_override = TRUE;
+	}
+
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		goto cleanup;
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index b63e35d..960bd99 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -173,7 +173,11 @@ static acpi_status acpi_tb_load_namespace(void)
 		     &&
 		     !ACPI_COMPARE_NAME(&
 					(acpi_gbl_root_table_list.tables[i].
-					 signature), ACPI_SIG_PSDT))
+					 signature), ACPI_SIG_PSDT)
+		     &&
+		     !ACPI_COMPARE_NAME(&
+					(acpi_gbl_root_table_list.tables[i].
+					 signature), ACPI_SIG_OSDT))
 		    ||
 		    ACPI_FAILURE(acpi_tb_validate_table
 				 (&acpi_gbl_root_table_list.tables[i]))) {
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index cbb7034..28099e2 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -97,7 +97,8 @@ u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
 
 	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) ||
 	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_PSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT)) {
+	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT) ||
+	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT)) {
 		return (TRUE);
 	}
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index cb8a6b9..2d5faf5 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -65,6 +65,7 @@
 #define ACPI_SIG_DSDT           "DSDT"	/* Differentiated System Description Table */
 #define ACPI_SIG_FADT           "FACP"	/* Fixed ACPI Description Table */
 #define ACPI_SIG_FACS           "FACS"	/* Firmware ACPI Control Structure */
+#define ACPI_SIG_OSDT           "OSDT"	/* Override System Description Table */
 #define ACPI_SIG_PSDT           "PSDT"	/* Persistent System Description Table */
 #define ACPI_SIG_RSDP           "RSD PTR "	/* Root System Description Pointer */
 #define ACPI_SIG_RSDT           "RSDT"	/* Root System Description Table */
-- 
1.7.10
