From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PCI / ACPI: Fix build of the AER driver for CONFIG_ACPI unset
Date: Sun, 16 Jan 2011 20:42:43 +0100
Message-ID: <201101162042.43341.rjw@sisk.pl>
References: <201101162041.02419.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201101162041.02419.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andres Salomon <dilinger@queued.net>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After commit 415e12b (PCI/ACPI: Request _OSC control once for each
root bridge (v3)) include/linux/pci-acpi.h is included by
drivers/pci/pcie/aer/aerdrv.c and if CONFIG_ACPI is unset, the
bogus and unnecessary alternative definition of
acpi_find_root_bridge_handle() causes a build error to occur.

Remove the offending piece of garbage.

Reported-and-tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pci-acpi.h |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/include/linux/pci-acpi.h
===================================================================
--- linux-2.6.orig/include/linux/pci-acpi.h
+++ linux-2.6/include/linux/pci-acpi.h
@@ -35,9 +35,6 @@ static inline acpi_handle acpi_pci_get_b
 	return acpi_get_pci_rootbridge_handle(pci_domain_nr(pbus),
 					      pbus->number);
 }
-#else
-static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
-{ return NULL; }
 #endif
 
 #ifdef CONFIG_ACPI_APEI
