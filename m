From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/4] tools/power/acpi: Make makefile work per subdirectory
Date: Mon,  7 Apr 2014 15:16:55 +0200
Message-ID: <1396876617-53345-3-git-send-email-trenn@suse.de>
References: <1396876617-53345-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47852 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbaDGNRB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 09:17:01 -0400
In-Reply-To: <1396876617-53345-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lv.zheng@intel.com, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Not sure why such a huge Makefile is needed to compile one file...
Anyway, I splitted up general variables/info and kept them in main
tools/power/acpi/Makefile
And created a new acpidump specific Makefile inside:
tools/power/acpi/tools/acpidump/Makefile

While this already is a cleanup worth by itself, I will add a new
tool making use of this new structure with a follow up submit.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/acpi/Makefile                |   94 +++++++++---------------------
 tools/power/acpi/tools/acpidump/Makefile |   27 +++++++++
 2 files changed, 55 insertions(+), 66 deletions(-)
 create mode 100644 tools/power/acpi/tools/acpidump/Makefile

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index c2c0f20..d97dada 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -8,28 +8,19 @@
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
+SUBDIRS = tools/acpidump
 
 # --- CONFIGURATION BEGIN ---
 
 # Set the following to `true' to make a unstripped, unoptimized
 # binary. Leave this set to `false' for production use.
-DEBUG ?=	true
+export DEBUG ?=	true
 
 # make the build silent. Set this to something else to make it noisy again.
 V ?=		false
 
 # Prefix to the directories we're installing to
-DESTDIR ?=
+export DESTDIR ?=
 
 # --- CONFIGURATION END ---
 
@@ -37,39 +28,37 @@ DESTDIR ?=
 # do not need to be changed. Please note that DESTDIR is
 # added in front of any of them
 
-bindir ?=	/usr/bin
-sbindir ?=	/usr/sbin
-mandir ?=	/usr/man
+export bindir ?=	/usr/bin
+export sbindir ?=	/usr/sbin
+export mandir ?=	/usr/man
 
 # Toolchain: what tools do we use, and what options do they need:
 
-INSTALL = /usr/bin/install -c
-INSTALL_PROGRAM = ${INSTALL}
-INSTALL_DATA  = ${INSTALL} -m 644
-INSTALL_SCRIPT = ${INSTALL_PROGRAM}
+export INSTALL = /usr/bin/install -c
+export INSTALL_PROGRAM = ${INSTALL}
+export INSTALL_DATA  = ${INSTALL} -m 644
+export INSTALL_SCRIPT = ${INSTALL_PROGRAM}
 
 # If you are running a cross compiler, you may want to set this
 # to something more interesting, like "arm-linux-".  If you want
 # to compile vs uClibc, that can be done here as well.
-CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC = $(CROSS)gcc
-LD = $(CROSS)gcc
-STRIP = $(CROSS)strip
-HOSTCC = gcc
+export CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
+export CC = $(CROSS)gcc
+export LD = $(CROSS)gcc
+export STRIP = $(CROSS)strip
+export HOSTCC = gcc
 
 # check if compiler option is supported
 cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}
 
 # use '-Os' optimization if available, else use -O2
-OPTIMIZATION := $(call cc-supports,-Os,-O2)
+export OPTIMIZATION := $(call cc-supports,-Os,-O2)
 
-WARNINGS := -Wall
+export WARNINGS := -Wall
 WARNINGS += $(call cc-supports,-Wstrict-prototypes)
 WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 
-KERNEL_INCLUDE := ../../../include
-CFLAGS += -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)
-CFLAGS += $(WARNINGS)
+export CFLAGS += $(WARNINGS)
 
 ifeq ($(strip $(V)),false)
 	QUIET=@
@@ -83,52 +72,25 @@ export QUIET ECHO
 # if DEBUG is enabled, then we do not strip or optimize
 ifeq ($(strip $(DEBUG)),true)
 	CFLAGS += -O1 -g -DDEBUG
-	STRIPCMD = /bin/true -Since_we_are_debugging
+	export STRIPCMD = /bin/true -Since_we_are_debugging
 else
 	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
-	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
+	export STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
 endif
 
-# --- ACPIDUMP BEGIN ---
-
-vpath %.c \
-	tools/acpidump
-
-DUMP_OBJS = \
-	acpidump.o
-
-DUMP_OBJS := $(addprefix $(OUTPUT)tools/acpidump/,$(DUMP_OBJS))
+all: $(SUBDIRS)
+	$(foreach dir,$(SUBDIRS),make -C $(dir);)
 
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
 
 clean:
-	-find $(OUTPUT) \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
+	-find . \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
 	 | xargs rm -f
-	-rm -f $(OUTPUT)acpidump
-
-install-tools:
-	$(INSTALL) -d $(DESTDIR)${sbindir}
-	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
-
-install-man:
-	$(INSTALL_DATA) -D man/acpidump.8 $(DESTDIR)${mandir}/man8/acpidump.8
+	$(foreach dir,$(SUBDIRS),make -C $(dir) clean;)
 
-install: all install-tools install-man
+install: 
+	$(foreach dir,$(SUBDIRS),make -C $(dir) install;)
 
 uninstall:
-	- rm -f $(DESTDIR)${sbindir}/acpidump
-	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
+	$(foreach dir,$(SUBDIRS),make -C $(dir) uninstall;)
 
-.PHONY: all utils install-tools install-man install uninstall clean
+.PHONY: all install uninstall clean
diff --git a/tools/power/acpi/tools/acpidump/Makefile b/tools/power/acpi/tools/acpidump/Makefile
new file mode 100644
index 0000000..4d0f993
--- /dev/null
+++ b/tools/power/acpi/tools/acpidump/Makefile
@@ -0,0 +1,27 @@
+KERNEL_INCLUDE := ../../../../../include
+CFLAGS += -D_LINUX -DACPI_USE_SYSTEM_INTTYPES=0 -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)
+
+acpidump: acpidump.o
+	$(ECHO) "  LD      " $@
+	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $< -o $@
+	$(QUIET) $(STRIPCMD) $@
+
+%.o: %.c
+	$(ECHO) "  CC      " $@
+	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
+
+all: acpidump
+
+install: 
+	$(INSTALL) -d $(DESTDIR)${sbindir}
+	$(INSTALL_PROGRAM) acpidump $(DESTDIR)${sbindir}
+	$(INSTALL_DATA) -D ../../man/acpidump.8 $(DESTDIR)${mandir}/man8/acpidump.8
+
+uninstall:
+	- rm -f $(DESTDIR)${sbindir}/acpidump
+	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
+
+clean:
+	-rm -f $(OUTPUT)acpidump
+
+.PHONY: all install uninstall
-- 
1.7.6.1

