From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI / EC: Add GPE reference counting debugging messages.
Date: Fri, 27 Feb 2015 14:48:24 +0800
Message-ID: <818c38396b797b611aeff81be8173cdb7e89e283.1425019470.git.lv.zheng@intel.com>
References: <alpine.LNX.2.11.1502151932250.630@localhost> <cover.1425019470.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1425019470.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch enhances debugging with the GPE reference count messages added.

This kind of log entries can be used by the platform validators to validate
if there is an EC transaction broken because of firmware/driver bugs.

No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 07426c8..a362f20 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -177,6 +177,8 @@ static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
 	ec_dbg(EC_DBG_REQ, fmt, ##__VA_ARGS__)
 #define ec_dbg_evt(fmt, ...) \
 	ec_dbg(EC_DBG_EVT, fmt, ##__VA_ARGS__)
+#define ec_dbg_ref(ec, fmt, ...) \
+	ec_dbg_raw("%lu: " fmt, ec->reference_count, ## __VA_ARGS__)
 
 /* --------------------------------------------------------------------------
  *                           Device Flags
@@ -544,6 +546,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 		ret = -EINVAL;
 		goto unlock;
 	}
+	ec_dbg_ref(ec, "Increase command");
 	/* following two actions should be kept atomic */
 	ec->curr = t;
 	ec_dbg_req("Command(%s) started", acpi_ec_cmd_string(t->command));
@@ -557,6 +560,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	ec->curr = NULL;
 	/* Disable GPE for command processing (IBF=0/OBF=1) */
 	acpi_ec_complete_request(ec);
+	ec_dbg_ref(ec, "Decrease command");
 unlock:
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
@@ -718,8 +722,10 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
 		ec_dbg_drv("Starting EC");
 		/* Enable GPE for event processing (SCI_EVT=1) */
-		if (!resuming)
+		if (!resuming) {
 			acpi_ec_submit_request(ec);
+			ec_dbg_ref(ec, "Increase driver");
+		}
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
@@ -748,8 +754,10 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		wait_event(ec->wait, acpi_ec_stopped(ec));
 		spin_lock_irqsave(&ec->lock, flags);
 		/* Disable GPE for event processing (SCI_EVT=1) */
-		if (!suspending)
+		if (!suspending) {
 			acpi_ec_complete_request(ec);
+			ec_dbg_ref(ec, "Decrease driver");
+		}
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
 		ec_log_drv("EC stopped");
-- 
1.7.10
