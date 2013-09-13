From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 05/12] ACPI/IPMI: Fix race caused by the unprotected ACPI IPMI user
Date: Fri, 13 Sep 2013 13:13:54 +0800
Message-ID: <dd7dd2436d4ae109e251d34a8280eaa69bed677d.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16998 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab3IMFOA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:14:00 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This patch uses reference counting to fix the race caused by the
unprotected ACPI IPMI user.

There are two rules for using ipmi_si APIs:
1.  In ipmi_si, ipmi_destroy_user() can ensure no ipmi_recv_msg be passed
    to ipmi_msg_handler(), but ipmi_request_settime() can not use a
    non-valid ipmi_user_t.  This means the ipmi_si users must ensure no
    local references on ipmi_user_t before invoking ipmi_destroy_user().
2.  In ipmi_si, smi_gone()/new_smi() callbacks are protected by
    smi_watchers_mutex, thus their invocations are serialized.  But as a
    new smi can re-use the freed intf_num, it requires that the callback
    implementation must not use intf_num as an identification mean or it
    must ensure all references to the previous smi are all dropped before
    exiting smi_gone() callback.

As the acpi_ipmi_device->user_interface check in acpi_ipmi_space_handler()
can happen before setting user_interface to NULL and codes after the check
in acpi_ipmi_space_handler() can happen after user_interface becoming NULL,
then the on-going acpi_ipmi_space_handler() still can pass an invalid
acpi_ipmi_device->user_interface to ipmi_request_settime().  Such race
condition is not allowed by the IPMI layer's API design as crash will
happen in ipmi_request_settime().

This patch follows ipmi_devintf.c design:
1. Invoking ipmi_destroy_user() after the reference count of
   acpi_ipmi_device dropping to 0.  References of acpi_ipmi_device dropping
   to 0 also means tx_msg related to this acpi_ipmi_device are all freed.
   This matches IPMI layer's API calling rule on ipmi_destroy_user() and
   ipmi_request_settime().
2. ipmi_flush_tx_msg() is performed so that no on-going tx_msg can still be
   running in acpi_ipmi_space_handler().  And it is invoked after invoking
   __ipmi_dev_kill() where acpi_ipmi_device is deleted from the list with a
   "dead" flag set, and the "dead" flag check is also introduced to the
   point where a tx_msg is going to be added to the tx_msg_list so that no
   new tx_msg can be created after returning from the __ipmi_dev_kill().
3. The waiting codes in ipmi_flush_tx_msg() is deleted because it is not
   required since this patch ensures no acpi_ipmi reference is still held
   for ipmi_user_t before calling ipmi_destroy_user() and
   ipmi_destroy_user() can ensure no more ipmi_msg_handler() can happen
   after returning from ipmi_destroy_user().
4. The flushing of tx_msg is also moved out of ipmi_lock in this patch.

The forthcoming IPMI operation region handler installation changes also
requires acpi_ipmi_device be handled in this style.

