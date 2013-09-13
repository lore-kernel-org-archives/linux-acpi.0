From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 12/12] ACPI/IPMI: Cleanup coding styles
Date: Fri, 13 Sep 2013 13:15:00 +0800
Message-ID: <9d903b2e0562786e60957f974304d1e2eef4d364.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33005 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab3IMFPH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:15:07 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This patch only introduces indentation cleanups.  No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_ipmi.c |  105 ++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 9d187fd..ac0f52f 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -33,7 +33,6 @@ MODULE_AUTHOR("Zhao Yakui");
 MODULE_DESCRIPTION("ACPI IPMI Opregion driver");
 MODULE_LICENSE("GPL");
 
-
 #define ACPI_IPMI_OK			0
 #define ACPI_IPMI_TIMEOUT		0x10
 #define ACPI_IPMI_UNKNOWN		0x07
@@ -44,12 +43,14 @@ MODULE_LICENSE("GPL");
 struct acpi_ipmi_device {
 	/* the device list attached to driver_data.ipmi_devices */
 	struct list_head head;
+
 	/* the IPMI request message list */
 	struct list_head tx_msg_list;
-	spinlock_t	tx_msg_lock;
+
+	spinlock_t tx_msg_lock;
 	acpi_handle handle;
 	struct device *dev;
-	ipmi_user_t	user_interface;
+	ipmi_user_t user_interface;
 	int ipmi_ifnum; /* IPMI interface number */
 	long curr_msgid;
 	bool dead;
@@ -57,10 +58,11 @@ struct acpi_ipmi_device {
 };
 
 struct ipmi_driver_data {
-	struct list_head	ipmi_devices;
-	struct ipmi_smi_watcher	bmc_events;
-	struct ipmi_user_hndl	ipmi_hndlrs;
-	struct mutex		ipmi_lock;
+	struct list_head ipmi_devices;
+	struct ipmi_smi_watcher bmc_events;
+	struct ipmi_user_hndl ipmi_hndlrs;
+	struct mutex ipmi_lock;
+
 	/*
 	 * NOTE: IPMI System Interface Selection
 	 * There is no system interface specified by the IPMI operation
@@ -73,6 +75,7 @@ struct ipmi_driver_data {
 
 struct acpi_ipmi_msg {
 	struct list_head head;
+
 	/*
 	 * General speaking the addr type should be SI_ADDR_TYPE. And
 	 * the addr channel should be BMC.
@@ -82,15 +85,19 @@ struct acpi_ipmi_msg {
 	 */
 	struct ipmi_addr addr;
 	long tx_msgid;
+
 	/* it is used to track whether the IPMI message is finished */
 	struct completion tx_complete;
+
 	struct kernel_ipmi_msg tx_message;
-	int	msg_done;
+	int msg_done;
+
 	/* tx/rx data . And copy it from/to ACPI object buffer */
-	u8	data[ACPI_IPMI_MAX_MSG_LENGTH];
-	u8	rx_len;
+	u8 data[ACPI_IPMI_MAX_MSG_LENGTH];
+	u8 rx_len;
+
 	struct acpi_ipmi_device *device;
-	struct kref	kref;
+	struct kref kref;
 };
 
 /* IPMI request/response buffer per ACPI 4.0, sec 5.5.2.4.3.2 */
@@ -132,7 +139,6 @@ ipmi_dev_alloc(int iface, struct device *dev, acpi_handle handle)
 	INIT_LIST_HEAD(&ipmi_device->head);
 	INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
 	spin_lock_init(&ipmi_device->tx_msg_lock);
-
 	ipmi_device->handle = handle;
 	ipmi_device->dev = get_device(dev);
 	ipmi_device->ipmi_ifnum = iface;
@@ -169,6 +175,7 @@ static void __ipmi_dev_kill(struct acpi_ipmi_device *ipmi_device)
 	list_del(&ipmi_device->head);
 	if (driver_data.selected_smi == ipmi_device)
 		driver_data.selected_smi = NULL;
+
 	/*
 	 * Always setting dead flag after deleting from the list or
 	 * list_for_each_entry() codes must get changed.
@@ -203,16 +210,19 @@ static struct acpi_ipmi_msg *ipmi_msg_alloc(void)
 	ipmi = acpi_ipmi_dev_get();
 	if (!ipmi)
 		return NULL;
+
 	ipmi_msg = kzalloc(sizeof(struct acpi_ipmi_msg), GFP_KERNEL);
 	if (!ipmi_msg) {
 		acpi_ipmi_dev_put(ipmi);
 		return NULL;
 	}
+
 	kref_init(&ipmi_msg->kref);
 	init_completion(&ipmi_msg->tx_complete);
 	INIT_LIST_HEAD(&ipmi_msg->head);
 	ipmi_msg->device = ipmi;
 	ipmi_msg->msg_done = ACPI_IPMI_UNKNOWN;
+
 	return ipmi_msg;
 }
 
@@ -242,11 +252,11 @@ static void acpi_ipmi_msg_put(struct acpi_ipmi_msg *tx_msg)
 	kref_put(&tx_msg->kref, ipmi_msg_release_kref);
 }
 
-#define		IPMI_OP_RGN_NETFN(offset)	((offset >> 8) & 0xff)
-#define		IPMI_OP_RGN_CMD(offset)		(offset & 0xff)
+#define IPMI_OP_RGN_NETFN(offset)	((offset >> 8) & 0xff)
+#define IPMI_OP_RGN_CMD(offset)		(offset & 0xff)
 static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
-				acpi_physical_address address,
-				acpi_integer *value)
+				    acpi_physical_address address,
+				    acpi_integer *value)
 {
 	struct kernel_ipmi_msg *msg;
 	struct acpi_ipmi_buffer *buffer;
@@ -254,6 +264,7 @@ static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 	unsigned long flags;
 
 	msg = &tx_msg->tx_message;
+
 	/*
 	 * IPMI network function and command are encoded in the address
 	 * within the IPMI OpRegion; see ACPI 4.0, sec 5.5.2.4.3.
@@ -261,11 +272,13 @@ static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 	msg->netfn = IPMI_OP_RGN_NETFN(address);
 	msg->cmd = IPMI_OP_RGN_CMD(address);
 	msg->data = tx_msg->data;
+
 	/*
 	 * value is the parameter passed by the IPMI opregion space handler.
 	 * It points to the IPMI request message buffer
 	 */
 	buffer = (struct acpi_ipmi_buffer *)value;
+
 	/* copy the tx message data */
 	if (buffer->length > ACPI_IPMI_MAX_MSG_LENGTH) {
 		dev_WARN_ONCE(tx_msg->device->dev, true,
@@ -275,6 +288,7 @@ static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 	}
 	msg->data_len = buffer->length;
 	memcpy(tx_msg->data, buffer->data, msg->data_len);
+
 	/*
 	 * now the default type is SYSTEM_INTERFACE and channel type is BMC.
 	 * If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE,
@@ -288,15 +302,17 @@ static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 
 	/* Get the msgid */
 	device = tx_msg->device;
+
 	spin_lock_irqsave(&device->tx_msg_lock, flags);
 	device->curr_msgid++;
 	tx_msg->tx_msgid = device->curr_msgid;
 	spin_unlock_irqrestore(&device->tx_msg_lock, flags);
+
 	return 0;
 }
 
 static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
-		acpi_integer *value)
+				      acpi_integer *value)
 {
 	struct acpi_ipmi_buffer *buffer;
 
@@ -305,6 +321,7 @@ static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
 	 * IPMI message returned by IPMI command.
 	 */
 	buffer = (struct acpi_ipmi_buffer *)value;
+
 	/*
 	 * If the flag of msg_done is not set, it means that the IPMI command is
 	 * not executed correctly.
@@ -312,6 +329,7 @@ static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
 	buffer->status = msg->msg_done;
 	if (msg->msg_done != ACPI_IPMI_OK)
 		return;
+
 	/*
 	 * If the IPMI response message is obtained correctly, the status code
 	 * will be ACPI_IPMI_OK
@@ -379,11 +397,12 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	unsigned long flags;
 
 	if (msg->user != ipmi_device->user_interface) {
-		dev_warn(dev, "Unexpected response is returned. "
-			"returned user %p, expected user %p\n",
-			msg->user, ipmi_device->user_interface);
+		dev_warn(dev,
+			 "Unexpected response is returned. returned user %p, expected user %p\n",
+			 msg->user, ipmi_device->user_interface);
 		goto out_msg;
 	}
+
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_for_each_entry_safe(tx_msg, temp, &ipmi_device->tx_msg_list, head) {
 		if (msg->msgid == tx_msg->tx_msgid) {
@@ -395,8 +414,9 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 
 	if (!msg_found) {
-		dev_warn(dev, "Unexpected response (msg id %ld) is "
-			"returned.\n", msg->msgid);
+		dev_warn(dev,
+			 "Unexpected response (msg id %ld) is returned.\n",
+			 msg->msgid);
 		goto out_msg;
 	}
 
@@ -407,6 +427,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 			      msg->msg.data_len);
 		goto out_comp;
 	}
+
 	/* response msg is an error msg */
 	msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
 	if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
@@ -418,15 +439,17 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 		}
 		goto out_comp;
 	}
