From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] asus-laptop: update Kconfig for input layer
Date: Sun, 18 Jan 2009 19:01:54 +0100
Message-ID: <1232301715-20292-6-git-send-email-corentincj@iksaif.net>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-3-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-4-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:58972 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758024AbZARSRN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 13:17:13 -0500
In-Reply-To: <1232301715-20292-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Corentin Chary <corentincj@iksaif.net>

Update Kconfig, now asus-laptop use the input layer.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1a266d4..9436311 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -42,6 +42,7 @@ config ASUS_LAPTOP
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on INPUT
 	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
-- 
1.6.0.6

