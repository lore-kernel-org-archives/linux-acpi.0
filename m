From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/2] ACPI: EC: Add wait for irq storm
Date: Wed, 30 Dec 2009 15:53:10 +0300
Message-ID: <20091230125310.11962.2661.stgit@thinkpad>
References: <20091230125303.11962.12105.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:36551 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752751AbZL3MxL (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 07:53:11 -0500
In-Reply-To: <20091230125303.11962.12105.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Merge of poll and irq modes accelerated EC transaction, so
that keyboard starts to suffer again. Add msleep(1) into
transaction path for the storm to allow keyboard controller
to do its job.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14747

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 32517d4..edfcbc7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -259,7 +259,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	spin_unlock_irqrestore(&ec->curr_lock, tmp);
 	ret = ec_poll(ec);
-	pr_debug(PREFIX "transaction end\n");
 	spin_lock_irqsave(&ec->curr_lock, tmp);
 	ec->curr = NULL;
 	spin_unlock_irqrestore(&ec->curr_lock, tmp);
@@ -316,6 +315,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 	/* check if we received SCI during transaction */
 	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		msleep(1);
 		/* it is safe to enable GPE outside of transaction */
 		acpi_enable_gpe(NULL, ec->gpe);
 	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
@@ -323,6 +323,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 			"transactions will use polling mode\n");
 		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
 	}
+	pr_debug(PREFIX "transaction end\n");
 end:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);

