From: akpm@linux-foundation.org
Subject: [patch 6/8] hp-wmi: notify of a potential docking state change on resume
Date: Wed, 04 Mar 2009 11:55:28 -0800
Message-ID: <200903041955.n24JtTPN028010@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38218 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756219AbZCDT4Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 14:56:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, elendil@planet.nl, mjg59@srcf.ucam.org

From: Frans Pop <elendil@planet.nl>

It is possible that the system gets docked or undocked while it's
suspended. Generate an input event on resume to notify user space
if there was a state change.

As it is a switch, we can generate the event unconditionally; the
input layer will only pass it on if there is an actual change.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/hp-wmi.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff -puN drivers/platform/x86/hp-wmi.c~hp-wmi-notify-of-a-potential-docking-state-change-on-resume drivers/platform/x86/hp-wmi.c
--- a/drivers/platform/x86/hp-wmi.c~hp-wmi-notify-of-a-potential-docking-state-change-on-resume
+++ a/drivers/platform/x86/hp-wmi.c
@@ -53,6 +53,7 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE9
 
 static int __init hp_wmi_bios_setup(struct platform_device *device);
 static int __exit hp_wmi_bios_remove(struct platform_device *device);
+static int hp_wmi_resume_handler(struct platform_device *device);
 
 struct bios_args {
 	u32 signature;
@@ -101,6 +102,7 @@ static struct platform_driver hp_wmi_dri
 	},
 	.probe = hp_wmi_bios_setup,
 	.remove = hp_wmi_bios_remove,
+	.resume = hp_wmi_resume_handler,
 };
 
 static int hp_wmi_perform_query(int query, int write, int value)
@@ -487,6 +489,29 @@ static int __exit hp_wmi_bios_remove(str
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
_
