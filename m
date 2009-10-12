From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/2] eeepc-laptop: Prevent a panic when disabling RT2860 wireless when associated
Date: Tue, 13 Oct 2009 00:13:33 +0200
Message-ID: <1255385613-25400-3-git-send-email-corentincj@iksaif.net>
References: <1255385613-25400-1-git-send-email-corentincj@iksaif.net>
 <1255385613-25400-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:54317 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756646AbZJLWNM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Oct 2009 18:13:12 -0400
In-Reply-To: <1255385613-25400-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Darren Salt <linux@youmustbejoking.demon.co.uk>

From: Darren Salt <linux@youmustbejoking.demon.co.uk>

This works around what I think is actually a bug in rt2860sta which is
triggered when the hardware "disappears" from beneath the driver, i.e. when
wireless is toggled off via ACPI. It does so by ensuring that the rfkill
soft-block flag is set before the hardware is disabled.

I do not know whether this patch is required if rt2800pci is in use instead
of rt2860sta; at the time of submission of this patch, I've not been able to
test this.

(Ref. http://bugzilla.kernel.org/show_bug.cgi?id=13390)

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 879b2e9..477d8c1 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -151,6 +151,8 @@ struct eeepc_hotk {
 /* The actual device the driver binds to */
 static struct eeepc_hotk *ehotk;
 
+static void eeepc_rfkill_hotplug(bool real);
+
 /* Platform device/driver */
 static int eeepc_hotk_thaw(struct device *device);
 static int eeepc_hotk_restore(struct device *device);
@@ -344,7 +346,16 @@ static bool eeepc_wlan_rfkill_blocked(void)
 static int eeepc_rfkill_set(void *data, bool blocked)
 {
 	unsigned long asl = (unsigned long)data;
-	return set_acpi(asl, !blocked);
+	int ret;
+
+	if (asl != CM_ASL_WLAN)
+		return set_acpi(asl, !blocked);
+
+	/* hack to avoid panic with rt2860sta */
+	if (blocked)
+		eeepc_rfkill_hotplug(false);
+	ret = set_acpi(asl, !blocked);
+	return ret;
 }
 
 static const struct rfkill_ops eeepc_rfkill_ops = {
@@ -677,13 +688,13 @@ static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
 	return 0;
 }
 
-static void eeepc_rfkill_hotplug(void)
+static void eeepc_rfkill_hotplug(bool real)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
-	bool blocked = eeepc_wlan_rfkill_blocked();
+	bool blocked = real ? eeepc_wlan_rfkill_blocked() : true;
 
-	if (ehotk->wlan_rfkill)
+	if (real && ehotk->wlan_rfkill)
 		rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 
 	mutex_lock(&ehotk->hotplug_lock);
@@ -726,7 +737,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	if (event != ACPI_NOTIFY_BUS_CHECK)
 		return;
 
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(true);
 }
 
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
@@ -884,7 +895,7 @@ static int eeepc_hotk_restore(struct device *device)
 {
 	/* Refresh both wlan rfkill state and pci hotplug */
 	if (ehotk->wlan_rfkill)
-		eeepc_rfkill_hotplug();
+		eeepc_rfkill_hotplug(true);
 
 	if (ehotk->bluetooth_rfkill)
 		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
@@ -1027,7 +1038,7 @@ static void eeepc_rfkill_exit(void)
 	 * Refresh pci hotplug in case the rfkill state was changed after
 	 * eeepc_unregister_rfkill_notifier()
 	 */
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(true);
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 
@@ -1151,7 +1162,7 @@ static int eeepc_rfkill_init(struct device *dev)
 	 * Refresh pci hotplug in case the rfkill state was changed during
 	 * setup.
 	 */
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(true);
 
 exit:
 	if (result && result != -ENODEV)
-- 
1.6.5.rc2

