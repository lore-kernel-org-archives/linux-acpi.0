From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 5/8] usb: add usb port auto power off mechanism
Date: Mon, 21 Jan 2013 22:18:04 +0800
Message-ID: <1358777887-2656-6-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch is to add usb port auto power off mechanism.
When usb device is suspending, usb core will suspend usb port and
usb port runtime pm callback will clear PORT_POWER feature to
power off port if all conditions were met. These conditions are
remote wakeup disable, pm qos NO_POWER_OFF flag clear and persist
enable. When it resumes, power on port again. Add did_runtime_put
in the struct usb_port in order to call pm_runtime_get/put(portdev)
paired during suspending and resuming.

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c  |   67 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/usb/core/hub.h  |    9 +++++++
 drivers/usb/core/port.c |   40 ++++++++++++++++++++++++++--
 3 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8c1f9a5..786db99 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/freezer.h>
 #include <linux/random.h>
+#include <linux/pm_qos.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -108,7 +109,7 @@ MODULE_PARM_DESC(use_both_schemes,
 DECLARE_RWSEM(ehci_cf_port_reset_rwsem);
 EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 
-#define HUB_DEBOUNCE_TIMEOUT	1500
+#define HUB_DEBOUNCE_TIMEOUT	2000
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
@@ -127,7 +128,7 @@ static inline char *portspeed(struct usb_hub *hub, int portstatus)
 }
 
 /* Note that hdev or one of its children must be locked! */
-static struct usb_hub *hdev_to_hub(struct usb_device *hdev)
+struct usb_hub *hdev_to_hub(struct usb_device *hdev)
 {
 	if (!hdev || !hdev->actconfig || !hdev->maxchild)
 		return NULL;
@@ -393,7 +394,7 @@ static int clear_hub_feature(struct usb_device *hdev, int feature)
 /*
  * USB 2.0 spec Section 11.24.2.2
  */
-static int clear_port_feature(struct usb_device *hdev, int port1, int feature)
+int clear_port_feature(struct usb_device *hdev, int port1, int feature)
 {
 	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
 		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
@@ -718,11 +719,16 @@ int usb_hub_set_port_power(struct usb_device *hdev, int port1,
 		bool set)
 {
 	int ret;
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	struct usb_port *port_dev = hub->ports[port1 - 1];
 
 	if (set)
 		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 	else
 		ret = clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+
+	if (!ret)
+		port_dev->power_is_on = set;
 	return ret;
 }
 
@@ -802,7 +808,11 @@ static unsigned hub_power_on(struct usb_hub *hub, bool do_delay)
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
 	for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
-		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
+		if (hub->ports[port1 - 1]->power_is_on)
+			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
+		else
+			clear_port_feature(hub->hdev, port1,
+						USB_PORT_FEAT_POWER);
 
 	/* Wait at least 100 msec for power to become stable */
 	delay = max(pgood_delay, (unsigned) 100);
@@ -1134,10 +1144,16 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 				set_bit(port1, hub->change_bits);
 
 		} else if (udev->persist_enabled) {
+			struct usb_port *port_dev = hub->ports[port1 - 1];
+
 #ifdef CONFIG_PM
 			udev->reset_resume = 1;
 #endif
-			set_bit(port1, hub->change_bits);
+			/* Don't set the change_bits when the device
+			 * was powered off.
+			 */
+			if (port_dev->power_is_on)
+				set_bit(port1, hub->change_bits);
 
 		} else {
 			/* The power session is gone; tell khubd */
@@ -2012,7 +2028,10 @@ void usb_disconnect(struct usb_device **pdev)
 		sysfs_remove_link(&udev->dev.kobj, "port");
 		sysfs_remove_link(&port_dev->dev.kobj, "device");
 
-		pm_runtime_put(&port_dev->dev);
+		if (!port_dev->did_runtime_put)
+			pm_runtime_put(&port_dev->dev);
+		else
+			port_dev->did_runtime_put = false;
 	}
 
 	usb_remove_ep_devs(&udev->ep0);
@@ -2844,6 +2863,8 @@ EXPORT_SYMBOL_GPL(usb_enable_ltm);
 int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 {
 	struct usb_hub	*hub = hdev_to_hub(udev->parent);
+	struct usb_port *port_dev = hub->ports[udev->portnum - 1];
+	enum pm_qos_flags_status pm_qos_stat;
 	int		port1 = udev->portnum;
 	int		status;
 
@@ -2936,6 +2957,21 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		udev->port_is_suspended = 1;
 		msleep(10);
 	}
+
+	/*
+	 * Check whether current status meets the requirement of
+	 * usb port power off mechanism
+	 */
+	pm_qos_stat = dev_pm_qos_flags(&port_dev->dev,
+			PM_QOS_FLAG_NO_POWER_OFF);
+	if (!udev->do_remote_wakeup
+			&& pm_qos_stat != PM_QOS_FLAGS_ALL
+			&& udev->persist_enabled
+			&& !status) {
+		pm_runtime_put_sync(&port_dev->dev);
+		port_dev->did_runtime_put = true;
+	}
+
 	usb_mark_last_busy(hub->hdev);
 	return status;
 }
@@ -3062,10 +3098,21 @@ static int finish_port_resume(struct usb_device *udev)
 int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 {
 	struct usb_hub	*hub = hdev_to_hub(udev->parent);
+	struct usb_port *port_dev = hub->ports[udev->portnum  - 1];
 	int		port1 = udev->portnum;
 	int		status;
 	u16		portchange, portstatus;
 
+	if (port_dev->did_runtime_put) {
+		status = pm_runtime_get_sync(&port_dev->dev);
+		port_dev->did_runtime_put = false;
+		if (status < 0) {
+			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
+					status);
+			return status;
+		}
+	}
+
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
 	if (status == 0 && !port_is_suspended(hub, portstatus))
