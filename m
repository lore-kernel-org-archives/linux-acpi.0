From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] platform/x86: depends instead of select for laptop platform drivers
Date: Wed, 25 Feb 2009 09:37:09 +0100
Message-ID: <1235551029-28504-1-git-send-email-corentincj@iksaif.net>
References: <20090225000317.82c3c3a7.akpm@linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:50461 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbZBYIrH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 03:47:07 -0500
In-Reply-To: <20090225000317.82c3c3a7.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Corentin Chary <corentincj@iksaif.net>

"I hate `select' and will gleefully leap on any s/select/depends/ patch,
whether it works or not :)"
  Andrew Morton

select INPUT is not needed here, because if someone doesn't want INPUT,
he won't want these drivers either.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7a46ed8..8cd903c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -39,10 +39,10 @@ config ASUS_LAPTOP
 	tristate "Asus Laptop Extras (EXPERIMENTAL)"
 	depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
+	depends on INPUT
 	select LEDS_CLASS
 	select NEW_LEDS
 	select BACKLIGHT_CLASS_DEVICE
-	select INPUT
 	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
@@ -185,11 +185,11 @@ config SONYPI_COMPAT
 config THINKPAD_ACPI
 	tristate "ThinkPad ACPI Laptop Extras"
 	depends on ACPI
+	depends on INPUT
 	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select NVRAM
-	select INPUT
 	select NEW_LEDS
 	select LEDS_CLASS
 	select NET
@@ -307,7 +307,6 @@ config EEEPC_LAPTOP
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select RFKILL
-	select INPUT
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 	  It also adds the ability to switch camera/wlan on/off.
-- 
1.6.1.3

