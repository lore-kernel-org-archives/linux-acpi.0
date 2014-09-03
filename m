From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v4 2/4] Mailbox: Add PCC Mailbox Helper functions
Date: Wed,  3 Sep 2014 15:38:57 -0400
Message-ID: <1409773139-10356-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1409773139-10356-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:33428 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbaICTjM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 15:39:12 -0400
Received: by mail-yh0-f44.google.com with SMTP id a41so5713003yho.3
        for <linux-acpi@vger.kernel.org>; Wed, 03 Sep 2014 12:39:11 -0700 (PDT)
In-Reply-To: <1409773139-10356-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

The current Mailbox framework expects the Mailbox controller
and clients to be backed by Struct devices and uses a DT specific
matching method for clients to lookup channels in a controller.

The helper functions introduced here allow the PCC Mailbox as defined
in the ACPI 5.0+ specification to workaround these expectations and
continue to work with the rest of the Mailbox framework even in the case
where PCC is defined using DT bindings.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/Kconfig       |   8 +++
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/pcc_mailbox.c | 136 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/mailbox/pcc_mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c8b5c13..0e7be60 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -50,4 +50,12 @@ config OMAP_MBOX_KFIFO_SIZE
 	  Specify the default size of mailbox's kfifo buffers (bytes).
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
+
+config PCC_MAILBOX_API
+	bool "Platform Communication Channel Mailbox API"
+	help
+		This contains helper functions for registering a PCC mailbox
+		with the generic Mailbox framework and for looking up a PCC
+		channel.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2fa343a..3a4f94d 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -9,3 +9,5 @@ obj-$(CONFIG_OMAP1_MBOX)	+= mailbox_omap1.o
 mailbox_omap1-objs		:= mailbox-omap1.o
 obj-$(CONFIG_OMAP2PLUS_MBOX)	+= mailbox_omap2.o
 mailbox_omap2-objs		:= mailbox-omap2.o
+
+obj-$(CONFIG_PCC_MAILBOX_API) += pcc_mailbox.o
diff --git a/drivers/mailbox/pcc_mailbox.c b/drivers/mailbox/pcc_mailbox.c
new file mode 100644
index 0000000..1454b67
--- /dev/null
+++ b/drivers/mailbox/pcc_mailbox.c
@@ -0,0 +1,136 @@
+/*
+ *	Copyright (C) 2014 Linaro Ltd.
+ *	Author:	Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+
+extern struct list_head mbox_cons;
+extern struct mutex con_mutex;
+extern void mbox_free_channel(struct mbox_chan *chan);
+extern void poll_txdone(unsigned long data);
+
+static struct mbox_controller *pcc_mbox;
+
+struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl, int index)
+{
+	struct mbox_chan *chan;
+	unsigned long flags;
+	int ret;
+
+	if (!pcc_mbox) {
+		pr_err("PCC Mailbox not found.\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_lock(&con_mutex);
+	/*
+	 * Each PCC Subspace is a Mailbox Channel.
+	 * The PCC Clients get their PCC Subspace ID
+	 * from their own tables and pass it here.
+	 * This returns a pointer to the PCC subspace
+	 * for the Client to operate on.
+	 */
+	chan = &pcc_mbox->chans[index];
+
+	if (!chan || chan->cl || !try_module_get(pcc_mbox->dev->driver->owner)) {
+		pr_err("%s: PCC mailbox not free\n", __func__);
+		mutex_unlock(&con_mutex);
+		return ERR_PTR(-EBUSY);
+	}
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->msg_free = 0;
+	chan->msg_count = 0;
+	chan->active_req = NULL;
+	chan->cl = cl;
+	init_completion(&chan->tx_complete);
+
+	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
+		chan->txdone_method |= TXDONE_BY_ACK;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	mutex_unlock(&con_mutex);
+	return chan;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
+
+void pcc_mbox_free_channel(struct mbox_chan *chan)
+{
+	unsigned long flags;
+
+	if (!chan || !chan->cl)
+		return;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->cl = NULL;
+	chan->active_req = NULL;
+	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
+		chan->txdone_method = TXDONE_BY_POLL;
+
+	module_put(chan->mbox->dev->driver->owner);
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
+
+int pcc_mbox_controller_register(struct mbox_controller *mbox)
+{
+	int i, txdone;
+
+	/* Sanity check */
+	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
+		return -EINVAL;
+
+	if (mbox->txdone_irq)
+		txdone = TXDONE_BY_IRQ;
+	else if (mbox->txdone_poll)
+		txdone = TXDONE_BY_POLL;
+	else /* It has to be ACK then */
+		txdone = TXDONE_BY_ACK;
+
+	if (txdone == TXDONE_BY_POLL) {
+		mbox->poll.function = &poll_txdone;
+		mbox->poll.data = (unsigned long)mbox;
+		init_timer(&mbox->poll);
+	}
+
+	for (i = 0; i < mbox->num_chans; i++) {
+		struct mbox_chan *chan = &mbox->chans[i];
+
+		chan->cl = NULL;
+		chan->mbox = mbox;
+		chan->txdone_method = txdone;
+		spin_lock_init(&chan->lock);
+	}
+
+	mutex_lock(&con_mutex);
+	list_add_tail(&mbox->node, &mbox_cons);
+	/*
+	 * Store this so we avoid digging for a PCC mbox in
+	 * the Channel lookup.
+	 */
+	pcc_mbox = mbox;
+	mutex_unlock(&con_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_controller_register);
+
-- 
1.9.1

