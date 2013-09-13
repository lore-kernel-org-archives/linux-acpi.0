From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 07/12] ACPI/IPMI: Add reference counting for ACPI IPMI transfers
Date: Fri, 13 Sep 2013 13:14:11 +0800
Message-ID: <1ef82696c34f1fa21e23621f14c6303d60f96be3.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43599 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab3IMFOT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:14:19 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This patch adds reference counting for ACPI IPMI transfers to tune the
locking granularity of tx_msg_lock.

This patch also makes whole acpi_ipmi module's coding style consistent by
using reference counting for all its objects (i.e., acpi_ipmi_device and
acpi_ipmi_msg).

The acpi_ipmi_msg handling is re-designed using referece counting.
1. tx_msg is always unlinked before complete(), so that it is safe to put
   complete() out side of tx_msg_lock.
2. Increasing the reference of tx_msg before calling
   ipmi_request_settime() and introducing tx_msg_lock protected
   ipmi_cancel_tx_msg() so that a complete() can happen in parellel with
   tx_msg unlinking in the failure cases.
3. tx_msg holds the reference of acpi_ipmi_device so that it can be flushed
   and freed in the contexts other than acpi_ipmi_space_handler().

The lockdep_chains shows all acpi_ipmi locks are leaf locks after the
tuning:
1. ipmi_lock is always leaf:
   irq_context: 0
   [ffffffff81a943f8] smi_watchers_mutex
   [ffffffffa06eca60] driver_data.ipmi_lock
   irq_context: 0
   [ffffffff82767b40] &buffer->mutex
   [ffffffffa00a6678] s_active#103
   [ffffffffa06eca60] driver_data.ipmi_lock
2. without this patch applied, lock used by complete() is held after
   holding tx_msg_lock:
   irq_context: 0
   [ffffffff82767b40] &buffer->mutex
   [ffffffffa00a6678] s_active#103
   [ffffffffa06ecce8] &(&ipmi_device->tx_msg_lock)->rlock
   irq_context: 1
   [ffffffffa06ecce8] &(&ipmi_device->tx_msg_lock)->rlock
   irq_context: 1
   [ffffffffa06ecce8] &(&ipmi_device->tx_msg_lock)->rlock
   [ffffffffa06eccf0] &x->wait#25
   irq_context: 1
   [ffffffffa06ecce8] &(&ipmi_device->tx_msg_lock)->rlock
   [ffffffffa06eccf0] &x->wait#25
   [ffffffff81e36620] &p->pi_lock
   irq_context: 1
   [ffffffffa06ecce8] &(&ipmi_device->tx_msg_lock)->rlock
   [ffffffffa06eccf0] &x->wait#25
   [ffffffff81e36620] &p->pi_lock
   [ffffffff81e5d0a8] &rq->lock
3. with this patch applied, tx_msg_lock is always leaf:
   irq_context: 0
   [ffffffff82767b40] &buffer->mutex
   [ffffffffa00a66d8] s_active#107
   [ffffffffa07ecdc8] &(&ipmi_device->tx_msg_lock)->rlock
   irq_context: 1
   [ffffffffa07ecdc8] &(&ipmi_device->tx_msg_lock)->rlock

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |  117 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 7ec4cd1..b9da5ef 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -104,6 +104,7 @@ struct acpi_ipmi_msg {
 	u8	data[ACPI_IPMI_MAX_MSG_LENGTH];
 	u8	rx_len;
 	struct acpi_ipmi_device *device;
+	struct kref	kref;
 };
 
 /* IPMI request/response buffer per ACPI 4.0, sec 5.5.2.4.3.2 */
@@ -208,16 +209,20 @@ static void acpi_ipmi_dev_put(struct acpi_ipmi_device *ipmi_device)
 	kref_put(&ipmi_device->kref, ipmi_dev_release_kref);
 }
 
