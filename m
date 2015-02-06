From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 5/5] ACPI / EC: Add GPE reference counting debugging messages.
Date: Fri,  6 Feb 2015 08:58:16 +0800
Message-ID: <08cb346175c337148d3a2cf800f4d8d23390d78b.1423183648.git.lv.zheng@intel.com>
References: <20141119121615.GA2514@node.dhcp.inet.fi> <cover.1423183647.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423183647.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch enhances debugging with the GPE reference count messages added.
No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 40002ae..14d0c89 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -31,6 +31,7 @@
 
 /* Uncomment next line to get verbose printout */
 /* #define DEBUG */
+#define DEBUG_REF 0
 #define pr_fmt(fmt) "ACPI : EC: " fmt
 
 #include <linux/kernel.h>
@@ -90,6 +91,13 @@ enum {
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
 #define ACPI_EC_COMMAND_COMPLETE	0x02 /* Completed last byte */
 
+#define ec_debug_ref(ec, fmt, ...)					\
+	do {								\
+		if (DEBUG_REF)						\
+			pr_debug("%lu: " fmt, ec->reference_count,	\
+				 ## __VA_ARGS__);			\
+	} while (0)
+
 /* ec.c is compiled in acpi namespace so this shows up as acpi.ec_delay param */
 static unsigned int ec_delay __read_mostly = ACPI_EC_DELAY;
 module_param(ec_delay, uint, 0644);
@@ -356,12 +364,14 @@ static void acpi_ec_submit_event(struct acpi_ec *ec)
 	/* Hold reference for pending event */
 	if (!acpi_ec_submit_flushable_request(ec, true))
 		return;
+	ec_debug_ref(ec, "Increase event\n");
 	if (!test_and_set_bit(EC_FLAGS_EVENT_PENDING, &ec->flags)) {
 		pr_debug("***** Event query started *****\n");
 		schedule_work(&ec->work);
 		return;
 	}
 	acpi_ec_complete_request(ec);
+	ec_debug_ref(ec, "Decrease event\n");
 }
 
 static void acpi_ec_complete_event(struct acpi_ec *ec)
@@ -371,6 +381,7 @@ static void acpi_ec_complete_event(struct acpi_ec *ec)
 		pr_debug("***** Event query stopped *****\n");
 		/* Unhold reference for pending event */
 		acpi_ec_complete_request(ec);
+		ec_debug_ref(ec, "Decrease event\n");
 		/* Check if there is another SCI_EVT detected */
 		acpi_ec_submit_event(ec);
 	}
@@ -381,12 +392,14 @@ static void acpi_ec_submit_detection(struct acpi_ec *ec)
 	/* Hold reference for query submission */
 	if (!acpi_ec_submit_flushable_request(ec, false))
 		return;
+	ec_debug_ref(ec, "Increase query\n");
 	if (!test_and_set_bit(EC_FLAGS_EVENT_DETECTED, &ec->flags)) {
 		pr_debug("***** Event detection blocked *****\n");
 		acpi_ec_submit_event(ec);
 		return;
 	}
 	acpi_ec_complete_request(ec);
+	ec_debug_ref(ec, "Decrease query\n");
 }
 
 static void acpi_ec_complete_detection(struct acpi_ec *ec)
@@ -396,6 +409,7 @@ static void acpi_ec_complete_detection(struct acpi_ec *ec)
 		pr_debug("***** Event detetion unblocked *****\n");
 		/* Unhold reference for query submission */
 		acpi_ec_complete_request(ec);
+		ec_debug_ref(ec, "Decrease query\n");
 	}
 }
 
@@ -570,6 +584,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 		ret = -EINVAL;
 		goto unlock;
 	}
+	ec_debug_ref(ec, "Increase command\n");
 	/* following two actions should be kept atomic */
 	ec->curr = t;
 	pr_debug("***** Command(%s) started *****\n",
@@ -585,6 +600,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	ec->curr = NULL;
 	/* Disable GPE for command processing (IBF=0/OBF=1) */
 	acpi_ec_complete_request(ec);
+	ec_debug_ref(ec, "Decrease command\n");
 unlock:
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
@@ -746,8 +762,10 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
 		pr_debug("+++++ Starting EC +++++\n");
 		/* Enable GPE for event processing (SCI_EVT=1) */
-		if (!resuming)
+		if (!resuming) {
 			acpi_ec_submit_request(ec);
+			ec_debug_ref(ec, "Increase driver\n");
+		}
 		pr_info("+++++ EC started +++++\n");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
@@ -776,8 +794,10 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		wait_event(ec->wait, acpi_ec_stopped(ec));
 		spin_lock_irqsave(&ec->lock, flags);
 		/* Disable GPE for event processing (SCI_EVT=1) */
-		if (!suspending)
+		if (!suspending) {
 			acpi_ec_complete_request(ec);
+			ec_debug_ref(ec, "Decrease driver\n");
+		}
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
 		pr_info("+++++ EC stopped +++++\n");
-- 
1.7.10
