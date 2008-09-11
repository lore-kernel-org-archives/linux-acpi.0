From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: the errors about two EC patches
Date: Thu, 11 Sep 2008 10:42:48 +0800
Message-ID: <1221100968.3989.224.camel@yakui_zhao.sh.intel.com>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>
	 <48C7BF94.6010204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-KPemP3Z1oVKgWycbRhfd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50006 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbYIKC2X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 22:28:23 -0400
In-Reply-To: <48C7BF94.6010204@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com


--=-KPemP3Z1oVKgWycbRhfd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2008-09-10 at 16:37 +0400, Alexey Starikovskiy wrote:
thanks for the so quick response. 

In the update patch it seems that spin_lock is used in the function of
ec_read_command/acpi_ec_write_cmd.
   IMO this is not reasonable. 
   Maybe the spin_lock is already called before OS evaluates some ACPI
object, in which the EC internal register will be accessed. In such case
there will give the following warning message.
      >2 locks held by swapper/1

>  
> Ok. Fixed, now -ETIME is returned in this case.
Yes. The code flow seems logic and reasonable after the -Etime is added.
If the timeout happens when EC transaction is not finished, it is
regarded as timeout.

But we should investigate why EC transaction is not finished when
timeout happens. Is it related with EC hardware or EC driver?
If EC can't update the status register in time after issuing
command/address, it is reasonable that it is regarded as timeout. If
not, maybe it is related with the EC driver.

In fact when timeout happens in the above cases, OS has no opportunity
to issue the EC command set completely.
    For example: Read Command: 
      a. Maybe OS has no opportunity to issue the accessed EC register
address.
      b. Maybe OS has no opportunity to read the returned data from EC
controller
In such case it is not appropriate that it is still regarded as timeout.

Maybe we should use the several phases to issue the EC transaction. And
In every phase OS should check whether the EC status is what OS expected
in the predefined time. If in some phase EC status is not what OS
expected, it can be regarded as timeout.
For example: EC Read transaction:
      a. Issuing the read command. (Write the 0x80 to EC Cmd port)
      b. Checking whether the input buffer is empty(IBF bit) and write
the accessed address to EC Data port.
      c. Checking wheter the data is already(OBF bit) and read the
returned data from EC controller

Based on the above analysis IMO the flow of EC transaction is quite
reasonable. Of course what should be improved is how to make it
reasonable when waiting whether EC status is what OS expected.

Please check whether the attached is reasonable.

Of course in the attached patch there is no detect mechanism of EC GPE
interrupt storm.


--=-KPemP3Z1oVKgWycbRhfd
Content-Disposition: attachment; filename=ec_work_mode.patch
Content-Type: text/x-patch; name=ec_work_mode.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Subject: ACPI: Unify the EC work modes of polling and GPE interrupt
>From : Zhao Yakui <yakui.zhao@intel.com>

The flow of EC transaction is still used. But the function of acpi_ec_wait
is changed. At the same time it is unnecessary to switch EC work mode.

While OS is waiting whether the EC status is what OS expected, it will work in
interrupt-driven mode if there is EC GPE confirmation. Otherwise it will still
work in polling mode. And there is no need to switch the work mode.

At the same time the acpi_ec_gpe_handler is also simplified. Only two tasks
are reserved. One is to process the EC notification event. Another is to 
wake up the process in ec waitqueue.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |   80 ++++++++++++++----------------------------------------
 1 file changed, 22 insertions(+), 58 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c	2008-09-11 09:54:51.000000000 +0800
