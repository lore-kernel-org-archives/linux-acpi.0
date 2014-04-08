From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI: Fix the issue that auto SSDT loading is conflict with customized SSDT that is included by the customized DSDT.
Date: Tue,  8 Apr 2014 10:49:06 +0800
Message-ID: <963261691c067d99bd5afecb69bdbd5e83ab21d7.1396925060.git.lv.zheng@intel.com>
References: <cover.1396925060.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18764 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbaDHCtb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 22:49:31 -0400
In-Reply-To: <cover.1396925060.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch fixes the following issue:
User can specify a DSDT with SSDT embedded, in which case, no_static_ssdt
must be enforced.  If we don't do that, then:
1. The namespace object conflicts will result in an AE_ALREADY_EXISTS
   exception;
2. The namespace objects that are deleted from the original SSDT will be
   restored by the auto loading of the original SSDT.

Note that the DSDT customization is a compile-time feature, thus the SSDT
inclusion indication of the DSDT customization is also implemented as a
compile-time configurable.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=69711
Original-by: Enrico Etxe Arte <goitizena.generoa@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig    |    8 ++++++++
 drivers/acpi/internal.h |    5 +++++
 drivers/acpi/osl.c      |   14 +++++++++++++-
 drivers/acpi/tables.c   |    2 ++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c205653..a0b8131 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -212,6 +212,14 @@ config ACPI_CUSTOM_DSDT
 	bool
 	default ACPI_CUSTOM_DSDT_FILE != ""
 
+config ACPI_CUSTOM_SSDT_INCLUDED
+	bool "Custom SSDT Tables included"
+	depends on ACPI_CUSTOM_DSDT
+	help
+	  This option turns on acpi.no_static_ssdt by default.
+
+	  If the SSDT code has been merged into the custom DSDT file, say Y.
+
 config ACPI_INITRD_TABLE_OVERRIDE
 	bool "ACPI tables override via initrd"
 	depends on BLK_DEV_INITRD && X86
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9573913..0d127ab 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -57,6 +57,11 @@ void acpi_cmos_rtc_init(void);
 #else
 static inline void acpi_cmos_rtc_init(void) {}
 #endif
+#ifdef CONFIG_ACPI_CUSTOM_SSDT_INCLUDED
+void __init acpi_ssdt_customized(void);
+#else
+static inline void acpi_ssdt_customized(void) {}
+#endif
 
 extern bool acpi_force_hot_remove;
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9aeae41..273b69a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1770,15 +1770,27 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 }
 #endif
 
-static int __init acpi_no_static_ssdt_setup(char *s)
+static void __init acpi_set_no_static_ssdt(void)
 {
 	acpi_gbl_disable_ssdt_table_install = TRUE;
 	pr_info("ACPI: static SSDT installation disabled\n");
+}
+
+#ifdef CONFIG_ACPI_CUSTOM_SSDT_INCLUDED
+void __init acpi_ssdt_customized(void)
+{
+	acpi_set_no_static_ssdt();
+}
+#else
+static int __init acpi_no_static_ssdt_setup(char *s)
+{
+	acpi_set_no_static_ssdt();
 
 	return 0;
 }
 
 early_param("acpi_no_static_ssdt", acpi_no_static_ssdt_setup);
+#endif
 
 static int __init acpi_disable_return_repair(char *s)
 {
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2178229..aaf2177 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -184,6 +184,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
+#include "internal.h"
 
 int __init
 acpi_table_parse_entries(char *id,
@@ -333,6 +334,7 @@ int __init acpi_table_init(void)
 {
 	acpi_status status;
 
+	acpi_ssdt_customized();
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
-- 
1.7.10

