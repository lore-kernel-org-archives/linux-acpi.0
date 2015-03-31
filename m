From: Feng Kan <fkan@apm.com>
Subject: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Tue, 31 Mar 2015 14:18:00 -0700
Message-ID: <1427836680-13008-1-git-send-email-fkan@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:48994 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751521AbbCaVSD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2015 17:18:03 -0400
Received: by padcy3 with SMTP id cy3so30977207pad.3
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2015 14:18:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: patches@apm.com, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>

This will add support for ACPI parsing of the mboxes attribute
when booting with ACPI table. The client will have a attribute
mimic the dts call "mboxes". In the ACPI case, the client will
mark "mboxes" with the ACPI HID of the mbox it wishes to use.

	Name (_DSD, Package () {
		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
		Package () {
			Package (2) {"mboxes", "ACPIHID"},
		}
	})

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/mailbox/mailbox.c          | 121 +++++++++++++++++++++++++++++--------
 include/linux/mailbox_controller.h |   2 +
 2 files changed, 99 insertions(+), 24 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 19b491d..9f2d0e3 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -278,6 +279,87 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
+static acpi_status
+mbox_acpi_find(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	struct acpi_device *acpi_dev;
+
+	if (acpi_bus_get_device(handle, &acpi_dev))
+		return AE_OK;
+
+	if (strcmp(acpi_device_hid(acpi_dev), (const char *)context) == 0)
+		*rv = acpi_dev;
+
+	return AE_OK;
+}
+
+static struct mbox_chan *mbox_acpi_parse_chan(struct device *dev, int index)
+{
+	const char *mbox_attr = "mboxes";
+	struct acpi_device *acpi_dev;
+	struct mbox_controller *mbox;
+	struct mbox_chan *chan;
+	int status;
+	char *hid_str;
+
+	status = device_property_read_string(dev, mbox_attr,
+					     (const char **)&hid_str);
+	if (status)
+		return ERR_PTR(-ENODEV);
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, mbox_acpi_find, NULL,
+				     (void *)hid_str, (void **)&acpi_dev);
+	if (ACPI_FAILURE(status) || !acpi_dev) {
+		dev_dbg(dev, "mbox: no matching mboxes %s found in ACPI table\n",
+			hid_str);
+		return ERR_PTR(-ENODEV);
+	}
+
+	chan = NULL;
+	list_for_each_entry(mbox, &mbox_cons, node)
+		if (ACPI_COMPANION(mbox->dev) == acpi_dev) {
+			chan = mbox->acpi_xlate(mbox, index);
+			break;
+		}
+
+	return chan;
+}
+
+static struct mbox_chan *mbox_of_parse_chan(struct device *dev, int index)
+{
+	struct of_phandle_args spec;
+	struct mbox_controller *mbox;
+	struct mbox_chan *chan;
+
+	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
+				       "#mbox-cells", index, &spec)) {
+		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
+		return ERR_PTR(-ENODEV);
+	}
+
+	chan = NULL;
+	list_for_each_entry(mbox, &mbox_cons, node)
+		if (mbox->dev->of_node == spec.np) {
+			chan = mbox->of_xlate(mbox, &spec);
+			break;
+		}
+
+	of_node_put(spec.np);
+	return chan;
+}
+
+static struct mbox_chan *mbox_parse_chan(struct device *dev, int index)
+{
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	if (dev->of_node)
+		return mbox_of_parse_chan(dev, index);
+	else
+		return mbox_acpi_parse_chan(dev, index);
+}
+
 /**
  * mbox_request_channel - Request a mailbox channel.
  * @cl: Identity of the client requesting the channel.
@@ -298,36 +380,15 @@ EXPORT_SYMBOL_GPL(mbox_send_message);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 {
 	struct device *dev = cl->dev;
-	struct mbox_controller *mbox;
-	struct of_phandle_args spec;
 	struct mbox_chan *chan;
 	unsigned long flags;
 	int ret;
 
-	if (!dev || !dev->of_node) {
-		pr_debug("%s: No owner device node\n", __func__);
-		return ERR_PTR(-ENODEV);
-	}
-
 	mutex_lock(&con_mutex);
+	chan = mbox_parse_chan(dev, index);
 
-	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", index, &spec)) {
-		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
-		mutex_unlock(&con_mutex);
-		return ERR_PTR(-ENODEV);
-	}
-
-	chan = NULL;
-	list_for_each_entry(mbox, &mbox_cons, node)
-		if (mbox->dev->of_node == spec.np) {
-			chan = mbox->of_xlate(mbox, &spec);
-			break;
-		}
-
-	of_node_put(spec.np);
-
-	if (!chan || chan->cl || !try_module_get(mbox->dev->driver->owner)) {
+	if (!chan || chan->cl ||
+	    !try_module_get(chan->mbox->dev->driver->owner)) {
 		dev_dbg(dev, "%s: mailbox not free\n", __func__);
 		mutex_unlock(&con_mutex);
 		return ERR_PTR(-EBUSY);
@@ -384,6 +445,15 @@ void mbox_free_channel(struct mbox_chan *chan)
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
 static struct mbox_chan *
+acpi_mbox_index_xlate(struct mbox_controller *mbox, int chan)
+{
+	if (chan >= mbox->num_chans)
+		return NULL;
+
+	return &mbox->chans[chan];
+}
+
+static struct mbox_chan *
 of_mbox_index_xlate(struct mbox_controller *mbox,
 		    const struct of_phandle_args *sp)
 {
@@ -434,6 +504,9 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	if (!mbox->of_xlate)
 		mbox->of_xlate = of_mbox_index_xlate;
 
+	if (!mbox->acpi_xlate)
+		mbox->acpi_xlate = acpi_mbox_index_xlate;
+
 	mutex_lock(&con_mutex);
 	list_add_tail(&mbox->node, &mbox_cons);
 	mutex_unlock(&con_mutex);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index d4cf96f..f61d9d4 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -80,6 +80,8 @@ struct mbox_controller {
 	unsigned txpoll_period;
 	struct mbox_chan *(*of_xlate)(struct mbox_controller *mbox,
 				      const struct of_phandle_args *sp);
+	struct mbox_chan *(*acpi_xlate)(struct mbox_controller *mbox,
+					int chan);
 	/* Internal to API */
 	struct timer_list poll;
 	struct list_head node;
-- 
1.9.1

