From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH  7/16][BUG] PCI slot: Remove compiler warnings (Not for mainline!)
Date: Fri, 21 Mar 2008 13:14:45 +0900
Message-ID: <47E33635.5080908@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39056 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbYCUEQK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:16:10 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Remove following compiler warnings.

drivers/pci/slot.c: In function 'pci_create_slot':
drivers/pci/slot.c:146: warning: format '%d' expects type 'int', but argument 4 has type 'atomic_t'
drivers/pci/slot.c: In function 'pci_destroy_slot':
drivers/pci/slot.c:198: warning: format '%d' expects type 'int', but argument 4 has type 'atomic_t'

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/slot.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.25-rc6/drivers/pci/slot.c
===================================================================
--- linux-2.6.25-rc6.orig/drivers/pci/slot.c
+++ linux-2.6.25-rc6/drivers/pci/slot.c
@@ -142,8 +142,8 @@ struct pci_slot *pci_create_slot(struct 
 		if (slot->number == slot_nr) {
 			kobject_get(&slot->kobj);
 			dbg("%s: bumped refcount to %d on %x:%d\n",
-				__func__, slot->kobj.kref.refcount,
-				parent->number, slot_nr);
+			    __func__, atomic_read(&slot->kobj.kref.refcount),
+			    parent->number, slot_nr);
 			goto out;
 		}
 	}
@@ -196,7 +196,8 @@ int pci_destroy_slot(struct pci_slot *sl
 	up_write(&pci_bus_sem);
 
 	dbg("%s: decreased refcount to %d on %x:%d\n", __func__,
-		slot->kobj.kref.refcount, slot->bus->number, slot->number);
+	    atomic_read(&slot->kobj.kref.refcount), slot->bus->number,
+	    slot->number);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_destroy_slot);


