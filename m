From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 6/8] thinkpad-acpi: Fix procfs hotkey reset command
Date: Sat, 12 Sep 2009 15:22:16 -0300
Message-ID: <1252779738-7459-7-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47739 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754645AbZILSWX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:23 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

echo "reset" > /proc/acpi/ibm/hotkey should do something non-useless,
so instead of setting it to Fn+F2, Fn+F3, Fn+F5, set it to
hotkey_recommended_mask.

It is not like it will survive for much longer, anyway.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +-
 drivers/platform/x86/thinkpad_acpi.c    |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index ab4b58e..6d03487 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -219,7 +219,7 @@ The following commands can be written to the /proc/acpi/ibm/hotkey file:
 	echo 0xffffffff > /proc/acpi/ibm/hotkey -- enable all hot keys
 	echo 0 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
 	... any other 8-hex-digit mask ...
-	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
+	echo reset > /proc/acpi/ibm/hotkey -- restore the recommended mask
 
 The following commands have been deprecated and will cause the kernel
 to log a warning:
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6b66789..dd779e5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3569,7 +3569,8 @@ static int hotkey_write(char *buf)
 			hotkey_enabledisable_warn(0);
 			res = -EPERM;
 		} else if (strlencmp(cmd, "reset") == 0) {
-			mask = hotkey_orig_mask;
+			mask = (hotkey_all_mask | hotkey_source_mask)
+				& ~hotkey_reserved_mask;
 		} else if (sscanf(cmd, "0x%x", &mask) == 1) {
 			/* mask set */
 		} else if (sscanf(cmd, "%x", &mask) == 1) {
-- 
1.6.3.3

