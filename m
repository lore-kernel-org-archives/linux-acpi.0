From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 14/15] eeepc-laptop: add rfkill support for the 3G modem in Eee PC 901 Go
Date: Tue, 16 Jun 2009 21:28:55 +0200
Message-ID: <1245180536-28009-15-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-8-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-9-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-10-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-11-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-12-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-13-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-14-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60981 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950AbZFPTb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:28 -0400
In-Reply-To: <1245180536-28009-14-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 789710a..deb103c 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -141,6 +141,7 @@ struct eeepc_hotk {
 	u16 *keycode_map;
 	struct rfkill *wlan_rfkill;
 	struct rfkill *bluetooth_rfkill;
+	struct rfkill *wwan3g_rfkill;
 	struct hotplug_slot *hotplug_slot;
 };
 
@@ -352,6 +353,23 @@ static int eeepc_bluetooth_rfkill_state(void *data, enum rfkill_state *state)
 	return 0;
 }
 
+static int eeepc_wwan3g_rfkill_set(void *data, enum rfkill_state state)
+{
+	if (state == RFKILL_STATE_SOFT_BLOCKED)
+		return set_acpi(CM_ASL_3G, 0);
+	else
+		return set_acpi(CM_ASL_3G, 1);
+}
+
+static int eeepc_wwan3g_rfkill_state(void *data, enum rfkill_state *state)
+{
+	if (get_acpi(CM_ASL_3G) == 1)
+		*state = RFKILL_STATE_UNBLOCKED;
+	else
+		*state = RFKILL_STATE_SOFT_BLOCKED;
+	return 0;
+}
+
 static void __init eeepc_enable_camera(void)
 {
 	/*
@@ -939,6 +957,8 @@ static void eeepc_rfkill_exit(void)
 		rfkill_unregister(ehotk->wlan_rfkill);
 	if (ehotk->bluetooth_rfkill)
 		rfkill_unregister(ehotk->bluetooth_rfkill);
+	if (ehotk->wwan3g_rfkill)
+		rfkill_unregister(ehotk->wwan3g_rfkill);
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 }
@@ -1036,6 +1056,15 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result && result != -ENODEV)
 		goto exit;
 
+	result = eeepc_new_rfkill(&ehotk->wwan3g_rfkill,
+				  "eeepc-wwan3g", dev,
+				  RFKILL_TYPE_WWAN, CM_ASL_3G,
+				  eeepc_wwan3g_rfkill_set,
+				  eeepc_wwan3g_rfkill_state);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
 	result = eeepc_setup_pci_hotplug();
 	/*
 	 * If we get -EBUSY then something else is handling the PCI hotplug -
-- 
1.6.3.1

