From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] ACPI EC driver on ia64
Date: Mon, 05 Dec 2005 19:45:27 +0900
Message-ID: <43941A47.40304@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net
Cc: len.brown@intel.com, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I need an ACPI EC driver on my IA64 machine. Currently CONFIG_ACPI_EC
depends on X86, so I cannot build ACPI EC driver on ia64. I tested
ACPI EC driver on ia64 with my special Kconfig, and it seemed to work
well. Could you consider applying the following patch to enable ACPI
EC driver on ia64?

Thanks,
Kenji Kaneshige


This patch enables ACPI EC driver on ia64.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc5/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.15-rc5.orig/drivers/acpi/Kconfig
+++ linux-2.6.15-rc5/drivers/acpi/Kconfig
@@ -269,7 +269,7 @@ config ACPI_DEBUG
 
 config ACPI_EC
 	bool
-	depends on X86
+	depends on IA64 || X86
 	default y
 	help
 	  This driver is required on some systems for the proper operation of
