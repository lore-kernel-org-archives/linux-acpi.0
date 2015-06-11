From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 5/5] ACPI / EC: Fix a code coverity issue when QR_EC transactions are failed.
Date: Thu, 11 Jun 2015 13:21:51 +0800
Message-ID: <401e7734e87c627d2d73030dbf2a0836bc869b01.1433999639.git.lv.zheng@intel.com>
References: <cover.1433734431.git.lv.zheng@intel.com> <cover.1433999639.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433999639.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When the QR_EC transaction fails, the EC_FLAGS_QUERY_PENDING flag prevents
the event handling work queue from being scheduled again.

Though there shouldn't be failed QR_EC transactions, and this gap was
efficiently used for catching and learning the SCI_EVT clearing timing
compliance issues, we need to fix this as we are not fully compatible
with all platforms/Windows to handle SCI_EVT clearing timing correctly.
Fixing this gives the EC driver the chances to recover from a state machine
failure.

So this patch fixes this issue. When nr_pending_queries drops to 0, it
clears EC_FLAGS_QUERY_PENDING at the proper position for different modes in
order to ensure that the SCI_EVT handling can proceed.

In order to be clearer for future ec_event_clearing modes, all checks in
this patch are written in the inclusive style, not the exclusive style.

Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 79817ce..9d4761d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -512,7 +512,8 @@ static void advance_transaction(struct acpi_ec *ec)
 	 */
 	if (!t || !(t->flags & ACPI_EC_COMMAND_POLL)) {
 		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
-		    test_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags)) {
+		    (!ec->nr_pending_queries ||
+		     test_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags))) {
 			clear_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
 			acpi_ec_complete_query(ec);
 		}
@@ -1065,6 +1066,17 @@ static void acpi_ec_event_handler(struct work_struct *work)
 		(void)acpi_ec_query(ec, NULL);
 		spin_lock_irqsave(&ec->lock, flags);
 		ec->nr_pending_queries--;
+		/*
+		 * Before exit, make sure that this work item can be
+		 * scheduled again. There might be QR_EC failures, leaving
+		 * EC_FLAGS_QUERY_PENDING uncleared and preventing this work
+		 * item from being scheduled again.
+		 */
+		if (!ec->nr_pending_queries) {
+			if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
+			    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY)
+				acpi_ec_complete_query(ec);
+		}
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 
-- 
1.7.10
