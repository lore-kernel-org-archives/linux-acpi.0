From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH -mm] acpi: use list.h API for sub_driver list
Date: Sun, 29 Oct 2006 22:40:03 +0900
Message-ID: <20061029134003.GC10295@localhost>
References: <20061028185313.GK9973@localhost> <20061028190254.GA7070@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:38771 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965230AbWJ2Njk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Oct 2006 08:39:40 -0500
Received: by nf-out-0910.google.com with SMTP id c2so1881770nfe
        for <linux-acpi@vger.kernel.org>; Sun, 29 Oct 2006 05:39:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061028190254.GA7070@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sat, Oct 28, 2006 at 08:02:54PM +0100, Christoph Hellwig wrote:
> Any chance to just switch the driver to use the list.h APIs instead
> of opencoding lists?

Subject: [PATCH -mm] acpi: use list.h API for sub_driver list

Use the list.h APIs instead of opencoding lists.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: work-fault-inject/drivers/acpi/pci_root.c
===================================================================
--- work-fault-inject.orig/drivers/acpi/pci_root.c
+++ work-fault-inject/drivers/acpi/pci_root.c
@@ -65,17 +65,14 @@ struct acpi_pci_root {
 
 static LIST_HEAD(acpi_pci_roots);
 
-static struct acpi_pci_driver *sub_driver;
+static LIST_HEAD(sub_driver);
 
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
 {
 	int n = 0;
 	struct list_head *entry;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr)
-		pptr = &(*pptr)->next;
-	*pptr = driver;
+	list_add_tail(&driver->list, &sub_driver);
 
 	if (!driver->add)
 		return 0;
@@ -96,14 +93,7 @@ void acpi_pci_unregister_driver(struct a
 {
 	struct list_head *entry;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr) {
-		if (*pptr == driver)
-			break;
-		pptr = &(*pptr)->next;
-	}
-	BUG_ON(!*pptr);
-	*pptr = (*pptr)->next;
+	list_del(&driver->list);
 
 	if (!driver->remove)
 		return;
Index: work-fault-inject/include/linux/acpi.h
===================================================================
--- work-fault-inject.orig/include/linux/acpi.h
+++ work-fault-inject/include/linux/acpi.h
@@ -480,7 +480,7 @@ void acpi_penalize_isa_irq(int irq, int 
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
-	struct acpi_pci_driver *next;
+	struct list_head list;
 	int (*add)(acpi_handle handle);
 	void (*remove)(acpi_handle handle);
 };
