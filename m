From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH v6 6/8] usb: expose usb port's pm qos flags to user space
Date: Mon, 21 Jan 2013 22:18:05 +0800
Message-ID: <1358777887-2656-7-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41834 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3AUOUq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 09:20:46 -0500
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

This patch is to expose usb port's pm qos flags(pm_qos_no_power_off,
pm_qos_remote_wakeup) to user space. User can set pm_qos_no_power_off
flag to prohibit the port from being powered off.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/port.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index dc1aaec..0c51d24 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -67,6 +67,7 @@ static void usb_port_device_release(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
+	dev_pm_qos_hide_flags(dev);
 	usb_acpi_unregister_power_resources(dev);
 	kfree(port_dev);
 }
@@ -176,7 +177,15 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		goto error_register;
 
 	pm_runtime_set_active(&port_dev->dev);
-	pm_runtime_enable(&port_dev->dev);
+
+	/* It would be dangerous if user space couldn't
+	 * prevent usb device from being powered off. So don't
+	 * enable port runtime pm if failed to expose port's pm qos.
+	 */
+	if (!dev_pm_qos_expose_flags(&port_dev->dev,
+			PM_QOS_FLAG_NO_POWER_OFF))
+		pm_runtime_enable(&port_dev->dev);
+
 	usb_acpi_register_power_resources(&port_dev->dev);
 
 	return 0;
-- 
1.7.9.5

