From: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/13] ACPI: add device_driver and helper functions
Date: Fri, 24 Nov 2006 00:17:31 -0500
Message-ID: <11643454642611-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com> <11643454641312-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21603 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934276AbWKXFNy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:13:54 -0500
In-Reply-To: <11643454641312-git-send-email-len.brown@intel.com>
Message-Id: <5b4e67afe03abecbba9eb45805f4e14214fc65a6.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

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
