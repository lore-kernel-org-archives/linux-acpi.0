From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 12/13] ACPI: thinkpad-acpi: fix selects in Kconfig
Date: Thu, 10 Apr 2008 00:53:04 -0300
Message-ID: <1207799585-10112-13-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42313 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754725AbYDJDxM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 23:53:12 -0400
In-Reply-To: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add missing select for BACKLIGHT_LCD_SUPPORT, as select doesn't select the
dependencies of a symbol for us.

Also, "select INPUT" in Kconfig.  We are not an Input device, nor are we
anywhere close to the input subsystem in the Kconfig tree, so using
"depends on INPUT" is not user-friendly at all.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 8a46cbc..bc2d859 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -208,10 +208,11 @@ config SONYPI_COMPAT
 config THINKPAD_ACPI
 	tristate "ThinkPad ACPI Laptop Extras"
 	depends on X86 && ACPI
+	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select NVRAM
-	depends on INPUT
+	select INPUT
 	select NEW_LEDS
 	select LEDS_CLASS
 	---help---
-- 
1.5.4.4