Authorship is also updated due to this design change.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |  249 +++++++++++++++++++++++++++++-----------------
 1 file changed, 156 insertions(+), 93 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 9171a1a..b285386 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -1,8 +1,9 @@
 /*
  *  acpi_ipmi.c - ACPI IPMI opregion
  *
- *  Copyright (C) 2010 Intel Corporation
- *  Copyright (C) 2010 Zhao Yakui <yakui.zhao@intel.com>
+ *  Copyright (C) 2010, 2013 Intel Corporation
+ *    Author: Zhao Yakui <yakui.zhao@intel.com>
+ *            Lv Zheng <lv.zheng@intel.com>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -67,6 +68,8 @@ struct acpi_ipmi_device {
 	long curr_msgid;
 	unsigned long flags;
 	struct ipmi_smi_info smi_data;
+	bool dead;
+	struct kref kref;
 };
 
 struct ipmi_driver_data {
@@ -107,8 +110,8 @@ struct acpi_ipmi_buffer {
 static void ipmi_register_bmc(int iface, struct device *dev);
 static void ipmi_bmc_gone(int iface);
 static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);
-static void acpi_add_ipmi_device(struct acpi_ipmi_device *ipmi_device);
-static void acpi_remove_ipmi_device(struct acpi_ipmi_device *ipmi_device);
+static int ipmi_install_space_handler(struct acpi_ipmi_device *ipmi);
+static void ipmi_remove_space_handler(struct acpi_ipmi_device *ipmi);
 
 static struct ipmi_driver_data driver_data = {
 	.ipmi_devices = LIST_HEAD_INIT(driver_data.ipmi_devices),
@@ -122,6 +125,88 @@ static struct ipmi_driver_data driver_data = {
 	},
 };
 
+static struct acpi_ipmi_device *
+ipmi_dev_alloc(int iface, struct ipmi_smi_info *smi_data, acpi_handle handle)
+{
+	struct acpi_ipmi_device *ipmi_device;
+	int err;
+	ipmi_user_t user;
+
+	ipmi_device = kzalloc(sizeof(*ipmi_device), GFP_KERNEL);
+	if (!ipmi_device)
+		return NULL;
+
+	kref_init(&ipmi_device->kref);
+	INIT_LIST_HEAD(&ipmi_device->head);
+	INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
+	spin_lock_init(&ipmi_device->tx_msg_lock);
+
+	ipmi_device->handle = handle;
+	ipmi_device->pnp_dev = to_pnp_dev(get_device(smi_data->dev));
+	memcpy(&ipmi_device->smi_data, smi_data, sizeof(struct ipmi_smi_info));
+	ipmi_device->ipmi_ifnum = iface;
+
+	err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
+			       ipmi_device, &user);
+	if (err) {
+		put_device(smi_data->dev);
+		kfree(ipmi_device);
+		return NULL;
+	}
+	ipmi_device->user_interface = user;
+	ipmi_install_space_handler(ipmi_device);
+
+	return ipmi_device;
+}
+
+static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
+{
+	ipmi_remove_space_handler(ipmi_device);
+	ipmi_destroy_user(ipmi_device->user_interface);
+	put_device(ipmi_device->smi_data.dev);
+	kfree(ipmi_device);
+}
+
+static void ipmi_dev_release_kref(struct kref *kref)
+{
+	struct acpi_ipmi_device *ipmi =
+		container_of(kref, struct acpi_ipmi_device, kref);
+
+	ipmi_dev_release(ipmi);
+}
+
+static void __ipmi_dev_kill(struct acpi_ipmi_device *ipmi_device)
+{
+	list_del(&ipmi_device->head);
+	/*
+	 * Always setting dead flag after deleting from the list or
+	 * list_for_each_entry() codes must get changed.
+	 */
+	ipmi_device->dead = true;
+}
+
+static struct acpi_ipmi_device *acpi_ipmi_dev_get(int iface)
+{
+	struct acpi_ipmi_device *temp, *ipmi_device = NULL;
+
+	mutex_lock(&driver_data.ipmi_lock);
+	list_for_each_entry(temp, &driver_data.ipmi_devices, head) {
+		if (temp->ipmi_ifnum == iface) {
+			ipmi_device = temp;
+			kref_get(&ipmi_device->kref);
+			break;
+		}
+	}
+	mutex_unlock(&driver_data.ipmi_lock);
+
+	return ipmi_device;
+}
+
+static void acpi_ipmi_dev_put(struct acpi_ipmi_device *ipmi_device)
+{
+	kref_put(&ipmi_device->kref, ipmi_dev_release_kref);
+}
+
 static struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
 {
 	struct acpi_ipmi_msg *ipmi_msg;
@@ -220,25 +305,22 @@ static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
 static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
 {
 	struct acpi_ipmi_msg *tx_msg, *temp;
-	int count = HZ / 10;
-	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
 	unsigned long flags;
 
+	/*
+	 * NOTE: On-going ipmi_recv_msg
+	 * ipmi_msg_handler() may still be invoked by ipmi_si after
+	 * flushing.  But it is safe to do a fast flushing on module_exit()
+	 * without waiting for all ipmi_recv_msg(s) to complete from
+	 * ipmi_msg_handler() as it is ensured by ipmi_si that all
+	 * ipmi_recv_msg(s) are freed after invoking ipmi_destroy_user().
+	 */
 	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
 	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
 		/* wake up the sleep thread on the Tx msg */
 		complete(&tx_msg->tx_complete);
 	}
 	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
-
-	/* wait for about 100ms to flush the tx message list */
-	while (count--) {
-		if (list_empty(&ipmi->tx_msg_list))
-			break;
-		schedule_timeout(1);
-	}
-	if (!list_empty(&ipmi->tx_msg_list))
-		dev_warn(&pnp_dev->dev, "tx msg list is not NULL\n");
 }
 
 static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
