From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] eeepc-laptop: Prevent a panic when disabling RT2860
 wireless when associated
Date: Thu, 15 Oct 2009 00:59:41 -0400
Message-ID: <b56ab33d68638e6aafdbfc694025e8354a628f49.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:33491 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZJOFAp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:45 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ00HOCHVTKHQJ@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:54 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Darren Salt <linux@youmustbejoking.demon.co.uk>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 789d6ae..d379e74 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -150,6 +150,8 @@ struct eeepc_hotk {
 /* The actual device the driver binds to */
 static struct eeepc_hotk *ehotk;
 
+static void eeepc_rfkill_hotplug(bool real);
+
 /* Platform device/driver */
 static int eeepc_hotk_thaw(struct device *device);
 static int eeepc_hotk_restore(struct device *device);
@@ -343,7 +345,16 @@ static bool eeepc_wlan_rfkill_blocked(void)
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
@@ -643,13 +654,13 @@ static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
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
@@ -692,7 +703,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	if (event != ACPI_NOTIFY_BUS_CHECK)
 		return;
 
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(true);
 }
 
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
@@ -850,7 +861,7 @@ static int eeepc_hotk_restore(struct device *device)
 {
 	/* Refresh both wlan rfkill state and pci hotplug */
 	if (ehotk->wlan_rfkill)
-		eeepc_rfkill_hotplug();
+		eeepc_rfkill_hotplug(true);
 
 	if (ehotk->bluetooth_rfkill)
 		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
@@ -993,7 +1004,7 @@ static void eeepc_rfkill_exit(void)
 	 * Refresh pci hotplug in case the rfkill state was changed after
 	 * eeepc_unregister_rfkill_notifier()
 	 */
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(true);
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 
@@ -1109,7 +1120,7 @@ static int eeepc_rfkill_init(struct device *dev)
 	 * Refresh pci hotplug in case the rfkill state was changed during
 	 * setup.
 	 */
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(true);
 
 exit:
 	if (result && result != -ENODEV)
-- 
1.6.0.6

