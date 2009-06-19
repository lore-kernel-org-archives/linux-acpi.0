From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 8/9] eeepc-laptop: add rfkill support for the 3G modem in Eee PC 901 Go
Date: Fri, 19 Jun 2009 14:52:10 +0200
Message-ID: <1245415931-26466-8-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-2-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-3-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-4-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-5-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-6-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-7-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23100 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811AbZFSMyn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:43 -0400
In-Reply-To: <1245415931-26466-7-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, Janne Grunau <j@jannau.net>

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 4d55c17..67ad360 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -141,6 +141,7 @@ struct eeepc_hotk {
 	u16 *keycode_map;
 	struct rfkill *wlan_rfkill;
 	struct rfkill *bluetooth_rfkill;
+	struct rfkill *wwan3g_rfkill;
 	struct hotplug_slot *hotplug_slot;
 };
 
@@ -990,6 +991,8 @@ static void eeepc_rfkill_exit(void)
 		rfkill_unregister(ehotk->wlan_rfkill);
 	if (ehotk->bluetooth_rfkill)
 		rfkill_unregister(ehotk->bluetooth_rfkill);
+	if (ehotk->wwan3g_rfkill)
+		rfkill_unregister(ehotk->wwan3g_rfkill);
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 }
@@ -1074,6 +1077,13 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result && result != -ENODEV)
 		goto exit;
 
+	result = eeepc_new_rfkill(&ehotk->wwan3g_rfkill,
+				  "eeepc-wwan3g", dev,
+				  RFKILL_TYPE_WWAN, CM_ASL_3G);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
 	result = eeepc_setup_pci_hotplug();
 	/*
 	 * If we get -EBUSY then something else is handling the PCI hotplug -
-- 
1.6.3.1


