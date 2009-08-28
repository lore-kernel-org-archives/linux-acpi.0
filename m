From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 02/24] eeepc-laptop: use a mutex to serialize pci hotplug (resume vs. notify)
Date: Fri, 28 Aug 2009 14:56:33 +0200
Message-ID: <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:51647 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZH1NAk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:00:40 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id A2D287006127
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:00:41 +0200 (CEST)
In-Reply-To: <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Commit d0265f0 "eeepc-laptop: fix hot-unplug on resume" used a workqueue
to protect pci hotplug against multiple simultaneous calls during
resume.  It seems to work, but a mutex would be more appropriate.

This is in preparation to fix the potential pci hotplug race on unload.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 69d73ed..1790103 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -143,7 +143,7 @@ struct eeepc_hotk {
 	struct rfkill *bluetooth_rfkill;
 	struct rfkill *wwan3g_rfkill;
 	struct hotplug_slot *hotplug_slot;
-	struct work_struct hotplug_work;
+	struct mutex hotplug_lock;
 };
 
 /* The actual device the driver binds to */
@@ -661,7 +661,7 @@ static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
 	return 0;
 }
 
-static void eeepc_hotplug_work(struct work_struct *work)
+static void eeepc_rfkill_hotplug(void)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -669,13 +669,15 @@ static void eeepc_hotplug_work(struct work_struct *work)
 
 	rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 
+	mutex_lock(&ehotk->hotplug_lock);
+
 	if (ehotk->hotplug_slot == NULL)
-		return;
+		goto out_unlock;
 
 	bus = pci_find_bus(0, 1);
 	if (!bus) {
 		pr_warning("Unable to find PCI bus 1?\n");
-		return;
+		goto out_unlock;
 	}
 
 	if (!blocked) {
@@ -683,7 +685,7 @@ static void eeepc_hotplug_work(struct work_struct *work)
 		if (dev) {
 			/* Device already present */
 			pci_dev_put(dev);
-			return;
+			goto out_unlock;
 		}
 		dev = pci_scan_single_device(bus, 0);
 		if (dev) {
@@ -698,6 +700,9 @@ static void eeepc_hotplug_work(struct work_struct *work)
 			pci_dev_put(dev);
 		}
 	}
+
+out_unlock:
+	mutex_unlock(&ehotk->hotplug_lock);
 }
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
@@ -705,7 +710,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	if (event != ACPI_NOTIFY_BUS_CHECK)
 		return;
 
-	schedule_work(&ehotk->hotplug_work);
+	eeepc_rfkill_hotplug();
 }
 
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
@@ -896,7 +901,7 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 
 		rfkill_set_sw_state(ehotk->wlan_rfkill, wlan != 1);
 
-		schedule_work(&ehotk->hotplug_work);
+		eeepc_rfkill_hotplug();
 	}
 
 	if (ehotk->bluetooth_rfkill)
@@ -1097,7 +1102,7 @@ static int eeepc_rfkill_init(struct device *dev)
 {
 	int result = 0;
 
-	INIT_WORK(&ehotk->hotplug_work, eeepc_hotplug_work);
+	mutex_init(&ehotk->hotplug_lock);
 
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
-- 
1.6.4


