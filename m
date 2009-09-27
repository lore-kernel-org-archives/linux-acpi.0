From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: thinkpad-acpi: fix CONFIG_THINKPAD_ACPI_HOTKEY_POLL build problem
Date: Sat, 26 Sep 2009 21:42:49 -0300
Message-ID: <1254012169-31473-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56110 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752780AbZI0Amt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Sep 2009 20:42:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix this problem when CONFIG_THINKPAD_ACPI_HOTKEY_POLL is undefined:

  CHECK   drivers/platform/x86/thinkpad_acpi.c
drivers/platform/x86/thinkpad_acpi.c:1968:21: error: not an lvalue
  CC [M]  drivers/platform/x86/thinkpad_acpi.o
drivers/platform/x86/thinkpad_acpi.c: In function 'tpacpi_hotkey_driver_mask_set':
drivers/platform/x86/thinkpad_acpi.c:1968: error: lvalue required as left operand of assignment

Reported-by: Noah Dain <noahdain@gmail.com>
Reported-by: Audrius Kazukauskas <audrius@neutrino.lt>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3910f2f..d93108d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2235,7 +2235,9 @@ static int tpacpi_hotkey_driver_mask_set(const u32 mask)
 
 	HOTKEY_CONFIG_CRITICAL_START
 	hotkey_driver_mask = mask;
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_source_mask |= (mask & ~hotkey_all_mask);
+#endif
 	HOTKEY_CONFIG_CRITICAL_END
 
 	rc = hotkey_mask_set((hotkey_acpi_mask | hotkey_driver_mask) &
-- 
1.6.3.3

