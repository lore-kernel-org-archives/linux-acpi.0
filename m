From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/84] Freezer: Introduce PF_FREEZER_NOSIG
Date: Sat, 28 Jun 2008 01:43:31 -0400
Message-ID: <847401e1c6271ba5f3c8cee25d1dede8b179b332.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62913 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbYF1FpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:03 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BBORZ1MG71@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:02 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The freezer currently attempts to distinguish kernel threads from
user space tasks by checking if their mm pointer is unset and it
does not send fake signals to kernel threads.  However, there are
kernel threads, mostly related to networking, that behave like
user space tasks and may want to be sent a fake signal to be frozen.

Introduce the new process flag PF_FREEZER_NOSIG that will be set
by default for all kernel threads and make the freezer only send
fake signals to the tasks having PF_FREEZER_NOSIG unset.  Provide
the set_freezable_with_signal() function to be called by the kernel
threads that want to be sent a fake signal for freezing.

This patch should not change the freezer's observable behavior.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/freezer.h |   10 +++++
 include/linux/sched.h   |    1 +
 kernel/kthread.c        |    2 +-
 kernel/power/process.c  |   97 ++++++++++++++++++++--------------------------
 4 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0893499..deddeed 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -128,6 +128,15 @@ static inline void set_freezable(void)
 }
 
 /*
+ * Tell the freezer that the current task should be frozen by it and that it
+ * should send a fake signal to the task to freeze it.
+ */
+static inline void set_freezable_with_signal(void)
+{
+	current->flags &= ~(PF_NOFREEZE | PF_FREEZER_NOSIG);
+}
+
+/*
  * Freezer-friendly wrappers around wait_event_interruptible() and
  * wait_event_interruptible_timeout(), originally defined in <linux/wait.h>
  */
@@ -174,6 +183,7 @@ static inline void freezer_do_not_count(void) {}
 static inline void freezer_count(void) {}
 static inline int freezer_should_skip(struct task_struct *p) { return 0; }
 static inline void set_freezable(void) {}
+static inline void set_freezable_with_signal(void) {}
 
 #define wait_event_freezable(wq, condition)				\
 		wait_event_interruptible(wq, condition)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5d3f84..e2c8328 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1507,6 +1507,7 @@ static inline void put_task_struct(struct task_struct *t)
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 #define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tester */
 #define PF_FREEZER_SKIP	0x40000000	/* Freezer should not count it as freezeable */
+#define PF_FREEZER_NOSIG 0x80000000	/* Freezer won't send signals to it */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bd1b9ea..1113e92 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -234,7 +234,7 @@ int kthreadd(void *unused)
 	set_user_nice(tsk, KTHREAD_NICE_LEVEL);
 	set_cpus_allowed(tsk, CPU_MASK_ALL);
 
-	current->flags |= PF_NOFREEZE;
+	current->flags |= PF_NOFREEZE | PF_FREEZER_NOSIG;
 
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index f1d0b34..5fb8765 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -19,9 +19,6 @@
  */
 #define TIMEOUT	(20 * HZ)
 
