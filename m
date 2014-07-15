From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 02/10] ACPI/EC: Add detailed command/query debugging information.
Date: Tue, 15 Jul 2014 11:14:34 +0800
Message-ID: <f05d34283fca4533f547d7b326efb6c926b46320.1405391678.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1405391678.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51799 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbaGODOk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 23:14:40 -0400
In-Reply-To: <cover.1405391678.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Developers really don't need to translate EC commands in mind. This patch
adds detailed debugging information for the EC commands.
The address can be found in the follow-up sequential EC_DATA(W) accesses,
thus this patch also removes some of the redundant address information.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1a94ba9..323a178 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -165,6 +165,27 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
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
@@ -293,16 +314,16 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	}
 	/* following two actions should be kept atomic */
 	ec->curr = t;
-	pr_debug("***** transaction started (cmd=0x%02x, addr=0x%02x) *****\n",
-		 t->command, t->wdata ? t->wdata[0] : 0);
+	pr_debug("***** Command(%s) started *****\n",
+		 acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
-	pr_debug("***** transaction stopped (cmd=0x%02x, addr=0x%02x) *****\n",
-		 t->command, t->wdata ? t->wdata[0] : 0);
+	pr_debug("***** Command(%s) stopped *****\n",
+		 acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
 unlock:
 	spin_unlock_irqrestore(&ec->lock, tmp);
-- 
1.7.10

