From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Resend PATCH V3 6/8] usb: move struct usb_device->children to struct usb_hub_port->child
Date: Fri, 11 May 2012 16:08:30 +0800
Message-ID: <1336723712-7686-7-git-send-email-tianyu.lan@intel.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336723712-7686-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Move child's pointer to the struct usb_hub_port since the child device
is directly associated with the port. Provide usb_get_hub_child_device()
to get child's pointer.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/usbip/usbip_common.c |    3 +-
 drivers/usb/core/devices.c           |    3 +-
 drivers/usb/core/hub.c               |   67 ++++++++++++++++++++--------------
 drivers/usb/host/r8a66597-hcd.c      |    3 +-
 include/linux/usb.h                  |    4 +-
 5 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/usbip/usbip_common.c b/drivers/staging/usbip/usbip_common.c
index 70f23026..95beb76 100644
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
index 0c17d5a..6bf7124 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -39,6 +39,7 @@
 
 struct usb_hub_port {
 	void			*port_owner;
+	struct usb_device	*child;
 };
 
 struct usb_hub {
@@ -93,7 +94,7 @@ static inline int hub_is_superspeed(struct usb_device *hdev)
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS);
 }
 
-/* Protect struct usb_device->state and ->children members
+/* Protect struct usb_device->state and struct usb_hub_port->child members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
 static DEFINE_SPINLOCK(device_state_lock);
@@ -176,7 +177,7 @@ static inline char *portspeed(struct usb_hub *hub, int portstatus)
 /* Note that hdev or one of its children must be locked! */
 static struct usb_hub *hdev_to_hub(struct usb_device *hdev)
 {
-	if (!hdev || !hdev->actconfig)
+	if (!hdev || !hdev->actconfig || !hdev->maxchild)
 		return NULL;
 	return usb_get_intfdata(hdev->actconfig->interface[0]);
 }
@@ -649,8 +650,8 @@ static int hub_port_disable(struct usb_hub *hub, int port1, int set_state)
 	struct usb_device *hdev = hub->hdev;
 	int ret = 0;
 