+
 	tx_msg->rx_len = msg->msg.data_len;
 	memcpy(tx_msg->data, msg->msg.data, tx_msg->rx_len);
 	tx_msg->msg_done = ACPI_IPMI_OK;
+
 out_comp:
 	complete(&tx_msg->tx_complete);
 	acpi_ipmi_msg_put(tx_msg);
 out_msg:
 	ipmi_free_recv_msg(msg);
-};
+}
 
 static void ipmi_register_bmc(int iface, struct device *dev)
 {
@@ -436,7 +459,6 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 	acpi_handle handle;
 
 	err = ipmi_get_smi_info(iface, &smi_data);
-
 	if (err)
 		return;
 
@@ -461,11 +483,11 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 		if (temp->handle == handle)
 			goto err_lock;
 	}
-
 	if (!driver_data.selected_smi)
 		driver_data.selected_smi = ipmi_device;
 	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
 	mutex_unlock(&driver_data.ipmi_lock);
+
 	put_device(smi_data.dev);
 	return;
 
@@ -484,7 +506,7 @@ static void ipmi_bmc_gone(int iface)
 
 	mutex_lock(&driver_data.ipmi_lock);
 	list_for_each_entry_safe(ipmi_device, temp,
-				&driver_data.ipmi_devices, head) {
+				 &driver_data.ipmi_devices, head) {
 		if (ipmi_device->ipmi_ifnum != iface) {
 			dev_found = true;
 			__ipmi_dev_kill(ipmi_device);
@@ -496,14 +518,13 @@ static void ipmi_bmc_gone(int iface)
 					&driver_data.ipmi_devices,
 					struct acpi_ipmi_device, head);
 	mutex_unlock(&driver_data.ipmi_lock);
+
 	if (dev_found) {
 		ipmi_flush_tx_msg(ipmi_device);
 		acpi_ipmi_dev_put(ipmi_device);
 	}
 }
