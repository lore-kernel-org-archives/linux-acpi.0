From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V7] ACPI, PCI, irq: support IRQ numbers greater than 256
Date: Mon, 30 Nov 2015 18:39:01 -0500
Message-ID: <1448926742-24308-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58138 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbK3XjJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 18:39:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, helgaas@kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

The ACPI compiler uses the extended format when used interrupt numbers
are greater than 15. The extended IRQ is 32 bits according to the ACPI
spec. The code supports parsing the extended interrupt numbers. However,
due to used data structure type; the code silently truncates interrupt
numbers greater than 256.

This patch changes the interrupt number type to 32 bits and places an
upper limit of 1020 as possible interrupt id. 1020 is the maximum
interrupt ID that can be assigned to an ARM SPI interrupt according to
ARM architecture.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 7c8408b..faa37cd 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
+ *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
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
@@ -147,6 +156,13 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 					       p->interrupts[i]);
 					continue;
 				}
+				if (p->interrupts[i] >= ACPI_MAX_IRQS) {
+					dev_warn(&link->device->dev,
+						 "Ignoring IRQ(%d) as it exceeds max(%d)\n",
+						 p->interrupts[i],
+						 ACPI_MAX_IRQS - 1);
+					continue;
+				}
 				link->irq.possible[i] = p->interrupts[i];
 				link->irq.possible_count++;
 			}
@@ -279,6 +295,13 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 		result = -ENODEV;
 	}
 
+	if (irq >= ACPI_MAX_IRQS) {
+		dev_err(&link->device->dev,
+			"Ignoring IRQ(%d) as it exceeds max(%d)\n",
+			irq,  ACPI_MAX_IRQS - 1);
+		result = -ENODEV;
+		goto end;
+	}
 	link->irq.active = irq;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
@@ -437,9 +460,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
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

