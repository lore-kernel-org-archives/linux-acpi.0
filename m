From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/5] ACPI/EC: Enhance the logs to apply to QR_EC transactions.
Date: Tue, 14 Oct 2014 14:23:43 +0800
Message-ID: <d2f52ceb522a6e01ccdd16ae77add8adb43d4dfa.1413267704.git.lv.zheng@intel.com>
References: <cover.1413267704.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43217 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbaJNGXt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2014 02:23:49 -0400
In-Reply-To: <cover.1413267704.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Currently some logs are applied to new transactions, but QR_EC transactions
are not included. This patch merges the code path to make the logs also
applying to the QR_EC transactions.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3eac545..49c4ced 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -303,12 +303,15 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* following two actions should be kept atomic */
 	ec->curr = t;
+	pr_debug("transaction start (cmd=0x%02x, addr=0x%02x)\n",
+			t->command, t->wdata ? t->wdata[0] : 0);
 	start_transaction(ec);
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	pr_debug("transaction end\n");
 	ec->curr = NULL;
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
@@ -334,8 +337,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 			goto unlock;
 		}
 	}
-	pr_debug("transaction start (cmd=0x%02x, addr=0x%02x)\n",
-			t->command, t->wdata ? t->wdata[0] : 0);
 	/* disable GPE during transaction if storm is detected */
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
 		/* It has to be disabled, so that it doesn't trigger. */
@@ -356,7 +357,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 			t->irq_count);
 		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
 	}
-	pr_debug("transaction end\n");
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 unlock:
-- 
1.7.10

