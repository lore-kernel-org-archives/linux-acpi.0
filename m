From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V4 3/8] usb: move children to struct usb_port
Date: Thu, 28 Jun 2012 15:31:37 +0800
Message-ID: <1340868702-1894-4-git-send-email-tianyu.lan@intel.com>
References: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:31769 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab2F1Hjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2012 03:39:46 -0400
In-Reply-To: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, Lan Tianyu <tianyu.lan@intel.com>

Move child's pointer to the struct usb_port since the child device
is directly associated with the port. Provide usb_get_hub_child()
to get child's pointer and macrio macro usb_get_hub_each_child to
iterate all child devices on the hub.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/staging/usbip/usbip_common.c |    3 +-
 drivers/usb/core/devices.c           |    7 +--
 drivers/usb/core/hub.c               |   71 +++++++++++++++++++++++-----------
 drivers/usb/host/r8a66597-hcd.c      |    9 ++--
 include/linux/usb.h                  |   16 +++++++-
 5 files changed, 71 insertions(+), 35 deletions(-)

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
index d956965..04ba6e3 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -496,6 +496,7 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 	char *pages_start, *data_end, *speed;
 	unsigned int length;
 	ssize_t total_written = 0;
+	struct usb_device *childdev = NULL;
 
 	/* don't bother with anything else if we're not writing any data */
 	if (*nbytes <= 0)
@@ -589,14 +590,12 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 	free_pages((unsigned long)pages_start, 1);
 
 	/* Now look at all of this device's children. */
