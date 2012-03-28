From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 3/5] usb: Add platform_data in the struct usb_hub_port
Date: Wed, 28 Mar 2012 14:49:11 +0800
Message-ID: <1332917353-28123-4-git-send-email-tianyu.lan@intel.com>
References: <1332917353-28123-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39568 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab2C1GxR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2012 02:53:17 -0400
In-Reply-To: <1332917353-28123-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@intel.com, mjg@redhat.com, Lan Tianyu <tianyu.lan@intel.com>

Add the member platform_data in the usb_hub_port to store port's
platform related data. Provide usb_set_hub_port_platform_data() and
usb_get_hub_port_platform_data() to access the member.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c |   22 ++++++++++++++++++++++
 drivers/usb/core/usb.h |    4 ++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 51bf5d4..ac7bd89 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 struct usb_hub_port {
 	void			*port_owner;
 	struct usb_device	*child;
+	unsigned long		platform_data;
 };
 
 struct usb_hub {
@@ -4163,3 +4164,24 @@ int usb_get_hub_child_device(struct usb_device *hdev, int port1,
 	return 0;
 }
 
+int usb_set_hub_port_platform_data(struct usb_device *hdev, int port1,
+	unsigned long data)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port1 > hdev->maxchild || port1 < 1)
+		return -EINVAL;
+	hub->port_data[port1 - 1].platform_data = data;
+	return 0;
+}
+
+int usb_get_hub_port_platform_data(struct usb_device *hdev, int port1,
+	unsigned long *data)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port1 > hdev->maxchild || port1 < 1)
+		return -EINVAL;
+	*data = hub->port_data[port1 - 1].platform_data;
+	return 0;
+}
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 636d98e..694c78d 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -154,6 +154,10 @@ extern void usb_notify_add_device(struct usb_device *udev);
 extern void usb_notify_remove_device(struct usb_device *udev);
 extern void usb_notify_add_bus(struct usb_bus *ubus);
 extern void usb_notify_remove_bus(struct usb_bus *ubus);
+extern int usb_get_hub_port_platform_data(struct usb_device *hdev,
+	int port1, unsigned long *data);
+extern int usb_set_hub_port_platform_data(struct usb_device *hdev,
+	int port1, unsigned long data);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
-- 
1.7.6.rc2.8.g28eb

