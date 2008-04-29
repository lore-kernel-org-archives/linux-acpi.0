From: Len Brown <lenb@kernel.org>
Subject: [PATCH 167/171] ACPI: thinkpad-acpi: fix selects in Kconfig
Date: Tue, 29 Apr 2008 04:44:32 -0400
Message-ID: <892855fec53804058a5346fb78dfacf693a03435.1209457073.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759962AbYD2Ipp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:45 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add missing select for BACKLIGHT_LCD_SUPPORT, as select doesn't select the
dependencies of a symbol for us.

Also, "select INPUT" in Kconfig.  We are not an Input device, nor are we
anywhere close to the input subsystem in the Kconfig tree, so using
"depends on INPUT" is not user-friendly at all.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3a5d769..2e21794 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -241,10 +241,11 @@ config SONYPI_COMPAT
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
1.5.5.1.99.gf0ec4

