From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 03/12] ACPI/IPMI: Fix race caused by the unprotected ACPI IPMI transfers
Date: Fri, 13 Sep 2013 13:13:39 +0800
Message-ID: <b54e559e73c7f6174bd6794dd5fc24ecf9b73d32.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5372 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab3IMFNq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:13:46 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This patch fixes races caused by unprotected ACPI IPMI transfers.

We can see the following crashes may occur:
1. There is no tx_msg_lock held for iterating tx_msg_list in
   ipmi_flush_tx_msg() while it is parellel unlinked on failure in
   acpi_ipmi_space_handler() under protection of tx_msg_lock.
2. There is no lock held for freeing tx_msg in acpi_ipmi_space_handler()
   while it is parellel accessed in ipmi_flush_tx_msg() and
   ipmi_msg_handler().

This patch enhances tx_msg_lock to protect all tx_msg accesses to solve
this issue.  Then tx_msg_lock is always held around complete() and tx_msg
accesses.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 7397135..87307ba 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -228,11 +228,14 @@ static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
 	struct acpi_ipmi_msg *tx_msg, *temp;
 	int count = HZ / 10;
 	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
+	unsigned long flags;
 
+	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
 	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
 		/* wake up the sleep thread on the Tx msg */
 		complete(&tx_msg->tx_complete);
 	}
+	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
 
 	/* wait for about 100ms to flush the tx message list */
 	while (count--) {
@@ -266,11 +269,10 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 		}
 	}
 
-	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 	if (!msg_found) {
 		dev_warn(&pnp_dev->dev, "Unexpected response (msg id %ld) is "
 			"returned.\n", msg->msgid);
-		goto out_msg;
+		goto out_lock;
 	}
 
 	/* copy the response data to Rx_data buffer */
@@ -284,6 +286,8 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 		tx_msg->msg_done = 1;
 	}
 	complete(&tx_msg->tx_complete);
+out_lock:
+	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 out_msg:
 	ipmi_free_recv_msg(msg);
 };
-- 
1.7.10

