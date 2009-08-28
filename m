From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 03/24] eeepc-laptop: fix pci hotplug race on load and unload
Date: Fri, 28 Aug 2009 14:56:34 +0200
Message-ID: <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.10]:55038 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbZH1NAm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:00:42 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2220.sfr.fr (SMTP Server) with ESMTP id A65977006DBC
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:00:41 +0200 (CEST)
In-Reply-To: <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Wifi rfkill state changes can race with pci hotplug cleanup.  A simple
fix is to refresh the hotplug state just before deregistering the pci
hotplug slot.

There is also potential for a hotplug notification to fire too early
during setup, while the structures it uses are still being initialised.
(This could only happen if the BIOS performs hotplug itself; a bug
triggered by removing the battery while hibernated).  Avoid this by
registering the notifier later.  The same refresh mechanism is used
to handle rfkill state changes which can now race with registration.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   77 ++++++++++++++++++++--------------
 1 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 1790103..8dd86f7 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -667,37 +667,37 @@ static void eeepc_rfkill_hotplug(void)
 	struct pci_bus *bus;
 	bool blocked = eeepc_wlan_rfkill_blocked();
 
-	rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
+	if (ehotk->wlan_rfkill)
+		rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 
 	mutex_lock(&ehotk->hotplug_lock);
 
-	if (ehotk->hotplug_slot == NULL)
-		goto out_unlock;
-
-	bus = pci_find_bus(0, 1);
-	if (!bus) {
-		pr_warning("Unable to find PCI bus 1?\n");
-		goto out_unlock;
-	}
-
-	if (!blocked) {
-		dev = pci_get_slot(bus, 0);
-		if (dev) {
-			/* Device already present */
-			pci_dev_put(dev);
+	if (ehotk->hotplug_slot) {
+		bus = pci_find_bus(0, 1);
+		if (!bus) {
+			pr_warning("Unable to find PCI bus 1?\n");
 			goto out_unlock;
 		}
-		dev = pci_scan_single_device(bus, 0);
-		if (dev) {
-			pci_bus_assign_resources(bus);
-			if (pci_bus_add_device(dev))
-				pr_err("Unable to hotplug wifi\n");
-		}
-	} else {
-		dev = pci_get_slot(bus, 0);
-		if (dev) {
-			pci_remove_bus_device(dev);
-			pci_dev_put(dev);
+
+		if (!blocked) {
+			dev = pci_get_slot(bus, 0);
+			if (dev) {
+				/* Device already present */
+				pci_dev_put(dev);
+				goto out_unlock;
+			}
+			dev = pci_scan_single_device(bus, 0);
+			if (dev) {
+				pci_bus_assign_resources(bus);
+				if (pci_bus_add_device(dev))
+					pr_err("Unable to hotplug wifi\n");
+			}
+		} else {
+			dev = pci_get_slot(bus, 0);
+			if (dev) {
+				pci_remove_bus_device(dev);
+				pci_dev_put(dev);
+			}
 		}
 	}
 
@@ -1029,14 +1029,22 @@ static void eeepc_rfkill_exit(void)
 {
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
-	if (ehotk->wlan_rfkill)
+	if (ehotk->wlan_rfkill) {
 		rfkill_unregister(ehotk->wlan_rfkill);
+		ehotk->wlan_rfkill = NULL;
+	}
+	/*
+	 * Refresh pci hotplug in case the rfkill state was changed after
+	 * eeepc_unregister_rfkill_notifier()
+	 */
+	eeepc_rfkill_hotplug();
+	if (ehotk->hotplug_slot)
+		pci_hp_deregister(ehotk->hotplug_slot);
+
 	if (ehotk->bluetooth_rfkill)
 		rfkill_unregister(ehotk->bluetooth_rfkill);
 	if (ehotk->wwan3g_rfkill)
 		rfkill_unregister(ehotk->wwan3g_rfkill);
-	if (ehotk->hotplug_slot)
-		pci_hp_deregister(ehotk->hotplug_slot);
 }
 
 static void eeepc_input_exit(void)
@@ -1104,9 +1112,6 @@ static int eeepc_rfkill_init(struct device *dev)
 
 	mutex_init(&ehotk->hotplug_lock);
 
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
-
 	result = eeepc_new_rfkill(&ehotk->wlan_rfkill,
 				  "eeepc-wlan", dev,
 				  RFKILL_TYPE_WLAN, CM_ASL_WLAN);
@@ -1136,6 +1141,14 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result == -EBUSY)
 		result = 0;
 
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
+	/*
+	 * Refresh pci hotplug in case the rfkill state was changed during
+	 * setup.
+	 */
+	eeepc_rfkill_hotplug();
+
 exit:
 	if (result && result != -ENODEV)
 		eeepc_rfkill_exit();
-- 
1.6.4


