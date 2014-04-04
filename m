From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/28] ACPICA: Tables: Avoid SSDT installation when acpi_gbl_disable_ssdt_table_load is specified.
Date: Fri,  4 Apr 2014 12:39:11 +0800
Message-ID: <7e62ebb1da11fc3232c0405c565c9d82a3b04013.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22847 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaDDEjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:39 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

It is reported that when acpi_gbl_disable_ssdt_table_load is specified, user
still can see it installed into /sys/firmware/acpi/tables on Linux boxes.
This is because the option only stops table "loading", but doesn't stop
table "installing", thus it is still in the acpi_gbl_root_table_list. With
previous cleanups, it is possible to prevent SSDT installations to make
it not such confusing.  The global variable is also renamed.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |   10 +++++++++-
 drivers/acpi/acpica/acglobal.h      |    4 ++--
 drivers/acpi/acpica/tbinstal.c      |   12 ++++++++++++
 drivers/acpi/acpica/tbxfload.c      |   13 -------------
 drivers/acpi/osl.c                  |   11 +++++------
 include/acpi/acpixf.h               |    2 +-
 6 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 91f0be8..0081db1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -237,7 +237,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			This feature is enabled by default.
 			This option allows to turn off the feature.
 
-	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
+	acpi_no_static_ssdt	[HW,ACPI]
+			Disable installation of static SSDTs at early boot time
+			By default, SSDTs contained in the RSDT/XSDT will be
+			installed automatically and they will appear under
+			/sys/firmware/acpi/tables.
+			This option turns off this feature.
+			Note that specifying this option does not affect
+			dynamic table installation which will install SSDT
+			tables to /sys/firmware/acpi/tables/dynamic.
 
 	acpica_no_return_repair [HW, ACPI]
 			Disable AML predefined validation mechanism
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 71bb5b5..0cac564 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -160,10 +160,10 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_truncate_io_addresses, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_auto_repair, FALSE);
 
 /*
- * Optionally do not load any SSDTs from the RSDT/XSDT during initialization.
+ * Optionally do not install any SSDTs from the RSDT/XSDT during initialization.
  * This can be useful for debugging ACPI problems on some machines.
  */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_ssdt_table_load, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_ssdt_table_install, FALSE);
 
 /*
  * We keep track of the latest version of Windows that has been requested by
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index cf1ccc5..de10d32 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -580,6 +580,18 @@ acpi_tb_install_non_fixed_table(acpi_physical_address address,
 		return_ACPI_STATUS(status);
 	}
 
+	/*
+	 * Optionally do not load any SSDTs from the RSDT/XSDT. This can
+	 * be useful for debugging ACPI problems on some machines.
+	 */
+	if (!reload && acpi_gbl_disable_ssdt_table_install &&
+	    ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG_SSDT)) {
+		ACPI_INFO((AE_INFO, "Ignoring installation of %4.4s at %p",
+			   new_table_desc.signature.ascii, ACPI_CAST_PTR(void,
+									 address)));
+		goto release_and_exit;
+	}
+
 	/* Validate and verify a table before installation */
 
 	status = acpi_tb_verify_table(&new_table_desc, NULL);
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 62bbd38..3f9eaf5 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -179,19 +179,6 @@ static acpi_status acpi_tb_load_namespace(void)
 			continue;
 		}
 
-		/*
-		 * Optionally do not load any SSDTs from the RSDT/XSDT. This can
-		 * be useful for debugging ACPI problems on some machines.
-		 */
-		if (acpi_gbl_disable_ssdt_table_load) {
-			ACPI_INFO((AE_INFO, "Ignoring %4.4s at %p",
-				   acpi_gbl_root_table_list.tables[i].signature.
-				   ascii, ACPI_CAST_PTR(void,
-							acpi_gbl_root_table_list.
-							tables[i].address)));
-			continue;
-		}
-
 		/* Ignore errors while loading tables, get as many as possible */
 
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f7fd72a..ff23fcc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1771,16 +1771,15 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 }
 #endif
 
-static int __init acpi_no_auto_ssdt_setup(char *s)
+static int __init acpi_no_static_ssdt_setup(char *s)
 {
-        printk(KERN_NOTICE PREFIX "SSDT auto-load disabled\n");
+	acpi_gbl_disable_ssdt_table_install = TRUE;
+	pr_info("ACPI: static SSDT installation disabled\n");
 
-        acpi_gbl_disable_ssdt_table_load = TRUE;
-
-        return 1;
+	return 0;
 }
 
-__setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
+early_param("acpi_no_static_ssdt", acpi_no_static_ssdt_setup);
 
 static int __init acpi_disable_return_repair(char *s)
 {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 44f5e97..2280c19 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -75,7 +75,7 @@ extern u8 acpi_gbl_auto_serialize_methods;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_disable_auto_repair;
-extern u8 acpi_gbl_disable_ssdt_table_load;
+extern u8 acpi_gbl_disable_ssdt_table_install;
 extern u8 acpi_gbl_do_not_use_xsdt;
 extern u8 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_enable_interpreter_slack;
-- 
1.7.10

