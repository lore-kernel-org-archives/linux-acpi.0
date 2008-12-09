From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 19/20] ACPI: PCI: whitespace and useless initialization cleanup
Date: Mon, 08 Dec 2008 21:31:37 -0700
Message-ID: <20081209043137.26415.41058.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:11350 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYLIEbh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:37 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch makes function declarations consistent throughout
the file and removes some unnecessary initializations.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 5a07d48..30aa0a0 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -151,8 +151,8 @@ static struct prt_quirk prt_quirks[] = {
 		"\\_SB_.PCI0.LNK3"},
 };
 
-static void
-do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
+static void do_prt_fixups(struct acpi_prt_entry *entry,
+			  struct acpi_pci_routing_table *prt)
 {
 	int i;
 	struct prt_quirk *quirk;
@@ -182,9 +182,8 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
 	}
 }
 
-static int
-acpi_pci_irq_add_entry(acpi_handle handle,
-		       int segment, int bus, struct acpi_pci_routing_table *prt)
+static int acpi_pci_irq_add_entry(acpi_handle handle, int segment, int bus,
+				  struct acpi_pci_routing_table *prt)
 {
 	struct acpi_prt_entry *entry;
 
@@ -301,8 +300,7 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
-static struct acpi_prt_entry *
-acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
+static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry;
 	struct pci_dev *bridge;
@@ -353,24 +351,17 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
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
@@ -448,9 +439,8 @@ void __attribute__ ((weak)) acpi_unregister_gsi(u32 i)
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

