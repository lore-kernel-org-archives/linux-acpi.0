From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 02/12] ACPI/IPMI: Fix potential response buffer overflow
Date: Fri, 13 Sep 2013 13:13:30 +0800
Message-ID: <d6c1a7e00bc3b7a6d654d5f7075359f0690e8b72.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11732 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab3IMFNh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:13:37 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This patch enhances sanity checks on message size to avoid potential buffer
overflow.

The kernel IPMI message size is IPMI_MAX_MSG_LENGTH(272 bytes) while the
ACPI specification defined IPMI message size is 64 bytes.  The difference
is not handled by the original codes.  This may cause crash in the response
handling codes.
This patch fixes this gap and also combines rx_data/tx_data to use single
data/len pair since they need not be seperated.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |   53 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index a6977e1..7397135 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -52,6 +52,7 @@ MODULE_LICENSE("GPL");
 #define ACPI_IPMI_UNKNOWN		0x07
 /* the IPMI timeout is 5s */
 #define IPMI_TIMEOUT			(5 * HZ)
+#define ACPI_IPMI_MAX_MSG_LENGTH	64
 
 struct acpi_ipmi_device {
 	/* the device list attached to driver_data.ipmi_devices */
@@ -90,11 +91,9 @@ struct acpi_ipmi_msg {
 	struct completion tx_complete;
 	struct kernel_ipmi_msg tx_message;
 	int	msg_done;
-	/* tx data . And copy it from ACPI object buffer */
-	u8	tx_data[64];
-	int	tx_len;
-	u8	rx_data[64];
-	int	rx_len;
+	/* tx/rx data . And copy it from/to ACPI object buffer */
+	u8	data[ACPI_IPMI_MAX_MSG_LENGTH];
+	u8	rx_len;
 	struct acpi_ipmi_device *device;
 };
 
@@ -102,7 +101,7 @@ struct acpi_ipmi_msg {
 struct acpi_ipmi_buffer {
 	u8 status;
 	u8 length;
-	u8 data[64];
+	u8 data[ACPI_IPMI_MAX_MSG_LENGTH];
 };
 
 static void ipmi_register_bmc(int iface, struct device *dev);
@@ -141,7 +140,7 @@ static struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
 
 #define		IPMI_OP_RGN_NETFN(offset)	((offset >> 8) & 0xff)
 #define		IPMI_OP_RGN_CMD(offset)		(offset & 0xff)
-static void acpi_format_ipmi_msg(struct acpi_ipmi_msg *tx_msg,
+static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 				acpi_physical_address address,
 				acpi_integer *value)
 {
@@ -157,15 +156,21 @@ static void acpi_format_ipmi_msg(struct acpi_ipmi_msg *tx_msg,
 	 */
 	msg->netfn = IPMI_OP_RGN_NETFN(address);
 	msg->cmd = IPMI_OP_RGN_CMD(address);
-	msg->data = tx_msg->tx_data;
+	msg->data = tx_msg->data;
 	/*
 	 * value is the parameter passed by the IPMI opregion space handler.
 	 * It points to the IPMI request message buffer
 	 */
 	buffer = (struct acpi_ipmi_buffer *)value;
 	/* copy the tx message data */
+	if (buffer->length > ACPI_IPMI_MAX_MSG_LENGTH) {
+		dev_WARN_ONCE(&tx_msg->device->pnp_dev->dev, true,
+			      "Unexpected request (msg len %d).\n",
+			      buffer->length);
+		return -EINVAL;
+	}
 	msg->data_len = buffer->length;
-	memcpy(tx_msg->tx_data, buffer->data, msg->data_len);
+	memcpy(tx_msg->data, buffer->data, msg->data_len);
 	/*
 	 * now the default type is SYSTEM_INTERFACE and channel type is BMC.
 	 * If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE,
@@ -183,6 +188,7 @@ static void acpi_format_ipmi_msg(struct acpi_ipmi_msg *tx_msg,
 	device->curr_msgid++;
 	tx_msg->tx_msgid = device->curr_msgid;
 	spin_unlock_irqrestore(&device->tx_msg_lock, flags);
+	return 0;
 }
 
 static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
@@ -214,7 +220,7 @@ static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
 	 */
 	buffer->status = ACPI_IPMI_OK;
 	buffer->length = msg->rx_len;
-	memcpy(buffer->data, msg->rx_data, msg->rx_len);
+	memcpy(buffer->data, msg->data, msg->rx_len);
 }
 
 static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
@@ -250,8 +256,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 		dev_warn(&pnp_dev->dev, "Unexpected response is returned. "
 			"returned user %p, expected user %p\n",
 			msg->user, ipmi_device->user_interface);
-		ipmi_free_recv_msg(msg);
-		return;
+		goto out_msg;
 	}
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_for_each_entry(tx_msg, &ipmi_device->tx_msg_list, head) {
@@ -265,17 +270,21 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	if (!msg_found) {
 		dev_warn(&pnp_dev->dev, "Unexpected response (msg id %ld) is "
 			"returned.\n", msg->msgid);
-		ipmi_free_recv_msg(msg);
-		return;
+		goto out_msg;
 	}
 
-	if (msg->msg.data_len) {
-		/* copy the response data to Rx_data buffer */
-		memcpy(tx_msg->rx_data, msg->msg_data, msg->msg.data_len);
+	/* copy the response data to Rx_data buffer */
+	if (msg->msg.data_len > ACPI_IPMI_MAX_MSG_LENGTH) {
+		dev_WARN_ONCE(&pnp_dev->dev, true,
+			      "Unexpected response (msg len %d).\n",
+			      msg->msg.data_len);
+	} else {
 		tx_msg->rx_len = msg->msg.data_len;
+		memcpy(tx_msg->data, msg->msg.data, tx_msg->rx_len);
 		tx_msg->msg_done = 1;
 	}
 	complete(&tx_msg->tx_complete);
+out_msg:
 	ipmi_free_recv_msg(msg);
 };
 
@@ -398,7 +407,10 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	if (!tx_msg)
 		return AE_NO_MEMORY;
 
-	acpi_format_ipmi_msg(tx_msg, address, value);
+	if (acpi_format_ipmi_request(tx_msg, address, value) != 0) {
+		status = AE_TYPE;
+		goto out_msg;
+	}
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
@@ -409,17 +421,18 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 					NULL, 0, 0, 0);
 	if (err) {
 		status = AE_ERROR;
-		goto end_label;
+		goto out_list;
 	}
 	rem_time = wait_for_completion_timeout(&tx_msg->tx_complete,
 					IPMI_TIMEOUT);
 	acpi_format_ipmi_response(tx_msg, value, rem_time);
 	status = AE_OK;
 
-end_label:
+out_list:
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_del(&tx_msg->head);
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
+out_msg:
 	kfree(tx_msg);
 	return status;
 }
-- 
1.7.10

