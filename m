From: yakui.zhao@intel.com
Subject: [PATCH v4 2/2] IPMI/ACPI: Install the IPMI space handler to enable ACPI to access the BMC controller
Date: Tue, 29 Dec 2009 09:44:20 +0800
Message-ID: <1262051060-23245-3-git-send-email-yakui.zhao@intel.com>
References: <1262051060-23245-1-git-send-email-yakui.zhao@intel.com>
 <1262051060-23245-2-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43903 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbZL2Bq3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2009 20:46:29 -0500
In-Reply-To: <1262051060-23245-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforge.net, bjorn.helgaas@hp.com, Zhao Yakui <yakui.zhao@intel.com>

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
    3. wait for the completion of IPMI message. It can be done in different
routes: One is in handled in IPMI user recv callback function. Another is
handled in timeout function.
    4. format the IPMI response and return it to ACPI AML code.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |  493 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 489 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 3f6ca11..be57d1c 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -65,7 +65,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/pnp.h>
-
+#include <linux/ipmi.h>
 #ifdef CONFIG_PPC_OF
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -1808,6 +1808,463 @@ static __devinit void hardcode_find_bmc(void)
 
 #include <linux/acpi.h>
 
+#define IPMI_FLAGS_HANDLER_INSTALL	0
+#define ACPI_IPMI_OK			0
+#define ACPI_IPMI_TIMEOUT		0x10
+#define ACPI_IPMI_UNKNOWN		0x07
+/* the IPMI timeout is 30s */
+#define IPMI_TIMEOUT			(30 * HZ)
+
+struct acpi_ipmi_device {
+	acpi_handle handle;
+	struct acpi_device *device;
+	/* the device list attached to driver_data.ipmi_devices */
+	struct list_head head;
+	ipmi_user_t 	user_interface;
+	struct mutex	mutex_lock;
+	/* the IPMI request message list */
+	struct list_head tx_msg_list;
+	long curr_msgid;
+	/* IPMI flags */
+	unsigned long flags;
+	/* IPMI interface number */
+	int ipmi_ifnum;
+	struct smi_info *smi_info;
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
+	/* message list */
+	struct list_head head;
+	/*
+	 * General speaking the addr type should be SI_ADDR_TYPE. And
+	 * the addr channel should be BMC.
+	 * In fact it can also be IPMB type. But we will have to
+	 * parse it from the Netfn command buffer. It is so complex
+	 * that it is skipped.
+	 */
+	struct ipmi_addr addr;
+	/* tx message id */
+	long tx_msgid;
+	/* it is used to track whether the IPMI message is finished */
+	struct completion tx_complete;
+	struct kernel_ipmi_msg tx_message;
+	int	msg_done;
+	/* tx data . And copy it from ACPI object buffer */
+	u8	tx_data[64];
+	int	tx_len;
+	/* get the response data */
+	u8	rx_data[64];
+	/* the response length. The netfn & cmd is excluded. */
+	int	rx_len;
+	struct acpi_ipmi_device *device;
+};
+
+/*
+ * IPMI request/response buffer.
+ * The length is 66 bytes.
+ */
+struct acpi_ipmi_buffer {
+	/* status code of a given IPMI command */
+	u8 status_code;
+	/* the length of the payload */
+	u8 length;
+	/*
+	 * the payload. Before the operation is carried out, it represents the
+	 * request message payload. After the operation is carried out, it
+	 * stores the response message returned by IPMI command.
+	 */
+	u8 data[64];
+};
+
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
+static
+struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
+{
+	struct acpi_ipmi_msg *ipmi_msg;
+
+	ipmi_msg = kzalloc(sizeof(struct acpi_ipmi_msg), GFP_KERNEL);
+	if (!ipmi_msg)	{
+		printk(KERN_DEBUG "Can't allocate memory for ipmi_msg\n");
+		return NULL;
+	}
+	init_completion(&ipmi_msg->tx_complete);
+	INIT_LIST_HEAD(&ipmi_msg->head);
+	ipmi_msg->device = ipmi;
+	return ipmi_msg;
+}
+
+static void acpi_format_ipmi_msg(struct acpi_ipmi_msg *tx_msg,
+		acpi_physical_address address,
+		acpi_integer *value)
+{
+	struct kernel_ipmi_msg *msg;
+	u8	temp_value;
+	struct acpi_ipmi_buffer *buffer;
+	struct acpi_ipmi_device *device;
+
+	msg = &tx_msg->tx_message;
+	/* get the netfn */
+	temp_value = (address >> 8) & 0xff;
+	msg->netfn = temp_value;
+	/* get the command */
+	temp_value = address & 0xff;
+	msg->cmd = temp_value;
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
+	 * the addr type should be changed to IPMB.
+	 */
+	tx_msg->addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	tx_msg->addr.channel = IPMI_BMC_CHANNEL;
+	tx_msg->addr.data[0] = 0;
+
+	/*
+	 * If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE, we should
+	 * parse the IPMI request message buffer to get the IPMB address.
+	 * If so, please fix me.
+	 */
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
+	/* when timeout is zero, it means that the timeout happens */
+	if (!timeout) {
+		/* the status code is ACPI_IPMI_TIMEOUT */
+		buffer->status_code = ACPI_IPMI_TIMEOUT;
+		return;
+	}
+	/*
+	 * If the flag of msg_done is not set, it means that the IPMI command
+	 * is not executed correctly.
+	 * The status code will be ACPI_IPMI_UNKNOWN.
+	 */
+	if (!msg->msg_done) {
+		buffer->status_code = ACPI_IPMI_UNKNOWN;
+		return;
+	}
+	/*
+	 * If the IPMI response message is obtained correctly, the status code
+	 * will be ACPI_IPMI_OK
+	 */
+	buffer->status_code = ACPI_IPMI_OK;
+	buffer->length = msg->rx_len;
+	memcpy(buffer->data, msg->rx_data, msg->rx_len);
+}
+
+static void ipmi_destroy_tx_msg(struct acpi_ipmi_device *ipmi)
+{
+	struct acpi_ipmi_msg *tx_msg = NULL, *temp;
+	int count = 20;
+
+	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
+		/* wake up the sleep thread on the Tx msg */
+		complete(&tx_msg->tx_complete);
+	}
+	/* wait for about 20 ticks to flush the tx message list */
+	while (count--) {
+		if (list_empty(&ipmi->tx_msg_list))
+			break;
+		schedule_timeout(1);
+	}
+	if (!list_empty(&ipmi->tx_msg_list))
+		printk(KERN_DEBUG "tx msg list is not NULL\n");
+
+}
+
+static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct acpi_ipmi_device *ipmi_device = user_msg_data;
+	int msg_found = 0;
+	struct acpi_ipmi_msg *tx_msg;
+
+	if (msg->user != ipmi_device->user_interface) {
+		printk(KERN_DEBUG "Incorrect IPMI user\n");
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
+		printk(KERN_DEBUG "Incorrect MSG is found \n");
+		return;
+	}
+
+	if (msg->msg.data_len > 1) {
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
+	struct acpi_ipmi_device *ipmi_device, *temp;
+	struct acpi_device *device;
+	ipmi_user_t		user;
+	int err;
+
+	if (list_empty(&driver_data.ipmi_devices))
+		return;
+
+	list_for_each_entry_safe(ipmi_device, temp,
+					&driver_data.ipmi_devices, head) {
+		device = ipmi_device->device;
+		if (ipmi_device->user_interface) {
+			/*
+			 * Only one user interface is allowed to be registered
+			 * for one IPMI device.
+			 * If we already create the user interface for
+			 * one IPMI device, skip it
+			 */
+			continue;
+		}
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
+				(ipmi_device->ipmi_ifnum == iface)) {
+			ipmi_destroy_user(ipmi_device->user_interface);
+			ipmi_device->user_interface = NULL;
+			ipmi_destroy_tx_msg(ipmi_device);
+		}
+	}
+}
+/* --------------------------------------------------------------------------
+ * 			Address Space Management
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
+	struct acpi_ipmi_msg *tx_msg = NULL;
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
+	if ((function & ACPI_IO_MASK) == ACPI_READ) {
+		/* Read function is not supported. AE_TYPE is returned. */
+		return AE_TYPE;
+	}
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
+
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
+
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
+		printk(KERN_DEBUG "Can't register IPMI opregion %s\n",
+					acpi_device_bid(ipmi->device));
+		return -EINVAL;
+	}
+
+	test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
+
+	return 0;
+}
+
+static void acpi_register_ipmi_handler(struct acpi_ipmi_device *ipmi_device)
+{
+	if (list_empty(&driver_data.ipmi_devices)) {
+		/*
+		 * when we try to register the first IPI0001 device, register
+		 * the smi_watcher.
+		 */
+		ipmi_smi_watcher_register(&driver_data.bmc_events);
+	}
+
+	mutex_init(&ipmi_device->mutex_lock);
+	INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
+
+	if (ipmi_install_handler(ipmi_device)) {
+		/*
+		 * can't register the IPMI opregion. We will print
+		 * some debug info and continue to register ipmi
+		 * opregion for next device.
+		 */
+		printk(KERN_DEBUG "Can't register IPMI opregion %s\n",
+				acpi_device_bid(ipmi_device->device));
+	}
+	list_add(&ipmi_device->head, &driver_data.ipmi_devices);
+}
+
+static void acpi_remove_ipmi_handler(struct acpi_ipmi_device *ipmi_device)
+{
+	if (!ipmi_device)
+		return;
+
+	if (ipmi_device->user_interface) {
+		/*
+		 * If the IPMI user interface is created, it
+		 * should be destroyed.
+		 */
+		ipmi_destroy_user(ipmi_device->user_interface);
+		ipmi_device->user_interface = NULL;
+	}
+	list_del(&ipmi_device->head);
+
+	if (!list_empty(&ipmi_device->tx_msg_list))
+		ipmi_destroy_tx_msg(ipmi_device);
+
+	ipmi_remove_handler(ipmi_device);
+	if (list_empty(&driver_data.ipmi_devices)) {
+		/*
+		 * when no IPI0001 device is in the list, uninstall the
+		 * smi_watcher.
+		 */
+		ipmi_smi_watcher_unregister(&driver_data.bmc_events);
+	}
+}
+
 /*
  * Once we get an ACPI failure, we don't try any more, because we go
  * through the tables sequentially.  Once we don't find a table, there
@@ -2033,6 +2490,8 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	acpi_handle handle;
 	acpi_status status;
 	unsigned long long tmp;
+	int ret;
+	struct acpi_ipmi_device *p_ipmi;
 
 	acpi_dev = pnp_acpi_device(dev);
 	if (!acpi_dev)
@@ -2042,6 +2501,13 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	if (!info)
 		return -ENOMEM;
 
+	p_ipmi = kzalloc(sizeof(*p_ipmi), GFP_KERNEL);
+	if (!p_ipmi) {
+		printk(KERN_ERR "Can't allocate memory for IPMI device\n");
+		kfree(info);
+		return -ENOMEM;
+	}
+
 	info->addr_source = "ACPI";
 
 	handle = acpi_dev->handle;
@@ -2094,20 +2560,39 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	}
 
 	info->dev = &acpi_dev->dev;
-	pnp_set_drvdata(dev, info);
+	p_ipmi->smi_info = info;
+	pnp_set_drvdata(dev, p_ipmi);
 
-	return try_smi_init(info);
+	p_ipmi->device = acpi_dev;
+	p_ipmi->handle = handle;
+	p_ipmi->ipmi_ifnum = -1;
+	acpi_register_ipmi_handler(p_ipmi);
+
+	ret = try_smi_init(info);
+	if (!ret)
+		return ret;
+	else
+		acpi_remove_ipmi_handler(p_ipmi);
 
 err_free:
+	pnp_set_drvdata(dev, NULL);
+	kfree(p_ipmi);
 	kfree(info);
 	return -EINVAL;
 }
 
 static void __devexit ipmi_pnp_remove(struct pnp_dev *dev)
 {
-	struct smi_info *info = pnp_get_drvdata(dev);
+	struct acpi_ipmi_device *p_ipmi;
+	struct smi_info *info;
+
+	p_ipmi = pnp_get_drvdata(dev);
+	info = p_ipmi->smi_info;
 
 	cleanup_one_si(info);
+	acpi_remove_ipmi_handler(p_ipmi);
+	pnp_set_drvdata(dev, NULL);
+	kfree(p_ipmi);
 }
 
 static const struct pnp_device_id pnp_dev_table[] = {
-- 
1.5.4.5

