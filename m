From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH] tools/power/acpi: Remove direct kernel source include reference
Date: Mon, 24 Oct 2016 22:11:19 +0800
Message-ID: <a22c3ddc6e0cdda05183aaaa8ed8aaddcaf6bba8.1477318223.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35546 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936517AbcJXOLm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2016 10:11:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPICA tools trickily uses integer types, and trickily includes kernel
include directory directly, which breaks tools build for some cross
compilers. This patch fixes this build issue.

Reported-and-tested-by: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h          |  3 +++
 tools/power/acpi/Makefile                | 10 ++++++++--
 tools/power/acpi/tools/acpidbg/Makefile  |  2 +-
 tools/power/acpi/tools/acpidbg/acpidbg.c |  8 +++++++-
 tools/power/acpi/tools/acpidump/Makefile |  2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index a5d98d1..e861a24 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -191,6 +191,9 @@
 #ifndef __init
 #define __init
 #endif
+#ifndef __iomem
+#define __iomem
+#endif
 
 /* Host-dependent types and defines for user-space ACPICA */
 
diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index a8bf908..ddb38d5 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -11,11 +11,17 @@
 include ../../scripts/Makefile.include
 
 all: acpidbg acpidump ec
-clean: acpidbg_clean acpidump_clean ec_clean
+clean: acpidbg_clean acpidump_clean include_clean ec_clean
 install: acpidbg_install acpidump_install ec_install
 uninstall: acpidbg_uninstall acpidump_uninstall ec_uninstall
+include/acpi:
+	mkdir -p include
+	ln -s ../../../../include/acpi include/acpi
+include_clean:
+	rm -f include/acpi
+	rm -rf include
 
-acpidbg acpidump ec: FORCE
+acpidbg acpidump ec: include/acpi FORCE
 	$(call descend,tools/$@,all)
 acpidbg_clean acpidump_clean ec_clean:
 	$(call descend,tools/$(@:_clean=),clean)
diff --git a/tools/power/acpi/tools/acpidbg/Makefile b/tools/power/acpi/tools/acpidbg/Makefile
index 352df4b..1f35977 100644
--- a/tools/power/acpi/tools/acpidbg/Makefile
+++ b/tools/power/acpi/tools/acpidbg/Makefile
@@ -19,7 +19,7 @@ vpath %.c \
 CFLAGS += -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER\
 	-I.\
 	-I../../../../../drivers/acpi/acpica\
-	-I../../../../../include
+	-I../../include
 LDFLAGS += -lpthread
 TOOL_OBJS = \
 	acpidbg.o
diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/tools/acpidbg/acpidbg.c
index a88ac45..4308362 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -12,10 +12,16 @@
 #include <acpi/acpi.h>
 
 /* Headers not included by include/acpi/platform/aclinux.h */
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <error.h>
 #include <stdbool.h>
 #include <fcntl.h>
 #include <assert.h>
-#include <linux/circ_buf.h>
+#include <sys/select.h>
+#include "../../../../../include/linux/circ_buf.h"
 
 #define ACPI_AML_FILE		"/sys/kernel/debug/acpi/acpidbg"
 #define ACPI_AML_SEC_TICK	1
diff --git a/tools/power/acpi/tools/acpidump/Makefile b/tools/power/acpi/tools/acpidump/Makefile
index 04b5db7..e9f05d5 100644
--- a/tools/power/acpi/tools/acpidump/Makefile
+++ b/tools/power/acpi/tools/acpidump/Makefile
@@ -21,7 +21,7 @@ vpath %.c \
 	../../os_specific/service_layers
 CFLAGS += -DACPI_DUMP_APP -I.\
 	-I../../../../../drivers/acpi/acpica\
-	-I../../../../../include
+	-I../../include
 TOOL_OBJS = \
 	apdump.o\
 	apfiles.o\
-- 
2.7.4