+++ linux-2.6/drivers/acpi/ec.c	2008-09-11 10:09:46.000000000 +0800
@@ -167,8 +167,6 @@
 
 static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
 {
-	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
-		return 0;
 	if (event == ACPI_EC_EVENT_OBF_1) {
 		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
 			return 1;
@@ -197,33 +195,28 @@
 
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
+	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
 	atomic_set(&ec->irq_count, 0);
-	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
-	    likely(!force_poll)) {
-		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
-				       msecs_to_jiffies(ACPI_EC_DELAY)))
-			return 0;
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		if (acpi_ec_check_status(ec, event)) {
-			/* missing GPEs, switch back to poll mode */
-			if (printk_ratelimit())
-				pr_info(PREFIX "missing confirmations, "
-						"switch off interrupt mode.\n");
-			ec_switch_to_poll_mode(ec);
-			ec_schedule_ec_poll(ec);
-			return 0;
-		}
-	} else {
-		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		while (time_before(jiffies, delay)) {
-			if (acpi_ec_check_status(ec, event))
-				return 0;
-			msleep(1);
-		}
-		if (acpi_ec_check_status(ec,event))
+	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+	while (time_before(jiffies, delay)) {
+		/*
+		 * Checking whether the EC staus is what OS expected by calling
+		 * wait_event_timeout. This process can be waked up by two
+		 * methods: One: timeout;  Two: EC GPE interrupt.
+		 * If it returns not zero, it means that it is waked up by EC
+		 * GPE interrupt and EC status is already what OS expected.
+		 * If it returns zero, it will continue to check the EC status.
+		 * That is to say, if there is EC GPE confirmation, it will
+		 * work in interrupt-driven mode. Otherwise it will work in
+		 * polling mode.
+		 */
+		if (wait_event_timeout(ec->wait,
+			acpi_ec_check_status(ec, event), 1))
 			return 0;
 	}
+	if (acpi_ec_check_status(ec, event))
+		return 0;
+
 	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
 		acpi_ec_read_status(ec),
 		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
@@ -236,7 +229,6 @@
 					int force_poll)
 {
 	int result = 0;
-	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	pr_debug(PREFIX "transaction start\n");
 	acpi_ec_write_cmd(ec, command);
 	for (; wdata_len > 0; --wdata_len) {
@@ -246,7 +238,6 @@
 			       "write_cmd timeout, command = %d\n", command);
 			goto end;
 		}
-		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		acpi_ec_write_data(ec, *(wdata++));
 	}
 
@@ -265,9 +256,6 @@
 			pr_err(PREFIX "read timeout, command = %d\n", command);
 			goto end;
 		}
-		/* Don't expect GPE after last read */
-		if (rdata_len > 1)
-			set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		*(rdata++) = acpi_ec_read_data(ec);
 	}
       end:
@@ -535,32 +523,15 @@
 	u8 state = acpi_ec_read_status(ec);
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	atomic_inc(&ec->irq_count);
-	if (atomic_read(&ec->irq_count) > 5) {
-		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
-		ec_switch_to_poll_mode(ec);
-		goto end;
-	}
-	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
-		wake_up(&ec->wait);
 
 	if (state & ACPI_EC_FLAG_SCI) {
 		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
 				acpi_ec_gpe_query, ec);
-	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
-		   in_interrupt()) {
-		/* this is non-query, must be confirmation */
-		if (printk_ratelimit())
-			pr_info(PREFIX "non-query interrupt received,"
-				" switching to interrupt mode\n");
-		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
-end:
-	ec_schedule_ec_poll(ec);
+
+	if ((state & ACPI_EC_FLAG_OBF) || !(state & ACPI_EC_FLAG_IBF))
+		wake_up(&ec->wait);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
@@ -761,7 +732,6 @@
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	ec_poll_stop(ec);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
@@ -809,8 +779,6 @@
 	acpi_ec_add_fs(device);
 	pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
 			  ec->gpe, ec->command_addr, ec->data_addr);
-	pr_info(PREFIX "driver started in %s mode\n",
-		(test_bit(EC_FLAGS_GPE_MODE, &ec->flags))?"interrupt":"poll");
 	return 0;
 }
 
@@ -904,7 +872,6 @@
 
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	ec_schedule_ec_poll(ec);
 	return ret;
 }
 
@@ -1000,8 +967,6 @@
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Stop using GPE */
-	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	return 0;
 }
@@ -1010,7 +975,6 @@
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Enable use of GPE back */
-	clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	return 0;
 }

--=-KPemP3Z1oVKgWycbRhfd--

