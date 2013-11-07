From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI: Remove acpi_pci_slot_init() headers from internal.h
Date: Thu, 07 Nov 2013 01:34:42 +0100
Message-ID: <12717501.dP4JbZxpHK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpi_pci_slot_init() is now called from acpi_pci_init()
and pci-acpi.h contains its header, remove that header (and the
empty definition of that function for CONFIG_ACPI_PCI_SLOT unset)
from internal.h as it doesn't have to be there any more.  That also
avoids a build warning about duplicate function definitions for
CONFIG_ACPI_PCI_SLOT unset.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -26,11 +26,6 @@
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
-#ifdef	CONFIG_ACPI_PCI_SLOT
-void acpi_pci_slot_init(void);
-#else
-static inline void acpi_pci_slot_init(void) { }
-#endif
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
 void acpi_pci_root_hp_init(void);
