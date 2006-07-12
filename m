From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm] acpi: handle firmware_register init errors
Date: Tue, 11 Jul 2006 22:47:02 -0700
Message-ID: <20060711224702.295b892f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:25259 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751331AbWGLFpo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 01:45:44 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2006 22:45:41 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/bus.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2618-rc1mm1.orig/drivers/acpi/bus.c
+++ linux-2618-rc1mm1/drivers/acpi/bus.c
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
 


---
