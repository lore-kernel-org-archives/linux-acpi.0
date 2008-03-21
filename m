From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 4/6] Drop support for broken controllers
Date: Fri, 21 Mar 2008 17:07:15 +0300
Message-ID: <20080321140715.30578.69844.stgit@thinkpad.local>
References: <20080321140648.30578.73816.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51708 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753460AbYCUOHo (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 10:07:44 -0400
In-Reply-To: <20080321140648.30578.73816.stgit@thinkpad.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Put all broken controllers into fully functional poll mode

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   61 ++++++++++-------------------------------------------
 1 files changed, 12 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1a7949c..7f07b68 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -79,11 +79,7 @@ enum {
 	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
-	EC_FLAGS_NO_ADDRESS_GPE,	/* Expect GPE only for non-address event */
-	EC_FLAGS_ADDRESS,		/* Address is being written */
-	EC_FLAGS_NO_WDATA_GPE,		/* Don't expect WDATA GPE event */
-	EC_FLAGS_WDATA,			/* Data is being written */
-	EC_FLAGS_NO_OBF1_GPE,		/* Don't expect GPE before read */
+	EC_FLAGS_NO_GPE,		/* Don't use GPE mode */
 	EC_FLAGS_RESCHEDULE_POLL	/* Re-schedule poll */
 };
 
@@ -189,6 +185,7 @@ static void ec_schedule_ec_poll(struct acpi_ec *ec)
 
 static void ec_switch_to_poll_mode(struct acpi_ec *ec)
 {
+	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
@@ -196,65 +193,34 @@ static void ec_switch_to_poll_mode(struct acpi_ec *ec)
 
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
-	int ret = 0;
-
-	if (unlikely(event == ACPI_EC_EVENT_OBF_1 &&
-		     test_bit(EC_FLAGS_NO_OBF1_GPE, &ec->flags)))
-		force_poll = 1;
-	if (unlikely(test_bit(EC_FLAGS_ADDRESS, &ec->flags) &&
-		     test_bit(EC_FLAGS_NO_ADDRESS_GPE, &ec->flags)))
-		force_poll = 1;
-	if (unlikely(test_bit(EC_FLAGS_WDATA, &ec->flags) &&
-		     test_bit(EC_FLAGS_NO_WDATA_GPE, &ec->flags)))
-		force_poll = 1;
 	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
 	    likely(!force_poll)) {
 		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
 				       msecs_to_jiffies(ACPI_EC_DELAY)))
-			goto end;
+			return 0;
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		if (acpi_ec_check_status(ec, event)) {
-			if (event == ACPI_EC_EVENT_OBF_1) {
-				/* miss OBF_1 GPE, don't expect it */
-				pr_info(PREFIX "missing OBF confirmation, "
-					"don't expect it any longer.\n");
-				set_bit(EC_FLAGS_NO_OBF1_GPE, &ec->flags);
-			} else if (test_bit(EC_FLAGS_ADDRESS, &ec->flags)) {
-				/* miss address GPE, don't expect it anymore */
-				pr_info(PREFIX "missing address confirmation, "
-					"don't expect it any longer.\n");
-				set_bit(EC_FLAGS_NO_ADDRESS_GPE, &ec->flags);
-			} else if (test_bit(EC_FLAGS_WDATA, &ec->flags)) {
-				/* miss write data GPE, don't expect it */
-				pr_info(PREFIX "missing write data confirmation, "
-					"don't expect it any longer.\n");
-				set_bit(EC_FLAGS_NO_WDATA_GPE, &ec->flags);
-			} else {
-				/* missing GPEs, switch back to poll mode */
-				if (printk_ratelimit())
-					pr_info(PREFIX "missing confirmations, "
+			/* missing GPEs, switch back to poll mode */
+			if (printk_ratelimit())
+				pr_info(PREFIX "missing confirmations, "
 						"switch off interrupt mode.\n");
-				ec_switch_to_poll_mode(ec);
-				ec_schedule_ec_poll(ec);
-			}
-			goto end;
+			ec_switch_to_poll_mode(ec);
+			ec_schedule_ec_poll(ec);
+			return 0;
 		}
 	} else {
 		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
-				goto end;
+				return 0;
 			udelay(ACPI_EC_UDELAY);
 		}
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
 		acpi_ec_read_status(ec),
 		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
-	ret = -ETIME;
-      end:
-	clear_bit(EC_FLAGS_ADDRESS, &ec->flags);
-	return ret;
+	return -ETIME;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
@@ -273,15 +239,11 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 			       "write_cmd timeout, command = %d\n", command);
 			goto end;
 		}
-		/* mark the address byte written to EC */
-		if (rdata_len + wdata_len > 1)
-			set_bit(EC_FLAGS_ADDRESS, &ec->flags);
 		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		acpi_ec_write_data(ec, *(wdata++));
 	}
 
 	if (!rdata_len) {
-		set_bit(EC_FLAGS_WDATA, &ec->flags);
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
 		if (result) {
 			pr_err(PREFIX
@@ -558,6 +520,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
 				acpi_ec_gpe_query, ec);
 	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
 		   in_interrupt()) {
 		/* this is non-query, must be confirmation */
 		if (printk_ratelimit())

