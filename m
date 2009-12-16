From: Len Brown <lenb@kernel.org>
Subject: [PATCH 058/103] PNPACPI: save struct acpi_device, not just acpi_handle
Date: Wed, 16 Dec 2009 03:36:09 -0500
Message-ID: <c4da6940a7a41c72781ff2d62ebd4b99f3749f14.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760839AbZLPKGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:12 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:06:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Some drivers need to look at things in the acpi_device structure
besides the handle.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/core.c     |   17 ++++++++++++-----
 drivers/pnp/pnpacpi/rsparser.c |    9 ++++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 83b8b5a..b2348fc 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -80,7 +80,8 @@ static int pnpacpi_get_resources(struct pnp_dev *dev)
 
 static int pnpacpi_set_resources(struct pnp_dev *dev)
 {
-	acpi_handle handle = dev->data;
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
 	struct acpi_buffer buffer;
 	int ret;
 
@@ -103,7 +104,8 @@ static int pnpacpi_set_resources(struct pnp_dev *dev)
 
 static int pnpacpi_disable_resources(struct pnp_dev *dev)
 {
-	acpi_handle handle = dev->data;
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
 	int ret;
 
 	dev_dbg(&dev->dev, "disable resources\n");
@@ -121,6 +123,8 @@ static int pnpacpi_disable_resources(struct pnp_dev *dev)
 #ifdef CONFIG_ACPI_SLEEP
 static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
 {
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
 	int power_state;
 
 	power_state = acpi_pm_device_sleep_state(&dev->dev, NULL);
@@ -128,12 +132,15 @@ static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
 		power_state = (state.event == PM_EVENT_ON) ?
 				ACPI_STATE_D0 : ACPI_STATE_D3;
 
-	return acpi_bus_set_power((acpi_handle) dev->data, power_state);
+	return acpi_bus_set_power(handle, power_state);
 }
 
 static int pnpacpi_resume(struct pnp_dev *dev)
 {
-	return acpi_bus_set_power((acpi_handle) dev->data, ACPI_STATE_D0);
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
+
+	return acpi_bus_set_power(handle, ACPI_STATE_D0);
 }
 #endif
 
@@ -168,7 +175,7 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->data = device->handle;
+	dev->data = device;
 	/* .enabled means the device can decode the resources */
 	dev->active = device->status.enabled;
 	status = acpi_get_handle(device->handle, "_SRS", &temp);
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index ef3a2cd..5702b2c 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -465,7 +465,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 
 int pnpacpi_parse_allocated_resource(struct pnp_dev *dev)
 {
-	acpi_handle handle = dev->data;
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
 	acpi_status status;
 
 	pnp_dbg(&dev->dev, "parse allocated resources\n");
@@ -773,7 +774,8 @@ static __init acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 
 int __init pnpacpi_parse_resource_option_data(struct pnp_dev *dev)
 {
-	acpi_handle handle = dev->data;
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
 	acpi_status status;
 	struct acpipnp_parse_option_s parse_data;
 
@@ -845,7 +847,8 @@ static acpi_status pnpacpi_type_resources(struct acpi_resource *res, void *data)
 int pnpacpi_build_resource_template(struct pnp_dev *dev,
 				    struct acpi_buffer *buffer)
 {
-	acpi_handle handle = dev->data;
+	struct acpi_device *acpi_dev = dev->data;
+	acpi_handle handle = acpi_dev->handle;
 	struct acpi_resource *resource;
 	int res_cnt = 0;
 	acpi_status status;
-- 
1.6.0.6

