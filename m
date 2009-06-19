From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 9/9] ACPI: remove unused acpi_device_ops .stop method
Date: Fri, 19 Jun 2009 15:32:20 -0600
Message-ID: <20090619213220.18001.39295.stgit@bob.kio>
References: <20090619213038.18001.16533.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:16252 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbZFSVcR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 17:32:17 -0400
In-Reply-To: <20090619213038.18001.16533.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>

No drivers use the .stop method, so remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
---
 drivers/acpi/scan.c     |    5 -----
 include/acpi/acpi_bus.h |    2 --
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ff510b..cce640b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -430,9 +430,6 @@ static int acpi_device_probe(struct device * dev)
 		if (acpi_drv->ops.notify) {
 			ret = acpi_device_install_notify_handler(acpi_dev);
 			if (ret) {
-				if (acpi_drv->ops.stop)
-					acpi_drv->ops.stop(acpi_dev,
-						   acpi_dev->removal_type);
 				if (acpi_drv->ops.remove)
 					acpi_drv->ops.remove(acpi_dev,
 						     acpi_dev->removal_type);
@@ -456,8 +453,6 @@ static int acpi_device_remove(struct device * dev)
 	if (acpi_drv) {
 		if (acpi_drv->ops.notify)
 			acpi_device_remove_notify_handler(acpi_dev);
-		if (acpi_drv->ops.stop)
-			acpi_drv->ops.stop(acpi_dev, acpi_dev->removal_type);
 		if (acpi_drv->ops.remove)
 			acpi_drv->ops.remove(acpi_dev, acpi_dev->removal_type);
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 84df486..339b2a9 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -89,7 +89,6 @@ struct acpi_device;
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
 typedef int (*acpi_op_start) (struct acpi_device * device);
-typedef int (*acpi_op_stop) (struct acpi_device * device, int type);
 typedef int (*acpi_op_suspend) (struct acpi_device * device,
 				pm_message_t state);
 typedef int (*acpi_op_resume) (struct acpi_device * device);
@@ -106,7 +105,6 @@ struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
 	acpi_op_start start;
-	acpi_op_stop stop;
 	acpi_op_suspend suspend;
 	acpi_op_resume resume;
 	acpi_op_bind bind;

