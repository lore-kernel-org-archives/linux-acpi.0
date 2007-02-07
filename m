From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/140] ACPI: add device_driver and hepler functions
Date: Wed,  7 Feb 2007 13:50:17 -0500
Message-ID: <11708743653073-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:17538 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422702AbXBGSws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:52:48 -0500
In-Reply-To: <11708743611662-git-send-email-lenb@kernel.org>
Message-Id: <d43ec68e9837dfa6618ab473622683fdbf6e68a9.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
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
@@ -222,11 +222,6 @@ acpi_eject_store(struct acpi_device *device, const char *buf, size_t count)
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
index fdd1095..a09538e 100644
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
1.5.0.rc3.39.gec804
