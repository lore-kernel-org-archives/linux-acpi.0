From: akpm@osdl.org
Subject: [patch 4/5] ACPI: disable SBS by default
Date: Thu, 06 Jul 2006 23:52:58 -0700
Message-ID: <200607070652.k676qw2M030087@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWGGGxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2006 02:53:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, dtor@insightbb.com, dtor@mail.ru

From: Dmitry Torokhov <dtor@insightbb.com>

Kconfig help even says that SBS is pretty rare and already obsolete so it
does not make sence to keep it enabled.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/Kconfig~acpi-disable-sbs-by-default drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~acpi-disable-sbs-by-default
+++ a/drivers/acpi/Kconfig
@@ -368,7 +368,7 @@ config ACPI_SBS
 	tristate "Smart Battery System (EXPERIMENTAL)"
 	depends on X86 && I2C
 	depends on EXPERIMENTAL
-	default y
+	default n
 	help
 	  This driver adds support for the Smart Battery System.
 	  Depends on I2C (Device Drivers ---> I2C support)
_
