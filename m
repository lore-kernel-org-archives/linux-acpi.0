From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 1/2] eeepc-laptop: fix rfkill memory leak on unload
Date: Wed, 19 Aug 2009 10:38:57 +0100
Message-ID: <4A8BC831.8050708@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:25819 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbZHSJjA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2009 05:39:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

rfkill_unregister() should always be followed by rfkill_destroy()

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 1c94860..36d613b 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -981,6 +981,7 @@ static void eeepc_rfkill_exit(void)
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
 	if (ehotk->wlan_rfkill) {
 		rfkill_unregister(ehotk->wlan_rfkill);
+		rfkill_destroy(ehotk->wlan_rfkill);
 		ehotk->wlan_rfkill = NULL;
 	}
 	/*
@@ -991,10 +992,14 @@ static void eeepc_rfkill_exit(void)
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
 
-	if (ehotk->bluetooth_rfkill)
+	if (ehotk->bluetooth_rfkill) {
 		rfkill_unregister(ehotk->bluetooth_rfkill);
-	if (ehotk->wwan3g_rfkill)
+		rfkill_destroy(ehotk->bluetooth_rfkill);
+	}
+	if (ehotk->wwan3g_rfkill) {
 		rfkill_unregister(ehotk->wwan3g_rfkill);
+		rfkill_destroy(ehotk->wwan3g_rfkill);
+	}
 }
 


