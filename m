From: Feng Kan <fkan@apm.com>
Subject: [PATCH V2 RESEND] mailbox: add ACPI support for mailbox framework
Date: Wed,  8 Apr 2015 16:58:27 -0700
Message-ID: <1428537507-30561-1-git-send-email-fkan@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: patches@apm.com, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-acpi@vger.kernel.org

This will add support for ACPI parsing of the mboxes attribute
when booting with ACPI table. The client will have a attribute
mimic the dts call "mboxes". In the ACPI case, the client will
mark "mboxes" with the ACPI reference of the mbox it wishes to
use.

	Name (_DSD, Package () {
		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
		Package () {
			Package (2) {"mboxes", Package(){"^^MBOXREF, index"}}
		}
	})

Signed-off-by: Feng Kan <fkan@apm.com>
---
 V2 CHANGE:
        - change to use ACPI reference rather than use ACPI HID directly.
	- consolidate to use one single xlate function
	- fix code to accept use of index

 drivers/mailbox/mailbox.c          | 105 ++++++++++++++++++++++++++-----------
 include/linux/mailbox_controller.h |   6 +--
 2 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 19b491d..3bb981c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -278,6 +279,70 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
+#ifdef CONFIG_ACPI
+static struct mbox_chan *mbox_acpi_parse_chan(struct device *dev, int index)
+{
+	struct acpi_device *acpi_dev;
+	struct mbox_controller *mbox;
+	struct mbox_chan *chan;
+	int status;
+	struct acpi_reference_args args;
+
+	status = acpi_dev_get_property_reference(ACPI_COMPANION(dev), "mboxes",
+						 index, &args);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(dev, "mbox: no matching mbox found in ACPI table\n");
+		return ERR_PTR(-ENODEV);
+	}
+	acpi_dev = args.adev;
+
+	chan = NULL;
+	list_for_each_entry(mbox, &mbox_cons, node)
+		if (ACPI_COMPANION(mbox->dev) == acpi_dev) {
+			chan = mbox->chan_xlate(mbox, args.args[0]);
+			break;
+		}
+
+	return chan;
+}
+#endif
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
+			chan = mbox->chan_xlate(mbox, spec.args[0]);
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
+#ifdef CONFIG_ACPI
+	else
+		return mbox_acpi_parse_chan(dev, index);
+#endif
+}
+
 /**
  * mbox_request_channel - Request a mailbox channel.
  * @cl: Identity of the client requesting the channel.
@@ -298,36 +363,15 @@ EXPORT_SYMBOL_GPL(mbox_send_message);
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
@@ -384,15 +428,12 @@ void mbox_free_channel(struct mbox_chan *chan)
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
 static struct mbox_chan *
-of_mbox_index_xlate(struct mbox_controller *mbox,
-		    const struct of_phandle_args *sp)
+mbox_index_xlate(struct mbox_controller *mbox, int chan)
 {
-	int ind = sp->args[0];
-
-	if (ind >= mbox->num_chans)
+	if (chan >= mbox->num_chans)
 		return NULL;
 
-	return &mbox->chans[ind];
+	return &mbox->chans[chan];
 }
 
 /**
@@ -431,8 +472,8 @@ int mbox_controller_register(struct mbox_controller *mbox)
 		spin_lock_init(&chan->lock);
 	}
 
-	if (!mbox->of_xlate)
-		mbox->of_xlate = of_mbox_index_xlate;
+	if (!mbox->chan_xlate)
+		mbox->chan_xlate = mbox_index_xlate;
 
 	mutex_lock(&con_mutex);
 	list_add_tail(&mbox->node, &mbox_cons);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index d4cf96f..920e545 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -66,7 +66,7 @@ struct mbox_chan_ops {
  *			no interrupt rises. Ignored if 'txdone_irq' is set.
  * @txpoll_period:	If 'txdone_poll' is in effect, the API polls for
  *			last TX's status after these many millisecs
- * @of_xlate:		Controller driver specific mapping of channel via DT
+ * @chan_xlate:		Controller driver specific mapping index to channel
  * @poll:		API private. Used to poll for TXDONE on all channels.
  * @node:		API private. To hook into list of controllers.
  */
@@ -78,8 +78,8 @@ struct mbox_controller {
 	bool txdone_irq;
 	bool txdone_poll;
 	unsigned txpoll_period;
-	struct mbox_chan *(*of_xlate)(struct mbox_controller *mbox,
-				      const struct of_phandle_args *sp);
+	struct mbox_chan *(*chan_xlate)(struct mbox_controller *mbox,
+					int chan);
 	/* Internal to API */
 	struct timer_list poll;
 	struct list_head node;
-- 
1.9.1
