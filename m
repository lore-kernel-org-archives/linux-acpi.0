From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 9/9] asus-laptop: remove EXPERIMENTAL dependency
Date: Fri, 19 Jun 2009 14:52:11 +0200
Message-ID: <1245415931-26466-9-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-2-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-3-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-4-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-5-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-6-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-7-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-8-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23104 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbZFSMyn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:43 -0400
In-Reply-To: <1245415931-26466-8-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2923cb0..a440394 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -37,7 +37,7 @@ config ACER_WMI
 config ASUS_LAPTOP
 	tristate "Asus Laptop Extras"
 	depends on ACPI
-	depends on EXPERIMENTAL && !ACPI_ASUS
+	depends on !ACPI_ASUS
 	select LEDS_CLASS
 	select NEW_LEDS
 	select BACKLIGHT_CLASS_DEVICE
-- 
1.6.3.1


