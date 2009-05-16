From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/19] eeepc-laptop: Work around rfkill firmware bug
Date: Sat, 16 May 2009 02:02:05 -0400
Message-ID: <978605c4fd8e7470f225eec7b5aab69d8796afcc.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:28805 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbZEPGCW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:22 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00II23FZMX27@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:24 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

1) Buggy firmware can change the RFKILL state by itself. This is easily
   detected.  The RFKILL API states that in such cases, we should call
   rfkill_force_state() to notify the core.

   I have reported the bug to Asus. I believe this is the right thing
   to do for robustness, even if this particular firmware bug is fixed.

2) The same bug causes the wireless toggle key to be reported as 0x11
   instead of 0x10.  0x11 is otherwise unused, so it should be safe to
   add this as a new keycode.

The bug is triggered by removing the laptop battery while hibernated.

On resume, the wireless toggle key causes the firmware to toggle the
wireless state itself.  (Also, the key is reported as 0x11 when the
current wireless state is OFF).

This is very poor behaviour because the OS can't predict whether the
firmware is controlling the RFKILL state.

Without this workaround, the bug means users have to press the wireless
toggle key twice to enable, due to the OS/firmware conflict.  (Assuming
rfkill-input or equivalent is being used).  The workaround avoids this.

I believe that acpid scripts which toggle the value of the sysfs state file
when the toggle key is pressed will be rendered ineffective by the bug,
regardless of this workaround.  If they simply toggle the state, when the
firmware has already toggled it, then you will never see a state change.

Tested on "EEEPC 4G" only.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index f54cfea..57f21f0 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -158,6 +158,7 @@ enum { KE_KEY, KE_END };
 static struct key_entry eeepc_keymap[] = {
 	/* Sleep already handled via generic ACPI code */
 	{KE_KEY, 0x10, KEY_WLAN },
+	{KE_KEY, 0x11, KEY_WLAN },
 	{KE_KEY, 0x12, KEY_PROG1 },
 	{KE_KEY, 0x13, KEY_MUTE },
 	{KE_KEY, 0x14, KEY_VOLUMEDOWN },
@@ -528,6 +529,7 @@ static int notify_brn(void)
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
+	enum rfkill_state state;
 	struct pci_dev *dev;
 	struct pci_bus *bus = pci_find_bus(0, 1);
 
@@ -539,7 +541,9 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		return;
 	}
 
-	if (get_acpi(CM_ASL_WLAN) == 1) {
+	eeepc_wlan_rfkill_state(ehotk->eeepc_wlan_rfkill, &state);
+
+	if (state == RFKILL_STATE_UNBLOCKED) {
 		dev = pci_get_slot(bus, 0);
 		if (dev) {
 			/* Device already present */
@@ -559,6 +563,8 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 			pci_dev_put(dev);
 		}
 	}
+
+	rfkill_force_state(ehotk->eeepc_wlan_rfkill, state);
 }
 
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
-- 
1.6.0.6

