From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/30] ACPICA: acpidump: Fix a duplicate variable definition
Date: Thu,  4 Aug 2016 16:44:17 +0800
Message-ID: <94dfdb4d48a4301bab465256a8cfe5f293914da4.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8322 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 080f99d5b29313380accd00d2b9768e809eb417b

acpi_gbl_integer_byte_width has already been instantiated by ACPI_GLOBAL() in
acglobal.h. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/080f99d5
Link: https://bugs.acpica.org/show_bug.cgi?id=1301
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/tools/acpidump/acpidump.h |    6 ------
 tools/power/acpi/tools/acpidump/apmain.c   |    1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 025c232..94dd8a1 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -72,12 +72,6 @@ EXTERN ACPI_FILE INIT_GLOBAL(gbl_output_file, NULL);
 EXTERN char INIT_GLOBAL(*gbl_output_filename, NULL);
 EXTERN u64 INIT_GLOBAL(gbl_rsdp_base, 0);
 
-/* Globals required for use with ACPICA modules */
-
-#ifdef _DECLARE_GLOBALS
-u8 acpi_gbl_integer_byte_width = 8;
-#endif
-
 /* Action table used to defer requested options */
 
 struct ap_dump_action {
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 7692e6b..cd6c097 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -315,6 +315,7 @@ int ACPI_SYSTEM_XFACE acpi_main(int argc, char *argv[])
 	ACPI_DEBUG_INITIALIZE();	/* For debug version only */
 	acpi_os_initialize();
 	gbl_output_file = ACPI_FILE_OUT;
+	acpi_gbl_integer_byte_width = 8;
 
 	/* Process command line options */
 
-- 
1.7.10

