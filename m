From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 41/42] ACPICA: Add per-table execution of module-level code
Date: Tue, 29 Dec 2015 14:04:19 +0800
Message-ID: <c287dcf66f22db8800cd136fe354838130bfe0f1.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 071eff738c59eda1792ac24b3b688b61691d7e7c

Execute any module-level code after each ACPI table (DSDT or SSDT)
is loaded into the namespace (rather than after all AML tables have
been loaded. This matches the behavior of other ACPI
implementations and is required to support BIOS code that
depends on this behavior.

Link: https://github.com/acpica/acpica/commit/071eff73
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsload.c   |   17 +++++++++++++++++
 drivers/acpi/acpica/utxfinit.c |    8 +++++++-
 include/acpi/acpixf.h          |    5 +++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index c106916..14c953e 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -149,6 +149,23 @@ unlock:
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "**** Completed Table Object Initialization\n"));
 
+	/*
+	 * Execute any module-level code that was detected during the table load
+	 * phase. Although illegal since ACPI 2.0, there are many machines that
+	 * contain this type of code. Each block of detected executable AML code
+	 * outside of any control method is wrapped with a temporary control
+	 * method object and placed on a global list. The methods on this list
+	 * are executed below.
+	 *
+	 * This case executes the module-level code for each table immediately
+	 * after the table has been loaded. This provides compatibility with
+	 * other ACPI implementations. Optionally, the execution can be deferred
+	 * until later, see acpi_initialize_objects.
+	 */
+	if (!acpi_gbl_group_module_level_code) {
+		acpi_ns_exec_module_code_list();
+	}
+
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 1c7ed49..e38facd 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -292,8 +292,14 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 	 * outside of any control method is wrapped with a temporary control
 	 * method object and placed on a global list. The methods on this list
 	 * are executed below.
+	 *
+	 * This case executes the module-level code for all tables only after
+	 * all of the tables have been loaded. It is a legacy option and is
+	 * not compatible with other ACPI implementations. See acpi_ns_load_table.
 	 */
-	acpi_ns_exec_module_code_list();
+	if (acpi_gbl_group_module_level_code) {
+		acpi_ns_exec_module_code_list();
+	}
 
 	/*
 	 * Initialize the objects that remain uninitialized. This runs the
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d60507b7..8c95e82 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -190,6 +190,11 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_copy_dsdt_locally, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
 
 /*
+ * Optionally support group module level code.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, TRUE);
+
+/*
  * Optionally use 32-bit FADT addresses if and when there is a conflict
  * (address mismatch) between the 32-bit and 64-bit versions of the
  * address. Although ACPICA adheres to the ACPI specification which
-- 
1.7.10