@@ -302,7 +384,6 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 {
 	struct acpi_ipmi_device *ipmi_device, *temp;
 	struct pnp_dev *pnp_dev;
-	ipmi_user_t		user;
 	int err;
 	struct ipmi_smi_info smi_data;
 	acpi_handle handle;
@@ -312,12 +393,18 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 	if (err)
 		return;
 
-	if (smi_data.addr_src != SI_ACPI) {
-		put_device(smi_data.dev);
-		return;
-	}
-
+	if (smi_data.addr_src != SI_ACPI)
+		goto err_ref;
 	handle = smi_data.addr_info.acpi_info.acpi_handle;
+	if (!handle)
+		goto err_ref;
+	pnp_dev = to_pnp_dev(smi_data.dev);
+
+	ipmi_device = ipmi_dev_alloc(iface, &smi_data, handle);
+	if (!ipmi_device) {
+		dev_warn(&pnp_dev->dev, "Can't create IPMI user interface\n");
+		goto err_ref;
+	}
 
 	mutex_lock(&driver_data.ipmi_lock);
 	list_for_each_entry(temp, &driver_data.ipmi_devices, head) {
@@ -326,34 +413,18 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 		 * to the device list, don't add it again.
 		 */
 		if (temp->handle == handle)
-			goto out;
+			goto err_lock;
 	}
 
-	ipmi_device = kzalloc(sizeof(*ipmi_device), GFP_KERNEL);
-
-	if (!ipmi_device)
-		goto out;
-
-	pnp_dev = to_pnp_dev(smi_data.dev);
-	ipmi_device->handle = handle;
-	ipmi_device->pnp_dev = pnp_dev;
-
-	err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
-					ipmi_device, &user);
-	if (err) {
-		dev_warn(&pnp_dev->dev, "Can't create IPMI user interface\n");
-		kfree(ipmi_device);
-		goto out;
-	}
-	acpi_add_ipmi_device(ipmi_device);
-	ipmi_device->user_interface = user;
-	ipmi_device->ipmi_ifnum = iface;
+	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
 	mutex_unlock(&driver_data.ipmi_lock);
-	memcpy(&ipmi_device->smi_data, &smi_data, sizeof(struct ipmi_smi_info));
+	put_device(smi_data.dev);
 	return;
 
-out:
+err_lock:
 	mutex_unlock(&driver_data.ipmi_lock);
+	ipmi_dev_release(ipmi_device);
+err_ref:
 	put_device(smi_data.dev);
 	return;
 }
@@ -361,19 +432,22 @@ out:
 static void ipmi_bmc_gone(int iface)
 {
 	struct acpi_ipmi_device *ipmi_device, *temp;
+	bool dev_found = false;
 
 	mutex_lock(&driver_data.ipmi_lock);
 	list_for_each_entry_safe(ipmi_device, temp,
 				&driver_data.ipmi_devices, head) {
-		if (ipmi_device->ipmi_ifnum != iface)
-			continue;
-
-		acpi_remove_ipmi_device(ipmi_device);
-		put_device(ipmi_device->smi_data.dev);
-		kfree(ipmi_device);
-		break;
+		if (ipmi_device->ipmi_ifnum != iface) {
+			dev_found = true;
+			__ipmi_dev_kill(ipmi_device);
+			break;
+		}
 	}
 	mutex_unlock(&driver_data.ipmi_lock);
+	if (dev_found) {
+		ipmi_flush_tx_msg(ipmi_device);
+		acpi_ipmi_dev_put(ipmi_device);
+	}
 }
 /* --------------------------------------------------------------------------
  *			Address Space Management
@@ -397,7 +471,8 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 		      void *handler_context, void *region_context)
 {
 	struct acpi_ipmi_msg *tx_msg;
-	struct acpi_ipmi_device *ipmi_device = handler_context;
+	int iface = (long)handler_context;
+	struct acpi_ipmi_device *ipmi_device;
 	int err;
 	acpi_status status;
 	unsigned long flags;
@@ -410,20 +485,31 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	if ((function & ACPI_IO_MASK) == ACPI_READ)
 		return AE_TYPE;
 
-	if (!ipmi_device->user_interface)
+	ipmi_device = acpi_ipmi_dev_get(iface);
+	if (!ipmi_device)
 		return AE_NOT_EXIST;
 
 	tx_msg = acpi_alloc_ipmi_msg(ipmi_device);
-	if (!tx_msg)
-		return AE_NO_MEMORY;
+	if (!tx_msg) {
+		status = AE_NO_MEMORY;
+		goto out_ref;
+	}
 
 	if (acpi_format_ipmi_request(tx_msg, address, value) != 0) {
 		status = AE_TYPE;
 		goto out_msg;
 	}
+	mutex_lock(&driver_data.ipmi_lock);
+	/* Do not add a tx_msg that can not be flushed. */
+	if (ipmi_device->dead) {
+		status = AE_NOT_EXIST;
+		mutex_unlock(&driver_data.ipmi_lock);
+		goto out_msg;
+	}
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
+	mutex_unlock(&driver_data.ipmi_lock);
 	err = ipmi_request_settime(ipmi_device->user_interface,
 					&tx_msg->addr,
 					tx_msg->tx_msgid,
@@ -443,6 +529,8 @@ out_list:
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 out_msg:
 	kfree(tx_msg);
+out_ref:
+	acpi_ipmi_dev_put(ipmi_device);
 	return status;
 }
 
