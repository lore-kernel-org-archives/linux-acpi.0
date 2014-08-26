From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Tue, 26 Aug 2014 15:35:36 -0400
Message-ID: <1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:40224 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbaHZTgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Aug 2014 15:36:32 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so14206502qab.36
        for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2014 12:36:32 -0700 (PDT)
In-Reply-To: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org

The PCC (Platform Communication Channel) is a generic
mailbox to be used by PCC clients such as CPPC, RAS
and MPST as defined in the ACPI 5.0+ spec. This patch
modifies the Mailbox framework to lookup PCC mailbox
controllers and channels such that PCC drivers can work
with or without ACPI support in the kernel.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/mailbox.c          | 118 ++++++++++++++++++++++++++++++++++---
 include/linux/mailbox_client.h     |   6 ++
 include/linux/mailbox_controller.h |   1 +
 3 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 63ecc17..09ad488 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -356,6 +356,14 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel);
 
+static void inline free_channel(struct mbox_chan *chan)
+{
+	chan->cl = NULL;
+	chan->active_req = NULL;
+	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
+		chan->txdone_method = TXDONE_BY_POLL;
+}
+
 /**
  * mbox_free_channel - The client relinquishes control of a mailbox
  *			channel by this call.
@@ -369,14 +377,9 @@ void mbox_free_channel(struct mbox_chan *chan)
 		return;
 
 	chan->mbox->ops->shutdown(chan);
-
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	spin_lock_irqsave(&chan->lock, flags);
-	chan->cl = NULL;
-	chan->active_req = NULL;
-	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
-		chan->txdone_method = TXDONE_BY_POLL;
-
+	free_channel(chan);
 	module_put(chan->mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
@@ -394,6 +397,97 @@ of_mbox_index_xlate(struct mbox_controller *mbox,
 	return &mbox->chans[ind];
 }
 
+#ifdef CONFIG_PCC
+/*
+ * The PCC (Platform Communication Channel) is
+ * defined in the ACPI 5.0+ spec. It is a generic
+ * mailbox interface between an OS and a Platform
+ * such as a BMC. The PCCT (Mailbox controller) has
+ * its own ACPI specific way to describe PCC clients
+ * and their subspace ids (Mailbox channels/clients).
+ *
+ * The following API is added such that PCC
+ * drivers continue to work with this Mailbox
+ * framework with or without ACPI.
+ */
+
+static struct mbox_controller *
+mbox_find_pcc_controller(char *name)
+{
+	struct mbox_controller *mbox;
+	list_for_each_entry(mbox, &mbox_cons, node) {
+		if (mbox->name)
+			if (!strcmp(mbox->name, name))
+				return mbox;
+	}
+
+	return NULL;
+}
+
+struct mbox_chan *
+pcc_mbox_request_channel(struct mbox_client *cl,
+		char *name, unsigned chan_id)
+{
+	struct mbox_controller *mbox;
+	struct mbox_chan *pcc_chan;
+	unsigned long flags;
+	int ret;
+
+	mutex_lock(&con_mutex);
+	mbox = mbox_find_pcc_controller(name);
+
+	if (!mbox) {
+		pr_err("PCC mbox %s not found.\n", name);
+		mutex_unlock(&con_mutex);
+		return ERR_PTR(-ENODEV);
+	}
+
+	pcc_chan = &mbox->chans[chan_id];
+
+	spin_lock_irqsave(&pcc_chan->lock, flags);
+	pcc_chan->msg_free = 0;
+	pcc_chan->msg_count = 0;
+	pcc_chan->active_req = NULL;
+	pcc_chan->cl = cl;
+	init_completion(&pcc_chan->tx_complete);
+
+	if (pcc_chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
+		pcc_chan->txdone_method |= TXDONE_BY_ACK;
+
+	spin_unlock_irqrestore(&pcc_chan->lock, flags);
+
+	ret = pcc_chan->mbox->ops->startup(pcc_chan);
+	if (ret) {
+		pr_err("Unable to startup the PCC channel (%d)\n", ret);
+		mbox_free_channel(pcc_chan);
+		mutex_unlock(&con_mutex);
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_unlock(&con_mutex);
+
+	return pcc_chan;
+}
+
+EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
+
+void pcc_mbox_free_channel(struct mbox_chan *chan)
+{
+	unsigned long flags;
+
+	if (!chan || !chan->cl)
+		return;
+
+	chan->mbox->ops->shutdown(chan);
+
+	spin_lock_irqsave(&chan->lock, flags);
+	free_channel(chan);
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
+
+#endif
+
 /**
  * mbox_controller_register - Register the mailbox controller
  * @mbox:	Pointer to the mailbox controller.
@@ -405,7 +499,17 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	int i, txdone;
 
 	/* Sanity check */
-	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
+
+	/*
+	 * PCC clients and controllers are currently not backed by
+	 * platform device structures.
+	 */
+#ifndef CONFIG_PCC
+	if (!mbox->dev)
+		return -EINVAL;
+#endif
+
+	if (!mbox || !mbox->ops || !mbox->num_chans)
 		return -EINVAL;
 
 	if (mbox->txdone_irq)
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 307d9ca..6a78df0 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -37,6 +37,12 @@ struct mbox_client {
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
 };
 
+#ifdef CONFIG_PCC
+struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *c,
+		char *name, unsigned int chan_id);
+void pcc_mbox_free_channel(struct mbox_chan *chan); /* may sleep */
+#endif
+
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
 int mbox_send_message(struct mbox_chan *chan, void *mssg);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 9ee195b..9f0ae42 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -81,6 +81,7 @@ struct mbox_controller {
 	unsigned txpoll_period;
 	struct mbox_chan *(*of_xlate)(struct mbox_controller *mbox,
 				      const struct of_phandle_args *sp);
+	char *name;
 	/* Internal to API */
 	struct timer_list poll;
 	unsigned period;
-- 
1.9.1

