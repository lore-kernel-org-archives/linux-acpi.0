From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/30] ACPICA: Utilities: Introduce facility to allow Linux to set correct logging levels
Date: Thu,  4 Aug 2016 16:42:49 +0800
Message-ID: <0eea2acb703c21a34dd806330a9a335989b3a602.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35354 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcHDIm4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:42:56 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 58c9e7b83ae35247e430c39363f55b6f70fa04a2

It is reported that the logging level of the ACPICA messages are not
correct in the Linux kernel. This patch fixes this issue. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/58c9e7b8
Link: https://bugzilla.kernel.org/show_bug.cgi?id=117461
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h   |   12 ++++++++++++
 include/acpi/platform/aclinux.h |    8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 0bb6325..91269a6 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -114,13 +114,25 @@ extern const char *acpi_gbl_pt_decode[];
 /*
  * Common error message prefixes
  */
+#ifndef ACPI_MSG_ERROR
 #define ACPI_MSG_ERROR          "ACPI Error: "
+#endif
+#ifndef ACPI_MSG_EXCEPTION
 #define ACPI_MSG_EXCEPTION      "ACPI Exception: "
+#endif
+#ifndef ACPI_MSG_WARNING
 #define ACPI_MSG_WARNING        "ACPI Warning: "
+#endif
+#ifndef ACPI_MSG_INFO
 #define ACPI_MSG_INFO           "ACPI: "
+#endif
 
+#ifndef ACPI_MSG_BIOS_ERROR
 #define ACPI_MSG_BIOS_ERROR     "ACPI BIOS Error (bug): "
+#endif
+#ifndef ACPI_MSG_BIOS_WARNING
 #define ACPI_MSG_BIOS_WARNING   "ACPI BIOS Warning (bug): "
+#endif
 
 /*
  * Common message suffix
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 93b61b1..296a276 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -168,6 +168,14 @@
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_next_filename
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_close_directory
 
+#define ACPI_MSG_ERROR          KERN_ERR "ACPI Error: "
+#define ACPI_MSG_EXCEPTION      KERN_ERR "ACPI Exception: "
+#define ACPI_MSG_WARNING        KERN_WARNING "ACPI Warning: "
+#define ACPI_MSG_INFO           KERN_INFO "ACPI: "
+
+#define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
+#define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
+
 #else				/* !__KERNEL__ */
 
 #include <stdarg.h>
-- 
1.7.10

