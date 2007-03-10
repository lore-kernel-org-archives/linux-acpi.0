From: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/20] ACPI: ec: fix race in status register access
Date: Fri,  9 Mar 2007 22:49:28 -0500
Message-ID: <11734985863491-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34271 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965830AbXCJDts (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:48 -0500
In-Reply-To: <11734985862291-git-send-email-len.brown@intel.com>
Message-Id: <c70b5fb8f6869f720160f774f9915730a6371d9c.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Delay the read of the EC status register until
after the event that caused it occurs -- otherwise
it is possible to read and act on stale status that was
associated with the previous event.

Do this with a perpetually incrementing "event_count" to detect
when a new event occurs and it is safe to read status.

There is no workaround for polling mode -- it is inherently
exposed to reading and acting on stale status, since it
doesn't have an interrupt to tell it the event completed.

http://bugzilla.kernel.org/show_bug.cgi?id=8110

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ab68883..1e525dd 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -100,6 +100,7 @@ static struct acpi_ec {
 	unsigned long global_lock;
 	struct mutex lock;
 	atomic_t query_pending;
+	atomic_t event_count;
 	atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 	wait_queue_head_t wait;
 } *ec_ecdt;
@@ -131,10 +132,12 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 	outb(data, ec->data_addr);
 }
 
-static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
+static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event,
+				       unsigned old_count)
 {
 	u8 status = acpi_ec_read_status(ec);
-
+	if (old_count == atomic_read(&ec->event_count))
+		return 0;
 	if (event == ACPI_EC_EVENT_OBF_1) {
 		if (status & ACPI_EC_FLAG_OBF)
 			return 1;
@@ -146,19 +149,19 @@ static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
 	return 0;
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event)
+static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, unsigned count)
 {
 	if (acpi_ec_mode == EC_POLL) {
 		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
 		while (time_before(jiffies, delay)) {
-			if (acpi_ec_check_status(ec, event))
+			if (acpi_ec_check_status(ec, event, 0))
 				return 0;
 		}
 	} else {
 		if (wait_event_timeout(ec->wait,
-				       acpi_ec_check_status(ec, event),
+				       acpi_ec_check_status(ec, event, count),
 				       msecs_to_jiffies(ACPI_EC_DELAY)) ||
-		    acpi_ec_check_status(ec, event)) {
+		    acpi_ec_check_status(ec, event, 0)) {
 			return 0;
 		} else {
 			printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
@@ -225,21 +228,22 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					u8 * rdata, unsigned rdata_len)
 {
 	int result = 0;
-
+	unsigned count = atomic_read(&ec->event_count);
 	acpi_ec_write_cmd(ec, command);
 
 	for (; wdata_len > 0; --wdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, count);
 		if (result) {
 			printk(KERN_ERR PREFIX
 			       "write_cmd timeout, command = %d\n", command);
 			goto end;
 		}
+		count = atomic_read(&ec->event_count);
 		acpi_ec_write_data(ec, *(wdata++));
 	}
 
 	if (!rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, count);
 		if (result) {
 			printk(KERN_ERR PREFIX
 			       "finish-write timeout, command = %d\n", command);
@@ -250,13 +254,13 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 	}
 
 	for (; rdata_len > 0; --rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1);
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, count);
 		if (result) {
 			printk(KERN_ERR PREFIX "read timeout, command = %d\n",
 			       command);
 			goto end;
 		}
-
+		count = atomic_read(&ec->event_count);
 		*(rdata++) = acpi_ec_read_data(ec);
 	}
       end:
@@ -288,7 +292,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 	/* Make sure GPE is enabled before doing transaction */
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
+	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
 	if (status) {
 		printk(KERN_DEBUG PREFIX
 		       "input buffer is not empty, aborting transaction\n");
@@ -369,8 +373,8 @@ int ec_write(u8 addr, u8 val)
 EXPORT_SYMBOL(ec_write);
 
 int ec_transaction(u8 command,
-			  const u8 * wdata, unsigned wdata_len,
-			  u8 * rdata, unsigned rdata_len)
+		   const u8 * wdata, unsigned wdata_len,
+		   u8 * rdata, unsigned rdata_len)
 {
 	struct acpi_ec *ec;
 
@@ -435,7 +439,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 	acpi_status status = AE_OK;
 	u8 value;
 	struct acpi_ec *ec = (struct acpi_ec *)data;
-
+	atomic_inc(&ec->event_count);
 	if (acpi_ec_mode == EC_INTR) {
 		wake_up(&ec->wait);
 	}
@@ -633,6 +637,7 @@ static int acpi_ec_add(struct acpi_device *device)
 	ec->uid = -1;
 	mutex_init(&ec->lock);
 	atomic_set(&ec->query_pending, 0);
+	atomic_set(&ec->event_count, 1);
 	if (acpi_ec_mode == EC_INTR) {
 		atomic_set(&ec->leaving_burst, 1);
 		init_waitqueue_head(&ec->wait);
@@ -807,6 +812,7 @@ acpi_fake_ecdt_callback(acpi_handle handle,
 	acpi_status status;
 
 	mutex_init(&ec_ecdt->lock);
+	atomic_set(&ec->event_count, 1);
 	if (acpi_ec_mode == EC_INTR) {
 		init_waitqueue_head(&ec_ecdt->wait);
 	}
@@ -888,6 +894,7 @@ static int __init acpi_ec_get_real_ecdt(void)
 		return -ENOMEM;
 
 	mutex_init(&ec_ecdt->lock);
+	atomic_set(&ec_ecdt->event_count, 1);
 	if (acpi_ec_mode == EC_INTR) {
 		init_waitqueue_head(&ec_ecdt->wait);
 	}
@@ -1016,8 +1023,7 @@ static int __init acpi_ec_set_intr_mode(char *str)
 		acpi_ec_mode = EC_POLL;
 	}
 	acpi_ec_driver.ops.add = acpi_ec_add;
-	printk(KERN_NOTICE PREFIX "%s mode.\n",
-			  intr ? "interrupt" : "polling");
+	printk(KERN_NOTICE PREFIX "%s mode.\n", intr ? "interrupt" : "polling");
 
 	return 1;
 }
-- 
1.5.0.3.310.g05ef5
