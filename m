From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V3 2/4] usb: move struct usb_device->children to struct usb_hub_port->child
Date: Sat, 31 Mar 2012 11:17:00 +0800
Message-ID: <1333163822-5849-3-git-send-email-tianyu.lan@intel.com>
References: <1333163822-5849-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35244 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146Ab2CaDVI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2012 23:21:08 -0400
In-Reply-To: <1333163822-5849-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg@redhat.com, Lan Tianyu <tianyu.lan@intel.com>

Move child's pointer to the struct usb_hub_port since the child device
is directly associated with the port. Provide usb_get_hub_child_device()
to get child's pointer.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/staging/usbip/usbip_common.c |    3 +-
 drivers/usb/core/devices.c           |    3 +-
 drivers/usb/core/hub.c               |   67 +++++++++++++++++++++-------------
 drivers/usb/host/r8a66597-hcd.c      |    3 +-
 include/linux/usb.h                  |    4 +-
 5 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/usbip/usbip_common.c b/drivers/staging/usbip/usbip_common.c
index d93e7f1..806a010 100644
--- a/drivers/staging/usbip/usbip_common.c
+++ b/drivers/staging/usbip/usbip_common.c
@@ -157,8 +157,7 @@ static void usbip_dump_usb_device(struct usb_device *udev)
 	dev_dbg(dev, "have_langid %d, string_langid %d\n",
 		udev->have_langid, udev->string_langid);
 
-	dev_dbg(dev, "maxchild %d, children %p\n",
-		udev->maxchild, udev->children);
+	dev_dbg(dev, "maxchild %d\n", udev->maxchild);
 }
 
 static void usbip_dump_request_type(__u8 rt)
diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index d956965..a83962b 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -590,7 +590,8 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 
 	/* Now look at all of this device's children. */
 	for (chix = 0; chix < usbdev->maxchild; chix++) {
-		struct usb_device *childdev = usbdev->children[chix];
+		struct usb_device *childdev =
+			usb_get_hub_child_device(usbdev, chix + 1);
 
 		if (childdev) {
 			usb_lock_device(childdev);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3c82bb7..d8a680d 100644
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
@@ -174,7 +175,7 @@ static inline char *portspeed(struct usb_hub *hub, int portstatus)
 /* Note that hdev or one of its children must be locked! */
 static struct usb_hub *hdev_to_hub(struct usb_device *hdev)
 {
-	if (!hdev || !hdev->actconfig)
+	if (!hdev || !hdev->actconfig || !hdev->maxchild)
 		return NULL;
 	return usb_get_intfdata(hdev->actconfig->interface[0]);
 }
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
@@ -1477,11 +1479,13 @@ bool usb_device_is_owned(struct usb_device *udev)
 
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
+	struct usb_hub	*hub = hdev_to_hub(udev);
 	int i;
 
 	for (i = 0; i < udev->maxchild; ++i) {
-		if (udev->children[i])
-			recursively_mark_NOTATTACHED(udev->children[i]);
+		if (hub->port_data[i].child)
+			recursively_mark_NOTATTACHED(
+				hub->port_data[i].child);
 	}
 	if (udev->state == USB_STATE_SUSPENDED)
 		udev->active_duration -= jiffies;
@@ -1647,6 +1651,7 @@ void usb_disconnect(struct usb_device **pdev)
 	struct usb_device	*udev = *pdev;
 	int			i;
 	struct usb_hcd		*hcd = bus_to_hcd(udev->bus);
+	struct usb_hub		*hub = hdev_to_hub(udev);
 
 	/* mark the device as inactive, so any further urb submissions for
 	 * this device (and any of its children) will fail immediately.
@@ -1659,9 +1664,9 @@ void usb_disconnect(struct usb_device **pdev)
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
@@ -2727,7 +2732,7 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
 		struct usb_device	*udev;
 
-		udev = hdev->children [port1-1];
+		udev = hub->port_data[port1-1].child;
 		if (udev && udev->can_submit) {
 			dev_warn(&intf->dev, "port %d nyet suspended\n", port1);
 			if (PMSG_IS_AUTO(msg))
@@ -3201,7 +3206,7 @@ hub_power_remaining (struct usb_hub *hub)
 
 	remaining = hdev->bus_mA - hub->descriptor->bHubContrCurrent;
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device	*udev = hdev->children[port1 - 1];
+		struct usb_device	*udev = hub->port_data[port1 - 1].child;
 		int			delta;
 
 		if (!udev)
@@ -3265,7 +3270,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 #endif
 
 	/* Try to resuscitate an existing device */
-	udev = hdev->children[port1-1];
+	udev = hub->port_data[port1-1].child;
 	if ((portstatus & USB_PORT_STAT_CONNECTION) && udev &&
 			udev->state != USB_STATE_NOTATTACHED) {
 		usb_lock_device(udev);
@@ -3294,7 +3299,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 
 	/* Disconnect any existing devices under this port */
 	if (udev)
-		usb_disconnect(&hdev->children[port1-1]);
+		usb_disconnect(&hub->port_data[port1-1].child);
 	clear_bit(port1, hub->change_bits);
 
 	/* We can forget about a "removed" device when there's a physical
@@ -3409,7 +3414,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 				&& highspeed_hubs != 0)
 			check_highspeed (hub, udev, port1);
 
-		/* Store the parent's children[] pointer.  At this point
+		/* Store the hub port's child pointer.  At this point
 		 * udev becomes globally accessible, although presumably
 		 * no one will look at it until hdev is unlocked.
 		 */
@@ -3423,7 +3428,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		if (hdev->state == USB_STATE_NOTATTACHED)
 			status = -ENOTCONN;
 		else
-			hdev->children[port1-1] = udev;
+			hub->port_data[port1-1].child = udev;
 		spin_unlock_irq(&device_state_lock);
 
 		/* Run it through the hoops (find a driver, etc) */
@@ -3431,7 +3436,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 			status = usb_new_device(udev);
 			if (status) {
 				spin_lock_irq(&device_state_lock);
-				hdev->children[port1-1] = NULL;
+				hub->port_data[port1-1].child = NULL;
 				spin_unlock_irq(&device_state_lock);
 			}
 		}
@@ -3590,7 +3595,7 @@ static void hub_events(void)
 				 */
 				if (!(portstatus & USB_PORT_STAT_ENABLE)
 				    && !connect_change
-				    && hdev->children[i-1]) {
+				    && hub->port_data[i-1].child) {
 					dev_err (hub_dev,
 					    "port %i "
 					    "disabled by hub (EMI?), "
@@ -3605,14 +3610,14 @@ static void hub_events(void)
 
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
@@ -4149,3 +4154,15 @@ void usb_queue_reset_device(struct usb_interface *iface)
 	schedule_work(&iface->reset_ws);
 }
 EXPORT_SYMBOL_GPL(usb_queue_reset_device);
+
+struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
+	int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (!hub || port1 > hdev->maxchild || port1 < 1)
+		return NULL;
+	return hub->port_data[port1 - 1].child;
+}
+EXPORT_SYMBOL_GPL(usb_get_hub_child_device);
+
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index e84ca19..2a50550 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2040,7 +2040,8 @@ static void collect_usb_address_map(struct usb_device *udev, unsigned long *map)
 		map[udev->devnum/32] |= (1 << (udev->devnum % 32));
 
 	for (chix = 0; chix < udev->maxchild; chix++) {
-		struct usb_device *childdev = udev->children[chix];
+		struct usb_device *childdev =
+			usb_get_hub_child_device(udev, chix + 1);
 
 		if (childdev)
 			collect_usb_address_map(childdev, map);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 0c51663..5e7058d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -428,7 +428,6 @@ enum usb_device_removable {
  *	access from userspace
  * @usbfs_dentry: usbfs dentry entry for the device
  * @maxchild: number of ports if hub
- * @children: child devices - USB devices that are attached to this hub
  * @quirks: quirks of the whole device
  * @urbnum: number of URBs submitted for the whole device
  * @active_duration: total time device is not suspended
@@ -501,7 +500,6 @@ struct usb_device {
 #endif
 
 	int maxchild;
-	struct usb_device *children[USB_MAXCHILDREN];
 
 	u32 quirks;
 	atomic_t urbnum;
@@ -527,6 +525,8 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
 
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
 extern void usb_put_dev(struct usb_device *dev);
+extern struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
+	int port1);
 
 /* USB device locking */
 #define usb_lock_device(udev)		device_lock(&(udev)->dev)
-- 
1.7.6.rc2.8.g28eb

