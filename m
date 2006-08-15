From: akpm@osdl.org
Subject: [patch 04/14] acpi bus: add missing newline
Date: Mon, 14 Aug 2006 22:37:23 -0700
Message-ID: <200608150537.k7F5bN6Z011538@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:38537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965077AbWHOFh0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 01:37:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, rdunlap@xenotime.net

From: Randy Dunlap <rdunlap@xenotime.net>

Add newline so next message won't begin with <6>...

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/bus.c~acpi-bus-add-missing-newline drivers/acpi/bus.c
--- a/drivers/acpi/bus.c~acpi-bus-add-missing-newline
+++ a/drivers/acpi/bus.c
@@ -192,7 +192,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device `[%s]' is not power manageable",
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device `[%s]' is not power manageable\n",
 				device->kobj.name));
 		return -ENODEV;
 	}
_
