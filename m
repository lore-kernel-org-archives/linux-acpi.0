From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPICA: Linux: Enable ACPI_MUTEX_DEBUG for Linux kernel
Date: Tue,  5 Jul 2016 13:53:04 +0800
Message-ID: <7ab2c9a68c936a6dadfdbf96dbdcfc924722c93a.1467697822.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45012 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbcGEFxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jul 2016 01:53:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch enables ACPI_MUTEX_DEBUG for Linux kernel so that the ACPICA
lock order issues can be captured by ACPICA itself.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 45c2d65..93b61b1 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -73,6 +73,10 @@
 #define ACPI_DEBUGGER
 #endif
 
+#ifdef CONFIG_ACPI_DEBUG
+#define ACPI_MUTEX_DEBUG
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
-- 
1.7.10

