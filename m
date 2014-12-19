From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 1/6] ACPI/EC: Cleanup transaction wakeup code
Date: Fri, 19 Dec 2014 13:59:31 +0800
Message-ID: <0020a09a4755570f0df61eb4ff95ab1ce9f0f5b5.1418966602.git.lv.zheng@intel.com>
References: <cover.1418966602.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbaLSF7h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2014 00:59:37 -0500
In-Reply-To: <cover.1418966602.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch moves transaction wakeup code into advance_transaction().
No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1b5853f..3e19123 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -200,7 +200,7 @@ static int ec_transaction_completed(struct acpi_ec *ec)
 	return ret;
 }
 
-static bool advance_transaction(struct acpi_ec *ec)
+static void advance_transaction(struct acpi_ec *ec)
 {
 	struct transaction *t;
 	u8 status;
@@ -235,7 +235,7 @@ static bool advance_transaction(struct acpi_ec *ec)
 			t->flags |= ACPI_EC_COMMAND_COMPLETE;
 			wakeup = true;
 		}
-		return wakeup;
+		goto out;
 	} else {
 		if (EC_FLAGS_QUERY_HANDSHAKE &&
 		    !(status & ACPI_EC_FLAG_SCI) &&
@@ -251,7 +251,7 @@ static bool advance_transaction(struct acpi_ec *ec)
 			t->flags |= ACPI_EC_COMMAND_POLL;
 		} else
 			goto err;
-		return wakeup;
+		goto out;
 	}
 err:
 	/*
@@ -262,14 +262,16 @@ err:
 		if (in_interrupt() && t)
 			++t->irq_count;
 	}
-	return wakeup;
+out:
+	if (wakeup && in_interrupt())
+		wake_up(&ec->wait);
 }
 
 static void start_transaction(struct acpi_ec *ec)
 {
 	ec->curr->irq_count = ec->curr->wi = ec->curr->ri = 0;
 	ec->curr->flags = 0;
-	(void)advance_transaction(ec);
+	advance_transaction(ec);
 }
 
 static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data);
@@ -304,7 +306,7 @@ static int ec_poll(struct acpi_ec *ec)
 					return 0;
 			}
 			spin_lock_irqsave(&ec->lock, flags);
-			(void)advance_transaction(ec);
+			advance_transaction(ec);
 			spin_unlock_irqrestore(&ec->lock, flags);
 		} while (time_before(jiffies, delay));
 		pr_debug("controller reset, restart transaction\n");
@@ -688,8 +690,7 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 	struct acpi_ec *ec = data;
 
 	spin_lock_irqsave(&ec->lock, flags);
-	if (advance_transaction(ec))
-		wake_up(&ec->wait);
+	advance_transaction(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
 	ec_check_sci(ec, acpi_ec_read_status(ec));
 	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
-- 
1.7.10

