From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/94] ACPI: PCI: move struct acpi_prt_entry declaration out of
 public header file
Date: Fri, 09 Jan 2009 04:26:46 -0500
Message-ID: <f748bafa3ca1fb056e63afdeecacc1c68d8104df.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbZAIJ2R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:17 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD70042368L15D6@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:46 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The struct acpi_prt_entry is used only in pci_irq.c, so there's no
need for the declaration to be public.  This patch moves it into
pci_irq.c.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   16 ++++++++++++++++
 include/linux/acpi.h   |   16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 9302f4b..ea003ba 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -41,6 +41,22 @@
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
-- 
1.5.6.6

