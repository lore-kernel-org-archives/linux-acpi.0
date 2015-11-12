From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] ACPI / SMBus: Fix boot stalls / high CPU caused by reentrant
 code
Date: Thu, 12 Nov 2015 18:05:37 +0000
Message-ID: <20151112180537.GA5237@localhost>
References: <20151106204408.GA11609@localhost>
 <53589361.gQMCOa1UoV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38649 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbKLSFm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 13:05:42 -0500
Content-Disposition: inline
In-Reply-To: <53589361.gQMCOa1UoV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lv.zheng@intel.com, mingo@redhat.com, oleg@redhat.com, aystarik@gmail.com, aaron.lu@intel.com

In the SBS initialisation, a reentrant call to wait_event_timeout()
causes an intermittent boot stall of several minutes usually following
the "Switching to clocksource tsc" message. Another symptom of this bug
is high CPU usage from programs (Firefox, upowerd) querying the battery
state. This is caused by:

 1. drivers/acpi/sbshc.c wait_transaction_complete() calls
    wait_event_timeout():

 	if (wait_event_timeout(hc->wait, smb_check_done(hc),
 			       msecs_to_jiffies(timeout)))

 2. ___wait_event sets task state to uninterruptible

 3. ___wait_event calls the "condition" smb_check_done()

 4. smb_check_done (sbshc.c) calls through to ec_read() in
    drivers/acpi/ec.c

 5. ec_guard() is reached which calls wait_event_timeout()

 	if (wait_event_timeout(ec->wait,
 			       ec_transaction_completed(ec),
 			       guard))

    ie. wait_event_timeout() is being called again inside evaluation of
    the previous wait_event_timeout() condition

 5. The EC IRQ handler calls wake_up() and wakes up the sleeping task in
    ec_guard()

 6. The task is now in state running even though the wait "condition" is
    still being evaluated

 7. The "condition" check returns false so ___wait_event calls
    schedule_timeout()

 8. Since the task state is running, the scheduler immediately schedules
    it again

 9. This loop usually repeats for around 250 seconds even though the
    original wait_event_timeout was only 1000ms.

    The timeout is incorrect because each call to schedule_timeout()
    usually returns immediately, taking less than 1ms, so the jiffies
    timeout counter is not decremented. The task is now stuck in a
    running state, and so is highly likely to be immediately
    rescheduled, which takes less than a jiffy. The loop will never exit
    if all schedule_timeout() calls take less than a jiffy.

Fix this by replacing SMBus reads in the wait_event_timeout condition
with checks of a boolean value that is updated by the EC query handler.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107191
Link: https://lkml.org/lkml/2015/11/6/776
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/sbshc.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index bf034f8..e290051 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -30,6 +30,7 @@ struct acpi_smb_hc {
 	u8 query_bit;
 	smbus_alarm_callback callback;
 	void *context;
+	bool done;
 };
 
 static int acpi_smbus_hc_add(struct acpi_device *device);
@@ -100,27 +101,11 @@ static inline int smb_hc_write(struct acpi_smb_hc *hc, u8 address, u8 data)
 	return ec_write(hc->offset + address, data);
 }
 
-static inline int smb_check_done(struct acpi_smb_hc *hc)
-{
-	union acpi_smb_status status = {.raw = 0};
-	smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw);
-	return status.fields.done && (status.fields.status == SMBUS_OK);
-}
-
 static int wait_transaction_complete(struct acpi_smb_hc *hc, int timeout)
 {
-	if (wait_event_timeout(hc->wait, smb_check_done(hc),
-			       msecs_to_jiffies(timeout)))
+	if (wait_event_timeout(hc->wait, hc->done, msecs_to_jiffies(timeout)))
 		return 0;
-	/*
-	 * After the timeout happens, OS will try to check the status of SMbus.
-	 * If the status is what OS expected, it will be regarded as the bogus
-	 * timeout.
-	 */
-	if (smb_check_done(hc))
-		return 0;
-	else
-		return -ETIME;
+	return -ETIME;
 }
 
 static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
@@ -135,6 +120,7 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
 	}
 
 	mutex_lock(&hc->lock);
+	hc->done = false;
 	if (macbook)
 		udelay(5);
 	if (smb_hc_read(hc, ACPI_SMB_PROTOCOL, &temp))
@@ -235,8 +221,10 @@ static int smbus_alarm(void *context)
 	if (smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw))
 		return 0;
 	/* Check if it is only a completion notify */
-	if (status.fields.done)
+	if (status.fields.done && status.fields.status == SMBUS_OK) {
+		hc->done = true;
 		wake_up(&hc->wait);
+	}
 	if (!status.fields.alarm)
 		return 0;
 	mutex_lock(&hc->lock);
-- 
2.1.4

