From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 1/4] usb: add struct usb_hub_port to store port related members.
Date: Fri, 30 Mar 2012 17:26:54 +0800
Message-ID: <1333099617-11019-2-git-send-email-tianyu.lan@intel.com>
References: <1333099617-11019-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1333099617-11019-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Add struct usb_hub_port pointer port_data in the struct usb_hub and allocate
struct usb_hub_port perspectively for each ports to store private data.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index aeefbab..3c82bb7 100644
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
 
@@ -1448,16 +1453,14 @@ int usb_hub_release_port(struct usb_device *hdev, unsigned port1, void *owner)
 
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
@@ -1468,7 +1471,7 @@ bool usb_device_is_owned(struct usb_device *udev)
 	if (udev->state == USB_STATE_NOTATTACHED || !udev->parent)
 		return false;
 	hub = hdev_to_hub(udev->parent);
-	return !!hub->port_owners[udev->portnum - 1];
+	return !!hub->port_data[udev->portnum - 1].port_owner;
 }
 
 
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
