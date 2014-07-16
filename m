From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 6/7] ACPI: Add support to force header inclusion rules for <acpi/acpi.h>.
Date: Wed, 16 Jul 2014 16:58:53 +0800
Message-ID: <83e64d3b252019ce4b13fa46244a5c9a63bfc69f.1405500886.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com> <cover.1405500886.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405500886.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

As there is only CONFIG_ACPI=n processing in the <linux/acpi.h>, it is not
safe to include <acpi/acpi.h> directly for source out of Linux ACPI
subsystems.

This patch adds error messaging to warn developers of such wrong
inclusions.

In order not to be bisected and reverted as a wrong commit, warning
messages are carefully split into a seperate patch other than the wrong
inclusion cleanups.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile    |    2 +-
 include/acpi/platform/aclinux.h |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 6b9ec23..4be4cc94 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -2,7 +2,7 @@
 # Makefile for ACPICA Core interpreter
 #
 
-ccflags-y			:= -Os
+ccflags-y			:= -Os -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index dfba354..1ba7c19 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -44,6 +44,16 @@
 #ifndef __ACLINUX_H__
 #define __ACLINUX_H__
 
+#ifdef __KERNEL__
+
+/* ACPICA external files should not include ACPICA headers directly. */
+
+#if !defined(BUILDING_ACPICA) && !defined(_LINUX_ACPI_H)
+#error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
+#endif
+
+#endif
+
 /* Common (in-kernel/user-space) ACPICA configuration */
 
 #define ACPI_USE_SYSTEM_CLIBRARY
-- 
1.7.10
