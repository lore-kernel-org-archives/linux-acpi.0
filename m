From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH  8/16][BUG] PCI slot: Fix invalid memory access (Not for mainline!)
Date: Fri, 21 Mar 2008 13:15:45 +0900
Message-ID: <47E33671.1000107@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:45207 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYCUEUJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:20:09 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Fix kernel oops in pci_release_slot() when dbg() is enabled.

The dbg() in pci_release_slot() cause a kernel oops (invalid memory
access) because it accesses slot after it is released. We need to
access slot before calling kobject_put().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/slot.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.25-rc6/drivers/pci/slot.c
===================================================================
--- linux-2.6.25-rc6.orig/drivers/pci/slot.c
+++ linux-2.6.25-rc6/drivers/pci/slot.c
@@ -191,13 +191,14 @@ EXPORT_SYMBOL_GPL(pci_create_slot);
 
 int pci_destroy_slot(struct pci_slot *slot)
 {
+	dbg("%s: decreased refcount to %d on %x:%d\n", __func__,
+	    atomic_read(&slot->kobj.kref.refcount) - 1, slot->bus->number,
+	    slot->number);
+
 	down_write(&pci_bus_sem);
 	kobject_put(&slot->kobj);
 	up_write(&pci_bus_sem);
 
-	dbg("%s: decreased refcount to %d on %x:%d\n", __func__,
-	    atomic_read(&slot->kobj.kref.refcount), slot->bus->number,
-	    slot->number);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_destroy_slot);


