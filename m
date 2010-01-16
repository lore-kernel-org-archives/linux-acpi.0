From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/16] eeepc-laptop: dmi blacklist to disable pci hotplug code
Date: Sat, 16 Jan 2010 02:33:02 -0500
Message-ID: <10ae4b5663ff3092553bfbd867e7bd474ce6c553.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:58800 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0APHeg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:36 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00L58X1LW0J1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:36 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

This is a short term workaround for Eeepc 1005HA.

refs: <http://bugzilla.kernel.org/show_bug.cgi?id=14570>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

