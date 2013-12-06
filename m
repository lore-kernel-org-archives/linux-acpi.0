From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI/Processor: use ACPI_COMPANION to get ACPI device
Date: Fri,  6 Dec 2013 15:36:26 +0800
Message-ID: <1386315386-4650-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44787 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab3LFHgb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Dec 2013 02:36:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Using ACPI_COMPANION to get ACPI device instead of acpi_bus_get_device().

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/processor_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 146ab7e..c1c3562 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -224,9 +224,9 @@ static int __acpi_processor_start(struct acpi_device *device)
 
 static int acpi_processor_start(struct device *dev)
 {
-	struct acpi_device *device;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 
-	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
+	if (!device)
 		return -ENODEV;
 
 	return __acpi_processor_start(device);
@@ -234,10 +234,10 @@ static int acpi_processor_start(struct device *dev)
 
 static int acpi_processor_stop(struct device *dev)
 {
-	struct acpi_device *device;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_processor *pr;
 
-	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
+	if (!device)
 		return 0;
 
 	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-- 
1.8.2.1

