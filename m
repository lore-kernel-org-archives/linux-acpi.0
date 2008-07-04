From: akpm@linux-foundation.org
Subject: [patch 3/4] acpi: add the abity to reset the system using RESET_REG in FADT table
Date: Fri, 04 Jul 2008 00:05:31 -0700
Message-ID: <200807040705.m6475V7S018516@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37768 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834AbYGDHFt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 03:05:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, adurbin@google.com, lenb@kernel.org

From: Aaron Durbin <adurbin@google.com>

Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.

Signed-off-by: Aaron Durbin <adurbin@google.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/Makefile |    2 -
 drivers/acpi/reboot.c |   50 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/reboot.h |   14 ++++++-----
 3 files changed, 59 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/Makefile~acpi-add-the-abity-to-reset-the-system-using-reset_reg-in-fadt-table drivers/acpi/Makefile
--- a/drivers/acpi/Makefile~acpi-add-the-abity-to-reset-the-system-using-reset_reg-in-fadt-table
+++ a/drivers/acpi/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_X86)		+= blacklist.o
 #
 # ACPI Core Subsystem (Interpreter)
 #
-obj-y				+= osl.o utils.o \
+obj-y				+= osl.o utils.o reboot.o\
 				   dispatcher/ events/ executer/ hardware/ \
 				   namespace/ parser/ resources/ tables/ \
 				   utilities/
diff -puN /dev/null drivers/acpi/reboot.c
--- /dev/null
+++ a/drivers/acpi/reboot.c
@@ -0,0 +1,50 @@
+
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <acpi/reboot.h>
+
+void acpi_reboot(void)
+{
+	struct acpi_generic_address *rr;
+	struct pci_bus *bus0;
+	u8 reset_value;
+	unsigned int devfn;
+
+	if (acpi_disabled)
+		return;
+
+	rr = &acpi_gbl_FADT.reset_register;
+
+	/* Is the reset register supported? */
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
+	    rr->bit_width != 8 || rr->bit_offset != 0)
+		return;
+
+	reset_value = acpi_gbl_FADT.reset_value;
+
+	/* The reset register can only exist in I/O, Memory or PCI config space
+	 * on a device on bus 0. */
+	switch (rr->space_id) {
+	case ACPI_ADR_SPACE_PCI_CONFIG:
+		/* The reset register can only live on bus 0. */
+		bus0 = pci_find_bus(0, 0);
+		if (!bus0)
+			return;
+		/* Form PCI device/function pair. */
+		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
+				  (rr->address >> 16) & 0xffff);
+		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.");
+		/* Write the value that resets us. */
+		pci_bus_write_config_byte(bus0, devfn,
+				(rr->address & 0xffff), reset_value);
+		break;
+
+	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+	case ACPI_ADR_SPACE_SYSTEM_IO:
+		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
+		acpi_hw_low_level_write(8, reset_value, rr);
+		break;
+	}
+	/* Wait ten seconds */
+	acpi_os_stall(10000000);
+}
diff -puN include/acpi/reboot.h~acpi-add-the-abity-to-reset-the-system-using-reset_reg-in-fadt-table include/acpi/reboot.h
--- a/include/acpi/reboot.h~acpi-add-the-abity-to-reset-the-system-using-reset_reg-in-fadt-table
+++ a/include/acpi/reboot.h
@@ -1,9 +1,11 @@
+#ifndef __ACPI_REBOOT_H
+#define __ACPI_REBOOT_H
+
+#ifdef CONFIG_ACPI
+extern void acpi_reboot(void);
+#else
+static inline void acpi_reboot(void) { }
+#endif
 
-/*
- * Dummy placeholder to make the EFI patches apply to the x86 tree.
- * Andrew/Len, please just kill this file if you encounter it.
- */
-#ifndef acpi_reboot
-# define acpi_reboot() do { } while (0)
 #endif
 
_
