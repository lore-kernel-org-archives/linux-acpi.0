From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 15/16] PCI slot: Trivial cleanups for slot.c (Not for mainline!)
Date: Fri, 21 Mar 2008 13:26:50 +0900
Message-ID: <47E3390A.7030308@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39666 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYCUE2k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:28:40 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Some trivial cleanups for drivers/pci/slot.c.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/slot.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6.25-rc6/drivers/pci/slot.c
===================================================================
--- linux-2.6.25-rc6.orig/drivers/pci/slot.c
+++ linux-2.6.25-rc6/drivers/pci/slot.c
@@ -132,19 +132,16 @@ EXPORT_SYMBOL_GPL(pci_destroy_slot);
 
 static int pci_slot_init(void)
 {
-	int result = 0;
 	struct kset *pci_bus_kset;
 
 	pci_bus_kset = bus_get_kset(&pci_bus_type);
-
 	pci_slots_kset = kset_create_and_add("slots", NULL,
 						&pci_bus_kset->kobj);
 	if (!pci_slots_kset) {
-		result = -ENOMEM;
-		printk(KERN_ERR "PCI: Slot initialization failure (%d)\n",
-			result);
+		printk(KERN_ERR "PCI: Slot initialization failure\n");
+		return -ENOMEM;
 	}
-	return result;
+	return 0;
 }
 
 subsys_initcall(pci_slot_init);


