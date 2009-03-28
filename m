From: Len Brown <lenb@kernel.org>
Subject: [PATCH 83/98] ACPI: remove unused acpi_device_ops .shutdown method
Date: Sat, 28 Mar 2009 00:31:58 -0400
Message-ID: <c0ce093f5b8bc3262c51bd0b5900424a67909831.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38339 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbZC1Edp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:45 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7008OJ8O66IQG@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:43 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No drivers use the .shutdown method, so remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |   12 ------------
 include/acpi/acpi_bus.h |    2 --
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c54d7b6..4a6c7ee 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -395,22 +395,10 @@ static int acpi_device_remove(struct device * dev)
 	return 0;
 }
 
-static void acpi_device_shutdown(struct device *dev)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = acpi_dev->driver;
-
-	if (acpi_drv && acpi_drv->ops.shutdown)
-		acpi_drv->ops.shutdown(acpi_dev);
-
-	return ;
-}
-
 struct bus_type acpi_bus_type = {
 	.name		= "acpi",
 	.suspend	= acpi_device_suspend,
 	.resume		= acpi_device_resume,
-	.shutdown	= acpi_device_shutdown,
 	.match		= acpi_bus_match,
 	.probe		= acpi_device_probe,
 	.remove		= acpi_device_remove,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e3c5a4e..fb91bc2 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -95,7 +95,6 @@ typedef int (*acpi_op_suspend) (struct acpi_device * device,
 typedef int (*acpi_op_resume) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
-typedef int (*acpi_op_shutdown) (struct acpi_device * device);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
@@ -121,7 +120,6 @@ struct acpi_device_ops {
 	acpi_op_resume resume;
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
-	acpi_op_shutdown shutdown;
 };
 
 struct acpi_driver {
-- 
1.6.0.6

