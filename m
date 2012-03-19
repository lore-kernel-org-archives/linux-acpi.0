From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 2/4] usb: add platform_data in the struct usb_hub_port
Date: Mon, 19 Mar 2012 22:33:44 +0800
Message-ID: <1332167626-5806-2-git-send-email-tianyu.lan@intel.com>
References: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332167626-5806-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add the member platform_data in the usb_hub_port to store port's
platform related data. Provide usb_set_hub_port_platform_data() and
usb_get_hub_port_platform_data() to access the member.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c |   23 +++++++++++++++++++++++
 drivers/usb/core/usb.h |    4 ++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4c20c34..af391cb 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -39,6 +39,7 @@
 
 struct usb_hub_port {
 	void			*port_owner;
+	unsigned long		platform_data;
 };
 
 struct usb_hub {
@@ -4150,3 +4151,25 @@ void usb_queue_reset_device(struct usb_interface *iface)
 	schedule_work(&iface->reset_ws);
 }
 EXPORT_SYMBOL_GPL(usb_queue_reset_device);
+
+int usb_set_hub_port_platform_data(struct usb_device *udev, int port,
+	unsigned long data)
+{
+	struct usb_hub *hub = hdev_to_hub(udev);
+
+	if (port > hub->descriptor->bNbrPorts || port < 1)
+		return -EINVAL;
+	hub->port_data[port - 1].platform_data = data;
+	return 0;
+}
+
+int usb_get_hub_port_platform_data(struct usb_device *udev, int port,
+	unsigned long *data)
+{
+	struct usb_hub *hub = hdev_to_hub(udev);
+
+	if (port > hub->descriptor->bNbrPorts || port < 1)
+		return -EINVAL;
+	*data = hub->port_data[port - 1].platform_data;
+	return 0;
+}
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 636d98e..3e70565 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -154,6 +154,10 @@ extern void usb_notify_add_device(struct usb_device *udev);
 extern void usb_notify_remove_device(struct usb_device *udev);
 extern void usb_notify_add_bus(struct usb_bus *ubus);
 extern void usb_notify_remove_bus(struct usb_bus *ubus);
+extern int usb_get_hub_port_platform_data(struct usb_device *udev,
+		int port, unsigned long *data);
+extern int usb_set_hub_port_platform_data(struct usb_device *udev,
+		int port, unsigned long data);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
