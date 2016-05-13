From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Add configuration item to configure ACPICA error logs out
Date: Fri, 13 May 2016 10:26:54 +0800
Message-ID: <94db29c4f0e4a6bc46d3587bb0414980b26dd98e.1463106348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29114 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbcEMC1H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 May 2016 22:27:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Sometimes, we need to disable ACPICA error logs to leave only ACPICA
debug logs enabled for debugging purpose. This is useful when ACPICA error
logs become a flood.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=114201
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig            |    7 +++++++
 include/acpi/platform/aclinux.h |    4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b7e2e77..ebb8d3b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -321,6 +321,13 @@ config ACPI_TABLE_UPGRADE
 	  initrd, therefore it's safe to say Y.
 	  See Documentation/acpi/initrd_table_override.txt for details
 
+config ACPI_NO_ERROR_MESSAGES
+	bool "Disable error messages"
+	default n
+	help
+	  The ACPI subsystem can produce error messages. Saying Y disables
+	  this output.
+
 config ACPI_DEBUG
 	bool "Debug Statements"
 	default n
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 45c2d65..a6d9217 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -73,6 +73,10 @@
 #define ACPI_DEBUGGER
 #endif
 
+#ifdef CONFIG_ACPI_NO_ERROR_MESSAGES
+#define ACPI_NO_ERROR_MESSAGES
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
-- 
1.7.10

