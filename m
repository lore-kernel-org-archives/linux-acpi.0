From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 1/1] apci_pad: in power_saving_thread(), call schedule() when need_resched is true
Date: Fri, 25 Apr 2014 14:19:29 -0400
Message-ID: <1398449969-10860-1-git-send-email-tcamuso@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbaDYSTe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Apr 2014 14:19:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: tcamuso@redhat.com, rjw@rjwysocki.net, lenb@kernel.org

(from a bug report submitted by Stuart Hayes)

The purpose of the acpi_pad driver is to implement the "processor power
aggregator" device as described in the ACPI 4.0 spec section 8.5. It
takes requests from the BIOS (via ACPI) to put a specified number of
CPUs into idle, in order to save power, until further notice.

It does this by creating high-priority threads that try to keep the CPUs
in a high C-state (using the monitor/mwait CPU instructions). The
mwait() call is in a loop that checks periodically if the thread should
end and a few other things.

It was discovered through testing that the power_saving threads were
causing the system to consume more power than the system was consuming
before the threads were created. A counter in the main loop of
power_saving_thread() revealed that it was spinning. The mwait()
instruction was not keeping the CPU in a high C state very much if at
all.

Here is a simplification of the loop in function power_saving_thread() in
drivers/acpi/acpi_pad.c

    while (!kthread_should_stop()) {
         :
        try_to_freeze()
         :
        while (!need_resched()) {
             :
            if (!need_resched())
                __mwait(power_saving_mwait_eax, 1);
             :
            if (jiffies > expire_time) {
                do_sleep = 1;
                break;
            }
        }
    }

If need_resched() returns true, then mwait() is not called. It was
returning true because of things like timer interrupts, as in the
following sequence.

hrtimer_interrupt->__run_hrtimer->tick_sched_timer-> update_process_times->
rcu_check_callbacks->rcu_pending->__rcu_pending->set_need_resched

Kernels 3.5.0-rc2+ do not exhibit this problem, because a patch to
try_to_freeze() in include/linux/freezer.h introduces a call to
might_sleep(), which ultimately calls schedule() to clear the reschedule
flag and allows the the loop to execute the call to mwait().

However, the changes to try_to_freeze are unrelated to acpi_pad, and it
does not seem like a good idea to rely on an unrelated patch in a
function that could later be changed and reintroduce this bug.

Therefore, it seems better to make an explicit call to schedule() in the
outer loop when the need_resched flag is set.

Reported-by: Stuart Hayes <stuart_hayes@dell.com>
Tested-by: Stuart Hayes <stuart_hayes@dell.com>
Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 drivers/acpi/acpi_pad.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 27bb6a9..447c55b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -219,8 +219,15 @@ static int power_saving_thread(void *data)
 		 * borrow CPU time from this CPU and cause RT task use > 95%
 		 * CPU time. To make 'avoid starvation' work, takes a nap here.
 		 */
-		if (do_sleep)
+		if (unlikely(do_sleep))
 			schedule_timeout_killable(HZ * idle_pct / 100);
+
+		/* If an external event has set the need_resched flag, then
+		 * we need to deal with it, or this loop will continue to
+		 * spin without calling __mwait().
+		 */
+		if (unlikely(need_resched()))
+			schedule();
 	}
 
 	exit_round_robin(tsk_index);
-- 
1.8.3.1

