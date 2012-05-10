From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH] usb/acpi: Add support usb port power off mechanism for device fixed on the motherboard
Date: Thu, 10 May 2012 16:33:58 +0800
Message-ID: <1336638838-6157-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46947 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757401Ab2EJIj2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2012 04:39:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

hi all:
	Currently, we are working on usb port power off mechanism. Our developing
machine provides usb port power control (a vbus switch)via ACPI power resource.
When the power resource turns off, usb port powers off and usb device loses
power. From usb hub side, just like the device being unplugged.

	Since usb port power off will affect hot-plug and devices remote wakeup
function, it should be careful to do that.
	We conclude three different situations for power off mechanism.
	(1) hard-wired port with device
	(2) hot-pluggable port without device
	(3) hot-pluggable port with device

For hard-wired port, the device will not be removed physically. So we can
power off it when device is suspended and remote wakeup is disabled without
concerning with hot-plug. This patch is dedicated to this siutation.

This patch is to provide usb acpi power control method and call them in the
usb_port_suspend() and usb_port_resume() when port can be power off. When the
usb port is in the power off state, usb core doesn't remove device which is
attached to the port. The device is still on the system and user can access
the device.

introduce three port's states.

USB_PORT_POWER_STATE_ON
USB_PORT_WAITING_FOR_CONNECTION
USB_PORT_POWER_STATE_OFF

"on"
	port power on

"waiting for connection"
	port power on but hub port has not detected the device or detect event has
not been processed.

"off"
	port power off

At first, port's state is "on". When the device is suspended, power off the port and
set port's state to "off". After the port powering off, the usb hub will detect a
connection change event. Normally, the device will be removed with regarding as being
unplugged. But in the power off mechanism, the device is still on the port and user
can still access the device. So ignore the event.

When the device is resumed, turn on the power resource and set port's state to
"waiting for connection". After the port powering on, the usb hub will detect a
connection change event which originally means a device plugged in and previous
device will be removed. But in the power offmechanism, the device is not changed
and so ignore the event. When port's state is "waiting for connection", receive
an event "connection" and the port's connection state is on. This means the usb
the device is detected by usb hub again after powering on port. Set port's state
to "on".

 "on"
  |
 "off"
  |
 "waiting for connection"
  |
 "on"

"waiting for connection" state is to avoid device to being removed.
If set to "on" after powering on, the connection event may not be processed at that
time. When it is processed, the port's state has been "on" and the device will be
removed. So introduce "waiting for connection" state.

We also have a proposal to add sys file for each port to control port power off
under usb hub sys directory. If the port's power off is supported by platform,
create a sys file e.g "port1_power"  for port one. Echo "on" to "port1_power" is
to not allow port to be power off. Echo "auto" to "port1_power" is to power off
port if possible.

Different type ports have different default values.
(1) hard-wired port with device				"auto"
(2) hot-pluggable port without device		"on"
(3) hot-pluggable port with device			"on"

Add member port_power_control, can_power_off  to struct usb_hub_port. port_power_control
records user choice. Can_power_off means the platform and device support to power off.
When a device is attached, check whether port can be power off if yes set can_power_off
to true. When device driver is load, the driver also can set value to can_power_off. When
try to power off port, can_power_off and port_power_control should be taken into account.
Only when these two members  are set to true, the port could be power off.

sys file operation
port with device
 port1_power "auto" => "on" or "on" => "auto" implement
	pm_runtime_get_syn(udev)
	port_power_control = "auto" or "on"
	pm_runtime_put_syn(udev)

port without device
	port can power on or power power off directly.

Suggestion and comments more welcome.
---
 drivers/usb/core/hub.c      |   95 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb-acpi.c |   33 ++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6c16ff5..d28d605 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -42,6 +42,7 @@ struct usb_hub_port {
 	struct usb_device	*child;
 	unsigned long		platform_data;
 	enum usb_port_connect_type connect_type;
+	unsigned		power_state:2; /* the power state of usb port */
 };
 
 struct usb_hub {
@@ -161,8 +162,14 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
+#define USB_PORT_POWER_STATE_ON		0
+#define USB_PORT_WAITING_FOR_CONNECTION 1
+#define USB_PORT_POWER_STATE_OFF	2
+
+#define HUB_PORT_RECONNECT_TRIES	20
 
 static int usb_reset_and_verify_device(struct usb_device *udev);
+static int hub_port_debounce(struct usb_hub *hub, int port1);
 
 static inline char *portspeed(struct usb_hub *hub, int portstatus)
 {
@@ -2518,6 +2525,24 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		usb_set_device_state(udev, USB_STATE_SUSPENDED);
 		msleep(10);
 	}
+
+	/*
+	 * Check whether the usb port has acpi power control method.
+	 * Devices on the motherboard can be power off without
+ 	 * considing hot-plug. When the device's remote wakeup is
+	 * enabled, it can't be power off since the function will
+	 * loss when power off.
+	 */
+	If (usb_acpi_power_manageable(hub->hdev, port1) &&
+		hub->port_data[port1 - 1].connect_type ==
+		USB_PORT_CONNECT_TYPE_HARD_WIRED &&
+		!udev->do_remote_wakeup && !status) {
+		status = usb_acpi_set_power_state(hub->hdev, port1, false);
+		if (!status)
+			hub->port_data[port1 - 1].power_state
+				= USB_PORT_POWER_STATE_OFF;
+	}
+
 	usb_mark_last_busy(hub->hdev);
 	return status;
 }
