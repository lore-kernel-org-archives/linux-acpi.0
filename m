From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/8] thinkpad-acpi: deprecate hotkey_bios_mask
Date: Sat, 12 Sep 2009 15:22:15 -0300
Message-ID: <1252779738-7459-6-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44778 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670AbZILSWX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:23 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some analysis of the ACPI DSDTs shows that the HKEY pre-enabled mask
is always 0x80c (FN+F3,FN+F4 and FN+F12), which are the hotkeys that
the second gen of HKEY firmware supported (the first gen didn't report
any hotkeys, the second reported these tree hotkeys but had no mask
support, and the third added mask support).

So, this is probably some sort of backwards compatibility with older
versions of the IBM ThinkVantage suite.  We have no use for that, and
I know of exactly ZERO users of that attribute, anyway.  Start the
process of getting rid of it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    6 +++++-
 drivers/platform/x86/thinkpad_acpi.c    |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index e2ddcde..ab4b58e 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -240,9 +240,13 @@ sysfs notes:
 		Returns 0.
 
 	hotkey_bios_mask:
+		DEPRECATED, DON'T USE, WILL BE REMOVED IN THE FUTURE.
+
 		Returns the hot keys mask when thinkpad-acpi was loaded.
 		Upon module unload, the hot keys mask will be restored
-		to this value.
+		to this value.   This is always 0x80c, because those are
+		the hotkeys that were supported by ancient firmware
+		without mask support.
 
 	hotkey_enable:
 		DEPRECATED, WILL BE REMOVED SOON.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 679a73b..6b66789 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2544,6 +2544,8 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
+	printk_deprecated_attribute("hotkey_bios_mask",
+			"This attribute is useless.");
 	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_orig_mask);
 }
 
-- 
1.6.3.3

