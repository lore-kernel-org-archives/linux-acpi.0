From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 2/4] ACPI: make acpi_pci_irq_find_prt_entry return a copy of a prt_entry
Date: Thu, 18 Nov 2010 08:52:18 -0500
Message-ID: <20101118135227.2269.72184.sendpatchset@localhost6.localdomain6>
References: <20101118135207.2269.2593.sendpatchset@localhost6.localdomain6>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101118135207.2269.2593.sendpatchset@localhost6.localdomain6>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: JBeulich@novell.com, bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, lenb@kernel.org, tglx@linutronix.de, Olaf.Dabrunz@gmx.net
List-Id: linux-acpi@vger.kernel.org

From: Stefan Assmann <sassmann@redhat.com>

By returning a pointer to a copy of struct acpi_prt_entry in
acpi_pci_irq_find_prt_entry() the calling code may modify the returned
structure without altering entries in the global acpi_prt_list. Thus the
changes to acpi_prt_entry by the boot interrupt reroute code won't change the
original PRT entries.
Currently there are only two calls for acpi_pci_irq_find_prt_entry() and both
are in acpi_pci_irq_lookup(). acpi_pci_irq_lookup() itself is used only by
acpi_pci_irq_enable() and acpi_pci_irq_disable() so both are also updated to
free the copy of struct acpi_prt_entry appropriately.

Signed-off-by: Stefan Assmann <sassmann@redhat.com>
---
 drivers/acpi/pci_irq.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 3bc2164..02202a2 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -60,7 +60,7 @@ static inline char pin_name(int pin)
 static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 							  int pin)
 {
-	struct acpi_prt_entry *entry;
+	struct acpi_prt_entry *entry, *entry_copy;
 	int segment = pci_domain_nr(dev->bus);
 	int bus = dev->bus->number;
 	int device = PCI_SLOT(dev->devfn);
@@ -72,7 +72,11 @@ static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 		    && (device == entry->id.device)
 		    && (pin == entry->pin)) {
 			spin_unlock(&acpi_prt_lock);
-			return entry;
+			entry_copy = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
+			if (!entry_copy)
+				return NULL;
+			memcpy(entry_copy, entry, sizeof(struct acpi_prt_entry));
+			return entry_copy;
 		}
 	}
 	spin_unlock(&acpi_prt_lock);
@@ -384,6 +388,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 							 &link);
 		else
 			gsi = entry->index;
+		kfree(entry);
 	} else
 		gsi = -1;
 
@@ -453,6 +458,8 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	else
 		gsi = entry->index;
 
+	if (entry)
+		kfree(entry);
 	/*
 	 * TBD: It might be worth clearing dev->irq by magic constant
 	 * (e.g. PCI_UNDEFINED_IRQ).
-- 
1.7.1