@@ -3744,7 +3791,7 @@ EXPORT_SYMBOL_GPL(usb_enable_ltm);
  * every 25ms for transient disconnects.  When the port status has been
  * unchanged for 100ms it returns the port status.
  */
-static int hub_port_debounce(struct usb_hub *hub, int port1)
+int hub_port_debounce(struct usb_hub *hub, int port1, bool must_be_connected)
 {
 	int ret;
 	int total_time, stable_time = 0;
@@ -3758,7 +3805,9 @@ static int hub_port_debounce(struct usb_hub *hub, int port1)
 
 		if (!(portchange & USB_PORT_STAT_C_CONNECTION) &&
 		     (portstatus & USB_PORT_STAT_CONNECTION) == connection) {
-			stable_time += HUB_DEBOUNCE_STEP;
+			if (!must_be_connected || (connection
+					== USB_PORT_STAT_CONNECTION))
+				stable_time += HUB_DEBOUNCE_STEP;
 			if (stable_time >= HUB_DEBOUNCE_STABLE)
 				break;
 		} else {
@@ -4279,7 +4328,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 
 	if (portchange & (USB_PORT_STAT_C_CONNECTION |
 				USB_PORT_STAT_C_ENABLE)) {
-		status = hub_port_debounce(hub, port1);
+		status = hub_port_debounce(hub, port1, false);
 		if (status < 0) {
 			if (printk_ratelimit())
 				dev_err(hub_dev, "connect-debounce failed, "
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 8ea6bc8..ccd4795 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -80,6 +80,8 @@ struct usb_hub {
  * @port_owner: port's owner
  * @connect_type: port's connect type
  * @portnum: port index num based one
+ * @power_is_on: port's power state
+ * @did_runtime_put: port has done pm_runtime_put().
  */
 struct usb_port {
 	struct usb_device *child;
@@ -87,6 +89,8 @@ struct usb_port {
 	struct dev_state *port_owner;
 	enum usb_port_connect_type connect_type;
 	u8 portnum;
+	unsigned power_is_on:1;
+	unsigned did_runtime_put:1;
 };
 
 #define to_usb_port(_dev) \
@@ -98,4 +102,9 @@ extern void usb_hub_remove_port_device(struct usb_hub *hub,
 		int port1);
 extern int usb_hub_set_port_power(struct usb_device *hdev,
 		int port1, bool set);
+extern struct usb_hub *hdev_to_hub(struct usb_device *hdev);
+extern int hub_port_debounce(struct usb_hub *hub, int port1,
+		bool must_be_connected);
+extern int clear_port_feature(struct usb_device *hdev,
+		int port1, int feature);
 
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index bd08f7e..dc1aaec 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -77,10 +77,36 @@ static int usb_port_runtime_resume(struct device *dev)
 	struct usb_port *port_dev = to_usb_port(dev);
 	struct usb_device *hdev = to_usb_device(dev->parent->parent);
 	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	int port1 = port_dev->portnum;
 	int retval;
 
+	if (!hub)
+		return -EINVAL;
+
 	usb_autopm_get_interface(intf);
-	retval = usb_hub_set_port_power(hdev, port_dev->portnum, true);
+	set_bit(port1, hub->busy_bits);
+
+	retval = usb_hub_set_port_power(hdev, port1, true);
+	if (port_dev->child && !retval) {
+		/*
+		 * Wait for usb hub port to be reconnected in order to make
+		 * the resume procedure successful.
+		 */
+		retval = hub_port_debounce(hub, port1, true);
+		if (retval < 0) {
+			dev_dbg(&port_dev->dev, "can't get reconnection after setting port  power on, status %d\n",
+					retval);
+			goto out;
+		}
+		clear_port_feature(hdev, port1,	USB_PORT_FEAT_C_ENABLE);
+
+		/* Set return value to 0 if debounce successful */
+		retval = 0;
+	}
+
+out:
+	clear_bit(port1, hub->busy_bits);
 	usb_autopm_put_interface(intf);
 	return retval;
 }
@@ -90,14 +116,23 @@ static int usb_port_runtime_suspend(struct device *dev)
 	struct usb_port *port_dev = to_usb_port(dev);
 	struct usb_device *hdev = to_usb_device(dev->parent->parent);
 	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	int port1 = port_dev->portnum;
 	int retval;
 
+	if (!hub)
+		return -EINVAL;
+
 	if (dev_pm_qos_flags(&port_dev->dev, PM_QOS_FLAG_NO_POWER_OFF)
 			== PM_QOS_FLAGS_ALL)
 		return -EAGAIN;
 
 	usb_autopm_get_interface(intf);
-	retval = usb_hub_set_port_power(hdev, port_dev->portnum, false);
+	set_bit(port1, hub->busy_bits);
+	retval = usb_hub_set_port_power(hdev, port1, false);
+	clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
+	clear_port_feature(hdev, port1,	USB_PORT_FEAT_C_ENABLE);
+	clear_bit(port1, hub->busy_bits);
 	usb_autopm_put_interface(intf);
 	return retval;
 }
@@ -130,6 +165,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 
 	hub->ports[port1 - 1] = port_dev;
 	port_dev->portnum = port1;
+	port_dev->power_is_on = true;
 	port_dev->dev.parent = hub->intfdev;
 	port_dev->dev.groups = port_dev_group;
 	port_dev->dev.type = &usb_port_device_type;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
