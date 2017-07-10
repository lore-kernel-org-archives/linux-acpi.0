From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/16] Back port of "ACPICA: Use designated initializers"
Date: Mon, 10 Jul 2017 15:23:08 +0800
Message-ID: <ef8459031a435a9dd389292b9a8b300915aced69.1499671181.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753418AbdGJHXM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:23:12 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Kees Cook <keescook@google.com>, Bob Moore <robert.moore@intel.com>

From: Kees Cook <keescook@google.com>

ACPICA commit 47538f5f0773c0820d8f552e20f6e77104290c01

The following commit is not correctly linuxized by its ACPICA form (see
link #1 for reference):
  Commit: 3d867f6c5fd6535cdeceef3170e5e84e5dd80fc1
  Subject: ACPICA: Use designated initializers
Thus breaks linuxize process.

This patch is a linuxized back port result of the upstreamed ACPICA
commit (see link #2 for reference).

Link: https://github.com/acpica/acpica/pull/248/       [#1]
Link: https://github.com/acpica/acpica/commit/47538f5f [#2]
Signed-off-by: Kees Cook <keescook@google.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c | 9 ++++++---
 include/acpi/platform/acenv.h   | 9 +++++----
 include/acpi/platform/aclinux.h | 3 +++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 7ef1393..e5c095c 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -72,13 +72,16 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
 static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
 	{ACPI_STRUCT_INIT(legacy_function,
 			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep)),
-	 ACPI_STRUCT_INIT(extended_function, acpi_hw_extended_sleep) },
+	 ACPI_STRUCT_INIT(extended_function,
+			  acpi_hw_extended_sleep)},
 	{ACPI_STRUCT_INIT(legacy_function,
 			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep)),
-	 ACPI_STRUCT_INIT(extended_function, acpi_hw_extended_wake_prep) },
+	 ACPI_STRUCT_INIT(extended_function,
+			  acpi_hw_extended_wake_prep)},
 	{ACPI_STRUCT_INIT(legacy_function,
 			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake)),
-	 ACPI_STRUCT_INIT(extended_function, acpi_hw_extended_wake) }
+	 ACPI_STRUCT_INIT(extended_function,
+			  acpi_hw_extended_wake)}
 };
 
 /*
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 912563c..043fd55 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -288,6 +288,11 @@
 #define ACPI_INLINE
 #endif
 
+/* Use ordered initialization if compiler doesn't support designated. */
+#ifndef ACPI_STRUCT_INIT
+#define ACPI_STRUCT_INIT(field, value)  value
+#endif
+
 /*
  * Configurable calling conventions:
  *
@@ -382,8 +387,4 @@
 #define ACPI_INIT_FUNCTION
 #endif
 
-#ifndef ACPI_STRUCT_INIT
-#define ACPI_STRUCT_INIT(field, value) value
-#endif
-
 #endif				/* __ACENV_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 047f138..afd95f2 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -178,6 +178,9 @@
 #define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
 #define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
 
+/*
+ * Linux wants to use designated initializers for function pointer structs.
+ */
 #define ACPI_STRUCT_INIT(field, value)	.field = value
 
 #else				/* !__KERNEL__ */
-- 
2.7.4

