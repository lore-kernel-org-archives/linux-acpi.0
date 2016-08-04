From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/30] ACPICA: Simplify configuration for "Max Loops" system parameter
Date: Thu,  4 Aug 2016 16:43:13 +0800
Message-ID: <6b0ab9abf3365bebb38a05c59496bf017c3db6b3.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31074 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcHDInW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:43:22 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 857c510d70e18eecc275dd3087807a18bae8aa51

Allow for static configuration of this parameter. It is used
to abort out of infinite loops caused by non-response from
hardware.

Link: https://github.com/acpica/acpica/commit/857c510d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utinit.c |    2 +-
 include/acpi/acconfig.h      |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index f91f724..1711fdf 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -206,7 +206,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_next_owner_id_offset = 0;
 	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
 	acpi_gbl_osi_mutex = NULL;
-	acpi_gbl_max_loop_iterations = 0xFFFF;
+	acpi_gbl_max_loop_iterations = ACPI_MAX_LOOP_COUNT;
 
 	/* Hardware oriented */
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index fe2e3ac..12c2882 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -144,6 +144,10 @@
 
 #define ACPI_ADDRESS_RANGE_MAX          2
 
+/* Maximum number of While() loops before abort */
+
+#define ACPI_MAX_LOOP_COUNT             0xFFFF
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
-- 
1.7.10

