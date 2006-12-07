From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/14] ACPI: add device_driver and hepler functions
Date: Thu, 07 Dec 2006 20:56:23 +0800
Message-ID: <1165496183.11485.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13048 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032168AbWLGMwR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 07:52:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Patrick Mochel <mochel@linux.intel.com>

Add device_driver into acpi_driver for driver model.
Add helper functions 'to_acpi_device' and 'to_acpi_driver'
to get structure acpi_device/acpi_driver by device/device_driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |    5 -----
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1f75ba6..5b42948 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -222,11 +222,6 @@ acpi_eject_store(struct acpi_device *dev
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
-static inline struct acpi_device * to_acpi_device(struct device * dev)
-{
-	return container_of(dev, struct acpi_device, dev);
-}
-
 static int root_suspend(struct acpi_device * acpi_dev, pm_message_t state)
 {
 	struct acpi_device * dev, * next;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f338e40..5282fe7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -136,6 +136,7 @@ struct acpi_driver {
 	atomic_t references;
 	char *ids;		/* Supported Hardware IDs */
 	struct acpi_device_ops ops;
+	struct device_driver drv;
 };
 
 /*
@@ -301,6 +302,8 @@ struct acpi_device {
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
+#define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
+#define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
 
 /*
  * Events
-- 
1.4.4.g59427
