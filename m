From: akpm@linux-foundation.org
Subject: [patch 08/26] compal-laptop: uses hwmon interfaces, depends on HWMON
Date: Tue, 20 Jul 2010 15:19:39 -0700
Message-ID: <201007202219.o6KMJepi021018@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, randy.dunlap@oracle.com, roald.frederickx@gmail.com
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

compal-laptop uses hwmon interfaces, so it should depend on HWMON.

compal-laptop.c:(.devinit.text+0x4071f): undefined reference to `hwmon_device_register'
compal-laptop.c:(.devexit.text+0x6ec0): undefined reference to `hwmon_device_unregister'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Roald Frederickx <roald.frederickx@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/platform/x86/Kconfig~compal-laptop-uses-hwmon-interfaces-depends-on-hwmon drivers/platform/x86/Kconfig
--- a/drivers/platform/x86/Kconfig~compal-laptop-uses-hwmon-interfaces-depends-on-hwmon
+++ a/drivers/platform/x86/Kconfig
@@ -182,6 +182,7 @@ config COMPAL_LAPTOP
 	depends on ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on RFKILL
+	depends on HWMON
 	---help---
 	  This is a driver for laptops built by Compal:
 
_
