From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Subject: ACPI: Add the abity to reset the system using RESET_REG
	in FADT table
Date: Mon, 14 Jul 2008 17:49:27 +0800
Message-ID: <1216028967.32159.28.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9291 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757140AbYGNJiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 05:38:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, adurbin@google.com, lenb@kernel.org

Subject: ACPI: Add the abity to reset the system using RESET_REG in FADT table
From: Aaron Durbin <adurbin@google.com>

Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.

Signed-off-by: Aaron Durbin <adurbin@google.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

---
 drivers/acpi/Makefile |    2 +-
 drivers/acpi/reboot.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/reboot.h |   13 +++++++------
 3 files changed, 58 insertions(+), 7 deletions(-)

Index: linux-2.6/include/acpi/reboot.h
===================================================================
--- linux-2.6.orig/include/acpi/reboot.h
+++ linux-2.6/include/acpi/reboot.h
@@ -1,9 +1,10 @@
+#ifndef __ACPI_REBOOT_H
+#define __ACPI_REBOOT_H
 
-/*
- * Dummy placeholder to make the EFI patches apply to the x86 tree.
- * Andrew/Len, please just kill this file if you encounter it.
- */
-#ifndef acpi_reboot
-# define acpi_reboot() do { } while (0)
+#ifdef CONFIG_ACPI
+extern void acpi_reboot(void);
+#else
+static inline void acpi_reboot(void) { }
 #endif
 
+#endif
Index: linux-2.6/drivers/acpi/reboot.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/acpi/reboot.c
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
Index: linux-2.6/drivers/acpi/Makefile
===================================================================
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_X86)		+= blacklist.o
 #
 # ACPI Core Subsystem (Interpreter)
 #
-obj-y				+= osl.o utils.o \
+obj-y				+= osl.o utils.o reboot.o\
 				   dispatcher/ events/ executer/ hardware/ \
 				   namespace/ parser/ resources/ tables/ \
 				   utilities/


