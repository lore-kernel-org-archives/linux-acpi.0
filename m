From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] eeepc-laptop: Work around rfkill firmware bug
Date: Wed, 08 Apr 2009 14:27:23 +0100
Message-ID: <49DCA63B.5050802@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:36891 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbZDHN12 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 09:27:28 -0400
Received: by fg-out-1718.google.com with SMTP id e12so41944fga.17
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2009 06:27:26 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

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
---
 drivers/platform/x86/eeepc-laptop.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index e21f7cd..f725eaf 100644
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
@@ -521,6 +522,7 @@ static void notify_brn(void)
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
+	enum rfkill_state state;
 	struct pci_dev *dev;
 	struct pci_bus *bus = pci_find_bus(0, 1);
 
@@ -532,7 +534,9 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		return;
 	}
 
-	if (get_acpi(CM_ASL_WLAN) == 1) {
+	eeepc_wlan_rfkill_state(ehotk->eeepc_wlan_rfkill, &state);
+
+	if (state == RFKILL_STATE_UNBLOCKED) {
 		dev = pci_get_slot(bus, 0);
 		if (dev) {
 			/* Device already present */
@@ -552,6 +556,8 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 			pci_dev_put(dev);
 		}
 	}
+
+	rfkill_force_state(ehotk->eeepc_wlan_rfkill, state);
 }
 
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
-- 
1.5.4.3

