From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] tools/power/acpi: Enable build for EC userspace tool.
Date: Tue, 28 Jul 2015 13:25:32 +0800
Message-ID: <267730a1b7dfb85e4c5f5489c936ddc9fbc01e08.1438060971.git.lv.zheng@intel.com>
References: <cover.1438060971.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438060971.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch allows EC userspace tool to be built as an ACPI tool.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/Makefile          |   16 ++++++++--------
 tools/power/acpi/tools/ec/Makefile |   33 ++++++++++++++-------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index 3d05237..e882c83 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -10,18 +10,18 @@
 
 include ../../scripts/Makefile.include
 
-all: acpidump
-clean: acpidump_clean
-install: acpidump_install
-uninstall: acpidump_uninstall
+all: acpidump ec
+clean: acpidump_clean ec_clean
+install: acpidump_install ec_install
+uninstall: acpidump_uninstall ec_uninstall
 
-acpidump: FORCE
+acpidump ec: FORCE
 	$(call descend,tools/$@,all)
-acpidump_clean:
+acpidump_clean ec_clean:
 	$(call descend,tools/$(@:_clean=),clean)
-acpidump_install:
+acpidump_install ec_install:
 	$(call descend,tools/$(@:_install=),install)
-acpidump_uninstall:
+acpidump_uninstall ec_uninstall:
 	$(call descend,tools/$(@:_uninstall=),uninstall)
 
 .PHONY: FORCE
diff --git a/tools/power/acpi/tools/ec/Makefile b/tools/power/acpi/tools/ec/Makefile
index b7b0b92..75d8a12 100644
--- a/tools/power/acpi/tools/ec/Makefile
+++ b/tools/power/acpi/tools/ec/Makefile
@@ -1,22 +1,17 @@
-ec_access: ec_access.o
-	$(ECHO) "  LD      " $@
-	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $< -o $@
-	$(QUIET) $(STRIPCMD) $@
+# tools/power/acpi/tools/acpidump/Makefile - ACPI tool Makefile
+#
+# Copyright (c) 2015, Intel Corporation
+#   Author: Lv Zheng <lv.zheng@intel.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; version 2
+# of the License.
 
-%.o: %.c
-	$(ECHO) "  CC      " $@
-	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
+include ../../Makefile.config
 
-all: ec_access
+TOOL = ec
+TOOL_OBJS = \
+	ec_access.o
 
-install:
-	$(INSTALL) -d $(DESTDIR)${sbindir}
-	$(INSTALL_PROGRAM) ec_access $(DESTDIR)${sbindir}
-
-uninstall:
-	- rm -f $(DESTDIR)${sbindir}/ec_access
-
-clean:
-	-rm -f $(OUTPUT)ec_access
-
-.PHONY: all install uninstall
+include ../../Makefile.rules
-- 
1.7.10
