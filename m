From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v3] tools/power/acpi: Remove direct kernel source include reference
Date: Sat, 12 Nov 2016 09:08:04 +0800
Message-ID: <d4a1e40704f0342e1f57cc957af4ef9773465d45.1478912866.git.lv.zheng@intel.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33614 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965067AbcKLBIR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2016 20:08:17 -0500
In-Reply-To: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>

ACPICA tools trickily uses integer types, and trickily includes kernel
include directory directly, which breaks tools build for some cross
compilers.
This patch improves ACPICA tools build to make it a bit more robust in such
situation by splitting include/acpi into a separate output directory.

This patch also contains OUTPUT/srctree cleanups in order to make above fix
working for various build environments.

Fixes: e323c02dee59 ("ACPICA: MSVC9: Fix <sys/stat.h> inclusion order issue")
Reported-and-tested-by: Yisheng Xie <xieyisheng1@huawei.com>
Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 include/acpi/platform/aclinux.h          |  3 +++
 tools/power/acpi/Makefile.config         | 21 +++++++++--------
 tools/power/acpi/Makefile.rules          | 40 +++++++++++++++++++++-----------
 tools/power/acpi/tools/acpidbg/Makefile  |  4 +---
 tools/power/acpi/tools/acpidbg/acpidbg.c |  8 ++++++-
 tools/power/acpi/tools/acpidump/Makefile | 12 +++++-----
 6 files changed, 55 insertions(+), 33 deletions(-)

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
 
diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index a538ff4..8320616 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -8,18 +8,19 @@
 # as published by the Free Software Foundation; version 2
 # of the License.
 
-include ../../../../scripts/Makefile.include
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+include $(srctree)/../../scripts/Makefile.include
 
-OUTPUT=./
+OUTPUT=$(srctree)/
 ifeq ("$(origin O)", "command line")
 	OUTPUT := $(O)/
 endif
