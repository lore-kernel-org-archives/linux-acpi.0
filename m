From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v4 1/4] Mailbox: Prepare to add PCC Mailbox support
Date: Wed,  3 Sep 2014 15:38:56 -0400
Message-ID: <1409773139-10356-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1409773139-10356-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:53217 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbaICTjK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 15:39:10 -0400
Received: by mail-yh0-f44.google.com with SMTP id a41so5647087yho.31
        for <linux-acpi@vger.kernel.org>; Wed, 03 Sep 2014 12:39:09 -0700 (PDT)
In-Reply-To: <1409773139-10356-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Restructure code to allow extending the Mailbox
functionality for PCC (Platform Communication Channel)
as a Mailbox.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/mailbox.c          | 10 +++-------
 include/linux/mailbox_controller.h |  4 ++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 63ecc17..5866412 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -21,12 +21,8 @@
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
 
-#define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
-#define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
-#define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
-
-static LIST_HEAD(mbox_cons);
-static DEFINE_MUTEX(con_mutex);
+LIST_HEAD(mbox_cons);
+DEFINE_MUTEX(con_mutex);
 
 static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 {
@@ -107,7 +103,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
 		complete(&chan->tx_complete);
 }
 
-static void poll_txdone(unsigned long data)
+void poll_txdone(unsigned long data)
 {
 	struct mbox_controller *mbox = (struct mbox_controller *)data;
 	bool txdone, resched = false;
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 9ee195b..956cc06 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -15,6 +15,10 @@
 
 struct mbox_chan;
 
+#define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
+#define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
+#define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+
 /**
  * struct mbox_chan_ops - methods to control mailbox channels
  * @send_data:	The API asks the MBOX controller driver, in atomic
-- 
1.9.1

