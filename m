From: yakui.zhao@intel.com
Subject: [PATCH_v7 2/2] ACPI/IPMI: Add the IPMI opregion driver to enable ACPI to access BMC controller
Date: Wed, 14 Jul 2010 20:54:54 +0800
Message-ID: <1279112094-16749-3-git-send-email-yakui.zhao@intel.com>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com>
 <1279112094-16749-2-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51338 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab0GNM6i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 08:58:38 -0400
In-Reply-To: <1279112094-16749-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, minyard@acm.org, bjorn.helgaas@hp.com, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

ACPI 4.0 spec adds the ACPI IPMI opregion, which means that the ACPI AML
code can also communicate with the BMC controller. This is to install
the ACPI IPMI opregion and enable the ACPI to access the BMC controller
through the IPMI message.

     It will create IPMI user interface for every IPMI device detected
in ACPI namespace and install the corresponding IPMI opregion space handler.
Then it can enable ACPI to access the BMC controller through the IPMI
message.

The following describes how to process the IPMI request in IPMI space handler:
    1. format the IPMI message based on the request in AML code.
    IPMI system address. Now the address type is SYSTEM_INTERFACE_ADDR_TYPE
    IPMI net function & command
    IPMI message payload
    2. send the IPMI message by using the function of ipmi_request_settime
    3. wait for the completion of IPMI message.
    4. format the IPMI response and return it to ACPI AML code.

At the same time it also addes the module dependency. The ACPI IPMI opregion
will depend on the IPMI subsystem.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Kconfig     |   10 +
 drivers/acpi/Makefile    |    1 +
 drivers/acpi/acpi_ipmi.c |  551 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 562 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/acpi_ipmi.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7464115..0fa6a01 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -204,6 +204,16 @@ config ACPI_PROCESSOR
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
+config ACPI_IPMI
+	tristate "IPMI"
+	depends on EXPERIMENTAL && IPMI_SI && IPMI_HANDLER
+	default n
+	help
+	  This driver enables the ACPI to access the BMC controller. And it
+	  uses the IPMI request/response message to communicate with BMC
+	  controller, which can be found on on the server.
+
+	  To compile this driver as a module, choose M here:
 
 config ACPI_HOTPLUG_CPU
 	bool
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 6ee3316..5ca31f1 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -67,5 +67,6 @@ processor-y			+= processor_idle.o processor_thermal.o
 processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
 
 obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
+obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
 
 obj-$(CONFIG_ACPI_APEI)		+= apei/
diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
new file mode 100644
index 0000000..3e674df
--- /dev/null
+++ b/drivers/acpi/acpi_ipmi.c
@@ -0,0 +1,551 @@
+/*
+ *  ipmi.c - ACPI IPMI opregion
+ *
+ *  Copyright (C) 2010 Intel Corporation
+ *  Copyright (C) 2010 Zhao Yakui <yakui.zhao@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/ipmi.h>
+#include <linux/device.h>
+#include <linux/pnp.h>
+
+MODULE_AUTHOR("Zhao Yakui");
+MODULE_DESCRIPTION("ACPI IPMI Opregion driver");
+MODULE_LICENSE("GPL");
+
+#define IPMI_FLAGS_HANDLER_INSTALL	0
+
+#define ACPI_IPMI_OK			0
+#define ACPI_IPMI_TIMEOUT		0x10
+#define ACPI_IPMI_UNKNOWN		0x07
+/* the IPMI timeout is 5s */
+#define IPMI_TIMEOUT			(5 * HZ)
+
+struct acpi_ipmi_device {
+	/* the device list attached to driver_data.ipmi_devices */
+	struct list_head head;
+	/* the IPMI request message list */
+	struct list_head tx_msg_list;
+	acpi_handle handle;
+	struct pnp_dev	*pnp_dev;
+	ipmi_user_t	user_interface;
+	struct mutex	mutex_lock;
+	int ipmi_ifnum; /* IPMI interface number */
+	long curr_msgid;
+	unsigned long flags;
+};
+
+struct ipmi_driver_data {
+	int device_count;
+	struct list_head	ipmi_devices;
+	struct ipmi_smi_watcher	bmc_events;
+	struct ipmi_user_hndl	ipmi_hndlrs;
+};
+
+struct acpi_ipmi_msg {
+	struct list_head head;
+	/*
+	 * General speaking the addr type should be SI_ADDR_TYPE. And
+	 * the addr channel should be BMC.
+	 * In fact it can also be IPMB type. But we will have to
+	 * parse it from the Netfn command buffer. It is so complex
+	 * that it is skipped.
+	 */
+	struct ipmi_addr addr;
+	long tx_msgid;
+	/* it is used to track whether the IPMI message is finished */
+	struct completion tx_complete;
+	struct kernel_ipmi_msg tx_message;
+	int	msg_done;
+	/* tx data . And copy it from ACPI object buffer */
+	u8	tx_data[64];
+	int	tx_len;
+	u8	rx_data[64];
+	int	rx_len;
+	struct acpi_ipmi_device *device;
+};
+
+/* IPMI request/response buffer per ACPI 4.0, sec 5.5.2.4.3.2 */
+struct acpi_ipmi_buffer {
+	u8 status;
+	u8 length;
+	u8 data[64];
+};
+
+static void ipmi_register_bmc(int iface, struct device *dev);
+static void ipmi_bmc_gone(int iface);
+static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);
+
+static struct ipmi_driver_data driver_data = {
+	.ipmi_devices = LIST_HEAD_INIT(driver_data.ipmi_devices),
+	.bmc_events = {
+		.owner = THIS_MODULE,
+		.new_smi = ipmi_register_bmc,
+		.smi_gone = ipmi_bmc_gone,
+	},
+	.ipmi_hndlrs = {
+		.ipmi_recv_hndl = ipmi_msg_handler,
+	},
+};
+
+
+struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
+{
+	struct acpi_ipmi_msg *ipmi_msg;
+	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
+
+	ipmi_msg = kzalloc(sizeof(struct acpi_ipmi_msg), GFP_KERNEL);
+	if (!ipmi_msg)	{
+		dev_warn(&pnp_dev->dev, "Can't allocate memory for ipmi_msg\n");
+		return NULL;
+	}
+	init_completion(&ipmi_msg->tx_complete);
+	INIT_LIST_HEAD(&ipmi_msg->head);
+	ipmi_msg->device = ipmi;
+	return ipmi_msg;
+}
+
+#define		IPMI_OP_RGN_NETFN(offset)	((offset >> 8) & 0xff)
+#define		IPMI_OP_RGN_CMD(offset)		(offset & 0xff)
+static void acpi_format_ipmi_msg(struct acpi_ipmi_msg *tx_msg,
+				acpi_physical_address address,
+				acpi_integer *value)
+{
+	struct kernel_ipmi_msg *msg;
+	struct acpi_ipmi_buffer *buffer;
+	struct acpi_ipmi_device *device;
+
+	msg = &tx_msg->tx_message;
+	/*
+	 * IPMI network function and command are encoded in the address
+	 * within the IPMI OpRegion; see ACPI 4.0, sec 5.5.2.4.3.
+	 */
+	msg->netfn = IPMI_OP_RGN_NETFN(address);
+	msg->cmd = IPMI_OP_RGN_CMD(address);
+	msg->data = tx_msg->tx_data;
+	/*
+	 * value is the parameter passed by the IPMI opregion space handler.
+	 * It points to the IPMI request message buffer
+	 */
+	buffer = (struct acpi_ipmi_buffer *)value;
+	/* copy the tx message data */
+	msg->data_len = buffer->length;
+	memcpy(tx_msg->tx_data, buffer->data, msg->data_len);
+	/*
+	 * now the default type is SYSTEM_INTERFACE and channel type is BMC.
+	 * If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE,
+	 * the addr type should be changed to IPMB. Then we will have to parse
+	 * the IPMI request message buffer to get the IPMB address.
+	 * If so, please fix me.
+	 */
+	tx_msg->addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	tx_msg->addr.channel = IPMI_BMC_CHANNEL;
+	tx_msg->addr.data[0] = 0;
+
+	/* Get the msgid */
+	device = tx_msg->device;
+	mutex_lock(&device->mutex_lock);
+	device->curr_msgid++;
+	tx_msg->tx_msgid = device->curr_msgid;
+	mutex_unlock(&device->mutex_lock);
+}
+
+static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
+		acpi_integer *value, int timeout)
+{
+	struct acpi_ipmi_buffer *buffer;
+
+	/*
+	 * value is also used as output parameter. It represents the response
+	 * IPMI message returned by IPMI command.
+	 */
+	buffer = (struct acpi_ipmi_buffer *)value;
+	if (!timeout && !msg->msg_done) {
+		buffer->status = ACPI_IPMI_TIMEOUT;
+		return;
+	}
+	/*
+	 * If the flag of msg_done is not set or the recv length is zero, it
+	 * means that the IPMI command is not executed correctly.
+	 * The status code will be ACPI_IPMI_UNKNOWN.
+	 */
+	if (!msg->msg_done || !msg->rx_len) {
+		buffer->status = ACPI_IPMI_UNKNOWN;
+		return;
+	}
+	/*
+	 * If the IPMI response message is obtained correctly, the status code
+	 * will be ACPI_IPMI_OK
+	 */
+	buffer->status = ACPI_IPMI_OK;
+	buffer->length = msg->rx_len;
+	memcpy(buffer->data, msg->rx_data, msg->rx_len);
+	return;
+}
+static void ipmi_destroy_tx_msg(struct acpi_ipmi_device *ipmi)
+{
+	struct acpi_ipmi_msg *tx_msg = NULL, *temp;
+	int count = 20;
+	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
+
+	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
+		/* wake up the sleep thread on the Tx msg */
+		complete(&tx_msg->tx_complete);
+	}
+
+	/* wait for about 20 ticks to flush the tx message list */
+	while (count--) {
+		if (list_empty(&ipmi->tx_msg_list))
+			break;
+		schedule_timeout(1);
+	}
+	if (!list_empty(&ipmi->tx_msg_list))
+		dev_warn(&pnp_dev->dev, "tx msg list is not NULL\n");
+
+}
+
+static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct acpi_ipmi_device *ipmi_device =
+			(struct acpi_ipmi_device *)user_msg_data;
+	int msg_found = 0;
+	struct acpi_ipmi_msg *tx_msg = NULL;
+	struct pnp_dev *pnp_dev = ipmi_device->pnp_dev;
+
+	if (msg->user != ipmi_device->user_interface) {
+		dev_warn(&pnp_dev->dev, "Incorrect IPMI user\n");
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+	mutex_lock(&ipmi_device->mutex_lock);
+	list_for_each_entry(tx_msg, &ipmi_device->tx_msg_list, head) {
+		if (msg->msgid == tx_msg->tx_msgid) {
+			/* find the message id */
+			msg_found = 1;
+			break;
+		}
+	}
+
+	mutex_unlock(&ipmi_device->mutex_lock);
+	if (!msg_found) {
+		/* no matched msg is found . But we should free it */
+		ipmi_free_recv_msg(msg);
+		dev_warn(&pnp_dev->dev, "Incorrect MSG is found\n");
+		return;
+	}
+
+	if (msg->msg.data_len) {
+		/* copy the response data to Rx_data buffer */
+		memcpy(tx_msg->rx_data, msg->msg_data, msg->msg.data_len);
+		tx_msg->rx_len = msg->msg.data_len;
+		tx_msg->msg_done = 1;
+	}
+	complete(&tx_msg->tx_complete);
+	ipmi_free_recv_msg(msg);
+};
+
+static void ipmi_register_bmc(int iface, struct device *dev)
+{
+	struct acpi_ipmi_device *ipmi_device;
+	struct pnp_dev *device;
+	ipmi_user_t		user;
+	int err;
+
+	if (list_empty(&driver_data.ipmi_devices))
+		return;
+
+	list_for_each_entry(ipmi_device, &driver_data.ipmi_devices, head) {
+		if (ipmi_device->user_interface) {
+			/*
+			 * Only one user interface is allowed to be registered
+			 * for one IPMI device.
+			 * If we already create the user interface for
+			 * one IPMI device, skip it
+			 */
+			continue;
+		}
+		device = ipmi_device->pnp_dev;
+		if (dev == &device->dev) {
+			/*
+			 * If the dev is identical to the ACPI device,
+			 * create the user interface.
+			 */
+			err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
+						ipmi_device, &user);
+			if (err == 0) {
+				ipmi_device->user_interface = user;
+				ipmi_device->ipmi_ifnum = iface;
+			}
+
+			break;
+		}
+	}
+}
+
+static void ipmi_bmc_gone(int iface)
+{
+	struct acpi_ipmi_device *ipmi_device, *temp;
+
+	if (list_empty(&driver_data.ipmi_devices))
+		return;
+
+	list_for_each_entry_safe(ipmi_device, temp,
+				&driver_data.ipmi_devices, head) {
+		if (ipmi_device->user_interface &&
+			(ipmi_device->ipmi_ifnum == iface)) {
+			ipmi_destroy_user(ipmi_device->user_interface);
+			ipmi_device->user_interface = NULL;
+			ipmi_destroy_tx_msg(ipmi_device);
+		}
+	}
+}
+/* --------------------------------------------------------------------------
+ *			Address Space Management
+   -------------------------------------------------------------------------- */
+/*
+ * This is the IPMI opregion space handler.
+ * @function: indicates the read/write. In fact as the IPMI message is driven
+ * by command, only write is meaningful.
+ * @address: This contains the netfn/command of IPMI request message.
+ * @bits   : not used.
+ * @value  : it is an in/out parameter. It points to the IPMI message buffer.
+ *	     Before the IPMI message is sent, it represents the actual request
+ *	     IPMI message. After the IPMI message is finished, it represents
+ *	     the response IPMI message returned by IPMI command.
+ * @handler_context: IPMI device context.
+ */
+
+static acpi_status
+acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
+		      u32 bits, acpi_integer *value,
+		      void *handler_context, void *region_context)
+{
+	struct acpi_ipmi_msg *tx_msg;
+	struct acpi_ipmi_device *ipmi_device =
+			(struct acpi_ipmi_device *) handler_context;
+	int err;
+	acpi_status status;
+	/*
+	 * IPMI opregion message.
+	 * IPMI message is firstly written to the BMC and system software
+	 * can get the respsonse. So it is unmeaningful for the IPMI read
+	 * access.
+	 */
+	if ((function & ACPI_IO_MASK) == ACPI_READ)
+		return AE_TYPE;
+
+	if (!ipmi_device->user_interface)
+		return AE_NOT_EXIST;
+
+	tx_msg = acpi_alloc_ipmi_msg(ipmi_device);
+	if (!tx_msg)
+		return AE_NO_MEMORY;
+
+	acpi_format_ipmi_msg(tx_msg, address, value);
+	mutex_lock(&ipmi_device->mutex_lock);
+	list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
+	mutex_unlock(&ipmi_device->mutex_lock);
+	err = ipmi_request_settime(ipmi_device->user_interface,
+					&tx_msg->addr,
+					tx_msg->tx_msgid,
+					&tx_msg->tx_message,
+					NULL, 0, 0, 0);
+	if (err) {
+		status = AE_ERROR;
+		goto end_label;
+	}
+	err = wait_for_completion_timeout(&tx_msg->tx_complete, IPMI_TIMEOUT);
+	acpi_format_ipmi_response(tx_msg, value, err);
+	status = AE_OK;
+
+end_label:
+	mutex_lock(&ipmi_device->mutex_lock);
+	list_del(&tx_msg->head);
+	mutex_unlock(&ipmi_device->mutex_lock);
+	kfree(tx_msg);
+	return status;
+}
+
+static void ipmi_remove_handler(struct acpi_ipmi_device *ipmi)
+{
+	if (!test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags))
+		return;
+	acpi_remove_address_space_handler(ipmi->handle,
+				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler);
+
+	clear_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
+}
+
+static int ipmi_install_handler(struct acpi_ipmi_device *ipmi)
+{
+	acpi_status status;
+
+	if (test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags))
+		return 0;
+
+	status = acpi_install_address_space_handler(ipmi->handle,
+						    ACPI_ADR_SPACE_IPMI,
+						    &acpi_ipmi_space_handler,
+						    NULL, ipmi);
+	if (ACPI_FAILURE(status)) {
+		struct pnp_dev *pnp_dev = ipmi->pnp_dev;
+		dev_warn(&pnp_dev->dev, "Can't register IPMI opregion for %s\n",
+					pnp_dev_name(pnp_dev));
+		return -EINVAL;
+	}
+	set_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
+	return 0;
+}
+
+
+static const struct pnp_device_id ipmi_device_ids[] = {
+	{"IPI0001", 0},
+	{"", 0},
+};
+
+static int match_device(struct pnp_dev *dev, const struct pnp_device_id *ids)
+{
+	const struct pnp_device_id *id;
+	struct pnp_id *pnp_id;
+
+	for (id = ids;  id->id[0]; id++) {
+		pnp_id = dev->id;
+		if (!pnp_id)
+			return 0;
+
+		while (pnp_id) {
+			if (!strncasecmp(pnp_id->id, (char *)id->id,
+					strlen((char *)id->id)))
+				return 1;
+			pnp_id = pnp_id->next;
+		};
+	}
+	return 0;
+}
+
+static int pnp_ipmi_match(struct device *dev, void *data)
+{
+	struct pnp_dev *pnp_dev;
+	struct acpi_ipmi_device *ipmi_device;
+	struct acpi_device *acpi_dev;
+
+	pnp_dev = to_pnp_dev(dev);
+
+	if (!match_device(pnp_dev, ipmi_device_ids))
+		return 0;
+
+	ipmi_device = kzalloc(sizeof(*ipmi_device), GFP_KERNEL);
+	if (!ipmi_device) {
+		dev_warn(dev, "Can't allocate memory for acpi_ipmi_device\n");
+		return -ENOMEM;
+	}
+	acpi_dev = pnp_acpi_device(pnp_dev);
+	INIT_LIST_HEAD(&ipmi_device->head);
+	ipmi_device->pnp_dev = pnp_dev;
+	ipmi_device->handle = acpi_dev->handle;
+
+	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
+	return 0;
+}
+
+static void acpi_add_ipmi_devices(void)
+{
+	struct acpi_ipmi_device *ipmi_device;
+
+	bus_for_each_dev(&pnp_bus_type, NULL, NULL, pnp_ipmi_match);
+	if (list_empty(&driver_data.ipmi_devices))
+		return;
+
+	list_for_each_entry(ipmi_device, &driver_data.ipmi_devices, head) {
+		mutex_init(&ipmi_device->mutex_lock);
+		INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
+		ipmi_install_handler(ipmi_device);
+	}
+}
+
+static void acpi_remove_ipmi_handlers(void)
+{
+	struct acpi_ipmi_device *ipmi_device, *temp;
+
+	list_for_each_entry_safe(ipmi_device, temp, &driver_data.ipmi_devices,
+					head) {
+		if (ipmi_device->user_interface) {
+			/*
+			 * If the IPMI user interface is created, it
+			 * should be destroyed.
+			 */
+			ipmi_destroy_user(ipmi_device->user_interface);
+			ipmi_device->user_interface = NULL;
+		}
+		list_del(&ipmi_device->head);
+		if (!list_empty(&ipmi_device->tx_msg_list)) {
+			/* destroy the Tx_msg list */
+			ipmi_destroy_tx_msg(ipmi_device);
+		}
+		ipmi_remove_handler(ipmi_device);
+		kfree(ipmi_device);
+	}
+	return;
+}
+
+static int __init acpi_ipmi_init(void)
+{
+	int result = 0;
+
+	if (acpi_disabled)
+		return result;
+
+	acpi_add_ipmi_devices();
+
+	result = ipmi_smi_watcher_register(&driver_data.bmc_events);
+
+	if (result)
+		acpi_remove_ipmi_handlers();
+
+	return result;
+}
+
+static void __exit acpi_ipmi_exit(void)
+{
+	if (acpi_disabled)
+		return;
+
+	acpi_remove_ipmi_handlers();
+	ipmi_smi_watcher_unregister(&driver_data.bmc_events);
+
+	return;
+}
+
+module_init(acpi_ipmi_init);
+module_exit(acpi_ipmi_exit);
-- 
1.5.4.5

