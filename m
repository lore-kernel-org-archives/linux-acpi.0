From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/4] tools/power/acpi: Make makefile work per
 subdirectory
Date: Tue, 8 Apr 2014 01:58:52 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802546F45@SHSMSX101.ccr.corp.intel.com>
References: <1396876617-53345-1-git-send-email-trenn@suse.de>
 <1396876617-53345-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22703 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbaDHB7Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2014 21:59:24 -0400
In-Reply-To: <1396876617-53345-3-git-send-email-trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Thomas

> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Monday, April 07, 2014 9:17 PM
> 
> Not sure why such a huge Makefile is needed to compile one file...

The huge Makefile is generated to include release automation of ACPICA's acpidump.
It's no longer 1 file, but bunch of files that originally can only be found in ACPICA repo.
I noticed that Rafael had merged the 20140325 ACPICA release into the bleeding-edge branch.
So you need to rebase this series on top of linux-pm/bleeding-edge.

> Anyway, I splitted up general variables/info and kept them in main
> tools/power/acpi/Makefile
> And created a new acpidump specific Makefile inside:
> tools/power/acpi/tools/acpidump/Makefile
> 
> While this already is a cleanup worth by itself, I will add a new
> tool making use of this new structure with a follow up submit.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  tools/power/acpi/Makefile                |   94 +++++++++---------------------
>  tools/power/acpi/tools/acpidump/Makefile |   27 +++++++++
>  2 files changed, 55 insertions(+), 66 deletions(-)
>  create mode 100644 tools/power/acpi/tools/acpidump/Makefile
> 
> diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
> index c2c0f20..d97dada 100644
> --- a/tools/power/acpi/Makefile
> +++ b/tools/power/acpi/Makefile
> @@ -8,28 +8,19 @@
>  # as published by the Free Software Foundation; version 2
>  # of the License.
> 
> -OUTPUT=./
> -ifeq ("$(origin O)", "command line")
> -	OUTPUT := $(O)/
> -endif
> -
> -ifneq ($(OUTPUT),)
> -# check that the output directory actually exists
> -OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
> -$(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
> -endif
> +SUBDIRS = tools/acpidump
> 
>  # --- CONFIGURATION BEGIN ---
> 
>  # Set the following to `true' to make a unstripped, unoptimized
>  # binary. Leave this set to `false' for production use.
> -DEBUG ?=	true
> +export DEBUG ?=	true
> 
>  # make the build silent. Set this to something else to make it noisy again.
>  V ?=		false
> 
>  # Prefix to the directories we're installing to
> -DESTDIR ?=
> +export DESTDIR ?=
> 
>  # --- CONFIGURATION END ---
> 
> @@ -37,39 +28,37 @@ DESTDIR ?=
>  # do not need to be changed. Please note that DESTDIR is
>  # added in front of any of them
> 
> -bindir ?=	/usr/bin
> -sbindir ?=	/usr/sbin
> -mandir ?=	/usr/man
> +export bindir ?=	/usr/bin
> +export sbindir ?=	/usr/sbin
> +export mandir ?=	/usr/man
> 
>  # Toolchain: what tools do we use, and what options do they need:
> 
> -INSTALL = /usr/bin/install -c
> -INSTALL_PROGRAM = ${INSTALL}
> -INSTALL_DATA  = ${INSTALL} -m 644
> -INSTALL_SCRIPT = ${INSTALL_PROGRAM}
> +export INSTALL = /usr/bin/install -c
> +export INSTALL_PROGRAM = ${INSTALL}
> +export INSTALL_DATA  = ${INSTALL} -m 644
> +export INSTALL_SCRIPT = ${INSTALL_PROGRAM}
> 
>  # If you are running a cross compiler, you may want to set this
>  # to something more interesting, like "arm-linux-".  If you want
>  # to compile vs uClibc, that can be done here as well.
> -CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> -CC = $(CROSS)gcc
> -LD = $(CROSS)gcc
> -STRIP = $(CROSS)strip
> -HOSTCC = gcc
> +export CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> +export CC = $(CROSS)gcc
> +export LD = $(CROSS)gcc
> +export STRIP = $(CROSS)strip
> +export HOSTCC = gcc
> 
>  # check if compiler option is supported
>  cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}
> 
>  # use '-Os' optimization if available, else use -O2
> -OPTIMIZATION := $(call cc-supports,-Os,-O2)
> +export OPTIMIZATION := $(call cc-supports,-Os,-O2)
> 
> -WARNINGS := -Wall
> +export WARNINGS := -Wall
>  WARNINGS += $(call cc-supports,-Wstrict-prototypes)
>  WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
> 
> -KERNEL_INCLUDE := ../../../include
> -CFLAGS += -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)
> -CFLAGS += $(WARNINGS)
> +export CFLAGS += $(WARNINGS)
> 
>  ifeq ($(strip $(V)),false)
>  	QUIET=@
> @@ -83,52 +72,25 @@ export QUIET ECHO
>  # if DEBUG is enabled, then we do not strip or optimize
>  ifeq ($(strip $(DEBUG)),true)
>  	CFLAGS += -O1 -g -DDEBUG
> -	STRIPCMD = /bin/true -Since_we_are_debugging
> +	export STRIPCMD = /bin/true -Since_we_are_debugging
>  else
>  	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
> -	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
> +	export STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
>  endif
> 
> -# --- ACPIDUMP BEGIN ---
> -
> -vpath %.c \
> -	tools/acpidump

