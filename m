From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 1/8] USB: Set usb port's DeviceRemovable according acpi information
Date: Mon, 21 Jan 2013 22:18:00 +0800
Message-ID: <1358777887-2656-2-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

ACPI provide "_PLD" and "_UPC" aml methods to describe usb port
visibility and connectability. This patch is to add usb_hub_adjust_DeviceRemovable()
to adjust usb hub port's DeviceRemovable according ACPI information and invoke it in
the rh_call_control(). When hub descriptor request is issued at first time,
usb port device isn't created and usb port is not bound with acpi. So first
hub descriptor request is not changed based on ACPI information. After usb
port devices being created, call usb_hub_adjust_DeviceRemovable in the hub_configure()
and then set hub port's DeviceRemovable according ACPI information and this also works
for non-root hub.

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hcd.c |    4 ++++
 drivers/usb/core/hub.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h |    3 +++
 3 files changed, 50 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 5f6da8b..2459896 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -619,6 +619,10 @@ nongeneric:
 		status = hcd->driver->hub_control (hcd,
 			typeReq, wValue, wIndex,
 			tbuf, wLength);
+
+		if (typeReq == GetHubDescriptor)
+			usb_hub_adjust_deviceremovable(hcd->self.root_hub,
+				(struct usb_hub_descriptor *)tbuf);
 		break;
 error:
 		/* "protocol stall" on error */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index cfdd4ee..29ca6ed 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1513,6 +1513,8 @@ static int hub_configure(struct usb_hub *hub,
 			dev_err(hub->intfdev,
 				"couldn't create port%d device.\n", i + 1);
 
+	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
+
 	hub_activate(hub, HUB_INIT);
 	return 0;
 
@@ -5219,6 +5221,47 @@ usb_get_hub_port_connect_type(struct usb_device *hdev, int port1)
 	return hub->ports[port1 - 1]->connect_type;
 }
 
+void usb_hub_adjust_deviceremovable(struct usb_device *hdev,
+		struct usb_hub_descriptor *desc)
+{
+	enum usb_port_connect_type connect_type;
+	int i;
+
+	if (!hub_is_superspeed(hdev)) {
+		for (i = 1; i <= hdev->maxchild; i++) {
+			connect_type = usb_get_hub_port_connect_type(hdev, i);
+
+			if (connect_type == USB_PORT_CONNECT_TYPE_HARD_WIRED) {
+				u8 mask = 1 << (i%8);
+
+				if (!(desc->u.hs.DeviceRemovable[i/8] & mask)) {
+					dev_dbg(&hdev->dev, "usb port%d's DeviceRemovable is changed to 1 according to platform information.\n",
+						i);
+					desc->u.hs.DeviceRemovable[i/8]	|= mask;
+				}
+			}
+		}
+	} else {
+		u16 port_removable = le16_to_cpu(desc->u.ss.DeviceRemovable);
+
+		for (i = 1; i <= hdev->maxchild; i++) {
+			connect_type = usb_get_hub_port_connect_type(hdev, i);
+
+			if (connect_type == USB_PORT_CONNECT_TYPE_HARD_WIRED) {
+				u16 mask = 1 << i;
+
+				if (!(port_removable & mask)) {
+					dev_dbg(&hdev->dev, "usb port%d's DeviceRemovable is changed to 1 according to platform information.\n",
+						i);
+					port_removable |= mask;
+				}
+			}
+		}
+
+		desc->u.ss.DeviceRemovable = cpu_to_le16(port_removable);
+	}
+}
+
 #ifdef CONFIG_ACPI
 /**
  * usb_get_hub_port_acpi_handle - Get the usb port's acpi handle
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index fb7d8fc..a7f20bd 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -1,6 +1,7 @@
 #include <linux/pm.h>
 #include <linux/acpi.h>
 
+struct usb_hub_descriptor;
 struct dev_state;
 
 /* Functions local to drivers/usb/core/ */
@@ -182,6 +183,8 @@ extern enum usb_port_connect_type
 	usb_get_hub_port_connect_type(struct usb_device *hdev, int port1);
 extern void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
 	enum usb_port_connect_type type);
+extern void usb_hub_adjust_deviceremovable(struct usb_device *hdev,
+		struct usb_hub_descriptor *desc);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
