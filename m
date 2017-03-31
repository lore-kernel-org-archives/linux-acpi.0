From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI: ACPICA: Cleanup drivers/acpi/acpica Makefile
Date: Fri, 31 Mar 2017 12:53:42 +0800
Message-ID: <796420b4be45373de2e0c6148062fb8d8ddbbcb4.1490930522.git.lv.zheng@intel.com>
References: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14723 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdCaExr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Mar 2017 00:53:47 -0400
In-Reply-To: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

ACPI_DEBUG_OUTPUT isn't necessarily a Makefile -D option defined
environment macro. This patch cleans up ACPICA Makefile by moving it to
aclinux.h, leaving only -D options for macros that must be defined in the
Makefile.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile    | 1 -
 include/acpi/platform/aclinux.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index dea6530..762f2261 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -3,7 +3,6 @@
 #
 
 ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
-ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace
 obj-y	+= acpi.o
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index a39e3f6..1ec8fb7 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -74,6 +74,7 @@
 #endif
 
 #ifdef CONFIG_ACPI_DEBUG
+#define ACPI_DEBUG_OUTPUT
 #define ACPI_MUTEX_DEBUG
 #endif
 
-- 
2.7.4

