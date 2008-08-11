From: Zhao Yakui <yakui.zhao@intel.com>
Subject: a problem about the EC mode switch
Date: Mon, 11 Aug 2008 10:35:46 +0800
Message-ID: <1218422146.6671.66.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19599 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbYHKCVw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Aug 2008 22:21:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi, Alexey
    There is a question about EC mode switch and I expect to discuss it with you.
    I am not sure whether the following is appropriate.

Subject: ACPI: Avoid bogus EC mode switch from interrupt to polling
>From : Zhao Yakui <yakui.zhao@intel.com>

When EC works in GPE interrupt mode, sometimes it will be switched from
interrupt mode to polling mode when EC timeout happens.
     if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
                msecs_to_jiffies(ACPI_EC_DELAY)))
	      return 0;
	
In fact in Linux although one process is already by wakeup by some events
(For example: interrupt wakeup, timeout wakeup), it won't be scheduled
immediately. Maybe it will have to wait for some time before it is scheduled
on some CPU. In such case maybe the following phenomena will happen.
       OS will check the EC status before the process is added to sleeping 
        waitqueue.If the EC status is not what we expect, it will be added to
	the sleeping waitqueue. Of course the state of the process will be
	changed to TASK_UNINTERRUPTIBLE.When the EC GPE interrupt is triggered,
        the waiting process will be waked up in the GPE interrupt service routine. 
        But as the process can't be scheduled immediately, maybe the wait_event_timeout will 
	also return 0, which means that timeout happens and EC will be 
	switched from interrupt mode to polling mode. 

As when the EC_FLAGS_WAIT_GPE bit will be cleared in GPE handler, Maybe it 
will be appropriate that OS check the EC_FLAGS_WAIT_GPE bit of EC flag and 
EC status before mode switch although timeout happens. If the bit of 
EC_FLAGS_WAIT_GPE is cleared and EC status is what we expect, OS won't
switch EC work mode even when the timeout happens. Otherwise it will continue
the orignal routine.

---
 drivers/acpi/ec.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -178,6 +178,15 @@ static int acpi_ec_wait(struct acpi_ec *
 		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
 				       msecs_to_jiffies(ACPI_EC_DELAY)))
 			return 0;
+		/*
+		 * If the EC_FLAGS_WAI_GPE bit is already clear and EC status
+		 * is what OS expects, it won't be switched interrupt mode to
+		 * polling mode.
+		 */
+		if (!test_bit(EC_FLAGS_WAIT_GPE, &ec->flags) &&
+			acpi_ec_check_status(ec, event))
+			return 0;
+
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		if (acpi_ec_check_status(ec, event)) {
 			/* missing GPEs, switch back to poll mode */

   
     

    

