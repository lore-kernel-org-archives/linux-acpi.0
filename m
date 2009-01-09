From: Len Brown <lenb@kernel.org>
Subject: [PATCH 57/94] ACPI: PCI: whitespace and useless initialization cleanup
Date: Fri, 09 Jan 2009 04:26:59 -0500
Message-ID: <3f0f3c27be19d390f23af1075d9948d0310e2673.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbZAIJ2w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:52 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700LHM6B6X3C7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:19 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes function declarations consistent throughout
the file and removes some unnecessary initializations.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 03d528e..cba8d4d 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -149,8 +149,8 @@ static struct prt_quirk prt_quirks[] = {
 		"\\_SB_.PCI0.LNK3"},
 };
 
-static void
-do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
+static void do_prt_fixups(struct acpi_prt_entry *entry,
+			  struct acpi_pci_routing_table *prt)
 {
 	int i;
 	struct prt_quirk *quirk;
@@ -180,9 +180,8 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
 	}
 }
 
-static int
-acpi_pci_irq_add_entry(acpi_handle handle,
-		       int segment, int bus, struct acpi_pci_routing_table *prt)
+static int acpi_pci_irq_add_entry(acpi_handle handle, int segment, int bus,
+				  struct acpi_pci_routing_table *prt)
 {
 	struct acpi_prt_entry *entry;
 
@@ -299,8 +298,7 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
-static struct acpi_prt_entry *
-acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
+static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry;
 	struct pci_dev *bridge;
@@ -351,24 +349,17 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 	return NULL;
 }
 
-/*
- * acpi_pci_irq_enable
- * success: return 0
- * failure: return < 0
- */
-
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
 	struct acpi_prt_entry *entry;
-	int gsi = 0;
-	u8 pin = 0;
+	int gsi;
+	u8 pin;
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	int polarity = ACPI_ACTIVE_LOW;
 	char *link = NULL;
 	char link_desc[16];
 	int rc;
 
-
 	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -446,9 +437,8 @@ void __attribute__ ((weak)) acpi_unregister_gsi(u32 i)
 void acpi_pci_irq_disable(struct pci_dev *dev)
 {
 	struct acpi_prt_entry *entry;
-	int gsi = 0;
-	u8 pin = 0;
-
+	int gsi;
+	u8 pin;
 
 	pin = dev->pin;
 	if (!pin)
-- 
1.5.6.6

