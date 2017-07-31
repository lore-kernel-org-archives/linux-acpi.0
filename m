From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/4] ACPI / EC: Cleanup EC GPE mask flag
Date: Mon, 31 Jul 2017 13:47:54 +0800
Message-ID: <c6d361ed7a7a9879907636cb232934b12c20cb0f.1501479412.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1501479412.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501479412.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

EC_FLAGS_COMMAND_STORM is actually used to mask GPE during IRQ processing.
This patch cleans it up using more readable flag/function names.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ddb01e9..54879c7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -112,8 +112,7 @@ enum {
 	EC_FLAGS_EVT_HANDLER_INSTALLED, /* _Qxx handlers installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
-	EC_FLAGS_COMMAND_STORM,		/* GPE storms occurred to the
-					 * current command processing */
+	EC_FLAGS_GPE_MASKED,		/* GPE masked */
 };
 
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -421,19 +420,19 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 		wake_up(&ec->wait);
 }
 
-static void acpi_ec_set_storm(struct acpi_ec *ec, u8 flag)
+static void acpi_ec_mask_gpe(struct acpi_ec *ec)
 {
-	if (!test_bit(flag, &ec->flags)) {
+	if (!test_bit(EC_FLAGS_GPE_MASKED, &ec->flags)) {
 		acpi_ec_disable_gpe(ec, false);
 		ec_dbg_drv("Polling enabled");
-		set_bit(flag, &ec->flags);
+		set_bit(EC_FLAGS_GPE_MASKED, &ec->flags);
 	}
 }
 
-static void acpi_ec_clear_storm(struct acpi_ec *ec, u8 flag)
+static void acpi_ec_unmask_gpe(struct acpi_ec *ec)
 {
-	if (test_bit(flag, &ec->flags)) {
-		clear_bit(flag, &ec->flags);
+	if (test_bit(EC_FLAGS_GPE_MASKED, &ec->flags)) {
+		clear_bit(EC_FLAGS_GPE_MASKED, &ec->flags);
 		acpi_ec_enable_gpe(ec, false);
 		ec_dbg_drv("Polling disabled");
 	}
@@ -460,7 +459,7 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
 
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
-	acpi_ec_set_storm(ec, EC_FLAGS_COMMAND_STORM);
+	acpi_ec_mask_gpe(ec);
 	if (!acpi_ec_event_enabled(ec))
 		return;
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
@@ -476,7 +475,7 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 		ec_dbg_evt("Command(%s) unblocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-	acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
+	acpi_ec_unmask_gpe(ec);
 }
 
 static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
@@ -688,7 +687,7 @@ static void advance_transaction(struct acpi_ec *ec)
 				++t->irq_count;
 			/* Allow triggering on 0 threshold */
 			if (t->irq_count == ec_storm_threshold)
-				acpi_ec_set_storm(ec, EC_FLAGS_COMMAND_STORM);
+				acpi_ec_mask_gpe(ec);
 		}
 	}
 out:
@@ -786,7 +785,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 
 	spin_lock_irqsave(&ec->lock, tmp);
 	if (t->irq_count == ec_storm_threshold)
-		acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
+		acpi_ec_unmask_gpe(ec);
 	ec_dbg_req("Command(%s) stopped", acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
 	/* Disable GPE for command processing (IBF=0/OBF=1) */
-- 
2.7.4
