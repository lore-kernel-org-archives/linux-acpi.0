From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/98] hp-wmi: notify of a potential docking state change on
 resume
Date: Sat, 28 Mar 2009 00:30:40 -0400
Message-ID: <4c395bdd3f2ca8f7e8efad881e16071182c3b8ca.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZC1Eck (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LR88LZZ0PR@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:25 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Frans Pop <elendil@planet.nl>

It is possible that the system gets docked or undocked while it's
suspended. Generate an input event on resume to notify user space
if there was a state change.

As it is a switch, we can generate the event unconditionally; the
input layer will only pass it on if there is an actual change.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/hp-wmi.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index f41135f..50d9019 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -53,6 +53,7 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
 
 static int __init hp_wmi_bios_setup(struct platform_device *device);
 static int __exit hp_wmi_bios_remove(struct platform_device *device);
+static int hp_wmi_resume_handler(struct platform_device *device);
 
 struct bios_args {
 	u32 signature;
@@ -101,6 +102,7 @@ static struct platform_driver hp_wmi_driver = {
 	},
 	.probe = hp_wmi_bios_setup,
 	.remove = hp_wmi_bios_remove,
+	.resume = hp_wmi_resume_handler,
 };
 
 static int hp_wmi_perform_query(int query, int write, int value)
@@ -487,6 +489,29 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 	return 0;
 }
 
+static int hp_wmi_resume_handler(struct platform_device *device)
+{
+	struct key_entry *key;
+
+	/*
+	 * Docking state may have changed while suspended, so trigger
+	 * an input event for the current state. As this is a switch,
+	 * the input layer will only actually pass it on if the state
+	 * changed.
+	 */
+	for (key = hp_wmi_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_SW:
+			input_report_switch(hp_wmi_input_dev, key->keycode,
+					    hp_wmi_dock_state());
+			input_sync(hp_wmi_input_dev);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int __init hp_wmi_init(void)
 {
 	int err;
-- 
1.6.0.6

