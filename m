From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/5] ACPI/EC: Add detailed command/query debugging information.
Date: Tue, 14 Oct 2014 14:23:49 +0800
Message-ID: <eee911ca55c64903a8f2f24505f04d38857555c3.1413267704.git.lv.zheng@intel.com>
References: <cover.1413267704.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47209 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbaJNGXy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2014 02:23:54 -0400
In-Reply-To: <cover.1413267704.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Developers really don't need to translate EC commands in mind. This patch
adds detailed debugging information for the EC commands.
The address can be found in the follow-up sequential EC_DATA(W) accesses,
thus this patch also removes some of the redundant address information.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 49c4ced..8957d51 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -164,6 +164,27 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 	outb(data, ec->data_addr);
 }
 
+#ifdef DEBUG
+static const char *acpi_ec_cmd_string(u8 cmd)
+{
+	switch (cmd) {
+	case 0x80:
+		return "RD_EC";
+	case 0x81:
+		return "WR_EC";
+	case 0x82:
+		return "BE_EC";
+	case 0x83:
+		return "BD_EC";
+	case 0x84:
+		return "QR_EC";
+	}
+	return "UNKNOWN";
+}
+#else
+#define acpi_ec_cmd_string(cmd)		"UNDEF"
+#endif
+
 static int ec_transaction_completed(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -199,7 +220,8 @@ static bool advance_transaction(struct acpi_ec *ec)
 				if (t->rlen == t->ri) {
 					t->flags |= ACPI_EC_COMMAND_COMPLETE;
 					if (t->command == ACPI_EC_COMMAND_QUERY)
-						pr_debug("hardware QR_EC completion\n");
+						pr_debug("***** Command(%s) hardware completion *****\n",
+							 acpi_ec_cmd_string(t->command));
 					wakeup = true;
 				}
 			} else
@@ -222,7 +244,8 @@ static bool advance_transaction(struct acpi_ec *ec)
 			t->flags |= ACPI_EC_COMMAND_POLL;
 			t->rdata[t->ri++] = 0x00;
 			t->flags |= ACPI_EC_COMMAND_COMPLETE;
-			pr_debug("software QR_EC completion\n");
+			pr_debug("***** Command(%s) software completion *****\n",
+				 acpi_ec_cmd_string(t->command));
 			wakeup = true;
 		} else if ((status & ACPI_EC_FLAG_IBF) == 0) {
 			acpi_ec_write_cmd(ec, t->command);
@@ -303,15 +326,16 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* following two actions should be kept atomic */
 	ec->curr = t;
-	pr_debug("transaction start (cmd=0x%02x, addr=0x%02x)\n",
-			t->command, t->wdata ? t->wdata[0] : 0);
+	pr_debug("***** Command(%s) started *****\n",
+		 acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	pr_debug("transaction end\n");
+	pr_debug("***** Command(%s) stopped *****\n",
+		 acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
-- 
1.7.10

