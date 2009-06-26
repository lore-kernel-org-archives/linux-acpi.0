From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/8] eeepc-laptop: add rfkill support for the 3G modem in Eee
 PC 901 Go
Date: Fri, 26 Jun 2009 00:20:19 -0400
Message-ID: <d58f1edaa9474692e22248a35ceb9b3515fbfc3a.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:39136 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZFZEVD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:21:03 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT00EFKW2C5QA4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:37 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Janne Grunau <j@jannau.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

