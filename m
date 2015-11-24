From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V5] acpi: add support for extended IRQ to PCI link
Date: Tue, 24 Nov 2015 15:10:43 -0500
Message-ID: <1448395843-23112-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54714 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbKXUKy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2015 15:10:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, helgaas@kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

The ACPI compiler uses the extended format when used interrupt numbers
are greater than 256. The extended IRQ numbers use 32 bits for storing
interrupts. The code already supports parsing extended IRQ type but is
limited by 256 due to used data structure type (u8). This patch changes
the interrupt number type to 32 bits and places an upper limit of 1020
as possible interrupt id. 1020 is the maximum interrupt ID that can be
assigned to an ARM SPI interrupt according to ARM architecture.

Additional checks have been placed to return an error when ACPI_MAX_IRQS
is exceeded.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 7c8408b..8fe4e6f 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -1,6 +1,7 @@
 /*
  *  pci_link.c - ACPI PCI Interrupt Link Device Driver ($Revision: 34 $)
  *
+ *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
@@ -47,6 +48,14 @@ ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
 
+/*
+ * 1020 is the maximum interrupt ID that can be assigned to
+ * an ARM SPI interrupt according to ARM architecture.
+ */
+#define ACPI_MAX_IRQS		1020
+#define ACPI_MAX_ISA_IRQ	16
+
+
 static int acpi_pci_link_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used);
 static void acpi_pci_link_remove(struct acpi_device *device);
@@ -67,12 +76,12 @@ static struct acpi_scan_handler pci_link_handler = {
  * later even the link is disable. Instead, we just repick the active irq
  */
 struct acpi_pci_link_irq {
-	u8 active;		/* Current IRQ */
+	u32 active;		/* Current IRQ */
 	u8 triggering;		/* All IRQs */
 	u8 polarity;		/* All IRQs */
 	u8 resource_type;
 	u8 possible_count;
-	u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
+	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 	u8 initialized:1;
 	u8 reserved:7;
 };
@@ -147,6 +156,12 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 					       p->interrupts[i]);
 					continue;
 				}
+				if (p->interrupts[i] > ACPI_MAX_IRQS) {
+					pr_warn("IRQ %d exceeds max (%d)\n",
+						p->interrupts[i],
+						ACPI_MAX_IRQS);
+					continue;
+				}
 				link->irq.possible[i] = p->interrupts[i];
 				link->irq.possible_count++;
 			}
@@ -279,6 +294,11 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 		result = -ENODEV;
 	}
 
+	if (irq > ACPI_MAX_IRQS) {
+		pr_err("IRQ %d number exceed max IRQ (%d)\n", irq,
+			ACPI_MAX_IRQS);
+		result = -ENODEV;
+	}
 	link->irq.active = irq;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
@@ -437,9 +457,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  * enabled system.
  */
 
-#define ACPI_MAX_IRQS		256
-#define ACPI_MAX_ISA_IRQ	16
-
 #define PIRQ_PENALTY_PCI_AVAILABLE	(0)
 #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
 #define PIRQ_PENALTY_PCI_USING		(16*16*16)
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

