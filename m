From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RFC PATCH] ACPI: Fix build errors due objects compiled unconditionally
Date: Tue, 13 Oct 2015 01:36:30 +0200
Message-ID: <1444692990-10107-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:51377 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbJLXgv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Oct 2015 19:36:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

If the CONFIG_ACPI Kconfig symbol is not enabled and a partial build is
attempted (make M=drivers/acpi), compile errors will happen due missing
types and identifiers.

This is because objects are tried to be built unconditionally even when
CONFIG_ACPI is not enabled. This is usually not a problem since arches'
Kconfig sources drivers/acpi/Kconfig directly and also selects ACPI but
the Makefile should conditionally build the objects as well.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Hello,

I found this issue while doing other stuff and since I'm not that
familiar with ACPI and was surprised that the obj-y comes from a
very old commit, I marked this patch as RFC.

$SUBJECT fixes the build issue for me though on ARM32 and I build
tested on x86. Build error log: http://hastebin.com/alaneqiper.pl

Patch is on top of next-20151012.

Best regards,
Javier

 drivers/acpi/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b5e7cd8a9c71..7fa53ddf6794 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -8,13 +8,13 @@ ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 #
 # ACPI Boot-Time Table Parsing
 #
-obj-y				+= tables.o
+obj-$(CONFIG_ACPI)		+= tables.o
 obj-$(CONFIG_X86)		+= blacklist.o
 
 #
 # ACPI Core Subsystem (Interpreter)
 #
-obj-y				+= acpi.o \
+obj-$(CONFIG_ACPI)		+= acpi.o \
 					acpica/
 
 # All the builtin files are in the "acpi." module_param namespace.
@@ -66,10 +66,10 @@ obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
-obj-y				+= container.o
+obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit.o
-obj-y				+= acpi_memhotplug.o
+obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
-- 
2.4.3

