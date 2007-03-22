From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -mm] acpi/dock: use NULL for pointer
Date: Wed, 21 Mar 2007 19:24:41 -0700
Message-ID: <20070321192441.d5d286a3.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:38923 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbXCVCbi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Mar 2007 22:31:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: kristen.c.accardi@intel.com, lenb@kernel.org, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Use NULL instead of 0 for pointers:
drivers/acpi/dock.c:677:75: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/dock.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.21-rc4-mm1.orig/drivers/acpi/dock.c
+++ linux-2.6.21-rc4-mm1/drivers/acpi/dock.c
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
