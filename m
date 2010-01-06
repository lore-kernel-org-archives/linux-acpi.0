From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/5] eeepc-laptop: dmi blacklist to disable pci hotplug code
Date: Wed,  6 Jan 2010 22:07:38 +0100
Message-ID: <1262812061-4119-3-git-send-email-corentincj@iksaif.net>
References: <1262812061-4119-1-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:34101 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932787Ab0AFVHr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jan 2010 16:07:47 -0500
In-Reply-To: <1262812061-4119-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

This is a short term workaround for Eeepc 1005HA.

refs: <http://bugzilla.kernel.org/show_bug.cgi?id=14570>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index e954f2a..7fc944a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -161,6 +161,7 @@ struct eeepc_laptop {
 	u32 cm_supported;		/* the control methods supported
 					   by this BIOS */
 	bool cpufv_disabled;
+	bool hotplug_disabled;
 	u16 event_count[128];		/* count for each event */
 
 	struct platform_device *platform_device;
@@ -845,6 +846,9 @@ static int eeepc_rfkill_init(struct eeepc_laptop *eeepc)
 	if (result && result != -ENODEV)
 		goto exit;
 
+	if (eeepc->hotplug_disabled)
+		return 0;
+
 	result = eeepc_setup_pci_hotplug(eeepc);
 	/*
 	 * If we get -EBUSY then something else is handling the PCI hotplug -
@@ -1314,6 +1318,10 @@ static void eeepc_dmi_check(struct eeepc_laptop *eeepc)
 {
 	const char *model;
 
+	model = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (!model)
+		return;
+
 	/*
 	 * Blacklist for setting cpufv (cpu speed).
 	 *
@@ -1333,17 +1341,24 @@ static void eeepc_dmi_check(struct eeepc_laptop *eeepc)
 	 * substring matching.  We don't want to affect the "701SD"
 	 * and "701SDX" models, because they do support S.H.E.
 	 */
-
-	model = dmi_get_system_info(DMI_PRODUCT_NAME);
-	if (!model)
-		return;
-
 	if (strcmp(model, "701") == 0 || strcmp(model, "702") == 0) {
 		eeepc->cpufv_disabled = true;
 		pr_info("model %s does not officially support setting cpu "
 			"speed\n", model);
 		pr_info("cpufv disabled to avoid instability\n");
 	}
+
+	/*
+	 * Blacklist for wlan hotplug
+	 *
+	 * Eeepc 1005HA doesn't work like others models and don't need the
+	 * hotplug code. In fact, current hotplug code seems to unplug another
+	 * device...
+	 */
+	if (strcmp(model, "1005HA") == 0) {
+		eeepc->hotplug_disabled = true;
+		pr_info("wlan hotplug disabled\n");
+	}
 }
 
 static void cmsg_quirk(struct eeepc_laptop *eeepc, int cm, const char *name)
-- 
1.6.6

