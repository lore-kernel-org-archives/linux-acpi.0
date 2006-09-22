From: Zhang Rui <rui.zhang@intel.com>
Subject: [03/12] acpi: add device_driver and helper functions
Date: Fri, 22 Sep 2006 17:22:15 +0800
Message-ID: <1158916935.11985.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45633 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751111AbWIVJUl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:20:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Patrick Mochel <mochel@linux.intel.com>

Add device_driver into acpi_driver for driver model.
Add helper functions 'to_acpi_device' and 'to_acpi_driver' 
to get structure acpi_device/acpi_driver by device/device_driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/scan.c     |    5 -----
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc7/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/scan.c	2006-09-19 19:47:22.000000000 +0800
+++ linux-2.6.18-rc7/drivers/acpi/scan.c	2006-09-19 19:47:52.000000000 +0800
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
Index: linux-2.6.18-rc7/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18-rc7.orig/include/acpi/acpi_bus.h	2006-09-14 13:26:49.000000000 +0800
+++ linux-2.6.18-rc7/include/acpi/acpi_bus.h	2006-09-19 19:47:52.000000000 +0800
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
