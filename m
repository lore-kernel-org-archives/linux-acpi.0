From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ACPI: Fix build errors due objects compiled unconditionally
Date: Fri, 20 Nov 2015 14:35:02 -0300
Message-ID: <1448040902-1349-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38145 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760833AbbKTRfN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Nov 2015 12:35:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Al Stone <al.stone@linaro.org>, Len Brown <lenb@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

If the CONFIG_ACPI Kconfig symbol is not enabled and a partial build is
attempted, compile errors will happen due missing types and identifiers.

This can be easily reproduced with the following commands:

$ export CROSS_COMPILE="arm-linux-gnueabihf-" ARCH=arm
$ make allmodconfig
$ make M=drivers/acpi/
  CC      drivers/acpi//tables.o
drivers/acpi//tables.c:235:3: warning: 'struct acpi_subtable_proc' declared inside parameter list
   unsigned int max_entries)
   ^
drivers/acpi//tables.c:235:3: warning: its scope is only this definition or declaration, which is probably not what you want
drivers/acpi//tables.c: In function 'acpi_parse_entries_array':
drivers/acpi//tables.c:269:4: error: invalid use of undefined type 'struct acpi_subtable_proc'
...
scripts/Makefile.build:258: recipe for target 'drivers/acpi//tables.o' failed
make[1]: *** [drivers/acpi//tables.o] Error 1
Makefile:1401: recipe for target '_module_drivers/acpi/' failed
make: *** [_module_drivers/acpi/] Error 2

This is because objects are tried to be built unconditionally even when
CONFIG_ACPI is not enabled. This is usually not a problem since arches'
Kconfig sources drivers/acpi/Kconfig directly and also selects ACPI but
the Makefile should conditionally build the objects as well to prevent
these build errors.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Hello,

I posted this patch first as an RFC more than a month ago [0]
and got no feedback, so I'm resending without the RFC tag.

[0]: https://lkml.org/lkml/2015/10/12/859

Best regards,
Javier

 drivers/acpi/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 675eaf337178..73ec23ca7db1 100644
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

