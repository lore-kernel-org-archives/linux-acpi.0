From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: wait for last write gpe
Date: Sat, 08 Nov 2008 21:42:30 +0300
Message-ID: <20081108184228.7154.51815.stgit@thinkpad>
References: <4915C296.9030903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39301 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751056AbYKHSmf (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 13:42:35 -0500
In-Reply-To: <4915C296.9030903@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

There is a possibility that EC might break if next command is
issued within 1 us after write or burst-disable command.
This "possibility" was in EC driver for 3.5 years, after
451566f45a2e6cd10ba56e7220a9dd84ba3ef550.

References: http://marc.info/?l=linux-acpi&m=122616284402886&w=4
Cc: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e5dbe21..d6007ac 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -102,6 +102,7 @@ struct transaction {
 	u8 command;
 	u8 wlen;
 	u8 rlen;
+	bool done;
 };
 
 static struct acpi_ec {
@@ -178,7 +179,7 @@ static int ec_transaction_done(struct acpi_ec *ec)
 	unsigned long flags;
 	int ret = 0;
 	spin_lock_irqsave(&ec->curr_lock, flags);
-	if (!ec->curr || (!ec->curr->wlen && !ec->curr->rlen))
+	if (!ec->curr || ec->curr->done)
 		ret = 1;
 	spin_unlock_irqrestore(&ec->curr_lock, flags);
 	return ret;
@@ -195,17 +196,20 @@ static void gpe_transaction(struct acpi_ec *ec, u8 status)
 			acpi_ec_write_data(ec, *(ec->curr->wdata++));
 			--ec->curr->wlen;
 		} else
-			/* false interrupt, state didn't change */
-			++ec->curr->irq_count;
-
+			goto err;
 	} else if (ec->curr->rlen > 0) {
 		if ((status & ACPI_EC_FLAG_OBF) == 1) {
 			*(ec->curr->rdata++) = acpi_ec_read_data(ec);
-			--ec->curr->rlen;
+			if (--ec->curr->rlen == 0)
+				ec->curr->done = true;
 		} else
-			/* false interrupt, state didn't change */
-			++ec->curr->irq_count;
-	}
+			goto err;
+	} else if (ec->curr->wlen == 0 && (status & ACPI_EC_FLAG_IBF) == 0)
+		ec->curr->done = true;
+	goto unlock;
+err:
+	/* false interrupt, state didn't change */
+	++ec->curr->irq_count;
 unlock:
 	spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
@@ -265,6 +269,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_lock_irqsave(&ec->curr_lock, tmp);
 	/* following two actions should be kept atomic */
 	t->irq_count = 0;
+	t->done = false;
 	ec->curr = t;
 	acpi_ec_write_cmd(ec, ec->curr->command);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)

