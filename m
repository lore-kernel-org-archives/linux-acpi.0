From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V4 2/8] usb: make usb port a real device
Date: Thu, 28 Jun 2012 15:31:36 +0800
Message-ID: <1340868702-1894-3-git-send-email-tianyu.lan@intel.com>
References: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340868702-1894-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch is to make usb port a real device under usb hub interface.
Move port_owner to struct usb_port.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c |   93 +++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4cc8dc9..c19e088 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -37,6 +37,12 @@
 #endif
 #endif
 
+struct usb_port {
+	struct usb_device *udev;
+	struct device dev;
+	struct dev_state *port_owner;
+};
+
 struct usb_hub {
 	struct device		*intfdev;	/* the "interface" device */
 	struct usb_device	*hdev;
@@ -81,7 +87,11 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
-	struct dev_state	**port_owners;
+	struct usb_port		**ports;
+};
+
+struct device_type usb_port_device_type = {
+	.name =		"usb_port",
 };
 
 static inline int hub_is_superspeed(struct usb_device *hdev)
@@ -154,6 +164,8 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
+#define to_usb_port(_dev) \
+	container_of(_dev, struct usb_port, dev)
 
 static int usb_reset_and_verify_device(struct usb_device *udev);
 
@@ -1220,6 +1232,49 @@ static int hub_post_reset(struct usb_interface *intf)
 	return 0;
 }
 
+static void usb_port_device_release(struct device *dev)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	kfree(port_dev);
+}
+
+static void usb_hub_remove_port_device(struct usb_hub *hub,
+				       int port1)
+{
+	device_unregister(&hub->ports[port1 - 1]->dev);
+}
+
+static int usb_hub_create_port_device(struct usb_hub *hub,
+				      int port1)
+{
+	struct usb_port *port_dev = NULL;
+	int retval;
+
+	port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
+	if (!port_dev) {
+		retval = -ENOMEM;
+		goto exit;
+	}
+
+	hub->ports[port1 - 1] = port_dev;
+	port_dev->udev = hub->hdev;
+	port_dev->dev.parent = hub->intfdev;
+	port_dev->dev.type = &usb_port_device_type;
+	port_dev->dev.release = usb_port_device_release;
+	dev_set_name(&port_dev->dev, "port%d", port1);
+
+	retval = device_register(&port_dev->dev);
+	if (retval)
+		goto error_register;
+	return 0;
+
+error_register:
+	put_device(&port_dev->dev);
+exit:
+	return retval;
+}
+
 static int hub_configure(struct usb_hub *hub,
 	struct usb_endpoint_descriptor *endpoint)
 {
@@ -1229,7 +1284,7 @@ static int hub_configure(struct usb_hub *hub,
 	u16 hubstatus, hubchange;
 	u16 wHubCharacteristics;
 	unsigned int pipe;
-	int maxp, ret;
+	int maxp, ret, i;
 	char *message = "out of memory";
 
 	hub->buffer = kmalloc(sizeof(*hub->buffer), GFP_KERNEL);
@@ -1271,9 +1326,9 @@ static int hub_configure(struct usb_hub *hub,
 
 	hdev->children = kzalloc(hdev->maxchild *
 				sizeof(struct usb_device *), GFP_KERNEL);
-	hub->port_owners = kzalloc(hdev->maxchild * sizeof(struct dev_state *),
-				GFP_KERNEL);
-	if (!hdev->children || !hub->port_owners) {
+	hub->ports = kzalloc(hdev->maxchild * sizeof(struct usb_port *),
+			     GFP_KERNEL);
+	if (!hdev->children || !hub->ports) {
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -1482,6 +1537,11 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
+	for (i = 0; i < hdev->maxchild; i++)
+		if (usb_hub_create_port_device(hub, i + 1) < 0)
+			dev_err(hub->intfdev, "couldn't create port%d "
+				"device.\n", i + 1);
+
 	hub_activate(hub, HUB_INIT);
 	return 0;
 
@@ -1506,6 +1566,10 @@ static void hub_disconnect(struct usb_interface *intf)
 {
 	struct usb_hub *hub = usb_get_intfdata(intf);
 	struct usb_device *hdev = interface_to_usbdev(intf);
+	int i;
+
+	for (i = 0; i < hdev->maxchild; i++)
+		usb_hub_remove_port_device(hub, i + 1);
 
 	/* Take the hub off the event list and don't let it be added again */
 	spin_lock_irq(&hub_event_lock);
@@ -1528,7 +1592,7 @@ static void hub_disconnect(struct usb_interface *intf)
 
 	usb_free_urb(hub->urb);
 	kfree(hdev->children);
-	kfree(hub->port_owners);
+	kfree(hub->ports);
 	kfree(hub->descriptor);
 	kfree(hub->status);
 	kfree(hub->buffer);
@@ -1660,7 +1724,7 @@ static int find_port_owner(struct usb_device *hdev, unsigned port1,
 	/* This assumes that devices not managed by the hub driver
 	 * will always have maxchild equal to 0.
 	 */
-	*ppowner = &(hdev_to_hub(hdev)->port_owners[port1 - 1]);
+	*ppowner = &(hdev_to_hub(hdev)->ports[port1 - 1]->port_owner);
 	return 0;
 }
 
@@ -1697,16 +1761,14 @@ int usb_hub_release_port(struct usb_device *hdev, unsigned port1,
 
 void usb_hub_release_all_ports(struct usb_device *hdev, struct dev_state *owner)
 {
+	struct usb_hub *hub = hdev_to_hub(hdev);
 	int n;
-	struct dev_state **powner;
 
-	n = find_port_owner(hdev, 1, &powner);
-	if (n == 0) {
-		for (; n < hdev->maxchild; (++n, ++powner)) {
-			if (*powner == owner)
-				*powner = NULL;
-		}
+	for (n = 0; n < hdev->maxchild; n++) {
+		if (hub->ports[n]->port_owner == owner)
+			hub->ports[n]->port_owner = NULL;
 	}
+
 }
 
 /* The caller must hold udev's lock */
@@ -1717,10 +1779,9 @@ bool usb_device_is_owned(struct usb_device *udev)
 	if (udev->state == USB_STATE_NOTATTACHED || !udev->parent)
 		return false;
 	hub = hdev_to_hub(udev->parent);
-	return !!hub->port_owners[udev->portnum - 1];
+	return !!hub->ports[udev->portnum - 1]->port_owner;
 }
 
