From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 4/4] asus-laptop: use select instead of depends on
Date: Sun, 15 Feb 2009 19:30:21 +0100
Message-ID: <1234722621-14498-5-git-send-email-corentincj@iksaif.net>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-4-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.services.sfr.fr ([93.17.128.3]:49412 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbZBOSlH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Feb 2009 13:41:07 -0500
Received: from smtp21.services.sfr.fr (msfrf2119 [10.18.25.33])
	by msfrf2110.sfr.fr (SMTP Server) with ESMTP id A542F7000A77
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2009 19:33:23 +0100 (CET)
In-Reply-To: <1234722621-14498-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Corentin Chary <corentincj@iksaif.net>

Like thinkpad_acpi or eeepc-laptop, asus-laptop will
now use "select" instead of "depends on".

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6f46bc6..000a4b7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -39,10 +39,10 @@ config ASUS_LAPTOP
 	tristate "Asus Laptop Extras (EXPERIMENTAL)"
 	depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
-	depends on LEDS_CLASS
-	depends on NEW_LEDS
-	depends on BACKLIGHT_CLASS_DEVICE
-	depends on INPUT
+	select LEDS_CLASS
+	select NEW_LEDS
+	select BACKLIGHT_CLASS_DEVICE
+	select INPUT
 	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
-- 
1.6.1.2