@@ -465,9 +553,8 @@ static int ipmi_install_space_handler(struct acpi_ipmi_device *ipmi)
 		return 0;
 
 	status = acpi_install_address_space_handler(ipmi->handle,
-						    ACPI_ADR_SPACE_IPMI,
-						    &acpi_ipmi_space_handler,
-						    NULL, ipmi);
+				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler,
+				NULL, (void *)((long)ipmi->ipmi_ifnum));
 	if (ACPI_FAILURE(status)) {
 		struct pnp_dev *pnp_dev = ipmi->pnp_dev;
 		dev_warn(&pnp_dev->dev, "Can't register IPMI opregion space "
@@ -478,36 +565,6 @@ static int ipmi_install_space_handler(struct acpi_ipmi_device *ipmi)
 	return 0;
 }
 
-static void acpi_add_ipmi_device(struct acpi_ipmi_device *ipmi_device)
-{
-
-	INIT_LIST_HEAD(&ipmi_device->head);
-
-	spin_lock_init(&ipmi_device->tx_msg_lock);
-	INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
-	ipmi_install_space_handler(ipmi_device);
-
-	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
-}
-
-static void acpi_remove_ipmi_device(struct acpi_ipmi_device *ipmi_device)
-{
-	/*
-	 * If the IPMI user interface is created, it should be
-	 * destroyed.
-	 */
-	if (ipmi_device->user_interface) {
-		ipmi_destroy_user(ipmi_device->user_interface);
-		ipmi_device->user_interface = NULL;
-	}
-	/* flush the Tx_msg list */
-	if (!list_empty(&ipmi_device->tx_msg_list))
-		ipmi_flush_tx_msg(ipmi_device);
-
-	list_del(&ipmi_device->head);
-	ipmi_remove_space_handler(ipmi_device);
-}
-
 static int __init acpi_ipmi_init(void)
 {
 	int result = 0;
@@ -524,7 +581,7 @@ static int __init acpi_ipmi_init(void)
 
 static void __exit acpi_ipmi_exit(void)
 {
-	struct acpi_ipmi_device *ipmi_device, *temp;
+	struct acpi_ipmi_device *ipmi_device;
 
 	if (acpi_disabled)
 		return;
@@ -538,11 +595,17 @@ static void __exit acpi_ipmi_exit(void)
 	 * handler and free it.
 	 */
 	mutex_lock(&driver_data.ipmi_lock);
-	list_for_each_entry_safe(ipmi_device, temp,
-				&driver_data.ipmi_devices, head) {
-		acpi_remove_ipmi_device(ipmi_device);
-		put_device(ipmi_device->smi_data.dev);
-		kfree(ipmi_device);
+	while (!list_empty(&driver_data.ipmi_devices)) {
+		ipmi_device = list_first_entry(&driver_data.ipmi_devices,
+					       struct acpi_ipmi_device,
+					       head);
+		__ipmi_dev_kill(ipmi_device);
+		mutex_unlock(&driver_data.ipmi_lock);
+
+		ipmi_flush_tx_msg(ipmi_device);
+		acpi_ipmi_dev_put(ipmi_device);
+
+		mutex_lock(&driver_data.ipmi_lock);
 	}
 	mutex_unlock(&driver_data.ipmi_lock);
 }
-- 
1.7.10