-/* --------------------------------------------------------------------------
- *			Address Space Management
- * -------------------------------------------------------------------------- */
+
 /*
  * This is the IPMI opregion space handler.
  * @function: indicates the read/write. In fact as the IPMI message is driven
@@ -516,17 +537,17 @@ static void ipmi_bmc_gone(int iface)
  *	     the response IPMI message returned by IPMI command.
  * @handler_context: IPMI device context.
  */
-
 static acpi_status
 acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, acpi_integer *value,
-		      void *handler_context, void *region_context)
+			u32 bits, acpi_integer *value,
+			void *handler_context, void *region_context)
 {
 	struct acpi_ipmi_msg *tx_msg;
 	struct acpi_ipmi_device *ipmi_device;
 	int err;
 	acpi_status status;
 	unsigned long flags;
+
 	/*
 	 * IPMI opregion message.
 	 * IPMI message is firstly written to the BMC and system software
@@ -539,13 +560,13 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	tx_msg = ipmi_msg_alloc();
 	if (!tx_msg)
 		return AE_NOT_EXIST;
-
 	ipmi_device = tx_msg->device;
 
 	if (acpi_format_ipmi_request(tx_msg, address, value) != 0) {
 		ipmi_msg_release(tx_msg);
 		return AE_TYPE;
 	}
+
 	acpi_ipmi_msg_get(tx_msg);
 	mutex_lock(&driver_data.ipmi_lock);
 	/* Do not add a tx_msg that can not be flushed. */
@@ -558,16 +579,18 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 	mutex_unlock(&driver_data.ipmi_lock);
+
 	err = ipmi_request_settime(ipmi_device->user_interface,
-					&tx_msg->addr,
-					tx_msg->tx_msgid,
-					&tx_msg->tx_message,
-					NULL, 0, 0, IPMI_TIMEOUT);
+				   &tx_msg->addr,
+				   tx_msg->tx_msgid,
+				   &tx_msg->tx_message,
+				   NULL, 0, 0, IPMI_TIMEOUT);
 	if (err) {
 		status = AE_ERROR;
 		goto out_msg;
 	}
 	wait_for_completion(&tx_msg->tx_complete);
+
 	acpi_format_ipmi_response(tx_msg, value);
 	status = AE_OK;
 
@@ -586,8 +609,9 @@ static int __init acpi_ipmi_init(void)
 		return 0;
 
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
-				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler,
-				NULL, NULL);
+						    ACPI_ADR_SPACE_IPMI,
+						    &acpi_ipmi_space_handler,
+						    NULL, NULL);
 	if (ACPI_FAILURE(status)) {
 		pr_warn("Can't register IPMI opregion space handle\n");
 		return -EINVAL;
@@ -629,7 +653,8 @@ static void __exit acpi_ipmi_exit(void)
 	}
 	mutex_unlock(&driver_data.ipmi_lock);
 	acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
-				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler);
+					  ACPI_ADR_SPACE_IPMI,
+					  &acpi_ipmi_space_handler);
 }
 
 module_init(acpi_ipmi_init);
-- 
1.7.10

