From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 10/24] eeepc-laptop: add rfkill support for the Wimax in ASUS Eee PC 1000HG
Date: Fri, 28 Aug 2009 14:56:41 +0200
Message-ID: <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61309 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id EFFEB70021F5
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:42 +0200 (CEST)
In-Reply-To: <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 1c94860..c9febf4 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -142,6 +142,7 @@ struct eeepc_hotk {
 	struct rfkill *wlan_rfkill;
 	struct rfkill *bluetooth_rfkill;
 	struct rfkill *wwan3g_rfkill;
+	struct rfkill *wimax_rfkill;
 	struct hotplug_slot *hotplug_slot;
 	struct mutex hotplug_lock;
 };
@@ -857,6 +858,9 @@ static int eeepc_hotk_restore(struct device *device)
 	if (ehotk->wwan3g_rfkill)
 		rfkill_set_sw_state(ehotk->wwan3g_rfkill,
 				    get_acpi(CM_ASL_3G) != 1);
+	if (ehotk->wimax_rfkill)
+		rfkill_set_sw_state(ehotk->wimax_rfkill,
+				    get_acpi(CM_ASL_WIMAX) != 1);
 
 	return 0;
 }
@@ -995,6 +999,8 @@ static void eeepc_rfkill_exit(void)
 		rfkill_unregister(ehotk->bluetooth_rfkill);
 	if (ehotk->wwan3g_rfkill)
 		rfkill_unregister(ehotk->wwan3g_rfkill);
+	if (ehotk->wimax_rfkill)
+		rfkill_unregister(ehotk->wimax_rfkill);
 }
 
 static void eeepc_input_exit(void)
@@ -1070,6 +1076,13 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result && result != -ENODEV)
 		goto exit;
 
+	result = eeepc_new_rfkill(&ehotk->wimax_rfkill,
+				  "eeepc-wimax", dev,
+				  RFKILL_TYPE_WIMAX, CM_ASL_WIMAX);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
 	result = eeepc_setup_pci_hotplug();
 	/*
 	 * If we get -EBUSY then something else is handling the PCI hotplug -
-- 
1.6.4


