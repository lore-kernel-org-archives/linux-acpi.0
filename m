From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] watchdog: wdat_wdt: Select WATCHDOG_CORE
Date: Mon, 21 Nov 2016 15:33:07 +0200
Message-ID: <20161121133307.157776-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The WDAT watchdog driver uses functionality provided by the watchdog timer
core but it did not select it explicitly. This results following linker
error when only WDAT_WDT is enabled in Kconfig:

  drivers/built-in.o: In function `wdat_wdt_probe':
  drivers/watchdog/wdat_wdt.c:444: undefined reference to `devm_watchdog_register_device'

Fix this by explicitly selecting WATCHDOG_CORE when WDAT watchdog driver is
enabled.

Fixes: 058dfc767008 (ACPI / watchdog: Add support for WDAT hardware watchdog)
Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fdd3228e0678..3eb58cb51e56 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -155,6 +155,7 @@ config TANGOX_WATCHDOG
 config WDAT_WDT
 	tristate "ACPI Watchdog Action Table (WDAT)"
 	depends on ACPI
+	select WATCHDOG_CORE
 	select ACPI_WATCHDOG
 	help
 	  This driver adds support for systems with ACPI Watchdog Action
-- 
2.10.2