-
-ifneq ($(OUTPUT),)
-# check that the output directory actually exists
-OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
-$(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
-endif
+##$(info Determined 'OUTPUT' to be $(OUTPUT))
 
 # --- CONFIGURATION BEGIN ---
 
@@ -70,8 +71,8 @@ WARNINGS := -Wall
 WARNINGS += $(call cc-supports,-Wstrict-prototypes)
 WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 
-KERNEL_INCLUDE := ../../../include
-ACPICA_INCLUDE := ../../../drivers/acpi/acpica
+KERNEL_INCLUDE := $(OUTPUT)include
+ACPICA_INCLUDE := $(srctree)/../../../drivers/acpi/acpica
 CFLAGS += -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
 CFLAGS += $(WARNINGS)
 
diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
index ec87a9e..51070de 100644
--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -8,28 +8,42 @@
 # as published by the Free Software Foundation; version 2
 # of the License.
 
-$(OUTPUT)$(TOOL): $(TOOL_OBJS) FORCE
-	$(ECHO) "  LD      " $@
-	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(TOOL_OBJS) -L$(OUTPUT) -o $@
+objdir := $(OUTPUT)tools/$(TOOL)/
+toolobjs := $(addprefix $(objdir),$(TOOL_OBJS))
+$(OUTPUT)$(TOOL): $(KERNEL_INCLUDE) $(toolobjs) FORCE
+	$(ECHO) "  LD      " $(subst $(OUTPUT),,$@)
+	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(toolobjs) -L$(OUTPUT) -o $@
+	$(ECHO) "  STRIP   " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(STRIPCMD) $@
 
-$(OUTPUT)%.o: %.c
-	$(ECHO) "  CC      " $@
+$(KERNEL_INCLUDE):
+	$(ECHO) "  MKDIR   " $(subst $(OUTPUT),,$@)
+	$(QUIET) mkdir -p $(KERNEL_INCLUDE)
+	$(ECHO) "  CP      " $(subst $(OUTPUT),,$@)
+	$(QUIET) cp -rf $(srctree)/../../../include/acpi $(KERNEL_INCLUDE)/
+
+$(objdir)%.o: %.c
+	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
 
 all: $(OUTPUT)$(TOOL)
 clean:
-	-find $(OUTPUT) \( -not -type d \) \
-	-and \( -name '*~' -o -name '*.[oas]' \) \
-	-type f -print \
-	 | xargs rm -f
-	-rm -f $(OUTPUT)$(TOOL)
+	$(ECHO) "  RMOBJ   " $(subst $(OUTPUT),,$(objdir))
+	$(QUIET) find $(objdir) \( -not -type d \)\
+		 -and \( -name '*~' -o -name '*.[oas]' \)\
+		 -type f -print | xargs rm -f
+	$(ECHO) "  RM      " $(TOOL)
+	$(QUIET) rm -f $(OUTPUT)$(TOOL)
+	$(ECHO) "  RMINC   " $(subst $(OUTPUT),,$(KERNEL_INCLUDE))
+	$(QUIET) rm -rf $(KERNEL_INCLUDE)
 
 install-tools:
-	$(INSTALL) -d $(DESTDIR)${sbindir}
-	$(INSTALL_PROGRAM) $(OUTPUT)$(TOOL) $(DESTDIR)${sbindir}
+	$(ECHO) "  INST    " $(TOOL)
+	$(QUIET) $(INSTALL) -d $(DESTDIR)$(sbindir)
+	$(QUIET) $(INSTALL_PROGRAM) $(OUTPUT)$(TOOL) $(DESTDIR)$(sbindir)
 uninstall-tools:
-	- rm -f $(DESTDIR)${sbindir}/$(TOOL)
+	$(ECHO) "  UNINST  " $(TOOL)
+	$(QUIET) rm -f $(DESTDIR)$(sbindir)/$(TOOL)
 
 install: all install-tools $(EXTRA_INSTALL)
 uninstall: uninstall-tools $(EXTRA_UNINSTALL)
diff --git a/tools/power/acpi/tools/acpidbg/Makefile b/tools/power/acpi/tools/acpidbg/Makefile
index 352df4b..f2d06e7 100644
--- a/tools/power/acpi/tools/acpidbg/Makefile
+++ b/tools/power/acpi/tools/acpidbg/Makefile
@@ -17,9 +17,7 @@ vpath %.c \
 	../../os_specific/service_layers\
 	.
 CFLAGS += -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER\
-	-I.\
-	-I../../../../../drivers/acpi/acpica\
-	-I../../../../../include
+	-I.
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
index 04b5db7..f7c7af1 100644
--- a/tools/power/acpi/tools/acpidump/Makefile
+++ b/tools/power/acpi/tools/acpidump/Makefile
@@ -19,9 +19,7 @@ vpath %.c \
 	./\
 	../../common\
 	../../os_specific/service_layers
-CFLAGS += -DACPI_DUMP_APP -I.\
-	-I../../../../../drivers/acpi/acpica\
-	-I../../../../../include
+CFLAGS += -DACPI_DUMP_APP -I.
 TOOL_OBJS = \
 	apdump.o\
 	apfiles.o\
@@ -49,7 +47,9 @@ TOOL_OBJS = \
 
 include ../../Makefile.rules
 
-install-man: ../../man/acpidump.8
-	$(INSTALL_DATA) -D $< $(DESTDIR)${mandir}/man8/acpidump.8
+install-man: $(srctree)/man/acpidump.8
+	$(ECHO) "  INST    " acpidump.8
+	$(QUIET) $(INSTALL_DATA) -D $< $(DESTDIR)$(mandir)/man8/acpidump.8
 uninstall-man:
-	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
+	$(ECHO) "  UNINST  " acpidump.8
+	$(QUIET) rm -f $(DESTDIR)$(mandir)/man8/acpidump.8
-- 
2.7.4