-static struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
+static struct acpi_ipmi_msg *ipmi_msg_alloc(void)
 {
+	struct acpi_ipmi_device *ipmi;
 	struct acpi_ipmi_msg *ipmi_msg;
-	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
 
+	ipmi = acpi_ipmi_dev_get();
+	if (!ipmi)
+		return NULL;
 	ipmi_msg = kzalloc(sizeof(struct acpi_ipmi_msg), GFP_KERNEL);
-	if (!ipmi_msg)	{
-		dev_warn(&pnp_dev->dev, "Can't allocate memory for ipmi_msg\n");
+	if (!ipmi_msg) {
+		acpi_ipmi_dev_put(ipmi);
 		return NULL;
 	}
+	kref_init(&ipmi_msg->kref);
 	init_completion(&ipmi_msg->tx_complete);
 	INIT_LIST_HEAD(&ipmi_msg->head);
 	ipmi_msg->device = ipmi;
@@ -225,6 +230,32 @@ static struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
 	return ipmi_msg;
 }
 
+static void ipmi_msg_release(struct acpi_ipmi_msg *tx_msg)
+{
+	acpi_ipmi_dev_put(tx_msg->device);
+	kfree(tx_msg);
+}
+
+static void ipmi_msg_release_kref(struct kref *kref)
+{
+	struct acpi_ipmi_msg *tx_msg =
+		container_of(kref, struct acpi_ipmi_msg, kref);
+
+	ipmi_msg_release(tx_msg);
+}
+
+static struct acpi_ipmi_msg *acpi_ipmi_msg_get(struct acpi_ipmi_msg *tx_msg)
+{
+	kref_get(&tx_msg->kref);
+
+	return tx_msg;
+}
+
+static void acpi_ipmi_msg_put(struct acpi_ipmi_msg *tx_msg)
+{
+	kref_put(&tx_msg->kref, ipmi_msg_release_kref);
+}
+
 #define		IPMI_OP_RGN_NETFN(offset)	((offset >> 8) & 0xff)
 #define		IPMI_OP_RGN_CMD(offset)		(offset & 0xff)
 static int acpi_format_ipmi_request(struct acpi_ipmi_msg *tx_msg,
@@ -305,7 +336,7 @@ static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
 
 static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
 {
-	struct acpi_ipmi_msg *tx_msg, *temp;
+	struct acpi_ipmi_msg *tx_msg;
 	unsigned long flags;
 
 	/*
@@ -317,18 +348,47 @@ static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
 	 * ipmi_recv_msg(s) are freed after invoking ipmi_destroy_user().
 	 */
 	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
-	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
+	while (!list_empty(&ipmi->tx_msg_list)) {
+		tx_msg = list_first_entry(&ipmi->tx_msg_list,
+					  struct acpi_ipmi_msg,
+					  head);
+		list_del(&tx_msg->head);
+		spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
+
 		/* wake up the sleep thread on the Tx msg */
 		complete(&tx_msg->tx_complete);
+		acpi_ipmi_msg_put(tx_msg);
+		spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
+	}
+	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
+}
+
+static void ipmi_cancel_tx_msg(struct acpi_ipmi_device *ipmi,
+			       struct acpi_ipmi_msg *msg)
+{
+	struct acpi_ipmi_msg *tx_msg, *temp;
+	bool msg_found = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
+	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
+		if (msg == tx_msg) {
+			msg_found = true;
+			list_del(&tx_msg->head);
+			break;
+		}
 	}
 	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
+
+	if (msg_found)
+		acpi_ipmi_msg_put(tx_msg);
 }
 
 static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 {
 	struct acpi_ipmi_device *ipmi_device = user_msg_data;
-	int msg_found = 0;
-	struct acpi_ipmi_msg *tx_msg;
+	bool msg_found = false;
+	struct acpi_ipmi_msg *tx_msg, *temp;
 	struct pnp_dev *pnp_dev = ipmi_device->pnp_dev;
 	unsigned long flags;
 
@@ -339,17 +399,19 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 		goto out_msg;
 	}
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
-	list_for_each_entry(tx_msg, &ipmi_device->tx_msg_list, head) {
+	list_for_each_entry_safe(tx_msg, temp, &ipmi_device->tx_msg_list, head) {
 		if (msg->msgid == tx_msg->tx_msgid) {
-			msg_found = 1;
+			msg_found = true;
+			list_del(&tx_msg->head);
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 
 	if (!msg_found) {
 		dev_warn(&pnp_dev->dev, "Unexpected response (msg id %ld) is "
 			"returned.\n", msg->msgid);
-		goto out_lock;
+		goto out_msg;
 	}
 
 	/* copy the response data to Rx_data buffer */
@@ -375,8 +437,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	tx_msg->msg_done = ACPI_IPMI_OK;
 out_comp:
 	complete(&tx_msg->tx_complete);
-out_lock:
-	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
+	acpi_ipmi_msg_put(tx_msg);
 out_msg:
 	ipmi_free_recv_msg(msg);
 };
@@ -491,26 +552,23 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	if ((function & ACPI_IO_MASK) == ACPI_READ)
 		return AE_TYPE;
 
-	ipmi_device = acpi_ipmi_dev_get();
-	if (!ipmi_device)
+	tx_msg = ipmi_msg_alloc();
+	if (!tx_msg)
 		return AE_NOT_EXIST;
 
-	tx_msg = acpi_alloc_ipmi_msg(ipmi_device);
-	if (!tx_msg) {
-		status = AE_NO_MEMORY;
-		goto out_ref;
-	}
+	ipmi_device = tx_msg->device;
 
 	if (acpi_format_ipmi_request(tx_msg, address, value) != 0) {
-		status = AE_TYPE;
-		goto out_msg;
+		ipmi_msg_release(tx_msg);
+		return AE_TYPE;
 	}
+	acpi_ipmi_msg_get(tx_msg);
 	mutex_lock(&driver_data.ipmi_lock);
 	/* Do not add a tx_msg that can not be flushed. */
 	if (ipmi_device->dead) {
-		status = AE_NOT_EXIST;
 		mutex_unlock(&driver_data.ipmi_lock);
-		goto out_msg;
+		ipmi_msg_release(tx_msg);
+		return AE_NOT_EXIST;
 	}
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
@@ -523,20 +581,15 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 					NULL, 0, 0, IPMI_TIMEOUT);
 	if (err) {
 		status = AE_ERROR;
-		goto out_list;
+		goto out_msg;
 	}
 	wait_for_completion(&tx_msg->tx_complete);
 	acpi_format_ipmi_response(tx_msg, value);
 	status = AE_OK;
 
-out_list:
-	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
-	list_del(&tx_msg->head);
-	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 out_msg:
-	kfree(tx_msg);
-out_ref:
-	acpi_ipmi_dev_put(ipmi_device);
+	ipmi_cancel_tx_msg(ipmi_device, tx_msg);
+	acpi_ipmi_msg_put(tx_msg);
 	return status;
 }
 
-- 
1.7.10

