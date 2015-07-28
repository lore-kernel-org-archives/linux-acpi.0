From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] tools/power/acpi: Add descend support in ACPI tools Makefile.
Date: Tue, 28 Jul 2015 13:25:25 +0800
Message-ID: <f2f8da0058d49ef530f5401d3361bd19af662b4f.1438060971.git.lv.zheng@intel.com>
References: <cover.1438060971.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438060971.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch splits tools/power/acpi/Makefile to support descend compling for
ACPI tools. In this patch tools/ec related stuff is removed as it is
originally not enabled.

Also a missing .o (utnonansi.o) is added to the acpidump/Makefile.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/Makefile                |  168 +++---------------------------
 tools/power/acpi/Makefile.config         |   92 ++++++++++++++++
 tools/power/acpi/Makefile.rules          |   37 +++++++
 tools/power/acpi/tools/acpidump/Makefile |   53 ++++++++++
 4 files changed, 199 insertions(+), 151 deletions(-)
 create mode 100644 tools/power/acpi/Makefile.config
 create mode 100644 tools/power/acpi/Makefile.rules
 create mode 100644 tools/power/acpi/tools/acpidump/Makefile

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index 3d1537b..3d05237 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -8,154 +8,20 @@
 # as published by the Free Software Foundation; version 2
 # of the License.
 
