From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
Date: Sat,  5 Jan 2019 10:06:01 +0000
Message-ID: <20190105100606.6673-7-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. This driver depends on the PCI infrastructure but
the dependency has not been explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7afb96cb1cd6..5e2109c54c7c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1135,7 +1135,7 @@ config SAMSUNG_Q10
 
 config APPLE_GMUX
 	tristate "Apple Gmux Driver"
-	depends on ACPI
+	depends on ACPI && PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
-- 
2.19.0
