From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 1/4] usb: add struct usb_hub_port to store port related members.
Date: Mon, 19 Mar 2012 22:33:43 +0800
Message-ID: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2791 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031485Ab2CSOgQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2012 10:36:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

Add struct usb_hub_port pointer port_data in the struct usb_hub and allocate
struct usb_hub_port perspectively for each ports to store private data.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index aeefbab..4c20c34 100644
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
@@ -79,7 +83,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
-	void			**port_owners;
+	struct usb_hub_port	*port_data;
 };
 
 static inline int hub_is_superspeed(struct usb_device *hdev)
@@ -1021,8 +1025,9 @@ static int hub_configure(struct usb_hub *hub,
 	dev_info (hub_dev, "%d port%s detected\n", hdev->maxchild,
 		(hdev->maxchild == 1) ? "" : "s");
 
-	hub->port_owners = kzalloc(hdev->maxchild * sizeof(void *), GFP_KERNEL);
-	if (!hub->port_owners) {
+	hub->port_data = kzalloc(hdev->maxchild * sizeof(struct usb_hub_port),
+			GFP_KERNEL);
+	if (!hub->port_data) {
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -1275,7 +1280,7 @@ static void hub_disconnect(struct usb_interface *intf)
 		highspeed_hubs--;
 
 	usb_free_urb(hub->urb);
-	kfree(hub->port_owners);
+	kfree(hub->port_data);
 	kfree(hub->descriptor);
 	kfree(hub->status);
 	kfree(hub->buffer);
@@ -1413,7 +1418,7 @@ static int find_port_owner(struct usb_device *hdev, unsigned port1,
 	/* This assumes that devices not managed by the hub driver
 	 * will always have maxchild equal to 0.
 	 */
-	*ppowner = &(hdev_to_hub(hdev)->port_owners[port1 - 1]);
+	*ppowner = &(hdev_to_hub(hdev)->port_data[port1 - 1].port_owner);
 	return 0;
 }
 
@@ -1451,13 +1456,12 @@ void usb_hub_release_all_ports(struct usb_device *hdev, void *owner)
 	int n;
 	void **powner;
 
-	n = find_port_owner(hdev, 1, &powner);
-	if (n == 0) {
-		for (; n < hdev->maxchild; (++n, ++powner)) {
-			if (*powner == owner)
-				*powner = NULL;
-		}
+	for (n = 1; n <= hdev->maxchild; n++) {
+		find_port_owner(hdev, n, &powner);
+		if (*powner == owner)
+			*powner = NULL;
 	}
+
 }
 
 /* The caller must hold udev's lock */
@@ -1468,7 +1472,7 @@ bool usb_device_is_owned(struct usb_device *udev)
 	if (udev->state == USB_STATE_NOTATTACHED || !udev->parent)
 		return false;
 	hub = hdev_to_hub(udev->parent);
-	return !!hub->port_owners[udev->portnum - 1];
+	return !!hub->port_data[udev->portnum - 1].port_owner;
 }
 
 
-- 
1.7.6.rc2.8.g28eb

