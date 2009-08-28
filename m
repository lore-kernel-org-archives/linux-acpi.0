From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 01/24] eeepc-laptop: don't touch the pci slot if it was claimed by a different driver
Date: Fri, 28 Aug 2009 14:56:32 +0200
Message-ID: <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.13]:35687 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZH1NJF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:09:05 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2215.sfr.fr (SMTP Server) with ESMTP id 402E9700689E
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:00:41 +0200 (CEST)
In-Reply-To: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The whole point of registering as a PCI hotplug driver was to prevent
conflict with pciehp.  At the moment it happens to work because
eeepc-laptop is loaded first, but it doesn't work the other way round.
If pciehp is loaded first then we fail to claim the slot - we need to
respect this and not handle hotplug events.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 222ffb8..69d73ed 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -664,15 +664,20 @@ static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
 static void eeepc_hotplug_work(struct work_struct *work)
 {
 	struct pci_dev *dev;
-	struct pci_bus *bus = pci_find_bus(0, 1);
-	bool blocked;
+	struct pci_bus *bus;
+	bool blocked = eeepc_wlan_rfkill_blocked();
+
+	rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 
+	if (ehotk->hotplug_slot == NULL)
+		return;
+
+	bus = pci_find_bus(0, 1);
 	if (!bus) {
 		pr_warning("Unable to find PCI bus 1?\n");
 		return;
 	}
 
-	blocked = eeepc_wlan_rfkill_blocked();
 	if (!blocked) {
 		dev = pci_get_slot(bus, 0);
 		if (dev) {
@@ -693,8 +698,6 @@ static void eeepc_hotplug_work(struct work_struct *work)
 			pci_dev_put(dev);
 		}
 	}
-
-	rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 }
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
-- 
1.6.4


