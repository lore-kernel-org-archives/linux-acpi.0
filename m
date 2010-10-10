From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ACPI: Only processor needs CPU_IDLE
Date: Sun, 10 Oct 2010 14:54:52 +0200
Message-ID: <20101010145452.72fd10e0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:15323 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab0JJMzG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Oct 2010 08:55:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

ACPI support itself doesn't need CPU_IDLE, only ACPI_PROCESSOR does,
so only ACPI_PROCESSOR should select CPU_IDLE.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.36-rc7.orig/drivers/acpi/Kconfig	2010-10-10 13:23:02.000000000 +0200
+++ linux-2.6.36-rc7/drivers/acpi/Kconfig	2010-10-10 13:23:08.000000000 +0200
@@ -9,7 +9,6 @@ menuconfig ACPI
 	depends on PCI
 	depends on PM
 	select PNP
-	select CPU_IDLE
 	default y
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
@@ -206,6 +205,7 @@ config ACPI_DOCK
 config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
+	select CPU_IDLE
 	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux and uses


-- 
Jean Delvare