-	for (chix = 0; chix < usbdev->maxchild; chix++) {
-		struct usb_device *childdev = usbdev->children[chix];
-
+	usb_get_hub_each_child(usbdev, chix, childdev) {
 		if (childdev) {
 			usb_lock_device(childdev);
 			ret = usb_device_dump(buffer, nbytes, skip_bytes,
 					      file_offset, childdev, bus,
-					      level + 1, chix, ++cnt);
+					      level + 1, chix - 1, ++cnt);
 			usb_unlock_device(childdev);
 			if (ret == -EFAULT)
 				return total_written;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c19e088..01655d4 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -39,6 +39,7 @@
 
 struct usb_port {
 	struct usb_device *udev;
+	struct usb_device *child;
 	struct device dev;
 	struct dev_state *port_owner;
 };
@@ -879,8 +880,8 @@ static int hub_port_disable(struct usb_hub *hub, int port1, int set_state)
 	struct usb_device *hdev = hub->hdev;
 	int ret = 0;
 
-	if (hdev->children[port1-1] && set_state)
-		usb_set_device_state(hdev->children[port1-1],
+	if (hub->ports[port1 - 1]->child && set_state)
+		usb_set_device_state(hub->ports[port1 - 1]->child,
 				USB_STATE_NOTATTACHED);
 	if (!hub->error && !hub_is_superspeed(hub->hdev))
 		ret = clear_port_feature(hdev, port1, USB_PORT_FEAT_ENABLE);
@@ -1036,7 +1037,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 	 * which ports need attention.
 	 */
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device *udev = hdev->children[port1-1];
+		struct usb_device *udev = hub->ports[port1 - 1]->child;
 		u16 portstatus, portchange;
 
 		portstatus = portchange = 0;
@@ -1201,8 +1202,8 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 	if (type != HUB_SUSPEND) {
 		/* Disconnect all the children */
 		for (i = 0; i < hdev->maxchild; ++i) {
-			if (hdev->children[i])
-				usb_disconnect(&hdev->children[i]);
+			if (hub->ports[i]->child)
+				usb_disconnect(&hub->ports[i]->child);
 		}
 	}
 
@@ -1324,11 +1325,9 @@ static int hub_configure(struct usb_hub *hub,
 	dev_info (hub_dev, "%d port%s detected\n", hdev->maxchild,
 		(hdev->maxchild == 1) ? "" : "s");
 
-	hdev->children = kzalloc(hdev->maxchild *
-				sizeof(struct usb_device *), GFP_KERNEL);
 	hub->ports = kzalloc(hdev->maxchild * sizeof(struct usb_port *),
 			     GFP_KERNEL);
-	if (!hdev->children || !hub->ports) {
+	if (!hub->ports) {
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -1591,7 +1590,6 @@ static void hub_disconnect(struct usb_interface *intf)
 		highspeed_hubs--;
 
 	usb_free_urb(hub->urb);
-	kfree(hdev->children);
 	kfree(hub->ports);
 	kfree(hub->descriptor);
 	kfree(hub->status);
@@ -1679,6 +1677,7 @@ static int
 hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
 {
 	struct usb_device *hdev = interface_to_usbdev (intf);
+	struct usb_hub *hub = hdev_to_hub(hdev);
 
 	/* assert ifno == 0 (part of hub spec) */
 	switch (code) {
@@ -1692,11 +1691,11 @@ hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
 		else {
 			info->nports = hdev->maxchild;
 			for (i = 0; i < info->nports; i++) {
-				if (hdev->children[i] == NULL)
+				if (hub->ports[i]->child == NULL)
 					info->port[i] = 0;
 				else
 					info->port[i] =
-						hdev->children[i]->devnum;
+						hub->ports[i]->child->devnum;
 			}
 		}
 		spin_unlock_irq(&device_state_lock);
@@ -1784,11 +1783,12 @@ bool usb_device_is_owned(struct usb_device *udev)
 
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
+	struct usb_hub *hub = hdev_to_hub(udev);
 	int i;
 
 	for (i = 0; i < udev->maxchild; ++i) {
-		if (udev->children[i])
-			recursively_mark_NOTATTACHED(udev->children[i]);
+		if (hub->ports[i]->child)
+			recursively_mark_NOTATTACHED(hub->ports[i]->child);
 	}
 	if (udev->state == USB_STATE_SUSPENDED)
 		udev->active_duration -= jiffies;
@@ -1952,6 +1952,7 @@ static void hub_free_dev(struct usb_device *udev)
 void usb_disconnect(struct usb_device **pdev)
 {
 	struct usb_device	*udev = *pdev;
+	struct usb_hub		*hub = hdev_to_hub(udev);
 	int			i;
 
 	/* mark the device as inactive, so any further urb submissions for
@@ -1966,8 +1967,8 @@ void usb_disconnect(struct usb_device **pdev)
 
 	/* Free up all the children before we remove this device */
 	for (i = 0; i < udev->maxchild; i++) {
-		if (udev->children[i])
-			usb_disconnect(&udev->children[i]);
+		if (hub->ports[i]->child)
+			usb_disconnect(&hub->ports[i]->child);
 	}
 
 	/* deallocate hcd/hardware state ... nuking all pending urbs and
@@ -3064,7 +3065,7 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
 		struct usb_device	*udev;
 
-		udev = hdev->children [port1-1];
+		udev = hub->ports[port1 - 1]->child;
 		if (udev && udev->can_submit) {
 			dev_warn(&intf->dev, "port %d nyet suspended\n", port1);
 			if (PMSG_IS_AUTO(msg))
@@ -3982,7 +3983,7 @@ hub_power_remaining (struct usb_hub *hub)
 
 	remaining = hdev->bus_mA - hub->descriptor->bHubContrCurrent;
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
-		struct usb_device	*udev = hdev->children[port1 - 1];
+		struct usb_device	*udev = hub->ports[port1 - 1]->child;
 		int			delta;
 
 		if (!udev)
@@ -4046,7 +4047,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 #endif
 
 	/* Try to resuscitate an existing device */
-	udev = hdev->children[port1-1];
+	udev = hub->ports[port1 - 1]->child;
 	if ((portstatus & USB_PORT_STAT_CONNECTION) && udev &&
 			udev->state != USB_STATE_NOTATTACHED) {
 		usb_lock_device(udev);
@@ -4075,7 +4076,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 
 	/* Disconnect any existing devices under this port */
 	if (udev)
-		usb_disconnect(&hdev->children[port1-1]);
+		usb_disconnect(&hub->ports[port1 - 1]->child);
 	clear_bit(port1, hub->change_bits);
 
 	/* We can forget about a "removed" device when there's a physical
@@ -4204,7 +4205,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		if (hdev->state == USB_STATE_NOTATTACHED)
 			status = -ENOTCONN;
 		else
-			hdev->children[port1-1] = udev;
+			hub->ports[port1 - 1]->child = udev;
 		spin_unlock_irq(&device_state_lock);
 
 		/* Run it through the hoops (find a driver, etc) */
@@ -4212,7 +4213,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 			status = usb_new_device(udev);
 			if (status) {
 				spin_lock_irq(&device_state_lock);
-				hdev->children[port1-1] = NULL;
+				hub->ports[port1 - 1]->child = NULL;
 				spin_unlock_irq(&device_state_lock);
 			}
 		}
@@ -4258,7 +4259,7 @@ static int hub_handle_remote_wakeup(struct usb_hub *hub, unsigned int port,
 	int ret;
 
 	hdev = hub->hdev;
-	udev = hdev->children[port-1];
+	udev = hub->ports[port - 1]->child;
 	if (!hub_is_superspeed(hdev)) {
 		if (!(portchange & USB_PORT_STAT_C_SUSPEND))
 			return 0;
@@ -4412,7 +4413,7 @@ static void hub_events(void)
 				 */
 				if (!(portstatus & USB_PORT_STAT_ENABLE)
 				    && !connect_change
-				    && hdev->children[i-1]) {
+				    && hub->ports[i - 1]->child) {
 					dev_err (hub_dev,
 					    "port %i "
 					    "disabled by hub (EMI?), "
@@ -4965,3 +4966,27 @@ void usb_queue_reset_device(struct usb_interface *iface)
 	schedule_work(&iface->reset_ws);
 }
 EXPORT_SYMBOL_GPL(usb_queue_reset_device);
+
+/**
+ * usb_get_hub_child - Get the pointer of child device
+ * attached to the port which is specified by @port1.
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port num to indicate which port the child device
+ *	is attached to.
+ *
+ * USB drivers call this function to get hub's child device
+ * pointer.
+ *
+ * Return NULL if input param is invalid and
+ * child's usb_device pointer if non-NULL.
+ */
+struct usb_device *usb_get_hub_child(struct usb_device *hdev,
+		int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port1 < 1 || port1 > hdev->maxchild)
+		return NULL;
+	return usb_get_dev(hub->ports[port1 - 1]->child);
+}
+EXPORT_SYMBOL_GPL(usb_get_hub_child);
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index c868be6..9a5a824 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2033,17 +2033,18 @@ static int r8a66597_get_frame(struct usb_hcd *hcd)
 static void collect_usb_address_map(struct usb_device *udev, unsigned long *map)
 {
 	int chix;
+	struct usb_device *childdev;
 
 	if (udev->state == USB_STATE_CONFIGURED &&
 	    udev->parent && udev->parent->devnum > 1 &&
 	    udev->parent->descriptor.bDeviceClass == USB_CLASS_HUB)
 		map[udev->devnum/32] |= (1 << (udev->devnum % 32));
 
-	for (chix = 0; chix < udev->maxchild; chix++) {
-		struct usb_device *childdev = udev->children[chix];
-
-		if (childdev)
+	usb_get_hub_each_child(udev, chix, childdev) {
+		if (childdev) {
+			usb_put_dev(childdev);
 			collect_usb_address_map(childdev, map);
+		}
 	}
 }
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index f717fbd..f034fb7 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -463,7 +463,6 @@ struct usb3_lpm_parameters {
  *	access from userspace
  * @usbfs_dentry: usbfs dentry entry for the device
  * @maxchild: number of ports if hub
- * @children: child devices - USB devices that are attached to this hub
  * @quirks: quirks of the whole device
  * @urbnum: number of URBs submitted for the whole device
  * @active_duration: total time device is not suspended
@@ -537,7 +536,6 @@ struct usb_device {
 	struct list_head filelist;
 
 	int maxchild;
-	struct usb_device **children;
 
 	u32 quirks;
 	atomic_t urbnum;
@@ -567,6 +565,20 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
 
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
 extern void usb_put_dev(struct usb_device *dev);
+extern struct usb_device *usb_get_hub_child(struct usb_device *hdev,
+	int port1);
+
+/**
+ * usb_get_hub_each_child - iterate over all child devices on the hub
+ * @hdev:  USB device belonging to the usb hub
+ * @port1: portnum associated with child device
+ * @child: child device pointer
+ *
+ */
+#define usb_get_hub_each_child(hdev, port1, child) \
+	for (port1 = 1,	child =	usb_get_hub_child(hdev, port1); \
+		port1 <= hdev->maxchild; \
+		child = usb_get_hub_child(hdev, ++port1))
 
 /* USB device locking */
 #define usb_lock_device(udev)		device_lock(&(udev)->dev)
-- 
1.7.6.rc2.8.g28eb

