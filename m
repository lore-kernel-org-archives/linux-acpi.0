From: Len Brown <lenb@kernel.org>
Subject: [PATCH 080/122] ACPI: thinkpad-acpi: Remove firmware backlight delays
 for Intel ACPI IGD OpRegion
Date: Thu, 23 Oct 2008 02:38:54 -0400
Message-ID: <d64c81c4cea0a14e88fc76e2c845e4885e491754.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbYJWGoU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:14 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, Yves-Alexis Perez <corsac@debian.org>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Based on analysis and a patch from Matthew Garrett <mjg59@srcf.ucam.org>.

Instruct the ThinkPad ACPI firmware to remove delays on the processing of
backlight brightness changes.  This method is present on ThinkPad
Vista-compatible BIOSes with standard ACPI backlight level control.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Yves-Alexis Perez <corsac@debian.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4c47f9b..17b8281 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -838,6 +838,13 @@ static int parse_strtoul(const char *buf,
 	return 0;
 }
 
+static void tpacpi_disable_brightness_delay(void)
+{
+	if (acpi_evalf(hkey_handle, NULL, "PWMS", "qvd", 0))
+		printk(TPACPI_NOTICE
+			"ACPI backlight control delay disabled\n");
+}
+
 static int __init tpacpi_query_bcl_levels(acpi_handle handle)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -2139,6 +2146,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	if (!tp_features.hotkey)
 		return 1;
 
+	tpacpi_disable_brightness_delay();
+
 	hotkey_dev_attributes = create_attr_set(13, NULL);
 	if (!hotkey_dev_attributes)
 		return -ENOMEM;
@@ -2512,6 +2521,8 @@ static void hotkey_suspend(pm_message_t state)
 
 static void hotkey_resume(void)
 {
+	tpacpi_disable_brightness_delay();
+
 	if (hotkey_mask_get())
 		printk(TPACPI_ERR
 		       "error while trying to read hot key mask "
-- 
1.5.5.1

