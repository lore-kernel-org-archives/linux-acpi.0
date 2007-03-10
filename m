From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/22] ACPI: EC: enable burst functionality in EC.
Date: Fri,  9 Mar 2007 23:00:51 -0500
Message-ID: <11734992724139-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:44913 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993169AbXCJEBN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:13 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <50a76c6beb6e41664f44239d866240952f56de78.1173498656.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   89 ++++++++++++++++++++++-------------------------------
 1 files changed, 37 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5999abd..e7ce6e4 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -101,7 +101,6 @@ static struct acpi_ec {
 	struct mutex lock;
 	atomic_t query_pending;
 	atomic_t event_count;
-	atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 	wait_queue_head_t wait;
 } *ec_ecdt;
 
@@ -173,56 +172,6 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, unsigned count)
 	return -ETIME;
 }
 
-#ifdef ACPI_FUTURE_USAGE
-/*
- * Note: samsung nv5000 doesn't work with ec burst mode.
- * http://bugzilla.kernel.org/show_bug.cgi?id=4980
- */
-int acpi_ec_enter_burst_mode(struct acpi_ec *ec)
-{
-	u8 tmp = 0;
-	u8 status = 0;
-
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL && !(status & ACPI_EC_FLAG_BURST)) {
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
-		if (status)
-			goto end;
-		acpi_ec_write_cmd(ec, ACPI_EC_BURST_ENABLE);
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1);
-		tmp = acpi_ec_read_data(ec);
-		if (tmp != 0x90) {	/* Burst ACK byte */
-			return -EINVAL;
-		}
-	}
-
-	atomic_set(&ec->leaving_burst, 0);
-	return 0;
-      end:
-	ACPI_EXCEPTION((AE_INFO, status, "EC wait, burst mode"));
-	return -1;
-}
-
-int acpi_ec_leave_burst_mode(struct acpi_ec *ec)
-{
-	u8 status = 0;
-
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL && (status & ACPI_EC_FLAG_BURST)) {
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
-		if (status)
-			goto end;
-		acpi_ec_write_cmd(ec, ACPI_EC_BURST_DISABLE);
-		acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
-	}
-	atomic_set(&ec->leaving_burst, 1);
-	return 0;
-      end:
-	ACPI_EXCEPTION((AE_INFO, status, "EC leave burst mode"));
-	return -1;
-}
-#endif				/* ACPI_FUTURE_USAGE */
-
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					const u8 * wdata, unsigned wdata_len,
 					u8 * rdata, unsigned rdata_len)
@@ -312,6 +261,21 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 	return status;
 }
 
+/*
+ * Note: samsung nv5000 doesn't work with ec burst mode.
+ * http://bugzilla.kernel.org/show_bug.cgi?id=4980
+ */
+int acpi_ec_burst_enable(struct acpi_ec *ec)
+{
+	u8 d;
+	return acpi_ec_transaction(ec, ACPI_EC_BURST_ENABLE, NULL, 0, &d, 1);
+}
+
+int acpi_ec_burst_disable(struct acpi_ec *ec)
+{
+	return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL, 0, NULL, 0);
+}
+
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
 {
 	int result;
@@ -333,6 +297,28 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 /*
  * Externally callable EC access functions. For now, assume 1 EC only
  */
+int ec_burst_enable(void)
+{
+	struct acpi_ec *ec;
+	if (!first_ec)
+		return -ENODEV;
+	ec = acpi_driver_data(first_ec);
+	return acpi_ec_burst_enable(ec);
+}
+
+EXPORT_SYMBOL(ec_burst_enable);
+
+int ec_burst_disable(void)
+{
+	struct acpi_ec *ec;
+	if (!first_ec)
+		return -ENODEV;
+	ec = acpi_driver_data(first_ec);
+	return acpi_ec_burst_disable(ec);
+}
+
+EXPORT_SYMBOL(ec_burst_disable);
+
 int ec_read(u8 addr, u8 * val)
 {
 	struct acpi_ec *ec;
@@ -639,7 +625,6 @@ static int acpi_ec_add(struct acpi_device *device)
 	atomic_set(&ec->query_pending, 0);
 	atomic_set(&ec->event_count, 1);
 	if (acpi_ec_mode == EC_INTR) {
-		atomic_set(&ec->leaving_burst, 1);
 		init_waitqueue_head(&ec->wait);
 	}
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
-- 
1.5.0.3.310.g05ef5
