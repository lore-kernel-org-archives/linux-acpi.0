From: akpm@linux-foundation.org
Subject: [patch 4/4] acpi/dock: use NULL for pointer
Date: Mon, 26 Mar 2007 21:38:49 -0800
Message-ID: <200703270538.l2R5cnU9007940@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:39766 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933982AbXC0FkG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Mar 2007 01:40:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, randy.dunlap@oracle.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Use NULL instead of 0 for pointers:
drivers/acpi/dock.c:677:75: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/dock.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/dock.c~acpi-dock-use-null-for-pointer drivers/acpi/dock.c
--- a/drivers/acpi/dock.c~acpi-dock-use-null-for-pointer
+++ a/drivers/acpi/dock.c
@@ -29,6 +29,7 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
+#include <linux/stddef.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -674,7 +675,7 @@ static ssize_t show_dock_uid(struct devi
 			     struct device_attribute *attr, char *buf)
 {
 	unsigned long lbuf;
-	acpi_status status = acpi_evaluate_integer(dock_station->handle, "_UID", 0, &lbuf);
+	acpi_status status = acpi_evaluate_integer(dock_station->handle, "_UID", NULL, &lbuf);
 	if(ACPI_FAILURE(status)) {
 	    return 0;
 	}
_
