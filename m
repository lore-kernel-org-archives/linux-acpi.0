From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 08/12] ACPI/IPMI: Cleanup several acpi_ipmi_device members
Date: Fri, 13 Sep 2013 13:14:21 +0800
Message-ID: <60fe5e11e519a5f44e68833a85034273ad390d1a.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7984 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab3IMFO3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:14:29 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This is a trivial patch:
1. Deletes a member of the acpi_ipmi_device - smi_data which is not
   actually used.
2. Updates a member of the acpi_ipmi_device - pnp_dev which is only used
   by dev_warn() invocations, so changes it to struct device.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index b9da5ef..90d57c8 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -61,11 +61,10 @@ struct acpi_ipmi_device {
 	struct list_head tx_msg_list;
 	spinlock_t	tx_msg_lock;
 	acpi_handle handle;
-	struct pnp_dev *pnp_dev;
+	struct device *dev;
 	ipmi_user_t	user_interface;
 	int ipmi_ifnum; /* IPMI interface number */
 	long curr_msgid;
-	struct ipmi_smi_info smi_data;
 	bool dead;
 	struct kref kref;
 };
@@ -131,7 +130,7 @@ static struct ipmi_driver_data driver_data = {
 };
 
 static struct acpi_ipmi_device *
-ipmi_dev_alloc(int iface, struct ipmi_smi_info *smi_data, acpi_handle handle)
+ipmi_dev_alloc(int iface, struct device *dev, acpi_handle handle)
 {
 	struct acpi_ipmi_device *ipmi_device;
 	int err;
@@ -147,14 +146,13 @@ ipmi_dev_alloc(int iface, struct ipmi_smi_info *smi_data, acpi_handle handle)
 	spin_lock_init(&ipmi_device->tx_msg_lock);
 
 	ipmi_device->handle = handle;
-	ipmi_device->pnp_dev = to_pnp_dev(get_device(smi_data->dev));
-	memcpy(&ipmi_device->smi_data, smi_data, sizeof(struct ipmi_smi_info));
+	ipmi_device->dev = get_device(dev);
 	ipmi_device->ipmi_ifnum = iface;
 
 	err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
 			       ipmi_device, &user);
 	if (err) {
-		put_device(smi_data->dev);
+		put_device(dev);
 		kfree(ipmi_device);
 		return NULL;
 	}
@@ -166,7 +164,7 @@ ipmi_dev_alloc(int iface, struct ipmi_smi_info *smi_data, acpi_handle handle)
 static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
 {
 	ipmi_destroy_user(ipmi_device->user_interface);
-	put_device(ipmi_device->smi_data.dev);
+	put_device(ipmi_device->dev);
 	kfree(ipmi_device);
 }
 
@@ -282,7 +280,7 @@ static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
 	buffer = (struct acpi_ipmi_buffer *)value;
 	/* copy the tx message data */
 	if (buffer->length > ACPI_IPMI_MAX_MSG_LENGTH) {
-		dev_WARN_ONCE(&tx_msg->device->pnp_dev->dev, true,
+		dev_WARN_ONCE(tx_msg->device->dev, true,
 			      "Unexpected request (msg len %d).\n",
 			      buffer->length);
 		return -EINVAL;
@@ -389,11 +387,11 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	struct acpi_ipmi_device *ipmi_device = user_msg_data;
 	bool msg_found = false;
 	struct acpi_ipmi_msg *tx_msg, *temp;
-	struct pnp_dev *pnp_dev = ipmi_device->pnp_dev;
+	struct device *dev = ipmi_device->dev;
 	unsigned long flags;
 
 	if (msg->user != ipmi_device->user_interface) {
-		dev_warn(&pnp_dev->dev, "Unexpected response is returned. "
+		dev_warn(dev, "Unexpected response is returned. "
 			"returned user %p, expected user %p\n",
 			msg->user, ipmi_device->user_interface);
 		goto out_msg;
@@ -409,14 +407,14 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 
 	if (!msg_found) {
-		dev_warn(&pnp_dev->dev, "Unexpected response (msg id %ld) is "
+		dev_warn(dev, "Unexpected response (msg id %ld) is "
 			"returned.\n", msg->msgid);
 		goto out_msg;
 	}
 
 	/* copy the response data to Rx_data buffer */
 	if (msg->msg.data_len > ACPI_IPMI_MAX_MSG_LENGTH) {
-		dev_WARN_ONCE(&pnp_dev->dev, true,
+		dev_WARN_ONCE(dev, true,
 			      "Unexpected response (msg len %d).\n",
 			      msg->msg.data_len);
 		goto out_comp;
@@ -426,7 +424,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
 	    msg->msg.data_len == 1) {
 		if (msg->msg.data[0] == IPMI_TIMEOUT_COMPLETION_CODE) {
-			dev_WARN_ONCE(&pnp_dev->dev, true,
+			dev_WARN_ONCE(dev, true,
 				      "Unexpected response (timeout).\n");
 			tx_msg->msg_done = ACPI_IPMI_TIMEOUT;
 		}
@@ -445,7 +443,6 @@ out_msg:
 static void ipmi_register_bmc(int iface, struct device *dev)
 {
 	struct acpi_ipmi_device *ipmi_device, *temp;
-	struct pnp_dev *pnp_dev;
 	int err;
 	struct ipmi_smi_info smi_data;
 	acpi_handle handle;
@@ -460,11 +457,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 	handle = smi_data.addr_info.acpi_info.acpi_handle;
 	if (!handle)
 		goto err_ref;
-	pnp_dev = to_pnp_dev(smi_data.dev);
 
-	ipmi_device = ipmi_dev_alloc(iface, &smi_data, handle);
+	ipmi_device = ipmi_dev_alloc(iface, smi_data.dev, handle);
 	if (!ipmi_device) {
-		dev_warn(&pnp_dev->dev, "Can't create IPMI user interface\n");
+		dev_warn(smi_data.dev, "Can't create IPMI user interface\n");
 		goto err_ref;
 	}
 
-- 
1.7.10

