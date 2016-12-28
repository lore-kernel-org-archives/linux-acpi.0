From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/18] ACPICA: Debugger: Rename debugger OSL names
Date: Wed, 28 Dec 2016 15:28:07 +0800
Message-ID: <1ac4dc3954b7a1a674608ef987ce78d18f9b2fb2.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2581 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbcL1IHq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Dec 2016 03:07:46 -0500
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit e76eb8b36ace880e4d475880db1128a206e57b6f

This linuxized ACPICA commit is a back port result of the following
linux commit:
  Commit: f8d31489629c125806ce4bf587c0c5c284d6d113
  Subject: ACPICA: Debugger: Convert some mechanisms to OSPM specific
During the back porting, it is requested by ACPICA to use expected OSL
names. Suggested by Bob Moore, Fixed by Lv Zheng.

Linux is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/e76eb8b3
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbxface.c     | 4 ++--
 include/acpi/acpiosxf.h           | 8 ++++----
 include/acpi/platform/aclinux.h   | 4 ++--
 include/acpi/platform/aclinuxex.h | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 124db23..5b8cae1 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -430,7 +430,7 @@ acpi_status acpi_initialize_debugger(void)
 
 		/* These were created with one unit, grab it */
 
-		status = acpi_os_initialize_command_signals();
+		status = acpi_os_initialize_debugger();
 		if (ACPI_FAILURE(status)) {
 			acpi_os_printf("Could not get debugger mutex\n");
 			return_ACPI_STATUS(status);
@@ -482,7 +482,7 @@ void acpi_terminate_debugger(void)
 			acpi_os_sleep(100);
 		}
 
-		acpi_os_terminate_command_signals();
+		acpi_os_terminate_debugger();
 	}
 
 	if (acpi_gbl_db_buffer) {
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index f3414c8..42ab9b3 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -355,12 +355,12 @@ void acpi_os_redirect_output(void *destination);
 acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read);
 #endif
 
-#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_command_signals
-acpi_status acpi_os_initialize_command_signals(void);
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_debugger
+acpi_status acpi_os_initialize_debugger(void);
 #endif
 
-#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_command_signals
-void acpi_os_terminate_command_signals(void);
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_debugger
+void acpi_os_terminate_debugger(void);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_command_ready
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index e861a24..af588e0 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -156,8 +156,8 @@
  */
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_readable
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
-#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_command_signals
-#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_command_signals
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_debugger
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_debugger
 
 /*
  * OSL interfaces used by utilities
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 7dbb114..de7648b 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -129,12 +129,12 @@ static inline u8 acpi_os_readable(void *pointer, acpi_size length)
 	return TRUE;
 }
 
-static inline acpi_status acpi_os_initialize_command_signals(void)
+static inline acpi_status acpi_os_initialize_debugger(void)
 {
 	return AE_OK;
 }
 
-static inline void acpi_os_terminate_command_signals(void)
+static inline void acpi_os_terminate_debugger(void)
 {
 	return;
 }
-- 
2.7.4

