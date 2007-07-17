From: Carlos Corbacho <cathectic@gmail.com>
Subject: [RFC][PATCH 4/5] ACPI: acer_acpi: Add Kconfig entry
Date: Tue, 17 Jul 2007 15:48:29 +0100
Message-ID: <200707171548.29486.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:31685 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbXGQOsR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 10:48:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so152242ugf
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 07:48:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Add a Kconfig entry for acer_acpi

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 drivers/misc/Kconfig |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2f2fbff..16e30d0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -78,6 +78,24 @@ config TIFM_7XX1
           To compile this driver as a module, choose M here: the module will
 	  be called tifm_7xx1.
 
+config ACER_ACPI
+	tristate "Acer Laptop ACPI Extras (EXPERIMENTAL)"
+	depends on X86
+	depends on ACPI
+	depends on EXPERIMENTAL
+	depends on LEDS_CLASS
+	depends on BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This driver drives the PNP0C14 device found on many Acer laptops from
+	  2005 onwards (and known to work on some Fujitsu Siemens laptops). It
+	  adds support for wireless, bluetooth, backlight and mail LED control.
+
+	  For more information, see <file:Documentation/acer_acpi.txt>
+	  and read <http://code.google.com/p/aceracpi/wiki/SupportedHardware>
+	  for a list of hardware known to work with the driver.
+
+	  If you are not sure, say N here.
+
 config ASUS_LAPTOP
         tristate "Asus Laptop Extras (EXPERIMENTAL)"
         depends on X86
-- 
1.4.2.1

