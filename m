From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/4] ACPI: thinkpad-acpi: Remove firmware backlight delays for Intel ACPI IGD OpRegion
Date: Sat, 18 Oct 2008 14:23:55 -0300
Message-ID: <1224350635-14021-5-git-send-email-hmh@hmh.eng.br>
References: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43984 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020AbYJRRYE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Oct 2008 13:24:04 -0400
In-Reply-To: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, Yves-Alexis Perez <corsac@debian.org>

Based on analysis and a patch from Matthew Garrett <mjg59@srcf.ucam.org>.

Instruct the ThinkPad ACPI firmware to remove delays on the processing of
backlight brightness changes.  This method is present on ThinkPad
Vista-compatible BIOSes with standard ACPI backlight level control.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Yves-Alexis Perez <corsac@debian.org>
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
1.5.6.5

