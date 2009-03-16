From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/14] asus-laptop: use select instead of depends on
Date: Mon, 16 Mar 2009 01:23:54 -0400
Message-ID: <e73e2c62f7646d54e30ef8863ac0be0b8e4ef0eb.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:25340 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZCPFYS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL008V030643FE@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:09 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Like thinkpad_acpi or eeepc-laptop, asus-laptop will
now use "select" instead of "depends on"
for LEDS_CLASS, NEW_LEDS and BACKLIGHT_CLASS_DEVICE

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b3866ad..fede8f3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -39,9 +39,9 @@ config ASUS_LAPTOP
 	tristate "Asus Laptop Extras (EXPERIMENTAL)"
 	depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
-	depends on LEDS_CLASS
-	depends on NEW_LEDS
-	depends on BACKLIGHT_CLASS_DEVICE
+	select LEDS_CLASS
+	select NEW_LEDS
+	select BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
-- 
1.5.6.6

