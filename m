From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v2 06/11] apple-gmux: Make PCI dependency explicit
Date: Sat, 22 Dec 2018 09:07:15 +0000
Message-ID: <20181222090720.19234-7-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..86b75fa55dbc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
 config APPLE_GMUX
 	tristate "Apple Gmux Driver"
 	depends on ACPI
+	depends on PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
-- 
2.19.0