-	if (hdev->children[port1-1] && set_state)
-		usb_set_device_state(hdev->children[port1-1],
+	if (hub->port_data[port1-1].child && set_state)
+		usb_set_device_state(hub->port_data[port1-1].child,
 				USB_STATE_NOTATTACHED);
 	if (!hub->error && !hub_is_superspeed(hub->hdev))
 		ret = clear_port_feature(hdev, port1, USB_PORT_FEAT_ENABLE);
@@ -806,7 +807,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 	 * which ports need attention.
 	 */
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device *udev = hdev->children[port1-1];
+		struct usb_device *udev = hub->port_data[port1-1].child;
 		u16 portstatus, portchange;
 
 		portstatus = portchange = 0;
@@ -971,8 +972,8 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 	if (type != HUB_SUSPEND) {
 		/* Disconnect all the children */
 		for (i = 0; i < hdev->maxchild; ++i) {
-			if (hdev->children[i])
-				usb_disconnect(&hdev->children[i]);
+			if (hub->port_data[i].child)
+				usb_disconnect(&hub->port_data[i].child);
 		}
 	}
 
@@ -1051,11 +1052,9 @@ static int hub_configure(struct usb_hub *hub,
 	dev_info (hub_dev, "%d port%s detected\n", hdev->maxchild,
 		(hdev->maxchild == 1) ? "" : "s");
 
-	hdev->children = kzalloc(hdev->maxchild *
-				sizeof(struct usb_device *), GFP_KERNEL);
 	hub->port_data = kzalloc(hdev->maxchild * sizeof(struct usb_hub_port),
 			GFP_KERNEL);
-	if (!hub->port_data || !hdev->children) {
+	if (!hub->port_data) {
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -1287,7 +1286,6 @@ static unsigned highspeed_hubs;
 static void hub_disconnect(struct usb_interface *intf)
 {
 	struct usb_hub *hub = usb_get_intfdata(intf);
-	struct usb_device *hdev = interface_to_usbdev(intf);
 
 	/* Take the hub off the event list and don't let it be added again */
 	spin_lock_irq(&hub_event_lock);
@@ -1309,7 +1307,6 @@ static void hub_disconnect(struct usb_interface *intf)
 		highspeed_hubs--;
 
 	usb_free_urb(hub->urb);
-	kfree(hdev->children);
 	kfree(hub->port_data);
 	kfree(hub->descriptor);
 	kfree(hub->status);
@@ -1397,6 +1394,7 @@ static int
 hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
 {
 	struct usb_device *hdev = interface_to_usbdev (intf);
+	struct usb_hub *hub = usb_get_intfdata(intf);
 
 	/* assert ifno == 0 (part of hub spec) */
 	switch (code) {
@@ -1410,11 +1408,11 @@ hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
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
@@ -1501,11 +1499,13 @@ bool usb_device_is_owned(struct usb_device *udev)
 
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
@@ -1669,6 +1669,7 @@ static void hub_free_dev(struct usb_device *udev)
 void usb_disconnect(struct usb_device **pdev)
 {
 	struct usb_device	*udev = *pdev;
+	struct usb_hub	*hub = hdev_to_hub(udev);
 	int			i;
 
 	/* mark the device as inactive, so any further urb submissions for
@@ -1683,8 +1684,8 @@ void usb_disconnect(struct usb_device **pdev)
 
 	/* Free up all the children before we remove this device */
 	for (i = 0; i < udev->maxchild; i++) {
-		if (udev->children[i])
-			usb_disconnect(&udev->children[i]);
+		if (hub->port_data[i].child)
+			usb_disconnect(&hub->port_data[i].child);
 	}
 
 	/* deallocate hcd/hardware state ... nuking all pending urbs and
@@ -2765,7 +2766,7 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
 		struct usb_device	*udev;
 
-		udev = hdev->children [port1-1];
+		udev = hub->port_data[port1-1].child;
 		if (udev && udev->can_submit) {
 			dev_warn(&intf->dev, "port %d nyet suspended\n", port1);
 			if (PMSG_IS_AUTO(msg))
@@ -3266,7 +3267,7 @@ hub_power_remaining (struct usb_hub *hub)
 
 	remaining = hdev->bus_mA - hub->descriptor->bHubContrCurrent;
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device	*udev = hdev->children[port1 - 1];
+		struct usb_device	*udev = hub->port_data[port1 - 1].child;
 		int			delta;
 
 		if (!udev)
@@ -3330,7 +3331,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 #endif
 
 	/* Try to resuscitate an existing device */
-	udev = hdev->children[port1-1];
+	udev = hub->port_data[port1-1].child;
 	if ((portstatus & USB_PORT_STAT_CONNECTION) && udev &&
 			udev->state != USB_STATE_NOTATTACHED) {
 		usb_lock_device(udev);
@@ -3359,7 +3360,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 
 	/* Disconnect any existing devices under this port */
 	if (udev)
-		usb_disconnect(&hdev->children[port1-1]);
+		usb_disconnect(&hub->port_data[port1-1].child);
 	clear_bit(port1, hub->change_bits);
 
 	/* We can forget about a "removed" device when there's a physical
@@ -3474,7 +3475,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 				&& highspeed_hubs != 0)
 			check_highspeed (hub, udev, port1);
 
-		/* Store the parent's children[] pointer.  At this point
+		/* Store the hub port's child pointer.  At this point
 		 * udev becomes globally accessible, although presumably
 		 * no one will look at it until hdev is unlocked.
 		 */
@@ -3488,7 +3489,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		if (hdev->state == USB_STATE_NOTATTACHED)
 			status = -ENOTCONN;
 		else
-			hdev->children[port1-1] = udev;
+			hub->port_data[port1-1].child = udev;
 		spin_unlock_irq(&device_state_lock);
 
 		/* Run it through the hoops (find a driver, etc) */
@@ -3496,7 +3497,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 			status = usb_new_device(udev);
 			if (status) {
 				spin_lock_irq(&device_state_lock);
-				hdev->children[port1-1] = NULL;
+				hub->port_data[port1-1].child = NULL;
 				spin_unlock_irq(&device_state_lock);
 			}
 		}
@@ -3542,7 +3543,7 @@ static int hub_handle_remote_wakeup(struct usb_hub *hub, unsigned int port,
 	int ret;
 
 	hdev = hub->hdev;
-	udev = hdev->children[port-1];
+	udev = hub->port_data[port - 1].child;
 	if (!hub_is_superspeed(hdev)) {
 		if (!(portchange & USB_PORT_STAT_C_SUSPEND))
 			return 0;
@@ -3696,7 +3697,7 @@ static void hub_events(void)
 				 */
 				if (!(portstatus & USB_PORT_STAT_ENABLE)
 				    && !connect_change
-				    && hdev->children[i-1]) {
+				    && hub->port_data[i-1].child) {
 					dev_err (hub_dev,
 					    "port %i "
 					    "disabled by hub (EMI?), "
@@ -4234,3 +4235,15 @@ void usb_queue_reset_device(struct usb_interface *iface)
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
index c868be6..4c82fdf 100644
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
index 5483cd7..69163a0 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -424,7 +424,6 @@ enum usb_device_removable {
  *	access from userspace
  * @usbfs_dentry: usbfs dentry entry for the device
  * @maxchild: number of ports if hub
- * @children: child devices - USB devices that are attached to this hub
  * @quirks: quirks of the whole device
  * @urbnum: number of URBs submitted for the whole device
  * @active_duration: total time device is not suspended
@@ -491,7 +490,6 @@ struct usb_device {
 	struct list_head filelist;
 
 	int maxchild;
-	struct usb_device **children;
 
 	u32 quirks;
 	atomic_t urbnum;
@@ -517,6 +515,8 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
 
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
 extern void usb_put_dev(struct usb_device *dev);
+extern struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
+	int port1);
 
 /* USB device locking */
 #define usb_lock_device(udev)		device_lock(&(udev)->dev)
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
