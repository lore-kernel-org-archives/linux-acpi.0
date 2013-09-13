From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 04/12] ACPI/IPMI: Fix race caused by the timed out ACPI IPMI transfers
Date: Fri, 13 Sep 2013 13:13:47 +0800
Message-ID: <1bf6da69624306c0d10c5900640b9d09c7341f52.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63095 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab3IMFNw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:13:52 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This patch fixes races caused by timed out ACPI IPMI transfers.

This patch uses timeout mechanism provided by ipmi_si to avoid the race
that the msg_done flag is set but without any protection, its content can
be invalid.  Thanks for the suggestion of Corey Minyard.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |   49 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 87307ba..9171a1a 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -51,7 +51,7 @@ MODULE_LICENSE("GPL");
 #define ACPI_IPMI_TIMEOUT		0x10
 #define ACPI_IPMI_UNKNOWN		0x07
 /* the IPMI timeout is 5s */
-#define IPMI_TIMEOUT			(5 * HZ)
+#define IPMI_TIMEOUT			(5000)
 #define ACPI_IPMI_MAX_MSG_LENGTH	64
 
 struct acpi_ipmi_device {
@@ -135,6 +135,7 @@ static struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
 	init_completion(&ipmi_msg->tx_complete);
 	INIT_LIST_HEAD(&ipmi_msg->head);
 	ipmi_msg->device = ipmi;
+	ipmi_msg->msg_done = ACPI_IPMI_UNKNOWN;
 	return ipmi_msg;
 }
 
@@ -192,7 +193,7 @@ static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 }
 
 static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
-		acpi_integer *value, int rem_time)
+		acpi_integer *value)
 {
 	struct acpi_ipmi_buffer *buffer;
 
@@ -201,24 +202,17 @@ static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
 	 * IPMI message returned by IPMI command.
 	 */
 	buffer = (struct acpi_ipmi_buffer *)value;
-	if (!rem_time && !msg->msg_done) {
-		buffer->status = ACPI_IPMI_TIMEOUT;
-		return;
-	}
 	/*
-	 * If the flag of msg_done is not set or the recv length is zero, it
-	 * means that the IPMI command is not executed correctly.
-	 * The status code will be ACPI_IPMI_UNKNOWN.
+	 * If the flag of msg_done is not set, it means that the IPMI command is
+	 * not executed correctly.
 	 */
-	if (!msg->msg_done || !msg->rx_len) {
-		buffer->status = ACPI_IPMI_UNKNOWN;
+	buffer->status = msg->msg_done;
+	if (msg->msg_done != ACPI_IPMI_OK)
 		return;
-	}
 	/*
 	 * If the IPMI response message is obtained correctly, the status code
 	 * will be ACPI_IPMI_OK
 	 */
-	buffer->status = ACPI_IPMI_OK;
 	buffer->length = msg->rx_len;
 	memcpy(buffer->data, msg->data, msg->rx_len);
 }
@@ -280,11 +274,23 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 		dev_WARN_ONCE(&pnp_dev->dev, true,
 			      "Unexpected response (msg len %d).\n",
 			      msg->msg.data_len);
-	} else {
-		tx_msg->rx_len = msg->msg.data_len;
-		memcpy(tx_msg->data, msg->msg.data, tx_msg->rx_len);
-		tx_msg->msg_done = 1;
+		goto out_comp;
 	}
+	/* response msg is an error msg */
+	msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
+	if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
+	    msg->msg.data_len == 1) {
+		if (msg->msg.data[0] == IPMI_TIMEOUT_COMPLETION_CODE) {
+			dev_WARN_ONCE(&pnp_dev->dev, true,
+				      "Unexpected response (timeout).\n");
+			tx_msg->msg_done = ACPI_IPMI_TIMEOUT;
+		}
+		goto out_comp;
+	}
+	tx_msg->rx_len = msg->msg.data_len;
+	memcpy(tx_msg->data, msg->msg.data, tx_msg->rx_len);
+	tx_msg->msg_done = ACPI_IPMI_OK;
+out_comp:
 	complete(&tx_msg->tx_complete);
 out_lock:
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
@@ -392,7 +398,7 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 {
 	struct acpi_ipmi_msg *tx_msg;
 	struct acpi_ipmi_device *ipmi_device = handler_context;
-	int err, rem_time;
+	int err;
 	acpi_status status;
 	unsigned long flags;
 	/*
@@ -422,14 +428,13 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 					&tx_msg->addr,
 					tx_msg->tx_msgid,
 					&tx_msg->tx_message,
-					NULL, 0, 0, 0);
+					NULL, 0, 0, IPMI_TIMEOUT);
 	if (err) {
 		status = AE_ERROR;
 		goto out_list;
 	}
-	rem_time = wait_for_completion_timeout(&tx_msg->tx_complete,
-					IPMI_TIMEOUT);
-	acpi_format_ipmi_response(tx_msg, value, rem_time);
+	wait_for_completion(&tx_msg->tx_complete);
+	acpi_format_ipmi_response(tx_msg, value);
 	status = AE_OK;
 
 out_list:
-- 
1.7.10

