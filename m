From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 2/8] eeepc-laptop: fix pci hotplug race on load and unload
Date: Sun, 02 Aug 2009 16:55:39 +0100
Message-ID: <4A75B6FB.8030503@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:14002 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZHBPzl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:55:41 -0400
Received: by ey-out-2122.google.com with SMTP id 9so821482eyd.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:55:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

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
1.6.3.2