@@ -2602,6 +2627,23 @@ static int finish_port_resume(struct usb_device *udev)
 }
 
 /*
+ * There is a latency  between usb port power on and usb hub port
+ * connect detection. The latency depends on devices. This routine
+ * is to wait for connect within 20 tries.
+ */
+static int usb_port_wait_for_connected(struct usb_hub *hub, int port1)
+{
+	int status, i;
+
+	for (i = 0; i < HUB_PORT_RECONNECT_TRIES; i++) {
+		status = hub_port_debounce(hub, port1);
+		if (status & USB_PORT_STAT_CONNECTION)
+			return 0;
+	}
+	return -ETIMEDOUT;
+}
+
+/*
  * usb_port_resume - re-activate a suspended usb device's upstream port
  * @udev: device to re-activate, not a root hub
  * Context: must be able to sleep; device not locked; pm locks held
@@ -2642,6 +2684,37 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 	int		status;
 	u16		portchange, portstatus;
 
+	/*
+	 * Check whether the usb port has acpi power control method
+	 * and if its power state is not on, power on the usb port.
+	 */
+	if (usb_acpi_power_manageable(hub->hdev, port1)
+		&& hub->port_data[port1 - 1].power_state
+		!= USB_PORT_POWER_STATE_ON) {
+		status = usb_acpi_set_power_state(hub->hdev, port1, true);
+		if (status < 0)
+			return status;
+
+		/*
+		 * After powering on, the port state is set to "waiting
+		 * for connection".
+		 */
+		hub->port_data[port1 - 1].power_state
+			= USB_PORT_WAITING_FOR_CONNECTION;
+
+		/*
+		 * Wait for usb hub port to be reconnected in order to make
+		 * the resume procedure successful.
+		 */
+		status = usb_port_wait_for_connected(hub, port1);
+		if (status < 0) {
+			dev_dbg(&udev->dev, "can't get reconnection after" \
+				" setting  port on, status %d\n", status);
+			return status;
+		}
+
+	}
+
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
 	if (status == 0 && !port_is_suspended(hub, portstatus))
@@ -3362,6 +3435,28 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		}
 	}
 
+	/*
+	 * When the usb port's state are power off, the device
+	 * should not be removed in order to resume it if necessary.
+	 * When the usb port's states are waiting for connection,
+	 * not remove device and check the usb hub port's connect
+	 * state. If it has been connected, set the usb port's state
+	 * "on".
+	 */
+	if (hub->port_data[port1 - 1].power_state == USB_PORT_POWER_STATE_OFF) {
+		clear_bit(port1, hub->change_bits);
+		return;
+	} else if (hub->port_data[port1 - 1].power_state
+			 == USB_PORT_WAITING_FOR_CONNECTION) {
+		if (portstatus & USB_PORT_STAT_CONNECTION
+		    && portchange & USB_PORT_STAT_C_CONNECTION) {
+			hub->port_data[port1 - 1].power_state
+				= USB_PORT_POWER_STATE_ON;
+		}
+		clear_bit(port1, hub->change_bits);
+		return;
+	}
+
 	/* Disconnect any existing devices under this port */
 	if (udev)
 		usb_disconnect(&hub->port_data[port1-1].child);
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 02739b47..3b091e8 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,6 +19,32 @@
 
 #include "usb.h"
 
+bool usb_acpi_power_manageable(struct usb_device *hdev, int port1)
+{
+	acpi_handle port_handle;
+
+	port_handle = (acpi_handle)usb_get_hub_port_platform_data(hdev,
+		port1);
+	return port_handle ? acpi_bus_power_manageable(port_handle) : false;
+}
+
+int usb_acpi_set_power_state(struct usb_device *hdev, int port1, bool enable)
+{
+	acpi_handle port_handle;
+	unsigned char state;
+	int error = -EINVAL;
+
+	port_handle = (acpi_handle)usb_get_hub_port_platform_data(hdev,
+		port1);
+	state = enable ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD;
+	error = acpi_bus_set_power(port_handle, state);
+	if (!error)
+		dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
+			port1, enable ? "enable" : "disabe");
+
+	return error;
+}
+
 static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
 	acpi_handle handle, int port1)
 {
@@ -55,9 +81,14 @@ static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
 				pld.user_visible ?
 					USB_PORT_CONNECT_TYPE_HOT_PLUG :
 					USB_PORT_CONNECT_TYPE_HARD_WIRED);
-	else if (!pld.user_visible)
+	else if (!pld.user_visible) {
 		usb_set_hub_port_connect_type(hdev, port1, USB_PORT_NOT_USED);
 
+		/* Power off the usb port which may not be used.*/
+		if (usb_acpi_power_manageable(hdev, port1))
+			usb_acpi_set_power_state(hdev, port1, false);
+	}
+
 out:
 	kfree(upc);
 	return ret;
-- 
1.7.6.rc2.8.g28eb