-#define FREEZER_KERNEL_THREADS 0
-#define FREEZER_USER_SPACE 1
-
 static inline int freezeable(struct task_struct * p)
 {
 	if ((p == current) ||
@@ -84,63 +81,53 @@ static void fake_signal_wake_up(struct task_struct *p)
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 }
 
-static int has_mm(struct task_struct *p)
+static inline bool should_send_signal(struct task_struct *p)
 {
-	return (p->mm && !(p->flags & PF_BORROWED_MM));
+	return !(p->flags & PF_FREEZER_NOSIG);
 }
 
 /**
  *	freeze_task - send a freeze request to given task
  *	@p: task to send the request to
- *	@with_mm_only: if set, the request will only be sent if the task has its
- *		own mm
- *	Return value: 0, if @with_mm_only is set and the task has no mm of its
- *		own or the task is frozen, 1, otherwise
+ *	@sig_only: if set, the request will only be sent if the task has the
+ *		PF_FREEZER_NOSIG flag unset
+ *	Return value: 'false', if @sig_only is set and the task has
+ *		PF_FREEZER_NOSIG set or the task is frozen, 'true', otherwise
  *
- *	The freeze request is sent by seting the tasks's TIF_FREEZE flag and
+ *	The freeze request is sent by setting the tasks's TIF_FREEZE flag and
  *	either sending a fake signal to it or waking it up, depending on whether
- *	or not it has its own mm (ie. it is a user land task).  If @with_mm_only
- *	is set and the task has no mm of its own (ie. it is a kernel thread),
- *	its TIF_FREEZE flag should not be set.
- *
- *	The task_lock() is necessary to prevent races with exit_mm() or
- *	use_mm()/unuse_mm() from occuring.
+ *	or not it has PF_FREEZER_NOSIG set.  If @sig_only is set and the task
+ *	has PF_FREEZER_NOSIG set (ie. it is a typical kernel thread), its
+ *	TIF_FREEZE flag will not be set.
  */
-static int freeze_task(struct task_struct *p, int with_mm_only)
+static bool freeze_task(struct task_struct *p, bool sig_only)
 {
-	int ret = 1;
+	/*
+	 * We first check if the task is freezing and next if it has already
+	 * been frozen to avoid the race with frozen_process() which first marks
+	 * the task as frozen and next clears its TIF_FREEZE.
+	 */
+	if (!freezing(p)) {
+		rmb();
+		if (frozen(p))
+			return false;
 
-	task_lock(p);
-	if (freezing(p)) {
-		if (has_mm(p)) {
-			if (!signal_pending(p))
-				fake_signal_wake_up(p);
-		} else {
-			if (with_mm_only)
-				ret = 0;
-			else
-				wake_up_state(p, TASK_INTERRUPTIBLE);
-		}
+		if (!sig_only || should_send_signal(p))
+			set_freeze_flag(p);
+		else
+			return false;
+	}
+
+	if (should_send_signal(p)) {
+		if (!signal_pending(p))
+			fake_signal_wake_up(p);
+	} else if (sig_only) {
+		return false;
 	} else {
-		rmb();
-		if (frozen(p)) {
-			ret = 0;
-		} else {
-			if (has_mm(p)) {
-				set_freeze_flag(p);
-				fake_signal_wake_up(p);
-			} else {
-				if (with_mm_only) {
-					ret = 0;
-				} else {
-					set_freeze_flag(p);
-					wake_up_state(p, TASK_INTERRUPTIBLE);
-				}
-			}
-		}
+		wake_up_state(p, TASK_INTERRUPTIBLE);
 	}
-	task_unlock(p);
-	return ret;
+
+	return true;
 }
 
 static void cancel_freezing(struct task_struct *p)
@@ -156,7 +143,7 @@ static void cancel_freezing(struct task_struct *p)
 	}
 }
 
-static int try_to_freeze_tasks(int freeze_user_space)
+static int try_to_freeze_tasks(bool sig_only)
 {
 	struct task_struct *g, *p;
 	unsigned long end_time;
@@ -175,7 +162,7 @@ static int try_to_freeze_tasks(int freeze_user_space)
 			if (frozen(p) || !freezeable(p))
 				continue;
 
-			if (!freeze_task(p, freeze_user_space))
+			if (!freeze_task(p, sig_only))
 				continue;
 
 			/*
@@ -235,13 +222,13 @@ int freeze_processes(void)
 	int error;
 
 	printk("Freezing user space processes ... ");
-	error = try_to_freeze_tasks(FREEZER_USER_SPACE);
+	error = try_to_freeze_tasks(true);
 	if (error)
 		goto Exit;
 	printk("done.\n");
 
 	printk("Freezing remaining freezable tasks ... ");
-	error = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
+	error = try_to_freeze_tasks(false);
 	if (error)
 		goto Exit;
 	printk("done.");
@@ -251,7 +238,7 @@ int freeze_processes(void)
 	return error;
 }
 
-static void thaw_tasks(int thaw_user_space)
+static void thaw_tasks(bool nosig_only)
 {
 	struct task_struct *g, *p;
 
@@ -260,7 +247,7 @@ static void thaw_tasks(int thaw_user_space)
 		if (!freezeable(p))
 			continue;
 
-		if (!p->mm == thaw_user_space)
+		if (nosig_only && should_send_signal(p))
 			continue;
 
 		thaw_process(p);
@@ -271,8 +258,8 @@ static void thaw_tasks(int thaw_user_space)
 void thaw_processes(void)
 {
 	printk("Restarting tasks ... ");
-	thaw_tasks(FREEZER_KERNEL_THREADS);
-	thaw_tasks(FREEZER_USER_SPACE);
+	thaw_tasks(true);
+	thaw_tasks(false);
 	schedule();
 	printk("done.\n");
 }
-- 
1.5.6.1.89.gd544

