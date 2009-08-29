From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/3] eeepc-laptop: fix rfkill memory leak on unload
Date: Sat, 29 Aug 2009 10:28:30 +0200
Message-ID: <1251534511-8479-2-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
 <1251534511-8479-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.20]:59672 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZH2I3d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 04:29:33 -0400
In-Reply-To: <1251534511-8479-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

rfkill_unregister() should always be followed by rfkill_destroy()

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 819c685..6f9a448 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -985,6 +985,7 @@ static void eeepc_rfkill_exit(void)
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
 	if (ehotk->wlan_rfkill) {
 		rfkill_unregister(ehotk->wlan_rfkill);
+		rfkill_destroy(ehotk->wlan_rfkill);
 		ehotk->wlan_rfkill = NULL;
 	}
 	/*
@@ -995,12 +996,21 @@ static void eeepc_rfkill_exit(void)
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 
-	if (ehotk->bluetooth_rfkill)
+	if (ehotk->bluetooth_rfkill) {
 		rfkill_unregister(ehotk->bluetooth_rfkill);
-	if (ehotk->wwan3g_rfkill)
+		rfkill_destroy(ehotk->bluetooth_rfkill);
+		ehotk->bluetooth_rfkill = NULL;
+	}
+	if (ehotk->wwan3g_rfkill) {
 		rfkill_unregister(ehotk->wwan3g_rfkill);
-	if (ehotk->wimax_rfkill)
+		rfkill_destroy(ehotk->wwan3g_rfkill);
+		ehotk->wwan3g_rfkill = NULL;
+	}
+	if (ehotk->wimax_rfkill) {
 		rfkill_unregister(ehotk->wimax_rfkill);
+		rfkill_destroy(ehotk->wimax_rfkill);
+		ehotk->wimax_rfkill = NULL;
+	}
 }
 
 static void eeepc_input_exit(void)
-- 
1.6.4.1