The "vpath" is required by the new acpidump.
As the new utility will reuse source files in the drivers/acpi/acpica folder to find ACPICA source code shared with this utility.

> -
> -DUMP_OBJS = \
> -	acpidump.o
> -
> -DUMP_OBJS := $(addprefix $(OUTPUT)tools/acpidump/,$(DUMP_OBJS))
> +all: $(SUBDIRS)
> +	$(foreach dir,$(SUBDIRS),make -C $(dir);)
> 
> -$(OUTPUT)acpidump: $(DUMP_OBJS)
> -	$(ECHO) "  LD      " $@
> -	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(DUMP_OBJS) -L$(OUTPUT) -o $@
> -	$(QUIET) $(STRIPCMD) $@
> -
> -$(OUTPUT)tools/acpidump/%.o: %.c
> -	$(ECHO) "  CC      " $@
> -	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
> -
> -# --- ACPIDUMP END ---
> -
> -all: $(OUTPUT)acpidump
> -	echo $(OUTPUT)
> 
>  clean:
> -	-find $(OUTPUT) \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
> +	-find . \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
>  	 | xargs rm -f
> -	-rm -f $(OUTPUT)acpidump
> -
> -install-tools:
> -	$(INSTALL) -d $(DESTDIR)${sbindir}
> -	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
> -
> -install-man:
> -	$(INSTALL_DATA) -D man/acpidump.8 $(DESTDIR)${mandir}/man8/acpidump.8
> +	$(foreach dir,$(SUBDIRS),make -C $(dir) clean;)
> 
> -install: all install-tools install-man
> +install:
> +	$(foreach dir,$(SUBDIRS),make -C $(dir) install;)
> 
>  uninstall:
> -	- rm -f $(DESTDIR)${sbindir}/acpidump
> -	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
> +	$(foreach dir,$(SUBDIRS),make -C $(dir) uninstall;)
> 
> -.PHONY: all utils install-tools install-man install uninstall clean
> +.PHONY: all install uninstall clean
> diff --git a/tools/power/acpi/tools/acpidump/Makefile b/tools/power/acpi/tools/acpidump/Makefile

The Makefile is put under tools/power/acpi because ACPICA release automation will put some shared files into "common" and "os_specific" folder.
If you are going to move the build commands into a tools/power/acpi/tools/acpidump/Makefile, you need to test using the recent upstream branch that contains the acpidump release.

> new file mode 100644
> index 0000000..4d0f993
> --- /dev/null
> +++ b/tools/power/acpi/tools/acpidump/Makefile
> @@ -0,0 +1,27 @@
> +KERNEL_INCLUDE := ../../../../../include
> +CFLAGS += -D_LINUX -DACPI_USE_SYSTEM_INTTYPES=0 -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)
> +
> +acpidump: acpidump.o
> +	$(ECHO) "  LD      " $@
> +	$(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $< -o $@
> +	$(QUIET) $(STRIPCMD) $@
> +
> +%.o: %.c
> +	$(ECHO) "  CC      " $@
> +	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<

I think this breaks new acpidump compilation.
vpath is needed as drivers/acpi/acpica, tools/power/acpi/common, tools/power/acpi/os_specific source files need to be compiled.

> +
> +all: acpidump
> +
> +install:
> +	$(INSTALL) -d $(DESTDIR)${sbindir}
> +	$(INSTALL_PROGRAM) acpidump $(DESTDIR)${sbindir}
> +	$(INSTALL_DATA) -D ../../man/acpidump.8 $(DESTDIR)${mandir}/man8/acpidump.8
> +
> +uninstall:
> +	- rm -f $(DESTDIR)${sbindir}/acpidump
> +	- rm -f $(DESTDIR)${mandir}/man8/acpidump.8
> +
> +clean:
> +	-rm -f $(OUTPUT)acpidump
> +
> +.PHONY: all install uninstall
> --
> 1.7.6.1

