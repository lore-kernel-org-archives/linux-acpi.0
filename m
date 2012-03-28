From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/5] usb: move struct usb_device->children to struct usb_hub_port->child
Date: Wed, 28 Mar 2012 14:49:10 +0800
Message-ID: <1332917353-28123-3-git-send-email-tianyu.lan@intel.com>
References: <1332917353-28123-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39568 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab2C1GxK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2012 02:53:10 -0400
In-Reply-To: <1332917353-28123-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@intel.com, mjg@redhat.com, Lan Tianyu <tianyu.lan@intel.com>

Move child's pointer to the struct usb_hub_port since the child device
is directly associated with the port. Provide usb_get_hub_child_device()
to get child's pointer.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/devices.c      |    4 ++-
 drivers/usb/core/hub.c          |   64 ++++++++++++++++++++++++--------------
 drivers/usb/host/r8a66597-hcd.c |    4 ++-
 include/linux/usb.h             |    3 +-
 4 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index d956965..b372531 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -590,7 +590,9 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 
 	/* Now look at all of this device's children. */
 	for (chix = 0; chix < usbdev->maxchild; chix++) {
-		struct usb_device *childdev = usbdev->children[chix];
+		struct usb_device *childdev;
+		if (usb_get_hub_child_device(usbdev, chix + 1, &childdev) < 0)
+			continue;
 
 		if (childdev) {
 			usb_lock_device(childdev);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1ee130d..51bf5d4 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -39,6 +39,7 @@
 
 struct usb_hub_port {
 	void			*port_owner;
+	struct usb_device	*child;
 };
 
 struct usb_hub {
@@ -91,7 +92,7 @@ static inline int hub_is_superspeed(struct usb_device *hdev)
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS);
 }
 
-/* Protect struct usb_device->state and ->children members
+/* Protect struct usb_device->state and struct usb_hub_port->child members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
 static DEFINE_SPINLOCK(device_state_lock);
@@ -624,8 +625,8 @@ static int hub_port_disable(struct usb_hub *hub, int port1, int set_state)
 	struct usb_device *hdev = hub->hdev;
 	int ret = 0;
 
-	if (hdev->children[port1-1] && set_state)
-		usb_set_device_state(hdev->children[port1-1],
+	if (hub->port_data[port1-1].child && set_state)
+		usb_set_device_state(hub->port_data[port1-1].child,
 				USB_STATE_NOTATTACHED);
 	if (!hub->error && !hub_is_superspeed(hub->hdev))
 		ret = clear_port_feature(hdev, port1, USB_PORT_FEAT_ENABLE);
@@ -781,7 +782,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 	 * which ports need attention.
 	 */
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device *udev = hdev->children[port1-1];
+		struct usb_device *udev = hub->port_data[port1-1].child;
 		u16 portstatus, portchange;
 
 		portstatus = portchange = 0;
@@ -945,8 +946,8 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 	if (type != HUB_SUSPEND) {
 		/* Disconnect all the children */
 		for (i = 0; i < hdev->maxchild; ++i) {
-			if (hdev->children[i])
-				usb_disconnect(&hdev->children[i]);
+			if (hub->port_data[i].child)
+				usb_disconnect(&hub->port_data[i].child);
 		}
 	}
 
@@ -1373,6 +1374,7 @@ static int
 hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
 {
 	struct usb_device *hdev = interface_to_usbdev (intf);
+	struct usb_hub *hub = usb_get_intfdata(intf);
 
 	/* assert ifno == 0 (part of hub spec) */
 	switch (code) {
@@ -1386,11 +1388,11 @@ hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
 		else {
 			info->nports = hdev->maxchild;
 			for (i = 0; i < info->nports; i++) {
-				if (hdev->children[i] == NULL)
+				if (hub->port_data[i].child == NULL)
 					info->port[i] = 0;
 				else
 					info->port[i] =
-						hdev->children[i]->devnum;
+						hub->port_data[i].child->devnum;
 			}
 		}
 		spin_unlock_irq(&device_state_lock);
@@ -1475,11 +1477,12 @@ bool usb_device_is_owned(struct usb_device *udev)
 
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
+	struct usb_hub	*hub = hdev_to_hub(udev);
 	int i;
 
 	for (i = 0; i < udev->maxchild; ++i) {
-		if (udev->children[i])
-			recursively_mark_NOTATTACHED(udev->children[i]);
+		if (hub->port_data[i].child)
+			recursively_mark_NOTATTACHED(hub->port_data[i].child);
 	}
 	if (udev->state == USB_STATE_SUSPENDED)
 		udev->active_duration -= jiffies;
@@ -1645,6 +1648,7 @@ void usb_disconnect(struct usb_device **pdev)
 	struct usb_device	*udev = *pdev;
 	int			i;
 	struct usb_hcd		*hcd = bus_to_hcd(udev->bus);
+	struct usb_hub		*hub = hdev_to_hub(udev);
 
 	/* mark the device as inactive, so any further urb submissions for
 	 * this device (and any of its children) will fail immediately.
@@ -1657,9 +1661,9 @@ void usb_disconnect(struct usb_device **pdev)
 	usb_lock_device(udev);
 
 	/* Free up all the children before we remove this device */
-	for (i = 0; i < USB_MAXCHILDREN; i++) {
-		if (udev->children[i])
-			usb_disconnect(&udev->children[i]);
+	for (i = 0; i < udev->maxchild; i++) {
+		if (hub->port_data[i].child)
+			usb_disconnect(&hub->port_data[i].child);
 	}
 
 	/* deallocate hcd/hardware state ... nuking all pending urbs and
@@ -2725,7 +2729,7 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
 		struct usb_device	*udev;
 
-		udev = hdev->children [port1-1];
+		udev = hub->port_data[port1-1].child;
 		if (udev && udev->can_submit) {
 			dev_warn(&intf->dev, "port %d nyet suspended\n", port1);
 			if (PMSG_IS_AUTO(msg))
@@ -3199,7 +3203,7 @@ hub_power_remaining (struct usb_hub *hub)
 
 	remaining = hdev->bus_mA - hub->descriptor->bHubContrCurrent;
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device	*udev = hdev->children[port1 - 1];
+		struct usb_device	*udev = hub->port_data[port1 - 1].child;
 		int			delta;
 
 		if (!udev)
@@ -3263,7 +3267,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 #endif
 
 	/* Try to resuscitate an existing device */
-	udev = hdev->children[port1-1];
+	udev = hub->port_data[port1-1].child;
 	if ((portstatus & USB_PORT_STAT_CONNECTION) && udev &&
 			udev->state != USB_STATE_NOTATTACHED) {
 		usb_lock_device(udev);
@@ -3292,7 +3296,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 
 	/* Disconnect any existing devices under this port */
 	if (udev)
-		usb_disconnect(&hdev->children[port1-1]);
+		usb_disconnect(&hub->port_data[port1-1].child);
 	clear_bit(port1, hub->change_bits);
 
 	/* We can forget about a "removed" device when there's a physical
@@ -3407,7 +3411,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 				&& highspeed_hubs != 0)
 			check_highspeed (hub, udev, port1);
 
-		/* Store the parent's children[] pointer.  At this point
+		/* Store the hub port's child pointer.  At this point
 		 * udev becomes globally accessible, although presumably
 		 * no one will look at it until hdev is unlocked.
 		 */
@@ -3421,7 +3425,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		if (hdev->state == USB_STATE_NOTATTACHED)
 			status = -ENOTCONN;
 		else
-			hdev->children[port1-1] = udev;
+			hub->port_data[port1-1].child = udev;
 		spin_unlock_irq(&device_state_lock);
 
 		/* Run it through the hoops (find a driver, etc) */
@@ -3429,7 +3433,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 			status = usb_new_device(udev);
 			if (status) {
 				spin_lock_irq(&device_state_lock);
-				hdev->children[port1-1] = NULL;
+				hub->port_data[port1-1].child = NULL;
 				spin_unlock_irq(&device_state_lock);
 			}
 		}
@@ -3588,7 +3592,7 @@ static void hub_events(void)
 				 */
 				if (!(portstatus & USB_PORT_STAT_ENABLE)
 				    && !connect_change
-				    && hdev->children[i-1]) {
+				    && hub->port_data[i-1].child) {
 					dev_err (hub_dev,
 					    "port %i "
 					    "disabled by hub (EMI?), "
@@ -3603,14 +3607,14 @@ static void hub_events(void)
 
 				clear_port_feature(hdev, i,
 					USB_PORT_FEAT_C_SUSPEND);
-				udev = hdev->children[i-1];
+				udev = hub->port_data[i-1].child;
 				if (udev) {
 					/* TRSMRCY = 10 msec */
 					msleep(10);
 
 					usb_lock_device(udev);
-					ret = usb_remote_wakeup(hdev->
-							children[i-1]);
+					ret = usb_remote_wakeup(hub->
+							port_data[i-1].child);
 					usb_unlock_device(udev);
 					if (ret < 0)
 						connect_change = 1;
@@ -4147,3 +4151,15 @@ void usb_queue_reset_device(struct usb_interface *iface)
 	schedule_work(&iface->reset_ws);
 }
 EXPORT_SYMBOL_GPL(usb_queue_reset_device);
+
+int usb_get_hub_child_device(struct usb_device *hdev, int port1,
+	struct usb_device **child)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port1 > hdev->maxchild || port1 < 1)
+		return -EINVAL;
+	*child = hub->port_data[port1 - 1].child;
+	return 0;
+}
+
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index e84ca19..7295a1b 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2040,7 +2040,9 @@ static void collect_usb_address_map(struct usb_device *udev, unsigned long *map)
 		map[udev->devnum/32] |= (1 << (udev->devnum % 32));
 
 	for (chix = 0; chix < udev->maxchild; chix++) {
-		struct usb_device *childdev = udev->children[chix];
+		struct usb_device *childdev;
+		if (usb_get_hub_child_device(usbdev, chix + 1, &childdev) < 0)
+			continue;
 
 		if (childdev)
 			collect_usb_address_map(childdev, map);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 0c51663..6d41c8d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -501,7 +501,6 @@ struct usb_device {
 #endif
 
 	int maxchild;
-	struct usb_device *children[USB_MAXCHILDREN];
 
 	u32 quirks;
 	atomic_t urbnum;
@@ -527,6 +526,8 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
 
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
 extern void usb_put_dev(struct usb_device *dev);
+extern int usb_get_hub_child_device(struct usb_device *hdev, int port1,
+	struct usb_device **child);
 
 /* USB device locking */
 #define usb_lock_device(udev)		device_lock(&(udev)->dev)
-- 
1.7.6.rc2.8.g28eb

