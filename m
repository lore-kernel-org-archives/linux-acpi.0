From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] eeepc-laptop: disable pci hotplug code when all notifiers fail to load
Date: Sun, 13 Dec 2009 22:16:11 +0100
Message-ID: <1260738971-25456-1-git-send-email-corentincj@iksaif.net>
References: <20091207212848.GA9171@srcf.ucam.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:55306 "HELO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754155AbZLMUT5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Dec 2009 15:19:57 -0500
In-Reply-To: <20091207212848.GA9171@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Corentin Chary <corentincj@iksaif.net>

This is a short term workaround for Eeepc 1005HA.

refs: <http://bugzilla.kernel.org/show_bug.cgi?id=14570>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 356ca11..45c3f52 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -177,6 +177,7 @@ struct eeepc_laptop {
 
 	struct hotplug_slot *hotplug_slot;
 	struct mutex hotplug_lock;
+	bool hotplug_enabled;
 
 	struct led_classdev tpd_led;
 	int tpd_led_wk;
@@ -642,6 +643,7 @@ static int eeepc_register_rfkill_notifier(struct eeepc_laptop *eeepc,
 						     eeepc);
 		if (ACPI_FAILURE(status))
 			pr_warning("Failed to register notify on %s\n", node);
+		eeepc->hotplug_enabled = true;
 	} else
 		return -ENODEV;
 
@@ -845,7 +847,17 @@ static int eeepc_rfkill_init(struct eeepc_laptop *eeepc)
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_setup_pci_hotplug(eeepc);
+	/*
+	 * Register notifiers first, if they all fail, we won't enable
+	 * pci hotplug because it's probably not needed for this model
+	 * (eg: 1005HA)
+	 */
+	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P5");
+	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P7");
+
+	if (eeepc->hotplug_enabled)
+		result = eeepc_setup_pci_hotplug(eeepc);
 	/*
 	 * If we get -EBUSY then something else is handling the PCI hotplug -
 	 * don't fail in this case
@@ -853,9 +865,6 @@ static int eeepc_rfkill_init(struct eeepc_laptop *eeepc)
 	if (result == -EBUSY)
 		result = 0;
 
-	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P5");
-	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P7");
 	/*
 	 * Refresh pci hotplug in case the rfkill state was changed during
 	 * setup.
-- 
1.6.5.4

