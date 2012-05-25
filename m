From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V3 1/4] usb: add struct usb_hub_port to store port related members.
Date: Fri, 25 May 2012 22:06:24 +0800
Message-ID: <1337954787-28388-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64355 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab2EYOM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2012 10:12:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

Add struct usb_hub_port pointer port_data in the struct usb_hub and allocate
struct usb_hub_port perspectively for each ports to store private data.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 04fb834..512f0d5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -37,6 +37,10 @@
 #endif
 #endif
 
+struct usb_hub_port {
+	void			*port_owner;
+};
+
 struct usb_hub {
 	struct device		*intfdev;	/* the "interface" device */
 	struct usb_device	*hdev;
@@ -81,7 +85,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
-	void			**port_owners;
+	struct usb_hub_port	*port_data;
 };
 
 static inline int hub_is_superspeed(struct usb_device *hdev)
@@ -1271,8 +1275,9 @@ static int hub_configure(struct usb_hub *hub,
 
 	hdev->children = kzalloc(hdev->maxchild *
 				sizeof(struct usb_device *), GFP_KERNEL);
-	hub->port_owners = kzalloc(hdev->maxchild * sizeof(void *), GFP_KERNEL);
-	if (!hdev->children || !hub->port_owners) {
+	hub->port_data = kzalloc(hdev->maxchild * sizeof(struct usb_hub_port),
+			GFP_KERNEL);
+	if (!hub->port_data || !hdev->children) {
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -1527,7 +1532,7 @@ static void hub_disconnect(struct usb_interface *intf)
 
 	usb_free_urb(hub->urb);
 	kfree(hdev->children);
-	kfree(hub->port_owners);
+	kfree(hub->port_data);
 	kfree(hub->descriptor);
 	kfree(hub->status);
 	kfree(hub->buffer);
@@ -1659,7 +1664,7 @@ static int find_port_owner(struct usb_device *hdev, unsigned port1,
 	/* This assumes that devices not managed by the hub driver
 	 * will always have maxchild equal to 0.
 	 */
-	*ppowner = &(hdev_to_hub(hdev)->port_owners[port1 - 1]);
+	*ppowner = &(hdev_to_hub(hdev)->port_data[port1 - 1].port_owner);
 	return 0;
 }
 
@@ -1694,16 +1699,14 @@ int usb_hub_release_port(struct usb_device *hdev, unsigned port1, void *owner)
 
 void usb_hub_release_all_ports(struct usb_device *hdev, void *owner)
 {
+	struct usb_hub *hub = hdev_to_hub(hdev);
 	int n;
-	void **powner;
 
-	n = find_port_owner(hdev, 1, &powner);
-	if (n == 0) {
-		for (; n < hdev->maxchild; (++n, ++powner)) {
-			if (*powner == owner)
-				*powner = NULL;
-		}
+	for (n = 0; n < hdev->maxchild; n++) {
+		if (hub->port_data[n].port_owner == owner)
+			hub->port_data[n].port_owner = NULL;
 	}
+
 }
 
 /* The caller must hold udev's lock */
@@ -1714,7 +1717,7 @@ bool usb_device_is_owned(struct usb_device *udev)
 	if (udev->state == USB_STATE_NOTATTACHED || !udev->parent)
 		return false;
 	hub = hdev_to_hub(udev->parent);
-	return !!hub->port_owners[udev->portnum - 1];
+	return !!hub->port_data[udev->portnum - 1].port_owner;
 }
 
 
-- 
1.7.6.rc2.8.g28eb

