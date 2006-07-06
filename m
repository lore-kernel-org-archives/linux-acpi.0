From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] ACPI: disable SBS by default
Date: Wed, 5 Jul 2006 23:46:04 -0400
Message-ID: <200607052346.04966.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:34218 "EHLO
	asav10.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S965155AbWGFDqG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Jul 2006 23:46:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

From: Dmitry Torokhov <dtor@insightbb.com>

ACPI: disable SBS by default

Kconfig help even says that SBS is pretty rare and already
obsolete so it does not make sence to keep it enabled.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/acpi/Kconfig
===================================================================
--- work.orig/drivers/acpi/Kconfig
+++ work/drivers/acpi/Kconfig
@@ -357,7 +357,7 @@ config ACPI_SBS
 	tristate "Smart Battery System (EXPERIMENTAL)"
 	depends on X86 && I2C
 	depends on EXPERIMENTAL
-	default y
+	default n
 	help
 	  This driver adds support for the Smart Battery System.
 	  Depends on I2C (Device Drivers ---> I2C support)
