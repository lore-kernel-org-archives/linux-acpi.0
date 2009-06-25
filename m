From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 7/7] eeepc-laptop: add rfkill support for the 3G modem in Eee PC 901 Go
Date: Thu, 25 Jun 2009 13:25:42 +0200
Message-ID: <1245929142-3354-7-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906240136300.32742@localhost.localdomain>
 <1245929142-3354-1-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-2-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-3-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-4-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-5-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-6-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:54905 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbZFYLXD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jun 2009 07:23:03 -0400
In-Reply-To: <1245929142-3354-6-git-send-email-corentincj@iksaif.net>
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
index f5d8473..ec560f1 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -141,6 +141,7 @@ struct eeepc_hotk {
 	u16 *keycode_map;
 	struct rfkill *wlan_rfkill;
 	struct rfkill *bluetooth_rfkill;
+	struct rfkill *wwan3g_rfkill;
 	struct hotplug_slot *hotplug_slot;
 };
 
@@ -1023,6 +1024,8 @@ static void eeepc_rfkill_exit(void)
 		rfkill_unregister(ehotk->wlan_rfkill);
 	if (ehotk->bluetooth_rfkill)
 		rfkill_unregister(ehotk->bluetooth_rfkill);
+	if (ehotk->wwan3g_rfkill)
+		rfkill_unregister(ehotk->wwan3g_rfkill);
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 }
@@ -1107,6 +1110,13 @@ static int eeepc_rfkill_init(struct device *dev)
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
1.6.3.3

