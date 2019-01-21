From: Sinan Kaya <okaya@kernel.org>
Subject: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date: Mon, 21 Jan 2019 22:46:43 +0000
Message-ID: <20190121224644.26903-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
depends on BACKLIGHT_LCD_SUPPORT.

Copy this dependency into ACPI_CMPC.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5e2109c54c7c..b84c2c5b6684 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -904,7 +904,7 @@ config TOSHIBA_WMI
 
 config ACPI_CMPC
 	tristate "CMPC Laptop Extras"
-	depends on ACPI && INPUT
+	depends on ACPI && INPUT && BACKLIGHT_LCD_SUPPORT
 	depends on RFKILL || RFKILL=n
 	select BACKLIGHT_CLASS_DEVICE
 	help
-- 
2.19.0
