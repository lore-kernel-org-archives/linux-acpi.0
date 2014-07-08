From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/25] ACPICA: Utilities: Introduce acpi_log_error() to improve portability.
Date: Tue,  8 Jul 2014 10:07:06 +0800
Message-ID: <724db9120f50b0c99caa8df074b6092aa6071b54.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62405 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbaGHCHM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:12 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch is only useful for ACPICA applications, most of which are not
shipped in the Linux kernel.
Note that follow-up commits will update acpidump to use this new API to
improve portability.

Invocations like fprintf(stderr) and perror() are not portable, this patch
introduces acpi_log_error() as a replacement, it is implemented using new
portable API - acpi_ut_file_vprintf().

Note that though acpi_os_initialize() need to be invoked prior than using
this new API, since no users are introduced in this patch, such invocations
are not added for applications that link utprint.c in this patch. Futher
patches that introduce users of acpi_log_error() should take care of this.
Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utdebug.c |   26 ++++++++++++++++++++++++++
 include/acpi/acpixf.h         |   20 ++++++++++++++++++++
 include/acpi/platform/acenv.h |    4 ++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 21a20ac..e516254 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -561,3 +561,29 @@ acpi_ut_ptr_exit(u32 line_number,
 }
 
 #endif
+
+#ifdef ACPI_APPLICATION
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_log_error
+ *
+ * PARAMETERS:  format              - Printf format field
+ *              ...                 - Optional printf arguments
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print error message to the console, used by applications.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE acpi_log_error(const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	(void)acpi_ut_file_vprintf(ACPI_FILE_ERR, format, args);
+	va_end(args);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_log_error)
+#endif
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 35b525c..9858551 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -335,6 +335,23 @@ ACPI_GLOBAL(u8, acpi_gbl_system_awake_and_running);
 
 #endif				/* ACPI_DEBUG_OUTPUT */
 
+/*
+ * Application prototypes
+ *
+ * All interfaces used by application will be configured
+ * out of the ACPICA build unless the ACPI_APPLICATION
+ * flag is defined.
+ */
+#ifdef ACPI_APPLICATION
+#define ACPI_APP_DEPENDENT_RETURN_VOID(prototype) \
+	prototype;
+
+#else
+#define ACPI_APP_DEPENDENT_RETURN_VOID(prototype) \
+	static ACPI_INLINE prototype {return;}
+
+#endif				/* ACPI_APPLICATION */
+
 /*****************************************************************************
  *
  * ACPICA public interface prototypes
@@ -861,6 +878,9 @@ ACPI_DBG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(6)
 						     const char *module_name,
 						     u32 component_id,
 						     const char *format, ...))
+ACPI_APP_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(1)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_log_error(const char *format, ...))
 
 /*
  * Divergences
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index b6429e4..4390ebd 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -423,8 +423,12 @@ typedef char *va_list;
 #ifdef ACPI_APPLICATION
 #include <stdio.h>
 #define ACPI_FILE              FILE *
+#define ACPI_FILE_OUT          stdout
+#define ACPI_FILE_ERR          stderr
 #else
 #define ACPI_FILE              void *
+#define ACPI_FILE_OUT          NULL
+#define ACPI_FILE_ERR          NULL
 #endif				/* ACPI_APPLICATION */
 #endif				/* ACPI_FILE */
 
-- 
1.7.10