-OUTPUT=./
-ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/
-endif
-
-ifneq ($(OUTPUT),)
-# check that the output directory actually exists
-OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
-$(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
-endif
-
-SUBDIRS = tools/ec
-
-# --- CONFIGURATION BEGIN ---
-
-# Set the following to `true' to make a unstripped, unoptimized
-# binary. Leave this set to `false' for production use.
-DEBUG ?=	true
-
-# make the build silent. Set this to something else to make it noisy again.
-V ?=		false
-
-# Prefix to the directories we're installing to
-DESTDIR ?=
-
-# --- CONFIGURATION END ---
-
-# Directory definitions. These are default and most probably
-# do not need to be changed. Please note that DESTDIR is
-# added in front of any of them
-
-bindir ?=	/usr/bin
-sbindir ?=	/usr/sbin
-mandir ?=	/usr/man
-
-# Toolchain: what tools do we use, and what options do they need:
-
-INSTALL = /usr/bin/install -c
-INSTALL_PROGRAM = ${INSTALL}
-INSTALL_DATA  = ${INSTALL} -m 644
-INSTALL_SCRIPT = ${INSTALL_PROGRAM}
-
-# If you are running a cross compiler, you may want to set this
-# to something more interesting, like "arm-linux-".  If you want
-# to compile vs uClibc, that can be done here as well.
-CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC = $(CROSS)gcc
-LD = $(CROSS)gcc
-STRIP = $(CROSS)strip
-HOSTCC = gcc
-
-# check if compiler option is supported
-cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}
-
-# use '-Os' optimization if available, else use -O2
-OPTIMIZATION := $(call cc-supports,-Os,-O2)
-
-WARNINGS := -Wall
-WARNINGS += $(call cc-supports,-Wstrict-prototypes)
-WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
-
-KERNEL_INCLUDE := ../../../include
-ACPICA_INCLUDE := ../../../drivers/acpi/acpica
-CFLAGS += -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
-CFLAGS += $(WARNINGS)
-
-ifeq ($(strip $(V)),false)
-	QUIET=@
-	ECHO=@echo
-else
-	QUIET=
-	ECHO=@\#
-endif
-export QUIET ECHO
-
-# if DEBUG is enabled, then we do not strip or optimize
-ifeq ($(strip $(DEBUG)),true)
-	CFLAGS += -O1 -g -DDEBUG
-	STRIPCMD = /bin/true -Since_we_are_debugging
-else
-	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
-	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
-endif
-
-# --- ACPIDUMP BEGIN ---
-
-vpath %.c \
-	../../../drivers/acpi/acpica\
-	tools/acpidump\
-	common\
-	os_specific/service_layers
-
-CFLAGS += -DACPI_DUMP_APP -Itools/acpidump
-
-DUMP_OBJS = \
-	apdump.o\
-	apfiles.o\
-	apmain.o\
-	osunixdir.o\
-	osunixmap.o\
-	osunixxf.o\
-	tbprint.o\
-	tbxfroot.o\
-	utbuffer.o\
-	utdebug.o\
-	utexcep.o\
-	utglobal.o\
-	utmath.o\
-	utprint.o\
-	utstring.o\
-	utxferror.o\
-	oslibcfs.o\
-	oslinuxtbl.o\
-	cmfsize.o\
-	getopt.o
-
-DUMP_OBJS := $(addprefix $(OUTPUT)tools/acpidump/,$(DUMP_OBJS))
-
-$(OUTPUT)acpidump: $(DUMP_OBJS)
-	$(ECHO) "  LD      " $@
-	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(DUMP_OBJS) -L$(OUTPUT) -o $@
-	$(QUIET) $(STRIPCMD) $@
-
-$(OUTPUT)tools/acpidump/%.o: %.c
-	$(ECHO) "  CC      " $@
-	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
-
-# --- ACPIDUMP END ---
-
-all: $(OUTPUT)acpidump
-	echo $(OUTPUT)
-
-clean:
-	-find $(OUTPUT) \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
-	 | xargs rm -f
-	-rm -f $(OUTPUT)acpidump
-
-install-tools:
-	$(INSTALL) -d $(DESTDIR)${sbindir}
-	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
-
-install-man:
-	$(INSTALL_DATA) -D man/acpidump.8 $(DESTDIR)${mandir}/man8/acpidump.8
-
-install: all install-tools install-man
-
-uninstall:
-	- rm -f $(DESTDIR)${sbindir}/acpidump
-	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
-
-.PHONY: all utils install-tools install-man install uninstall clean
+include ../../scripts/Makefile.include
+
+all: acpidump
+clean: acpidump_clean
+install: acpidump_install
+uninstall: acpidump_uninstall
+
+acpidump: FORCE
+	$(call descend,tools/$@,all)
+acpidump_clean:
+	$(call descend,tools/$(@:_clean=),clean)
+acpidump_install:
+	$(call descend,tools/$(@:_install=),install)
+acpidump_uninstall:
+	$(call descend,tools/$(@:_uninstall=),uninstall)
+
+.PHONY: FORCE
diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
new file mode 100644
index 0000000..552af68
--- /dev/null
+++ b/tools/power/acpi/Makefile.config
@@ -0,0 +1,92 @@
+# tools/power/acpi/Makefile.config - ACPI tool Makefile
+#
+# Copyright (c) 2015, Intel Corporation
+#   Author: Lv Zheng <lv.zheng@intel.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; version 2
+# of the License.
+
+include ../../../../scripts/Makefile.include
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
+KERNEL_INCLUDE := ../../../include
+ACPICA_INCLUDE := ../../../drivers/acpi/acpica
+CFLAGS += -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
+CFLAGS += $(WARNINGS)
+
+ifeq ($(strip $(V)),false)
+	QUIET=@
+	ECHO=@echo
+else
+	QUIET=
+	ECHO=@\#
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
diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
new file mode 100644
index 0000000..ec87a9e
--- /dev/null
+++ b/tools/power/acpi/Makefile.rules
@@ -0,0 +1,37 @@
+# tools/power/acpi/Makefile.rules - ACPI tool Makefile
+#
+# Copyright (c) 2015, Intel Corporation
+#   Author: Lv Zheng <lv.zheng@intel.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; version 2
+# of the License.
+
+$(OUTPUT)$(TOOL): $(TOOL_OBJS) FORCE
+	$(ECHO) "  LD      " $@
+	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(TOOL_OBJS) -L$(OUTPUT) -o $@
+	$(QUIET) $(STRIPCMD) $@
+
+$(OUTPUT)%.o: %.c
+	$(ECHO) "  CC      " $@
+	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
+
+all: $(OUTPUT)$(TOOL)
+clean:
+	-find $(OUTPUT) \( -not -type d \) \
+	-and \( -name '*~' -o -name '*.[oas]' \) \
+	-type f -print \
+	 | xargs rm -f
+	-rm -f $(OUTPUT)$(TOOL)
+
+install-tools:
+	$(INSTALL) -d $(DESTDIR)${sbindir}
+	$(INSTALL_PROGRAM) $(OUTPUT)$(TOOL) $(DESTDIR)${sbindir}
+uninstall-tools:
+	- rm -f $(DESTDIR)${sbindir}/$(TOOL)
+
+install: all install-tools $(EXTRA_INSTALL)
+uninstall: uninstall-tools $(EXTRA_UNINSTALL)
+
+.PHONY: FORCE
diff --git a/tools/power/acpi/tools/acpidump/Makefile b/tools/power/acpi/tools/acpidump/Makefile
new file mode 100644
index 0000000..8d76157
--- /dev/null
+++ b/tools/power/acpi/tools/acpidump/Makefile
@@ -0,0 +1,53 @@
+# tools/power/acpi/tools/acpidump/Makefile - ACPI tool Makefile
+#
+# Copyright (c) 2015, Intel Corporation
+#   Author: Lv Zheng <lv.zheng@intel.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; version 2
+# of the License.
+
+include ../../Makefile.config
+
+TOOL = acpidump
+EXTRA_INSTALL = install-man
+EXTRA_UNINSTALL = uninstall-man
+
+vpath %.c \
+	../../../../../drivers/acpi/acpica\
+	./\
+	../../common\
+	../../os_specific/service_layers
+CFLAGS += -DACPI_DUMP_APP -I.\
+	-I../../../../../drivers/acpi/acpica\
+	-I../../../../../include
+TOOL_OBJS = \
+	apdump.o\
+	apfiles.o\
+	apmain.o\
+	osunixdir.o\
+	osunixmap.o\
+	osunixxf.o\
+	tbprint.o\
+	tbxfroot.o\
+	utbuffer.o\
+	utdebug.o\
+	utexcep.o\
+	utglobal.o\
+	utmath.o\
+	utnonansi.o\
+	utprint.o\
+	utstring.o\
+	utxferror.o\
+	oslibcfs.o\
+	oslinuxtbl.o\
+	cmfsize.o\
+	getopt.o
+
+include ../../Makefile.rules
+
+install-man: ../../man/acpidump.8
+	$(INSTALL_DATA) -D $< $(DESTDIR)${mandir}/man8/acpidump.8
+uninstall-man:
+	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
-- 
1.7.10
