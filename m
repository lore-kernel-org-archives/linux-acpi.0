From: akpm@osdl.org
Subject: [patch 05/14] acpi: handle firmware_register init errors
Date: Mon, 14 Aug 2006 22:37:24 -0700
Message-ID: <200608150537.k7F5bOTW011542@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:38026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965098AbWHOFkg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 01:40:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, rdunlap@xenotime.net, greg@kroah.com

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: Greg KH <greg@kroah.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/bus.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/bus.c~acpi-handle-firmware_register-init-errors drivers/acpi/bus.c
--- a/drivers/acpi/bus.c~acpi-handle-firmware_register-init-errors
+++ a/drivers/acpi/bus.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
@@ -738,7 +739,10 @@ static int __init acpi_init(void)
 		return -ENODEV;
 	}
 
-	firmware_register(&acpi_subsys);
+	result = firmware_register(&acpi_subsys);
+	if (result < 0)
+		printk(KERN_WARNING "%s: firmware_register error: %d\n",
+			__FUNCTION__, result);
 
 	result = acpi_bus_init();
 
_
