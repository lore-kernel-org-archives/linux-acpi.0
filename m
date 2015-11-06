From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] Preserve task state in reentrant calls to ___wait_event
Date: Fri, 6 Nov 2015 20:44:08 +0000
Message-ID: <20151106204408.GA11609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, lv.zheng@intel.com, mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net, oleg@redhat.com, aystarik@gmail.com
List-Id: linux-acpi@vger.kernel.org

In the ACPI SBS initialisation, a reentrant call to wait_event_timeout()
causes an intermittent boot stall of several minutes usually following
the "Switching to clocksource tsc" message. This stall is caused by:

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

 9. This loop repeats for around 250 seconds event though the original
    wait_event_timeout was only 1000ms.

    This happens because each the call to schedule_timeout() usually
    returns immediately, taking less than 1ms, so the jiffies timeout
    counter is not decremented. The task is now stuck in a running
    state, and so is highly likely to get rescheduled immediately, which
    takes less than a jiffy.

The root problem is that wait_event_timeout() does not preserve the task
state when called by tasks that are not running. We fix this by
preserving and restoring the task state in ___wait_event().

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
I am assuming here that wait_event_timeout() is supposed to support reentrant
calls. If not, perhaps it should BUG_ON when called with a non-running task
state, and the SBS HC / ACPI EC code needs to be fixed to stop doing this. If
reentrant calls are supposed to work, then this patch will preserve the task
state (there may be a more appropriate way to support reentrant calls than this
exact patch, suggestions/alternatives are welcome, but this does work).
---
 include/linux/wait.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 1e1bf9f..a847cf8 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -209,11 +209,12 @@ wait_queue_head_t *bit_waitqueue(void *, int);
  * otherwise.
  */
 
-#define ___wait_event(wq, condition, state, exclusive, ret, cmd)	\
+#define ___wait_event(wq, condition, nstate, exclusive, ret, cmd)	\
 ({									\
 	__label__ __out;						\
 	wait_queue_t __wait;						\
 	long __ret = ret;	/* explicit shadow */			\
+	long ostate = current->state;					\
 									\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	if (exclusive)							\
@@ -222,16 +223,16 @@ wait_queue_head_t *bit_waitqueue(void *, int);
 		__wait.flags = 0;					\
 									\
 	for (;;) {							\
-		long __int = prepare_to_wait_event(&wq, &__wait, state);\
+		long __int = prepare_to_wait_event(&wq, &__wait, nstate);\
 									\
 		if (condition)						\
 			break;						\
 									\
-		if (___wait_is_interruptible(state) && __int) {		\
+		if (___wait_is_interruptible(nstate) && __int) {	\
 			__ret = __int;					\
 			if (exclusive) {				\
 				abort_exclusive_wait(&wq, &__wait,	\
-						     state, NULL);	\
+						     nstate, NULL);	\
 				goto __out;				\
 			}						\
 			break;						\
@@ -240,6 +241,7 @@ wait_queue_head_t *bit_waitqueue(void *, int);
 		cmd;							\
 	}								\
 	finish_wait(&wq, &__wait);					\
+	set_current_state(ostate);					\
 __out:	__ret;								\
 })
 
-- 
2.1.4
