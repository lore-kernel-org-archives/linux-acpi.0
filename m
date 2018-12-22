From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v1 04/11] platform/x86: make PCI dependency explicit
Date: Sat, 22 Dec 2018 00:14:45 +0000
Message-ID: <20181222001452.7474-5-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

ipss driver is a PCI device driver but this has not been mentioned
anywhere in Kconfig.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e3b62c2ee8d1..b36ea14b41ad 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1009,7 +1009,7 @@ config INTEL_MFLD_THERMAL
 
 config INTEL_IPS
 	tristate "Intel Intelligent Power Sharing"
-	depends on ACPI
+	depends on ACPI && PCI
 	---help---
 	  Intel Calpella platforms support dynamic power sharing between the
 	  CPU and GPU, maximizing performance in a given TDP.  This driver,
-- 
2.19.0
