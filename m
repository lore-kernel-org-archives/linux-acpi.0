From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/4] eeepc-laptop: Fix Kconfig
Date: Sun, 15 Feb 2009 19:30:18 +0100
Message-ID: <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.services.sfr.fr ([93.17.128.1]:61934 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbZBOSlG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Feb 2009 13:41:06 -0500
Received: from smtp21.services.sfr.fr (msfrf2119 [10.18.25.33])
	by msfrf2105.sfr.fr (SMTP Server) with ESMTP id 71E1B70005F5
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2009 19:33:23 +0100 (CET)
In-Reply-To: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Corentin Chary <corentincj@iksaif.net>

Add a "select INPUT" to Kconfig now that eeepc-laptop
is using the input layer.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9436311..6f46bc6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -305,6 +305,7 @@ config EEEPC_LAPTOP
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select RFKILL
+	select INPUT
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 	  It also adds the ability to switch camera/wlan on/off.
-- 
1.6.1.2


