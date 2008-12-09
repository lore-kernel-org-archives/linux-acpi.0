From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 06/20] ACPI: PCI: move struct acpi_prt_entry declaration out
	of public header file
Date: Mon, 08 Dec 2008 21:30:31 -0700
Message-ID: <20081209043031.26415.63894.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:13898 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYLIEab (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:31 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The struct acpi_prt_entry is used only in pci_irq.c, so there's no
need for the declaration to be public.  This patch moves it into
pci_irq.c.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   16 ++++++++++++++++
 include/linux/acpi.h   |   16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index f80b8a2..04b9df4 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -43,6 +43,22 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_irq");
 
+struct acpi_prt_entry {
+	struct list_head	node;
+	struct acpi_pci_id	id;
+	u8			pin;
+	struct {
+		acpi_handle		handle;
+		u32			index;
+	}			link;
+	u32			irq;
+};
+
+struct acpi_prt_list {
+	int			count;
+	struct list_head	entries;
+};
+
 static struct acpi_prt_list acpi_prt;
 static DEFINE_SPINLOCK(acpi_prt_lock);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fba8051..813f937 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -131,22 +131,6 @@ extern int acpi_get_override_irq(int bus_irq, int *trigger, int *polarity);
  */
 void acpi_unregister_gsi (u32 gsi);
 
-struct acpi_prt_entry {
-	struct list_head	node;
-	struct acpi_pci_id	id;
-	u8			pin;
-	struct {
-		acpi_handle		handle;
-		u32			index;
-	}			link;
-	u32			irq;
-};
-
-struct acpi_prt_list {
-	int			count;
-	struct list_head	entries;
-};
-
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);

