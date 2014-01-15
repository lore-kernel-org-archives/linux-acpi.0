From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPICA: acpidump: Cleanup tools/power/acpi makefiles.
Date: Wed, 15 Jan 2014 12:04:09 +0800
Message-ID: <13c29ccf3ab3c8e301c3f571f8d9d58a94571b39.1389676901.git.lv.zheng@intel.com>
References: <cover.1376378577.git.lv.zheng@intel.com> <cover.1389676901.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62753 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbaAOEEU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jan 2014 23:04:20 -0500
In-Reply-To: <cover.1389676901.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch cleans up old tools/power/acpi Makefile for further porting,
make it compiled in a similar way as the other tools.  No functional
changes.

The CFLAGS is modified as follows:
1. Previous cc flags:
   -Wall -Wstrict-prototypes -Wdeclaration-after-statement -Os -s \
   -D_LINUX -DDEFINE_ALTERNATE_TYPES -I../../../include
2. Current cc flags:
   DEBUG=false:
   -D_LINUX -DDEFINE_ALTERNATE_TYPES -I../../../include -Wall \
   -Wstrict-prototypes -Wdeclaration-after-statement -Os \
   -fomit-frame-pointer
   Normal:
   -D_LINUX -DDEFINE_ALTERNATE_TYPES -I../../../include -Wall \
   -Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG

There is only one difference: -fomit-frame-pointer.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/Makefile                        |  149 ++++++++++++++++++++--
 tools/power/acpi/{ => man}/acpidump.8            |    0
 tools/power/acpi/{ => tools/acpidump}/acpidump.c |    0
 3 files changed, 137 insertions(+), 12 deletions(-)
 rename tools/power/acpi/{ => man}/acpidump.8 (100%)
 rename tools/power/acpi/{ => tools/acpidump}/acpidump.c (100%)

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index bafeb8d..d9186a2 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -1,18 +1,143 @@
-PROG= acpidump
-SRCS=	acpidump.c
+# tools/power/acpi/Makefile - ACPI tool Makefile
+#
+# Copyright (c) 2013, Intel Corporation
+#   Author: Lv Zheng <lv.zheng@intel.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; version 2
+# of the License.
+
+OUTPUT=./
+ifeq ("$(origin O)", "command line")
+	OUTPUT := $(O)/
+endif
+
+ifneq ($(OUTPUT),)
+# check that the output directory actually exists
+OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
+$(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
+endif
+
+# --- CONFIGURATION BEGIN ---
+
+# Set the following to `true' to make a unstripped, unoptimized
+# binary. Leave this set to `false' for production use.
+DEBUG ?=	true
+
+# make the build silent. Set this to something else to make it noisy again.
+V ?=		false
+
+# Prefix to the directories we're installing to
+DESTDIR ?=
+
+# --- CONFIGURATION END ---
+
+# Directory definitions. These are default and most probably
+# do not need to be changed. Please note that DESTDIR is
+# added in front of any of them
+
+bindir ?=	/usr/bin
+sbindir ?=	/usr/sbin
+mandir ?=	/usr/man
+
+# Toolchain: what tools do we use, and what options do they need:
+
+INSTALL = /usr/bin/install -c
+INSTALL_PROGRAM = ${INSTALL}
+INSTALL_DATA  = ${INSTALL} -m 644
+INSTALL_SCRIPT = ${INSTALL_PROGRAM}
+
+# If you are running a cross compiler, you may want to set this
+# to something more interesting, like "arm-linux-".  If you want
+# to compile vs uClibc, that can be done here as well.
+CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
+CC = $(CROSS)gcc
+LD = $(CROSS)gcc
+STRIP = $(CROSS)strip
+HOSTCC = gcc
+
+# check if compiler option is supported
+cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}
+
+# use '-Os' optimization if available, else use -O2
+OPTIMIZATION := $(call cc-supports,-Os,-O2)
+
+WARNINGS := -Wall
+WARNINGS += $(call cc-supports,-Wstrict-prototypes)
+WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
+
 KERNEL_INCLUDE := ../../../include
-CFLAGS += -Wall -Wstrict-prototypes -Wdeclaration-after-statement -Os -s -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE) 
+CFLAGS += -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)
+CFLAGS += $(WARNINGS)
+
+ifeq ($(strip $(V)),false)
+	QUIET=@
+	ECHO=@echo
+else
+	QUIET=
+	ECHO=@\#
+endif
+export QUIET ECHO
+
+# if DEBUG is enabled, then we do not strip or optimize
+ifeq ($(strip $(DEBUG)),true)
+	CFLAGS += -O1 -g -DDEBUG
+	STRIPCMD = /bin/true -Since_we_are_debugging
+else
+	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
+	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
+endif
+
+# if DEBUG is enabled, then we do not strip or optimize
+ifeq ($(strip $(DEBUG)),true)
+	CFLAGS += -O1 -g -DDEBUG
+	STRIPCMD = /bin/true -Since_we_are_debugging
+else
+	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
+	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
+endif
+
+# --- ACPIDUMP BEGIN ---
+
+vpath %.c \
+	tools/acpidump
+
+DUMP_OBJS = \
+	acpidump.o
+
+DUMP_OBJS := $(addprefix $(OUTPUT)tools/acpidump/,$(DUMP_OBJS))
+
+$(OUTPUT)acpidump: $(DUMP_OBJS)
+	$(ECHO) "  LD      " $@
+	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(DUMP_OBJS) -L$(OUTPUT) -o $@
+	$(QUIET) $(STRIPCMD) $@
+
+$(OUTPUT)tools/acpidump/%.o: %.c
+	$(ECHO) "  CC      " $@
+	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
+
+# --- ACPIDUMP END ---
+
+all: $(OUTPUT)acpidump
+	echo $(OUTPUT)
+
+clean:
+	-find $(OUTPUT) \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
+	 | xargs rm -f
+	-rm -f $(OUTPUT)acpidump
 
-all: acpidump
-$(PROG) : $(SRCS)
-	$(CC) $(CFLAGS) $(SRCS) -o $(PROG)
+install-tools:
+	$(INSTALL) -d $(DESTDIR)${bindir}
+	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
 
-CLEANFILES= $(PROG)
+install-man:
+	$(INSTALL_DATA) -D man/acpidump.8 $(DESTDIR)${mandir}/man8/acpidump.8
 
-clean : 
-	rm -f $(CLEANFILES) $(patsubst %.c,%.o, $(SRCS)) *~
+install: all install-tools install-man
 
-install :
-	install acpidump /usr/sbin/acpidump
-	install acpidump.8 /usr/share/man/man8
+uninstall:
+	- rm -f $(DESTDIR)${sbindir}/acpidump
+	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
 
+.PHONY: all utils install-tools install-man install uninstall clean
diff --git a/tools/power/acpi/acpidump.8 b/tools/power/acpi/man/acpidump.8
similarity index 100%
rename from tools/power/acpi/acpidump.8
rename to tools/power/acpi/man/acpidump.8
diff --git a/tools/power/acpi/acpidump.c b/tools/power/acpi/tools/acpidump/acpidump.c
similarity index 100%
rename from tools/power/acpi/acpidump.c
rename to tools/power/acpi/tools/acpidump/acpidump.c
-- 
1.7.10

