From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 07/15] asus_acpi: Deprecate in favor of asus-laptop
Date: Tue, 16 Jun 2009 21:28:48 +0200
Message-ID: <1245180536-28009-8-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60976 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbZFPTb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:26 -0400
In-Reply-To: <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

asus-laptop have been merged in the kernel two years ago,
it is now stable and used by most distribution instead of
the old asus_acpi driver.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index a5386b2..bb538d5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -35,7 +35,7 @@ config ACER_WMI
 	  here.
 
 config ASUS_LAPTOP
-	tristate "Asus Laptop Extras (EXPERIMENTAL)"
+	tristate "Asus Laptop Extras"
 	depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
 	select LEDS_CLASS
@@ -373,7 +373,7 @@ config ACPI_WMI
 	  any ACPI-WMI devices.
 
 config ACPI_ASUS
-	tristate "ASUS/Medion Laptop Extras"
+	tristate "ASUS/Medion Laptop Extras (DEPRECATED)"
 	depends on ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
-- 
1.6.3.1

