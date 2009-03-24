From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/3] ACPI: remove unused acpi_device_ops .shutdown method
Date: Tue, 24 Mar 2009 10:55:27 -0600
Message-ID: <20090324165527.25119.52477.stgit@bob.kio>
References: <20090324165420.25119.78955.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:46038 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762634AbZCXQz3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 12:55:29 -0400
In-Reply-To: <20090324165420.25119.78955.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Rajesh Shah <rajesh.shah@intel.com>

No drivers use the .shutdown method, so remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c     |   12 ------------
 include/acpi/acpi_bus.h |    2 --
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2f04cd1..467e9d0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -397,22 +397,10 @@ static int acpi_device_remove(struct device * dev)
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

