From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/2] ACPI: EC: Workaround for optimized controllers (version 3)
Date: Wed, 21 Nov 2007 03:23:32 +0300
Message-ID: <20071121002332.8368.57985.stgit@localhost.localdomain>
References: <20071121002326.8368.48287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:44588 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760001AbXKUAXJ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 19:23:09 -0500
In-Reply-To: <20071121002326.8368.48287.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Some controllers fail to send confirmation GPE after address or data write.
Detect this and don't expect such confirmation in future.
This is a generalization of previous workaround 
(66c5f4e7367b0085652931b2f3366de29e7ff5ec), which did only read address.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9327

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Romano Giannetti <romano.giannetti@gmail.com>
---

 drivers/acpi/ec.c             |   46 +++++++++++++++++++++++++++++------------
 drivers/acpi/processor_core.c |    5 ++++
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d5a5958..7d6b841 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -78,7 +78,10 @@ enum {
 	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
-	EC_FLAGS_ONLY_IBF_GPE,		/* Expect GPE only for IBF = 0 event */
+	EC_FLAGS_NO_ADDRESS_GPE,	/* Expect GPE only for non-address event */
+	EC_FLAGS_ADDRESS,		/* Address is being written */
+	EC_FLAGS_NO_WDATA_GPE,		/* Don't expect WDATA GPE event */
+	EC_FLAGS_WDATA,			/* Data is being written */
 };
 
 static int acpi_ec_remove(struct acpi_device *device, int type);
@@ -175,39 +178,54 @@ static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
 
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
+	int ret = 0;
+	if (unlikely(test_bit(EC_FLAGS_ADDRESS, &ec->flags) &&
+		     test_bit(EC_FLAGS_NO_ADDRESS_GPE, &ec->flags)))
+		force_poll = 1;
+	if (unlikely(test_bit(EC_FLAGS_WDATA, &ec->flags) &&
+		     test_bit(EC_FLAGS_NO_WDATA_GPE, &ec->flags)))
+		force_poll = 1;
 	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
 	    likely(!force_poll)) {
 		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
 				       msecs_to_jiffies(ACPI_EC_DELAY)))
-			return 0;
+			goto end;
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		if (acpi_ec_check_status(ec, event)) {
-			if (event == ACPI_EC_EVENT_OBF_1) {
-				/* miss OBF = 1 GPE, don't expect it anymore */
-				pr_info(PREFIX "missing OBF_1 confirmation,"
-					"switching to degraded mode.\n");
-				set_bit(EC_FLAGS_ONLY_IBF_GPE, &ec->flags);
+			if (test_bit(EC_FLAGS_ADDRESS, &ec->flags)) {
+				/* miss address GPE, don't expect it anymore */
+				pr_info(PREFIX "missing address confirmation, "
+					"don't expect it any longer.\n");
+				set_bit(EC_FLAGS_NO_ADDRESS_GPE, &ec->flags);
+			} else if (test_bit(EC_FLAGS_WDATA, &ec->flags)) {
+				/* miss write data GPE, don't expect it */
+				pr_info(PREFIX "missing write data confirmation, "
+					"don't expect it any longer.\n");
+				set_bit(EC_FLAGS_NO_WDATA_GPE, &ec->flags);
 			} else {
 				/* missing GPEs, switch back to poll mode */
 				if (printk_ratelimit())
-					pr_info(PREFIX "missing IBF_1 confirmations,"
+					pr_info(PREFIX "missing confirmations, "
 						"switch off interrupt mode.\n");
 				clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 			}
-			return 0;
+			goto end;
 		}
 	} else {
 		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
-				return 0;
+				goto end;
 		}
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout,"
 			       " status = %d, expect_event = %d\n",
 			       acpi_ec_read_status(ec), event);
-	return -ETIME;
+	ret = -ETIME;
+      end:
+	clear_bit(EC_FLAGS_ADDRESS, &ec->flags);
+	return ret;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
@@ -226,11 +244,15 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 			       "write_cmd timeout, command = %d\n", command);
 			goto end;
 		}
+		/* mark the address byte written to EC */
+		if (rdata_len + wdata_len > 1)
+			set_bit(EC_FLAGS_ADDRESS, &ec->flags);
 		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		acpi_ec_write_data(ec, *(wdata++));
 	}
 
 	if (!rdata_len) {
+		set_bit(EC_FLAGS_WDATA, &ec->flags);
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
 		if (result) {
 			pr_err(PREFIX
@@ -241,8 +263,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 
 	for (; rdata_len > 0; --rdata_len) {
-		if (test_bit(EC_FLAGS_ONLY_IBF_GPE, &ec->flags))
-			force_poll = 1;
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
 		if (result) {
 			pr_err(PREFIX "read timeout, command = %d\n", command);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 235a51e..692b2a0 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -684,7 +684,7 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_processor *pr = data;
 	struct acpi_device *device = NULL;
-
+	int saved;
 
 	if (!pr)
 		return;
@@ -694,7 +694,10 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
+		saved = pr->performance_platform_limit;
 		acpi_processor_ppc_has_changed(pr);
+		if (saved == pr->performance_platform_limit)
+			break;
 		acpi_bus_generate_proc_event(device, event,
 					pr->performance_platform_limit);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,

