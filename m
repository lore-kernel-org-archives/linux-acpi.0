From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH  4/16][BUG] PCI slot: Add missing semaphore for slot release
 (Not for mainline!)
Date: Fri, 21 Mar 2008 13:12:27 +0900
Message-ID: <47E335AB.6020709@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35429 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYCUEN4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:13:56 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Add missing pci_bus sem into pci_destroy_slot(). There is possible
race condition because current code doesn't have any serialization
in the destroy path.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/slot.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.25-rc6/drivers/pci/slot.c
===================================================================
--- linux-2.6.25-rc6.orig/drivers/pci/slot.c
+++ linux-2.6.25-rc6/drivers/pci/slot.c
@@ -196,7 +196,9 @@ EXPORT_SYMBOL_GPL(pci_create_slot);
 
 int pci_destroy_slot(struct pci_slot *slot)
 {
+	down_write(&pci_bus_sem);
 	kobject_put(&slot->kobj);
+	up_write(&pci_bus_sem);
 
 	dbg("%s: decreased refcount to %d on %x:%d\n", __func__,
 		slot->kobj.kref.refcount, slot->bus->number, slot->number);


